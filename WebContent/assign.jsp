<%@include file="imports.jsp" %>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Assign</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  		
		<style type="text/css">
			.user-record-container{
				width: 90%;margin-left: 5%;margin-right: 5%;margin-top: 100px;
			}
			
			.table-container{
				width: 75%;height: 800px; float: left;overflow-y:auto;
			}
			

			
			.table-container td{
				width: 50px;
			}
			.table-container tbody tr:hover{
				background-color: lightgrey;
			}

			.cards-container{
				width: 20%;height: 850px;background-color: grey;float: right;overflow-y:auto;border-radius: 20px;
			}
			.proceed{
				position:relative;left:50%;transform:translate(-50%);width:20%; top:100px;
			}
			.display-hide{
				display: none;
			}
			.table thead tr{
			 	background-color: grey; font-weight: bold;
			}
			@media only screen and (max-width: 1200px){
				.user-record-container{
					overflow:scroll;
				}
				.table-container{
					width:1300px;
				}
				.cards-container{
					width:500px;
				}
			}
			
		</style>
	</head>
	<body>
		<% 
			HttpSession sess=request.getSession(false);
		
			if(request.getAttribute("valid")==null && sess.getAttribute("isValidAdmin")==null){
	 			response.sendRedirect("admin.jsp");
			}else{
				sess.setAttribute("isValidAdmin", null);
			}
		%>
		
		<div class="user-record-container">
			<form action="newOrder" method="post">
				<input type="text" name="unk" value="assign-tester-work" class="display-hide" >
				<section class="table-container">
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
							<%
								String DB_NAME = "orderdata";
								Connection con=DriverManager.getConnection(Provider.CONNECTION_URL+DB_NAME+Provider.timezone, Provider.USERNAME , Provider.PASSWORD);;
								Statement st= con.createStatement();
								ResultSet rs=st.executeQuery("select orderid,no_of_container,pod,dod,tod,status from orders"); 
							%>
							
							<% while(rs.next()){ if(!rs.getString("status").equals("pending")) continue; %>
							<tr>
								<td class="display-hide orderid"><%=rs.getString(1)+"+" %></td>
								<td><p><%= rs.getString(1) %></p></td>
								<td><p><%= rs.getString(2) %></p></td>
								<td><p><%= rs.getString(3) %></p></td>
								<td><p><%= rs.getString(4) %></p></td>
								<td><p><%= rs.getString(5) %></p></td>
							</tr>	
							<%	} %>
							
							
							
						</tbody>
					</table>
					<input type="submit" name="" value="proceed" class="proceed btn btn-primary">
				</section>
				
				<section class="cards-container">
					
  					<% rs= st.executeQuery("select * from tester") ; %>
  					<% while(rs.next()){ %>
  					
  						<div class="card card-onclick" style="width:100%">
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
  						
  					<%} %>
				</section>
				<input class="display-hide testerid-inp" type="text" name="id">
				<input class="display-hide orderid-inp" type="text" name="orderid">
			</form>
		</div>
		
		
		
		<script type="text/javascript">
		
			$(function(){
				$('.table tbody tr').click(function(event) {
					$(this).attr('id', 'row-no');
					$(this).css('opacity', '0.7');
					var row = $("#row-no .orderid").text();
					$(".orderid-inp").attr('value', row);
				});
				
				$('.card-onclick').click(function(event) {
					$(this).attr('id', 'dyn-id');
					$(this).css('opacity', '0.7');
					var id=$("#dyn-id .card-body p").text();
					$(".testerid-inp").attr('value', id);
				});
			});
		
		</script>
	</body>
</html>