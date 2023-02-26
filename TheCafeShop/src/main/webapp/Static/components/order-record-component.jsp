<%@page import="ApplicationUtils.DateFormatter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<%
		String orderNo = request.getParameter("order-no"),
			itemName = request.getParameter("item-name"),
			itemPrice = request.getParameter("item-price"),
			itemQuantity = request.getParameter("quantity"),
			itemImage = request.getParameter("item-image"),
			deliveryCharge = request.getParameter("delivery-charge"),
			address = request.getParameter("address"),
			mobile = request.getParameter("mobile"),
			date = request.getParameter("date"),
			time = request.getParameter("time"),
			status = request.getParameter("status"),
			user = (String)session.getAttribute("username");
		int totalPayable = (Integer.parseInt(itemPrice) * Integer.parseInt(itemQuantity)) + Integer.parseInt(deliveryCharge);
	%>
	<div style="border-radius: 4px; border: 2px solid green; margin: 10px; padding: 15px" class="bg-light">
		<div style="display: flex; justify-content: space-between; align-items: center">
			<span><font color="brown">Order ID. </font><span><font color="green" class="badge rounded-pill bg-success"><%= orderNo %></font></span></span>
			<span><font color="brown"><%= new DateFormatter(date, "yyyymmdd") %></font> <font color="green">@<%= time %></font></span>
			<% if (status.equals("PENDING")) { %>
			<div>
				<form onsubmit="return handleSubmit(event)" action="cancel-order" method="post">
					<input style="display: none; visibility: hidden;" name="order-no" value="<%= orderNo %>" />
					<input style="display: none; visibility: hidden;" name="quantity" value="<%= itemQuantity %>" />
					<button type="submit" class="btn btn-sm btn-danger">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
						  <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"/>
						</svg>
					</button>
				</form>
			</div>
			<% } %>
		</div>
		
		<hr>
		
		<div style="display: flex; justify-content: space-between; align-items: center">
			<section>
				<img style="border-radius: 50%; border: 1px solid gray; padding: 1px;" width="80px" height="80px" alt="product image" src="http://localhost:8082/MCASEM-1_Project/resource/<%= itemImage %>" />
			</section>
			<section style="display: flex; flex-direction: column; width: 40%">
				<span><font color="green">Item: </font><font color="brown"><%= itemName %></font></span>
				<span><font color="green">User: </font><font color="brown"><%= user %></font></span>
				<span><font color="green">Phone: </font><font color="brown"><%= mobile %></font></span>
				<span><font color="green">Address: </font><font color="brown"><%= address %></font></span>
			</section>
			<div class="vr"></div>
			<section style="display: flex; flex-direction: column; width: 40%">
				<div><font color="green">Price x Quantity: </font><span style="float: right"><font color="brown"><%= "&#8377;" + itemPrice + " x " + itemQuantity %></font></span></div>
				<div><font color="green">Delivery Charge: </font><span style="float: right"><font color="brown"><%= "&#8377;" + deliveryCharge %></font></span></div>
				<hr>
				<div><font color="green">Total: </font><span style="float: right"><font color="brown"><%= "&#8377;" + totalPayable %></font></span></div>
				<div><font color="green">Payment Mode: </font><font color="brown">Cash On Delivery</font></div>
			</section>
		</div>
		
		<hr>
		
		<div style="display: block; text-align: right;">
			<font color="green">Status: </font><font id="order-status" color="brown"><%= status %></font>
		</div>
	</div>
	
	<script>
		document.querySelectorAll('#order-status').forEach(text => {
				if (text.innerHTML === 'PENDING') {
					text.classList.add('badge', 'bg-warning');
				} else if (text.innerHTML === 'DELIVERED') {
					text.classList.add('badge', 'bg-success');
				} else if (text.innerHTML === 'ON THE WAY') {
					text.classList.add('badge', 'bg-info');
				} else {
					text.classList.add('badge', 'bg-danger');
				}
			});
	</script>
</body>
</html>