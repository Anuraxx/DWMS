<%@include file="register.jsp"%>
<%@include file="imports.jsp" %>

<script type="text/javascript">
	
	/*-----------------------------------*/
	$(function() {
		$("section[class=email]").remove();
		$("section[class=phone]").remove();
		$("input[name=address]").remove();
		$("select[name=occup]").remove();
		
		$(".reg-form-inp-bs").css('margin-top', '0px');
		$("input[name=pass]").attr('class', 'reg-form-inp');
		$(".reg-form-div").css('height', '391px');
		$(".reg-form-div .reg-form .unk").attr('value', 'addTester');

	});

</script>