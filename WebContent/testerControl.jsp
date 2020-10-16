
<%@ include file="imports.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>control panel</title>
		
		<style type="text/css">
			.card-container{
                width:22%; max-height:600px;float: left;
            }
            .display-hide{
                display:none; 
            }
            .tester-control-container{
                width:90%;margin-top: 100px;
            }
            body{
                padding-left:5%;padding-right: 5%;
            }
            .table-container{
                max-height: 600px;width: 60%;float: right;margin-left: 10%;overflow-y: auto;
            }
            .table-container td{
                width: 50px;
            }
            button{
                float: right;margin-left: 20px;
            }
            .table tbody tr:hover{
                background-color: #E1DFDF;
            }
            .table thead tr{
                background-color: grey; font-weight: bold;
            }
            .table-container .norec{
            	text-align: center;font-size: 150%;color: grey;padding: 20%;
          	}
			
		</style>
	</head>
	
	
	<body>
		<% 
			HttpSession sess=request.getSession(false);
			if(request.getAttribute("valid")==null && sess.getAttribute("isValidtester")==null){
	 			response.sendRedirect("tester.jsp");
			}else{
				sess.setAttribute("isValidtester", null);
				sess.setAttribute("hellousr", null);
			}
		%>
		
		<%!
			
			String DB_NAME = null;
			Connection con=null;
			Statement st =null;
			ResultSet rs=null;

			public void createConn(String db_name){
				try{
					this.DB_NAME=db_name;
					con=DriverManager.getConnection(Provider.CONNECTION_URL+DB_NAME+Provider.timezone, Provider.USERNAME , Provider.PASSWORD);
					st= con.createStatement();
				}catch(SQLException e){e.printStackTrace();}
			}

		%>
		<div class="tester-control-container">
				<%	
					createConn("orderdata");
				    System.out.println(request.getAttribute("testerid"));
				 	rs= st.executeQuery("select * from tester where id='"+request.getAttribute("testerid")+"' ") ; 
				 	if(rs.next()){
				 %>
				
				<div class="card card-container" style="">
  							<%if(rs.getString(6).equals("male")){ %>
    							<img class="card-img-top" src="male.PNG" alt="Card image" style="width:100%;height:300px;">
    						<%} else{%>
    							<img class="card-img-top" src="female.PNG" alt="Card image" style="width:100%;height:300px;">
    						<%} %>
    						<div class="card-body">
    							<p class="display-hide testerid"><%=rs.getString("id") %></p>
    							<h4><%= rs.getString("nam") %></h4>
      							<h1><span class="badge badge-secondary" style="background-color:#5DADE2"><%= Integer.toString(HelperMethods.getAge((rs.getString("dob"))))%></span></h1>
      							<h5 class="">Approve : <span style="color:green"><%= rs.getString("approve")  %></span></h5>
      							<h5 class="">Disapprove : <span style="color:red"><%= rs.getString("dapprove")  %></span></h5>
    						</div>
  				</div>
  				<div class="table-container">
  				<%	
				 			rs= st.executeQuery("select * from tester where id='"+request.getAttribute("testerid")+"' ") ; 
				 			rs.next() ;
				 			String[] orderID=null;
				 			if(Optional.ofNullable(rs.getString("rownos")).isPresent())
				 				orderID = HelperMethods.getOrderID(rs.getString("rownos"));
				 			else{
				 				orderID=new String[0];
				 				request.setAttribute("norec", "no task found");
				 				con.close();
				 			}
				 			
				 			int len=orderID.length;
				 			
				 %>
				<%if(len!=0){ %>
                <table class="table" style="background-color: white">
                        <thead>
                            <tr>
                                <th>#orderid</th>
                                <th>#container</th>
                                <th>place of delivery</th>
                                <th>date of delivery</th>
                                <th>time of delivery</th>
                            </tr>
                        </thead>
                        <tbody>
                        
							
							<% for(int i=0;i<len;i++){ 
								rs=st.executeQuery("select * from orders where orderid='"+orderID[i]+"' ");
								rs.next();
								if(!rs.getString("status").equals("quality testing")) continue;
							%>    
                            <tr>
                                <td class="display-hide orderid"><%=rs.getString(1)+"+" %></td>
                                <td><p><%= rs.getString(1) %></p></td>
                                <td><p><%= rs.getString(2) %></p></td>
                                <td><p><%= rs.getString(3) %></p></td>
                                <td><p><%= rs.getString(4) %></p></td>
                                <td><p><%= rs.getString(5) %></p></td>
                            </tr>
                            
                            <%} con.close();%>
                            
                        </tbody>
                </table>
                <form class="" action="approveDisapprove" method="POST">
                	<input type="hidden" name="unk" value="accrejct" class="display-hide" >
                	<input type="hidden" name="testerid" value=<%=request.getAttribute("testerid") %> class="display-hide" >
                    <input type="hidden" class="orderid-inp display-hide">
                    <button type="submit" class="btn btn-secondary disapprove-button">Disapprove</button>
                    <button type="submit" class="btn btn-primary approve-button">Approve</button>
                </form>
                <% }else{ %>
                	<p class="norec"><%=request.getAttribute("norec")%></p>
                <%}%>
               
            </div>
			<%} %>	
		</div>

		<script type="text/javascript">
		
			var row="";
                $('.table tbody tr').click(function(event) {
                    $(this).attr('id', 'row-no');
                    $(this).css('opacity', '0.7');
                    row = $("#row-no .orderid").text();
                });

                $('.approve-button').click(function(event) {
                	row= row+"yes";
                    $(".tester-control-container form .orderid-inp").attr({name:'accrejct',value:row});
                    
                });
                $('.disapprove-button').click(function(event) {
                	row=row+"no";
                    $(".tester-control-container form .orderid-inp").attr({name:'accrejct',value:row});
                });
		
		</script>
	</body>
</html>