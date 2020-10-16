<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="imports.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>Admin</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=ABeeZee' rel='stylesheet'>
    <link href='main.css' rel='stylesheet'>
    <link href='adm.css' rel='stylesheet'>
    

	

</head>
<body>
	<% request.setAttribute("valid", "false"); %>

	<div id="box">
        <div id="insd">
            <form id="login-form" action="Varify" method="POST">
           		<input type="text" name="unk" value="admin-login" class="unk" >
                <input type="text" name="name" id="name" class="inp" placeholder="username" required=""><br>
                <input type="password" name="pass" id="pass" class="inp" placeholder="password" required><br>
                <input type="submit" value="Login" id="submit" >
                <p id="msg">${wp}</p>
                <p id="reset">Reset password ?</p>
            </form>
                <div id="panel">
                    <form id="form2" action="Reset" method="POST">
                    	<input type="text" name="unk" value="admin-reset" class="unk">
                        <input type="password" name="op" class="inp2" placeholder="old password" required><br>
                        <input type="password" name="np" class="inp2" placeholder="new password" required><br>
                        <input type="submit" value="reset" id="submit2">
                        <!--  p id="msg">${rp }</p-->
                    </form>
                </div>
            
        </div>
    </div>

    
	<script>                                          // jQuery has higher priority than css<style>
    	//$.noConflict();
        $(function(){
        /*	var temp=(jQuery("body").innerWidth()-300)/2;   
        	var col="red";
        	//jQuery("#form").css("background-color",col);

        	jQuery("#insd").css({"margin-left":temp, "margin-right":temp});  */
			$("#zee").css("backgroundColor","red");
        	
 		 	$("#reset").click(function(){
 		 		$("#panel").slideToggle("slow");
  		 	 });
        	$("#submit2").click(function(event) {
        		$("#panel").slideToggle("slow");
 		 	});
 		 	
 		 	

  				
  		});
	</script>



</body>

</html>