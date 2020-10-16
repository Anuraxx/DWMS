

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="imports.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="reg.css" rel='stylesheet' />
<style type="text/css">
	.order-menu{
		width:300px;height:290px;border:1px solid grey;position:relative;left:50%;transform:translate(-50%);top:200px;border-radius:15px;box-sizing: border-box;
	}
	.menu-item{
		width:90%;height:50px;background-color: #3498DB;margin-left:5%;margin-bottom:20px;text-align: center;padding-top:15px;padding-bottom:15px;box-sizing: border-box;
		box-shadow: 0px 2px 7px grey;color:black;
	}
	.order-menu a:link,a:visited,a:active{
		text-decoration: none; color:black;
	}
	.blue-circle{
		height:20px;width:20px;background-color: #3498DB;border-radius:50%;float: right; margin-top: -8px;
	}
	a{
		width: 100%;height: 100%;
	}
	
</style>
</head>
<body>
	<!-- -----goes inside service() -->
		<% 
			
			if(request.getAttribute("valid")==null && request.getSession().getAttribute("isValiduser")==null){
	 			response.sendRedirect("index.jsp");
			}else{
				
			}
		%>
		
	<!-- ----goes outside service() -->	
		<%! 
			 	
		
		%>	
			
	

	<div class="order-menu">
		<p class="blue-circle" style="background-color: black;margin-right: 30px"></p><p class="blue-circle"></p>
		<p class="menu-item" style= "margin-top:80px;" ><a href="placeorder.jsp">place order</a></p>
		<p class="menu-item"><a href="orderStatus.jsp">order status</a></p>
		<p class="menu-item"><a href="modifyOrder.jsp">modify order</a></p>
	</div>

</body>
</html>