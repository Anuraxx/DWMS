package com.dwms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;
import java.util.Scanner;
//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.dwms.Provider.*;
import static com.dwms.HelperMethods.*;

public class Varify extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String DB_NAME = "varify";
	
	public void createConn(String dbname) {
		try {
			DB_NAME=dbname;
			con=DriverManager.getConnection(CONNECTION_URL+DB_NAME+timezone, USERNAME , PASSWORD);
			st=con.createStatement();
		}catch(SQLException e) {e.printStackTrace();}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Class.forName("com.mysql.cj.jdbc.driver");
		
		switch(Optional.ofNullable(request.getParameter("unk")).isPresent() ? request.getParameter("unk") : "garbageValue" ) {
			
		case "admin-login":{
			createConn("varify");
			
			try {
				rs=st.executeQuery("SELECT * FROM admin");
				rs.next();
				if(request.getParameter("name").equals("admin") &&
						rs.getString(2).equals(request.getParameter("pass"))) {
					request.setAttribute("valid", "true");
					HttpSession sess=request.getSession();
					sess.setAttribute("isValidAdmin", "true");
					request.getRequestDispatcher("adminControl.jsp").forward(request, response);
				}
				else {
					
					request.setAttribute("wp", "username/password is incorrect");
					request.getRequestDispatcher("admin.jsp").forward(request, response);
				}
				
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
			break;
		}
		case "admin-reset":{
			createConn("varify");
			try {
				rs=st.executeQuery("SELECT * FROM admin");
				rs.next();
				//System.out.println(rs.getString(2).getClass().getName());
				String a= rs.getString(2);
				String b= request.getParameter("op");
				if(a.equals(b)) {
					String np=request.getParameter("np");
					st.executeUpdate("update admin set password='"+np+"' where name='admin'");
					rs=st.executeQuery("SELECT * FROM admin");
					rs.next();
					if(rs.getString(2).equals((String)request.getParameter("np"))) {
						request.setAttribute("rp", "password reset successfully");
						request.getRequestDispatcher("admin.jsp").forward(request, response);
					}else {
						request.getRequestDispatcher("error.jsp").forward(request, response);
					}
				}
				else {
					request.setAttribute("rp", "*password missmatched");
					request.getRequestDispatcher("admin.jsp").forward(request, response);
				}
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		}
		case "registration":{
			createConn("varify");
			try {
				String uname = request.getParameter("un");
				String email = request.getParameter("email");
				String phone = request.getParameter("phone");
				String address = request.getParameter("address");
				String dob = changeDateFormat(request.getParameter("dob"));
				String gender = request.getParameter("gender");
				String occup = request.getParameter("occup");
				String pass=  request.getParameter("pass");
				System.out.println(pass);
				
				String fetch="SELECT uname,email,phone FROM users where uname='"+uname+"' OR email='"+email+"' OR phone='"+phone+"' ";
				String update="insert into users(uname,email,phone,address,dob,gender,occup,pass) values('"+uname+"','"+email+"','"+phone+"','"+address+"','"+dob+"','"+gender+"','"+occup+"','"+pass+"')";
				
				rs=st.executeQuery(fetch);
		
			
				boolean isExist=false;
				
				if((Integer.parseInt((new SimpleDateFormat("yyyy").format(new Date())))-Integer.parseInt(dob.substring(0, 4)))<21) {
					isExist=true;
					request.setAttribute("dobexp", "dob is not valid, your age must be greater than 21yrs");
				}
				
				while(rs.next()) {
					
					if(rs.getString(1).equals(uname)) {
						isExist=true;
						request.setAttribute("unamexp", "username already taken");
					}	
					if(rs.getString(2).equals(email)) {
						isExist=true;
						request.setAttribute("emailexp", "email is already registered");
					}		
					if(rs.getString(3).equals(phone)) {
						isExist=true;
						request.setAttribute("phonexp", "phone no. already existed");
					}
				}
				
				
				if(isExist) {
					request.getRequestDispatcher("register.jsp").forward(request, response);
				}else {
					// uname email phone address dob gender occup
					st.executeUpdate(update);
					rs=st.executeQuery(fetch);
					if(rs.next()) {
						request.setAttribute("success", "regsitered successfully");
						request.getRequestDispatcher("register.jsp").forward(request, response);
					}else {
						request.getRequestDispatcher("error.jsp").forward(request, response);
					}
				}
				System.out.println("done");
				
				con.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			break;
		}
		
		case "usrlogin":{
			createConn("varify");
			
			String un = request.getParameter("name");
			String passw = request.getParameter("pass");
			try {
				String fetch = "SELECT uname,pass FROM users where uname='"+un+"' AND pass='"+passw+"' ";
				
				rs=st.executeQuery(fetch);
				if(rs.next()) {
					request.setAttribute("valid", "true");
					HttpSession sess=request.getSession();
					sess.setAttribute("isValiduser", "true");
					sess.setAttribute("hellousr", new Scanner(un).next());
					sess.setAttribute("fulluname", un);
					request.setAttribute("hellousr",new Scanner(un).next());
					request.getRequestDispatcher("usrContent.jsp").forward(request, response);
				}
				else {
					request.setAttribute("wp", "username/password is incorrect");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
				
				con.close();
			}catch(SQLException e) { 
				e.printStackTrace();
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}
				
			
			break;
		}
		
		case "usrReset":{
			createConn("varify");
			
			String unameoremail = request.getParameter("unameoremail");
			String op=request.getParameter("op");
			String np=request.getParameter("np");
			String fetch = "SELECT uname,pass FROM users where uname='"+unameoremail+"' or email='"+unameoremail+"' ";
			
			
			try {
				rs=st.executeQuery(fetch);
				if(rs.next()) {
					String uname=rs.getString(1);
					if(op.equals(rs.getString(2))) {
						st.executeUpdate("UPDATE users SET pass = '"+np+"' WHERE uname='"+uname+"' ");
						rs= st.executeQuery("SELECT uname,pass FROM users where uname='"+uname+"' and pass='"+np+"' ");
						if(rs.next()) {
							request.setAttribute("wp", "password changed successfully");
							request.getRequestDispatcher("login.jsp").forward(request, response);
						}else request.getRequestDispatcher("error.jsp").forward(request, response);
					}else {
						request.setAttribute("rp", "password missmatched");
						request.getRequestDispatcher("login.jsp").forward(request, response);
					}
				}else {
					request.setAttribute("wp", "username/password wrong");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
					
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
			break;
		}
		
		case "testerlogin":{
			createConn("orderdata");
			
			String id = request.getParameter("name");
			String passw = request.getParameter("pass");
			
			try {
				String fetch = "SELECT nam,pass FROM tester where id='"+id+"' AND pass='"+passw+"' ";
				
				rs=st.executeQuery(fetch);
				if(rs.next()) {
					request.setAttribute("valid", "true");
					request.setAttribute("hellousr",new Scanner(rs.getString(1)).next());
					request.setAttribute("testerid",id);
					request.getSession().setAttribute("isValidtester", "true");
					request.getRequestDispatcher("testerControl.jsp").forward(request, response);
				}
				else {
					request.setAttribute("wp", "id/password is incorrect");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
				
				con.close();
			}catch(SQLException e) { 
				e.printStackTrace();
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}
			
			break;
		}
		
		case "addTester":{
			createConn("orderdata");
			
			String uname = request.getParameter("un");
			String dob = changeDateFormat(request.getParameter("dob"));
			String gender = request.getParameter("gender");
			String pass=  request.getParameter("pass");

			try{
				
				st.executeUpdate("insert into tester(nam,dob,gender,pass) values('"+uname+"','"+dob+"','"+gender+"','"+pass+"')");
				request.setAttribute("success", "a new profile added");
				request.getRequestDispatcher("addtester.jsp").forward(request, response);
				//response.sendRedirect("addtester.jsp");
				con.close();

			}catch(SQLException e){e.printStackTrace();}

			break;
		}
		case "testerReset":{
			break;
		}
		
		default :{
			
			request.getRequestDispatcher("error.html").forward(request, response);
			break;
		}
		
		}
	}

}
