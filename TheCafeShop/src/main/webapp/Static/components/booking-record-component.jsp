<%@page import="ApplicationUtils.DateFormatter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<%
		String tableNo = request.getParameter("table-no"),
			bookingNo = request.getParameter("booking-no"),
			date = request.getParameter("date"),
			time = request.getParameter("time"),
			remarks = request.getParameter("remarks"),
			capacity = request.getParameter("capacity");
	%>
	<div style="border-radius: 4px; border: 2px solid green; margin: 10px; padding: 15px" class="bg-light">
		<div style="display: flex; justify-content: space-between; align-items: center">
			<span><font color="brown">Booking No. </font><span><font color="green" class="badge rounded-pill bg-success"><%= bookingNo %></font></span></span>
			<span><font color="brown"><%= new DateFormatter(date, "yyyymmdd") %></font> <font color="green">@<%= time %></font></span>
			<% if (remarks.equals("PENDING")) { %>
			<div>
				<form onsubmit="return handleDelete(event)" action="cancel-booking" method="post">
					<input style="display: none" name="book-table-id" value=<%= bookingNo %> />
					<input style="display: none" name="table-id" value="<%= tableNo %>" />
					<button class="btn btn-sm btn-danger">
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
			<span><font color="brown">Table No. </font><span><font color="green"><%= tableNo %></font></span></span>
			<span><font color="brown">For </font> <font color="green"><%= capacity %> Persons</font></span>
			<span><font color="brown">Status: </font> <font id="booking-status"><%= remarks %></font></span>
		</div>
	</div>
	
	<script>
		document.querySelectorAll('#booking-status').forEach(text => {
			if (text.innerHTML === 'PENDING') {
				text.classList.add('badge', 'bg-warning');
			} else if (text.innerHTML === 'SETTLED') {
				text.classList.add('badge', 'bg-success');
			} else {
				text.classList.add('badge', 'bg-danger');
			}
		});
	</script>
</body>
</html>