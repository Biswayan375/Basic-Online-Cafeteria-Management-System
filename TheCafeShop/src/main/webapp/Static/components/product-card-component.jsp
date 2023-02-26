<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<%
		String name = request.getParameter("name"),
		price = request.getParameter("price"),
		quantity = request.getParameter("quantity"),
		image_name = request.getParameter("image_path");
	%>
	
	
	
	<div class="card">
		<%
			if (!quantity.equals("0")) {
				%>
				<div action="order" method="POST" style="display: flex; flex-direction: column;">
					<img alt="product image" src="http://localhost:8082/MCASEM-1_Project/resource/<%= image_name %>" width="200px" style="border-radius: 5px; margin: auto;" />
					<span style="color: green" class='display-5'><%= name %></span>
					<div style="display: flex; justify-content: space-evenly; align-items: center;">
						<span style="font-weight: bold; color: #08ba7f;" class="fs-4">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-currency-rupee" viewBox="0 0 16 16">
							  <path d="M4 3.06h2.726c1.22 0 2.12.575 2.325 1.724H4v1.051h5.051C8.855 7.001 8 7.558 6.788 7.558H4v1.317L8.437 14h2.11L6.095 8.884h.855c2.316-.018 3.465-1.476 3.688-3.049H12V4.784h-1.345c-.08-.778-.357-1.335-.793-1.732H12V2H4v1.06Z"/>
							</svg>
							<%= price %>
						</span>
						<div class="vr"></div>
						<label for="quantity<%= name %>" class='form-label'>Quantity</label>
						<input id="quantity<%= name %>" style="width: 60px;" class="form-control" type="number" name="quantity" value=1 min=1 max=<% if (Integer.parseInt(quantity) <= 10) out.print(quantity); else out.print("10"); %> required>
					</div>
					<div style="display: block; text-align: center">
						<button onclick="return handleSubmit(event)" type="submit" style="width: 100px; text-align: center" class="btn btn-outline-success mt-2" data-bs-toggle="modal" data-bs-target="#order-confirm-modal" data-name="<%= name %>" data-price=<%= price %> data-image-path=<%= image_name %>>
							Order Now
						</button>
					</div>
				</div>
				<%
			} else {
				%>
				<div style="display: flex; flex-direction: column;">
					<img alt="product image" src="http://localhost:8082/MCASEM-1_Project/resource/<%= image_name %>" width="200px" style="border-radius: 5px; margin: auto; filter: grayscale(100%);" />
					<span style="color: gray" class='display-5'><%= name %></span>
					<div style="display: flex; justify-content: space-evenly; align-items: center;">
						<span style="font-weight: bold; color: gray;" class="fs-4">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-currency-rupee" viewBox="0 0 16 16">
							  <path d="M4 3.06h2.726c1.22 0 2.12.575 2.325 1.724H4v1.051h5.051C8.855 7.001 8 7.558 6.788 7.558H4v1.317L8.437 14h2.11L6.095 8.884h.855c2.316-.018 3.465-1.476 3.688-3.049H12V4.784h-1.345c-.08-.778-.357-1.335-.793-1.732H12V2H4v1.06Z"/>
							</svg>
							<%= price %>
						</span>
					</div>
					<div style="display: block; text-align: center">
						<span style="color: gray; fs-2"><b>Out of Stock</b></span>
					</div>
				</div>
				<%
			}
		%>
	</div>
	
	<script>
		function handleSubmit(event) {
			modalText = document.getElementById("order-confirm-modal-text");
			
			price = event.target.getAttribute("data-price");
			name = event.target.getAttribute("data-name");
			quantity = document.getElementById("quantity" + name).value;
			image = event.target.getAttribute("data-image-path");
			
			
			dtext = '<label class="form-label" for="customer-name">Name</label>   							<input class="form-control" id="customer-name" name="customer-name" value="' + document.getElementById("username").value + '" readonly/>';
			dtext += '<label class="form-label" for="customer-mobile">Mobile</label>   						<input type="number" class="form-control" id="customer-mobile" name="customer-mobile" required />';
			dtext += '<label class="form-label" for="delivery-address">Delivery Address</label>   			<textarea class="form-control" id="delivery-address" name="delivery-address" rows="3" maxlength="99" required></textarea>';
			dtext += '<label class="form-label" for="item-name">Item</label>   								<input id="item-name" class="form-control" name="item-name" value="' + name + '" readonly/>';
			dtext += '<label class="form-label" for="item-quantity">Quantity</label>   						<input class="form-control" id="item-quantity" name="item-quantity" value="' + quantity + '" readonly/>';
			dtext += '<label class="form-label" for="item-price">Price(&#8377;)</label>   					<input class="form-control" id="item-price" name="item-price" value="' + price + '" readonly/>'
			dtext += '<label class="form-label" for="item-total">Item Total(&#8377;)</label>   				<input class="form-control" id="item-total" name="item-total" value=' + (quantity * price) + ' readonly/>';
			dtext += '<label class="form-label" for="delivery-charge">Delivery Charge(&#8377;)</label>   	<input class="form-control" id="delivery-charge" name="delivery-charge" value=30 readonly/>';
			dtext += '<label class="form-label" for="net-charge">Net Payable(&#8377;)</label>				<input class="form-control" id="net-charge" name="net-charge" value="' + ((quantity * price) + 30) + '" readonly/>';
			
			dtext += '<input name="image-path" style="display: none; visibility: hidden" value="' + image + '" readonly/>';
			
			dtext += '<hr><button style="display: block; float: right;" type="submit" class="btn btn-success mt-3">Place Order</button>';
			
			modalText.innerHTML = dtext;
		}
	</script>
</body>
</html>