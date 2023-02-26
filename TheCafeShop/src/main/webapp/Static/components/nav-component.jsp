<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<nav style="box-shadow: 0px 0px 20px 4px #b3b3b3;" class="navbar navbar-expand-lg navbar-light bg-light">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="#">
	      <img style="border: 1px solid #c5c4c4" src="Static/images/logo.png" alt="" width="100">
	    </a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNav">
	      <ul class="navbar-nav">
	        <li class="nav-item">
	          <a class="nav-link" id='home-nav' aria-current="page" href="home">Book Table</a>
	        </li>
	        <div class="vr"></div>
	        <li class="nav-item">
	          <a class="nav-link" id='order-nav' aria-current="page" href="order">Order Food</a>
	        </li>
	        <div class="vr"></div>
	        <li class="nav-item">
	          <a class="nav-link" id='my-orders-nav' aria-current="page" href="my-orders">My Orders</a>
	        </li>
	      </ul>
	    </div>
	    
	    <div style="float: left; font-size: 1.1rem">
	    	<span>Hello, <font color="green"><%= session.getAttribute("username") %></font></span>
	    	<div class="vr"></div>
	    	<a href="logout">Sign out</a>
	    </div>
	  </div>
	</nav>
	
	<script>
		// original URL -> http://localhost:8080/MyCafeShop/home
		// After splitting -> [ 'http:', '', 'localhost:8080', 'MyCafeShop', 'home' ]
		var currentPath = document.URL.split('/')[4]; // currentPath <- 'home'
		
		const navs = {
				'home': 'home-nav',
				'order': 'order-nav',
				'my-orders': 'my-orders-nav'
		};
		
		Object.keys(navs).forEach(key => {
			if (key === currentPath) {
				document.getElementById(navs[key]).classList.add('active');
				document.getElementById(navs[key]).style.color = 'green';
			} else {
				document.getElementById(navs[key]).classList.remove('active');
				document.getElementById(navs[key]).style.color = 'gray';
			}
		});
	</script>
</body>
</html>