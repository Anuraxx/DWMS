package com.dwms;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static com.dwms.Provider.*;
import static com.dwms.HelperMethods.*;


public class OrderData extends HttpServlet  {
	private static final long serialVersionUID = 1L;
    
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String DB_NAME = "orderdata";
	
	public void createConn(String dbname) {
		try {
			DB_NAME=dbname;
			con=DriverManager.getConnection(CONNECTION_URL+DB_NAME+timezone, USERNAME , PASSWORD);
			st=con.createStatement();
		}catch(SQLException e) {e.printStackTrace();}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		switch(Optional.ofNullable(request.getParameter("unk")).isPresent() ? request.getParameter("unk") : "garbageValue" ) {
		
		
		case "new-order":{
			createConn("orderdata");
			
			try {
				String noc=request.getParameter("nofcont");
				String place=request.getParameter("addr");
				String dod=changeDateFormat(request.getParameter("date"));
				String tod=request.getParameter("time");
				String orderid="";
				String transpoterid="";
				
				rs=st.executeQuery("select orderid,transpoterid from orderdata.orders");
				rs.next();
				st.executeUpdate("insert into orderdata.orders(no_of_container,pod,dod,tod,uname) values('"+noc+"','"+place+"','"+dod+"','"+tod+"','"+request.getSession().getAttribute("fulluname")+"')");
				
				rs=st.executeQuery("select orderid from orderdata.orders where uname='"+request.getSession().getAttribute("fulluname")+"' ");
				rs.next();
				orderid=rs.getString(1).concat("+");
				
				createConn("varify");
				rs=st.executeQuery("select orderids from users where uname='"+request.getSession().getAttribute("fulluname")+"' ");
				rs.next();
				orderid=rs.getString(1).concat(orderid);
				st.executeUpdate("update users set orderids='"+orderid+"' where uname='"+request.getSession().getAttribute("fulluname")+"'");
				
				createConn("orderdata");
				st.executeUpdate("update orders set uname= '' ");
			/*	rs=st.executeQuery("select orderid from orderdata.orders where orderid='"+orderid+"' ");

				if(rs.next()) { */
					response.addCookie(new Cookie("valid", "true"));
					response.addCookie(new Cookie("success", "placed"));
					response.sendRedirect("usrContent.jsp");
			/*	}else {
					response.sendRedirect("error.jsp");
				}
			*/	
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		}
		case "assign-tester-work":{
			createConn("orderdata");
			
			String testerid=request.getParameter("id");
			String orderid=request.getParameter("orderid");
			try {
				rs=st.executeQuery("select rownos from tester where id='"+testerid+"' " );
				rs.next();
				orderid= orderid.concat(rs.getString(1));
				st.executeUpdate("update tester set rownos='"+orderid+"' "
						+ "where id='"+testerid+"' ");
				String[] rows=orderid.split("\\+");
				for(int i=0;i<rows.length;i++) {
					String status="quality testing";
					st.executeUpdate("update orders set status='"+status+"' where orderid='"+rows[i]+"' ");
				}
				request.getSession().setAttribute("isValidAdmin", "true");
				request.getRequestDispatcher("assign.jsp").forward(request, response);
				
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			break;
		}
		
		
		case "accrejct":{
			createConn("orderdata");
			
			String orderids= request.getParameter("accrejct");
			String[] orderid=orderids.split("\\+");
			int len=orderid.length;
			String y_n = orderid[len-1];
			String testerid= request.getParameter("testerid");
		//-------------------------------------------------------------
			try{
				rs=st.executeQuery("select approve,dapprove from tester where id='"+testerid+"'");
				rs.next();
				if(y_n.equals("yes")){
					st.executeUpdate("update tester set approve='"+Integer.toString(Integer.parseInt(rs.getString(1))+(len-1))+"' where id='"+testerid+"'  ");
				}
				else{
					st.executeUpdate("update tester set dapprove='"+Integer.toString(Integer.parseInt(rs.getString(2))+(len-1))+"' where id='"+testerid+"'  ");
				}
				
				for(int i=0;i<len-1;i++) {
					if(y_n.equals("yes"))
						st.executeUpdate("update orders set status='approved' where orderid='"+orderid[i]+"'  ");
					else {
						st.executeUpdate("update orders set status='disapproved' where orderid='"+orderid[i]+"'  ");
					}
				}

				request.setAttribute("testerid", testerid);
				request.getRequestDispatcher("testerControl.jsp").forward(request, response);
				con.close();
			}catch(Exception e){e.printStackTrace();}
			break;
		}
		default:{
			break;
		}
		}
	}

}
