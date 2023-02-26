<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>TheCafeShop - Order</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="<%= request.getContextPath() + "/Static/Style/Default.css?id=4352" %>">
		<style>
			#product-card-holder {
				display: block;
				margin: auto;
				text-align: center;
				border: 1px solid #c8c9ca;
				border-radius: 5px;
				max-width: 86%;
				padding: 20px;
				max-height: 530px;
				overflow: auto;
			}
			.card {
				width: fit-content;
				display: inline-block;
				margin-top: 3px;
				padding: 10px;
				border: 1px solid #b2b2b2;
			}
		</style>
	</head>
	<body style="background-image: url('Static/images/background.jpeg');">
		<jsp:include page="../components/nav-component.jsp" />
		<div style="margin-top: 10px; background-color: whitesmoke" class="container">
			<h2 class="display-3">Order your <font color="green">Meal</font></h2>
			<hr>
		</div>

		
		<section style="background-color: white" id="product-card-holder" class="shadowed-form">
			<jsp:include page="../components/all-products-component.jsp" />
		</section>
		
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>