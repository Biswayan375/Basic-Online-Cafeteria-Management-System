<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>MyCafeteria - login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- 
	The CSS file was being cached by the browser automatically and therefore in my dev environment whenever I was
	changing the CSS, it was not reflected as it was not getting the new file but the old cached one. So, by adding
	the small query parameter ?id=1234 will prevent the browser from automatically caching it.
 -->
<link rel="stylesheet" href="<%= request.getContextPath() + "/Static/Style/Default.css" %>">
</head>
<body>
	<div class="custom-container">
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
	
		<form class="shadowed-form" action="login" method="post">
			<div style="display: flex; justify-content: space-between; align-items: center;">
				<div>
					<img style="border: 1px solid #c5c4c4" src="Static/images/logo.png" alt="company logo" width="100" />
				</div>
				<div>
					<h3><font color="brown">Sign</font> <font color="green">in</font></h3>
				</div>
			</div>
			<hr>
		
			 <div class="mb-3">
			 	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
				  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
				</svg>
			   <label for="username" class="form-label">Username</label>
			   <input type="text" class="form-control" id="username" name="username" required>
			 </div>
			 
			 <div class="mb-3">
			 	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
			  <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
			</svg>
			   <label for="password" class="form-label">Password</label>
			   <input type="password" class="form-control" name="password" id="password" required>
			 </div>
			 
			 <div style="text-align: right">
				<a href="<%= (request.getContextPath() + "/register") %>">New user?</a>
			 	<button type="submit" class="btn btn-primary">Login</button>
			 </div>
		</form>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>