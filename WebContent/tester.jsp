<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="login.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<script type="text/javascript">
    	$(function () {
    		
    		
    		$("#form2 input:first-child").addClass("inp2");
    		$("#form2 input:first-child").attr({type:"text",name:"userid",placeholder:"tester id",required:""});
    		
			$("#login-form").attr('action', 'testerlogin');
			$("#login-form .unk").attr('value','testerlogin');
			
			$("#form2").attr('action','testerlogin');
			$("#form2 .unk").attr('value','testerlogin');
			
			$("#login-form .inp:first").attr('placeholder','tester id');
			
		});
    </script>
</body>
</html>