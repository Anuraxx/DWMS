<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="imports.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />

		<link type="text/css" href="css/bootstrap.min.css" />
        <link type="text/css" href="css/bootstrap-timepicker.min.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-timepicker.min.js"></script>
        
        <link href="placeorder.css" rel='stylesheet' />
        
</head>
<body>
 	<% 
			HttpSession sess=request.getSession(false);
		
			if(request.getAttribute("valid")==null && sess.getAttribute("isValiduser")==null){
	 			response.sendRedirect("login.jsp");
			}else{
				sess.setAttribute("isValiduser", null);
			}
	%>
	<div class="order-form" style="">
		<p class="blue-circle" style="background-color: black;margin-right: 30px"></p><p class="blue-circle"></p>
		<form action="newOrder" method="post">
			<input type="text" name="unk" value="new-order" class="unk" >
			<div class="number" >
			<b>container's quantity: </b><span class="minus">-</span>
				<input type="text" name="nofcont" value="1" style="width:100px" required/>
				<span class="plus">+</span>
			</div>
			
			<input type="text" name="addr" placeholder="place of delivery"  class="pod" required><br>
			<!--input type="text" name="date" id="datepicker1" width="276px" placeholder="date of delivery" --><br>
			<div role="wrapper" class="gj-datepicker gj-datepicker-bootstrap gj-unselectable input-group" >
				<input type="text" name="date" id="datepicker1" width="276px" placeholder="date of delivery" data-type="datepicker" data-guid="7a9d443d-80be-6c1a-fa72-4693567a21df" data-datepicker="true" class="form-control" role="input" style="padding:3%" required>
				<span class="input-group-append" role="right-icon"><button class="btn btn-outline-secondary border-left-0" type="button"><i class="gj-icon">event</i></button></span>
			</div>
			
    		<div role="wrapper" class="gj-timepicker gj-timepicker-md gj-unselectable" style="width: 80%;margin:10%">
    			<input id="timepicker1" type="text" name="time" class="form-control input-small gj-textbox-md" placeholder="time of delivery" width="80%" data-type="timepicker" data-guid="61cca403-f1ca-4d7d-ea64-343b05679954" data-timepicker="true" role="input" style="padding:4%" required>
    			<i class="gj-icon clock" role="right-icon"></i>
    		</div>

    	
			<button type="submit" class="btn btn-primary">confirm</button>
		</form>
		
		
	
	
	</div>
	
	<script type="text/javascript">
            $('#timepicker1').timepicker();
     </script>
	
	<script type="text/javascript">
	$(function(){
		
        $('#datepicker1').datepicker({
            uiLibrary: 'bootstrap4'
        });
	});
        
    </script>
    <script>
    $(document).ready(function() {
			$('.minus').click(function () {
				var $input = $(this).parent().find('input');
				var count = parseInt($input.val()) - 1;
				count = count < 1 ? 1 : count;
				$input.val(count);
				$input.change();
				return false;
			});
			$('.plus').click(function () {
				var $input = $(this).parent().find('input');
				$input.val(parseInt($input.val()) + 1);
				$input.change();
				return false;
			});
		});
	</script>

</body>
</html>