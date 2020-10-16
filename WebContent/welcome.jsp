<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<%
//			System.out.print(request.getAttribute("valid").equals("true"));
			if(request.getAttribute("valid")==null || !request.getAttribute("valid").equals("true")){
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}
		%>
					welcome!!
</body>
</html>