<%@page import="ApplicationUtils.DateFormatter"%>
<%@page import="ApplicationUtils.ResultSetAndStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<%
		if (session.getAttribute("flash-my-orders-error-message") != null) {
			%>
			<span style="display: block; text-align: center;"><%= session.getAttribute("flash-my-orders-error-message") %></span>
			<%
			session.removeAttribute("flash-my-orders-error-message");
		} else if (session.getAttribute("flash-my-orders-history") != null) {
			ResultSetAndStatement result = (ResultSetAndStatement)session.getAttribute("flash-my-orders-history");
			result.rs.last();
			int n = result.rs.getRow();
			result.rs.first();
			
			if (n > 0) {
				for (int i = 0; i < n; i++, result.rs.next()) {
					%>
					<jsp:include page="./order-record-component.jsp">
						<jsp:param value='<%= result.rs.getString("order_no") %>' name="order-no"/>
						<jsp:param value='<%= result.rs.getString("item_name") %>' name="item-name"/>
						<jsp:param value='<%= result.rs.getString("item_price") %>' name="item-price"/>
						<jsp:param value='<%= result.rs.getString("item_image") %>' name="item-image"/>
						<jsp:param value='<%= result.rs.getString("item_quantity") %>' name="quantity"/>
						<jsp:param value='<%= result.rs.getString("delivery_charges") %>' name="delivery-charge"/>
						<jsp:param value='<%= result.rs.getString("address") %>' name="address"/>
						<jsp:param value='<%= result.rs.getString("mobile_no") %>' name="mobile"/>
						<jsp:param value='<%= result.rs.getString("order_date") %>' name="date"/>
						<jsp:param value='<%= result.rs.getString("order_time") %>' name="time"/>
						<jsp:param value='<%= result.rs.getString("order_status") %>' name="status"/>
					</jsp:include>
					<%
				}
			} else {
				%>
				<span style="display: block; text-align: center; color: blue; font-weight: bold;">You Currently have no CANCELLED or DELIVERED records :)</span>
				<%
			}
			result.doneWithIt();
			session.removeAttribute("flash-my-orders-history");
		}
	%>
	
	<script>
		var statuses = document.querySelectorAll(".order-status");
		statuses.forEach(status => {
			if (status.innerHTML === "CANCELLED")
				status.classList.add('badge', 'bg-danger');
			else
				status.classList.add('badge', 'bg-success');
		});
	</script>
</body>
</html>