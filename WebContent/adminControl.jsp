
<%@include file="imports.jsp" %>
<%@include file="usrContent.jsp" %>


<script type="text/javascript">

	$(function(){
		$(".menu-item:nth-child(3) a").html("Add tester");
		$(".menu-item:nth-child(4) a").html("Assign tester");
		$(".menu-item:nth-child(5) a").html("Remove tester");
		
		$(".menu-item:nth-child(3) a").attr('href','addtester.jsp');
		$(".menu-item:nth-child(4) a").attr('href','assign.jsp');
	});
	
	
</script>