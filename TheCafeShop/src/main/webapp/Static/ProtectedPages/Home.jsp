<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TheCafeShop - Home</title>
<style type="text/css">
	.box-section {
		display: flex;
		justify-content: space-evenly;
	}
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="<%= request.getContextPath() + "/Static/Style/Default.css?id=5231" %>">
</head>
<body style="background-image: url('Static/images/background.jpeg');">
	<jsp:include page="../components/nav-component.jsp" />
	<div style="margin-top: 10px; background-color: whitesmoke" class="container">
		<h2 class="display-3">Book your <font color="green">Table</font></h2>
		<hr>
	</div>
	
		<!-- 
			FLASH MESSAGE SECTION ---------------------------------------------------------------------------------------------
		 -->
		<%
			String flash = null;
			if (session.getAttribute("flash-error-message") != null) {
				flash = (String)session.getAttribute("flash-error-message");
				session.removeAttribute("flash-error-message");
				%>
				<div style="width: 790px; margin: auto; margin-bottom: 28px;" class="alert alert-danger alert-dismissible fade show" role="alert">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-diamond" viewBox="0 0 16 16">
					  <path d="M6.95.435c.58-.58 1.52-.58 2.1 0l6.515 6.516c.58.58.58 1.519 0 2.098L9.05 15.565c-.58.58-1.519.58-2.098 0L.435 9.05a1.482 1.482 0 0 1 0-2.098L6.95.435zm1.4.7a.495.495 0 0 0-.7 0L1.134 7.65a.495.495 0 0 0 0 .7l6.516 6.516a.495.495 0 0 0 .7 0l6.516-6.516a.495.495 0 0 0 0-.7L8.35 1.134z"/>
					  <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
					</svg>
				  <%= flash %>
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
				<%
			}
			else if (session.getAttribute("flash-success-message") != null) {
				flash = (String)session.getAttribute("flash-success-message");
				session.removeAttribute("flash-success-message");
				%>
				<div style="width: 790px; margin: auto; margin-bottom: 28px;" class="alert alert-success alert-dismissible fade show" role="alert">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
					  <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
					  <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
					</svg>
				  <%= flash %>
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
				<%
			}
		%>
		<!-- 
			--------------------------------------------------------------------------------------------------------------------
		 -->
	
	<section class="box-section">
		<div style="max-height: 450px; height: min-content; overflow: auto; width: 25%; background-color: white" class="shadowed-form">
			<h1 style="color: #6dae25;" class="display-5">Book Now</h1>
			<hr>
			<jsp:include page="../components/booknow-component.jsp" />
		</div>
		<div style="max-height: 450px; height: min-content; overflow: auto; width: 35%; height: fit-content; background-color: white" class="shadowed-form">
			<h1 style="color: #386b00;" class="display-5">Booking History</h1>
			<hr>
			<jsp:include page="../components/booking-history-component.jsp" />
		</div>
		<div style="max-height: 450px; height: min-content; overflow: auto; width: 35%; height: fit-content; background-color: white" class="shadowed-form">
			<h1 style="color: #386b00;" class="display-5">My Bookings</h1>
			<hr>
			<jsp:include page="../components/all-bookings-component.jsp" />
		</div>
	</section>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>