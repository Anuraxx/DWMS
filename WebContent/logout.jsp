
<%
	HttpSession sessions = request.getSession();
	sessions.removeAttribute("fulluname");
	sessions.removeAttribute("hellousr");
	sessions.removeAttribute("isValidtester");
	sessions.removeAttribute("isValiduser");
	

	response.sendRedirect("index.jsp");

%>