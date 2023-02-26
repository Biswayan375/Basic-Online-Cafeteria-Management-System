<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MyCafeteria - Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="<%= request.getContextPath() + "/Static/Style/Default.css?id=5233" %>">
<style>
	#password-message, #confirm-password-message { color: tomato; }
</style>
</head>
<body>
	<div class="custom-container" style="top: 50px">
		<!-- 
			FLASH MESSAGE SECTION ---------------------------------------------------------------------------------------------
		 -->
		<%
			String flash = (String)session.getAttribute("flash-message");
			if (flash != null) {
				if (!flash.equals("")) {
					%>
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-diamond" viewBox="0 0 16 16">
						  <path d="M6.95.435c.58-.58 1.52-.58 2.1 0l6.515 6.516c.58.58.58 1.519 0 2.098L9.05 15.565c-.58.58-1.519.58-2.098 0L.435 9.05a1.482 1.482 0 0 1 0-2.098L6.95.435zm1.4.7a.495.495 0 0 0-.7 0L1.134 7.65a.495.495 0 0 0 0 .7l6.516 6.516a.495.495 0 0 0 .7 0l6.516-6.516a.495.495 0 0 0 0-.7L8.35 1.134z"/>
						  <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
						</svg>
					  <%= flash %>
					  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
					<%
				}
				session.setAttribute("flash-message", null);
			}
		%>
		<!-- 
			--------------------------------------------------------------------------------------------------------------------
		 -->
	
		<form class="shadowed-form" action="register" method="post">
			<div style="display: flex; justify-content: space-between; align-items: center;">
				<div>
					<img style="border: 1px solid #c5c4c4" src="Static/images/logo.png" alt="company logo" width="100" />
				</div>
				<div>
					<h3><font color="brown">Sign</font> <font color="green">Up</font></h3>
				</div>
			</div>
			<hr>
			<div class="mb-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
				  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
				</svg>
			    <label for="username" class="form-label">Username*</label>
			    <input placeholder="e.g. sandwich305" type="text" class="form-control" id="username" name="username" minlength="3" required>
			</div>
			
			<div class="mb-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-at-fill" viewBox="0 0 16 16">
				  <path d="M2 2A2 2 0 0 0 .05 3.555L8 8.414l7.95-4.859A2 2 0 0 0 14 2H2Zm-2 9.8V4.698l5.803 3.546L0 11.801Zm6.761-2.97-6.57 4.026A2 2 0 0 0 2 14h6.256A4.493 4.493 0 0 1 8 12.5a4.49 4.49 0 0 1 1.606-3.446l-.367-.225L8 9.586l-1.239-.757ZM16 9.671V4.697l-5.803 3.546.338.208A4.482 4.482 0 0 1 12.5 8c1.414 0 2.675.652 3.5 1.671Z"/>
				  <path d="M15.834 12.244c0 1.168-.577 2.025-1.587 2.025-.503 0-1.002-.228-1.12-.648h-.043c-.118.416-.543.643-1.015.643-.77 0-1.259-.542-1.259-1.434v-.529c0-.844.481-1.4 1.26-1.4.585 0 .87.333.953.63h.03v-.568h.905v2.19c0 .272.18.42.411.42.315 0 .639-.415.639-1.39v-.118c0-1.277-.95-2.326-2.484-2.326h-.04c-1.582 0-2.64 1.067-2.64 2.724v.157c0 1.867 1.237 2.654 2.57 2.654h.045c.507 0 .935-.07 1.18-.18v.731c-.219.1-.643.175-1.237.175h-.044C10.438 16 9 14.82 9 12.646v-.214C9 10.36 10.421 9 12.485 9h.035c2.12 0 3.314 1.43 3.314 3.034v.21Zm-4.04.21v.227c0 .586.227.8.581.8.31 0 .564-.17.564-.743v-.367c0-.516-.275-.708-.572-.708-.346 0-.573.245-.573.791Z"/>
				</svg>
			   <label for="email" class="form-label">Email*</label>
			   <input placeholder="e.g. momo@burger.com" type="email" class="form-control" id="email" name="email" required>
		 	</div>
		 	
		 	<div class="mb-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone-fill" viewBox="0 0 16 16">
				  <path d="M3 2a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V2zm6 11a1 1 0 1 0-2 0 1 1 0 0 0 2 0z"/>
				</svg>
			   <label for="mobile" class="form-label">Mobile*</label>
			   <input placeholder="e.g. 9999999999" type="number" class="form-control" id="mobile" name="mobile" required>
		 	</div> 
			
			<div class="mb-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key-fill" viewBox="0 0 16 16">
				  <path d="M3.5 11.5a3.5 3.5 0 1 1 3.163-5H14L15.5 8 14 9.5l-1-1-1 1-1-1-1 1-1-1-1 1H6.663a3.5 3.5 0 0 1-3.163 2zM2.5 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
				</svg>
			    <label for="password" class="form-label">Password*</label>
			    <input onkeyup="return handleTextChange(event)" placeholder="e.g. a@#B029!&" type="password" class="form-control" id="password" name="password" required>
				<span id="password-message"></span>
			</div>
			
			<div class="mb-3">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key-fill" viewBox="0 0 16 16">
				  <path d="M3.5 11.5a3.5 3.5 0 1 1 3.163-5H14L15.5 8 14 9.5l-1-1-1 1-1-1-1 1-1-1-1 1H6.663a3.5 3.5 0 0 1-3.163 2zM2.5 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
				</svg>
			    <label for="confirm-password" class="form-label">Confirm Password*</label>
			    <input onkeyup="return handleTextChange(event)" type="password" class="form-control" id="confirm-password" name="confirm-password" required>
			    <span id="confirm-password-message"></span>
			</div>
			
			<div style="text-align: right">
				<a href="<%= (request.getContextPath() + "/login") %>">Already have an account?</a>
			 	<button id="register-btn" type="submit" class="btn btn-primary">Register</button>
			 </div>
		</form>
	</div>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script>
		var password = "", confirmPassword = "";
		/**
		 * REGEX FOR PASSWORD ----------------------------------------------------
		 * (?=.*[0-9]) - Assert a string has at least one number.				 |
		 * (?=.*[!@#$%^&*]) - Assert a string has at least one special character.|
		 * (?=.*[a-z]) - Assert a string has at least one lower case character.	 |
		 * (?=.*[A-Z]) - Assert a string has at least one upper case character.	 |
		 * {8, 16} - Total length of the string must be between 8 and 16.		 |
		 * -----------------------------------------------------------------------
		*/
		const passwordMatchExp = /^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%^&*]{8,16}$/;
		const btn = document.getElementById("register-btn");
		
		function handleTextChange(event) {
			if (event.target.name === "password") {
				password = document.getElementById(event.target.id).value;
			} else if (event.target.name === "confirm-password") {
				confirmPassword = document.getElementById(event.target.id).value;
			}
			
			if (passwordMatchExp.test(password) && password == confirmPassword) {
				document.getElementById("confirm-password-message").innerHTML = '';
				document.getElementById("password-message").innerHTML = '';
				btn.disabled = false;
			} else {
				btn.disabled = true;
				if (password != confirmPassword)
					document.getElementById("confirm-password-message").innerHTML = 'password did not matched';
				else
					document.getElementById("confirm-password-message").innerHTML = '';
				
				if (!passwordMatchExp.test(password))
					document.getElementById("password-message").innerHTML = 'password must contain one upper case, one lower case, one special character and one digit';
				else
					document.getElementById("password-message").innerHTML = '';
			}
		}
	</script>
</body>
</html>