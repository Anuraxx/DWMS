<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="admin.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Admin</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=ABeeZee' rel='stylesheet'>
    <link href='main.css' rel='stylesheet'>
    <link href='adm.css' rel='stylesheet'>
    <link href='login.css' rel='stylesheet'>
</head>



<body>

	
    
	 <script type="text/javascript">
    	$(function () {
    		
    		var newItem = document.createElement("input");
    		var formElemnt=document.getElementById("form2");
    		formElemnt.insertBefore(newItem, formElemnt.childNodes[0]);
    		
    		$("#form2 input:first-child").addClass("inp2");
    		$("#form2 input:first-child").attr({type:"text",name:"unameoremail",placeholder:"username or email",required:""});
    		
			$("#login-form").attr('action', 'usrlogin');
			$("#login-form .unk").attr('value','usrlogin');
			
			$("#form2").attr('action','usrReset');
			$("#form2 .unk").attr('value','usrReset');
			
			
		});
    </script>
   
</body>
</html>