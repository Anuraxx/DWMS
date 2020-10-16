<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Scanner" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>head</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=ABeeZee' rel='stylesheet'>
    <link rel="stylesheet" type="text/css" href="main.css">
</head>



<body style="background-image: url('Water1.jpg'); background-repeat: no-repeat;background-size: 100% 1200px">
	<div class="header"> 
		<a href="#" ><section class="brand-name">P U R E </section></a>
		
		<p class="hello-user">hello! <span style="color:white"><%= request.getSession().getAttribute("hellousr")==null?"": new Scanner(request.getSession().getAttribute("hellousr").toString()).next() %></span></p>
		
		<div class="drop-down-menu-tri"></div>
		<ul class="header-menu" >
			<li><a href="register.jsp">register</a></li>
			<li><a href="login.jsp">login</a></li>
			<li><a href="admin.jsp">admin</a></li>
			<li><a href="placeorder.jsp">place order</a></li>
			<li><a href="tester.jsp">quality inspection</a></li>
			<li><a href="logout.jsp">logout</a></li>
			

		</ul>
	</div>
	
	
	
	<script type="text/javascript">
		$(".drop-down-menu-tri").hover(function() {
			$(".header-menu").slideToggle('slow');
		}, function() {
			$(".header-menu li a").click(function(event) {
				$(".header-menu").slideUp('slow');
			});
		});
	</script>

</body>
</html>