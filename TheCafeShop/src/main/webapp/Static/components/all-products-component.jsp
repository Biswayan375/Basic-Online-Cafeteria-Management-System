<%@page import="ApplicationUtils.ResultSetAndStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<!-- 
		FLASH MESSAGE SECTION ---------------------------------------------------------------------------------------------
	 -->
	 <%
	 	if (session.getAttribute("flash-orderfood-error-message") != null) {
	 		%>
			<div style="width: 790px; margin: auto; margin-bottom: 28px;" class="alert alert-danger alert-dismissible fade show" role="alert">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-diamond" viewBox="0 0 16 16">
				  <path d="M6.95.435c.58-.58 1.52-.58 2.1 0l6.515 6.516c.58.58.58 1.519 0 2.098L9.05 15.565c-.58.58-1.519.58-2.098 0L.435 9.05a1.482 1.482 0 0 1 0-2.098L6.95.435zm1.4.7a.495.495 0 0 0-.7 0L1.134 7.65a.495.495 0 0 0 0 .7l6.516 6.516a.495.495 0 0 0 .7 0l6.516-6.516a.495.495 0 0 0 0-.7L8.35 1.134z"/>
				  <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
				</svg>
			  <%= session.getAttribute("flash-orderfood-error-message") %>
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
			<%
	 		
	 		session.removeAttribute("flash-orderfood-error-message");
	 	} else if (session.getAttribute("flash-orderfood-success-message") != null) {
	 		%>
	 		<div style="width: 790px; margin: auto; margin-bottom: 28px;" class="alert alert-success alert-dismissible fade show" role="alert">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
				  <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
				  <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
				</svg>
			  <%= session.getAttribute("flash-orderfood-success-message") %>
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
	 		<%
	 		
	 		session.removeAttribute("flash-orderfood-success-message");
	 	}
	 %>
	<!-- 
		-------------------------------------------------------------------------------------------------------------------
	 -->
	 
	<!-- 
		Confirmation Modal -------------------------------------------------------------------------------
	-->
	<div class="modal" id="order-confirm-modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Place Order</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <span>
	        	<form id="order-confirm-modal-text" style="text-align: left" action="order" method="post">
	        		<!-- Populated with JavaScript -->
	        	</form>
	        </span>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 
		----------------------------------------------------------------------------------------------------
	-->
	
	<input id="username" style="display: none; visibility: hidden" value='<%= session.getAttribute("username") %>' readonly/>
	
	
	
	 
	<%
		if (session.getAttribute("flash-orderfood-error-message") != null) {
			%>
			<span style="display: block; text-align: center;"><%= session.getAttribute("flash-orderfood-error-message") %></span>
			<%
			session.removeAttribute("flash-orderfood-error-message");
		} else {
			ResultSetAndStatement result = (ResultSetAndStatement)session.getAttribute("flash-orderfood");
			for (int i = 0; i < (int)session.getAttribute("all-orders"); i++, result.rs.next()) {
				String name = result.rs.getString("name"),
						price = result.rs.getString("price"),
						image_path = result.rs.getString("image"),
						quantity = result.rs.getString("quantity");
				%>
				<jsp:include page="./product-card-component.jsp">
					<jsp:param value="<%= name %>" name="name"/>
					<jsp:param value="<%= price %>" name="price"/>
					<jsp:param value="<%= image_path %>" name="image_path"/>
					<jsp:param value="<%= quantity %>" name="quantity"/>
				</jsp:include>
				<%
			}
			result.doneWithIt();
			session.removeAttribute("flash-orderfood");
			session.removeAttribute("all-orders");
		}
	%>
</body>
</html>