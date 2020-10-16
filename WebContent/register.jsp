<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="header.jsp" %>  

<!DOCTYPE html>
<html>
<head>
	<title>register</title>
	
<!-- ---------------------------------------------------------------------------------------------------for dateandtime ui -------------------------->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<!-- --------------------------------------------------------------------------------------------------------------------------------------------- -->
    
    <link href='https://fonts.googleapis.com/css?family=ABeeZee' rel='stylesheet'>
    <link href="main.css" rel="stylesheet" type="text/css" />
    <link href="reg.css" rel="stylesheet" type="text/css" />
    <link href='adm.css' rel='stylesheet'>
    
<!-------------------------------------------------------------------------------------------------------------------css-------------->    
    
</head>
<body>
	
	<p class="reg-success-msg">${success }</p>
	
	<div class="reg-form-div">
		<form class="reg-form" method="post" action="register">
			<input type="text" name="unk" value="registration" class="unk">
			<section class="un">
			<input type="text" name="un" placeholder="username" class="reg-form-inp first-last-inp" required> <br>
			<p class="reg-msg" >${unamexp }</p>
			</section>
			<section class="email">
			<input type="email" name="email" placeholder="email address" class="reg-form-inp" required><br>
			<p class="reg-msg">${emailexp }</p>
			</section>
			<section class="phone">
			<input type="text" name="phone" placeholder="mobile number" class="reg-form-inp" required><br>
			<p class="reg-msg">${phonexp }</p>
			</section> 
			<input type="text" name="address" placeholder="complete address" class="reg-form-inp" required><br>
			<section class="reg-form-inp-bs">
				<input id="datepicker8" width="275px" name="dob" placeholder="date of birth" required>
				<p class="reg-dob-msg">${dobexp }</p>
			</section><br>
			<input type="password" name="pass" placeholder="password" class="reg-form-inp first-last-inp" required><br><br>
			<section class="reg-form-radio">
				<input type="radio" name="gender" value="male" required> Male  
				<input type="radio" name="gender" value="female" required> Female  
				<input type="radio" name="gender" value="other" required> Other
			</section>
			<select class="reg-form-select" name="occup" required>
				<option value="">type</option>
				<option value="student">student</option>
				<option value="employee">employee</option>
				<option value="unemployed">unemployed</option>
			</select><br>
			<input type="submit" name="" value="register" class="reg-form-button"><br>
			
		</form>
	</div>

<!-- ------------------------------------------------------------------------------------------------------------------jquery------------>
	<script>
        $('#datepicker8').datepicker({
            uiLibrary: 'bootstrap4'
        });
    </script>

</body>
</html>