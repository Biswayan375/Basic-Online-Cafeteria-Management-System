<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<!-- 
		Confirmation Modal -------------------------------------------------------------------------------
	 -->
	<div class="modal" id="booking-confirm-modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Payment for Booking</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p id="booking-confirm-modal-text"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
	        <button onclick="return bookNow(event)" type="button" class="btn btn-primary">Pay & Book</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 
		----------------------------------------------------------------------------------------------------
	 -->


	<form action="check-seat" method="post">
		<label for="table-select">For how many?</label>
		<select id="table-select" class="form-select" name="table-select">
			<option name="2" value="2">Couple</option>
			<option name="4" value="4">Small Family of Four</option>
			<option name="6" value="6">Party for 6</option>
			<option name="10" value="10">Meeting upto 10</option>
		</select>
		<button class="btn btn-sm btn-outline-success mt-3">Check Availability</button>
	</form>
	<%
		if (session.getAttribute("seat-availability") != null) {
			ResultSet result = (ResultSet)session.getAttribute("seat-availability");
			%>
			<hr>
			<table class="table table-success table-striped">
				<thead>
					<tr style="text-align: center;">
						<th scope="col">Table No.</th>
						<th scope="col">Capacity</th>
						<th scope="col">Action</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < (int)session.getAttribute("available"); i++, result.next()) {
							%>
							<tr style="text-align: center;">
								<td><%= result.getString("table_no") %></td>
								<td><%= result.getString("capacity") %></td>
								<td>
									<form onsubmit="return handleSubmit(event)" action="book-seat" method="post">
										<input style="display: none" name="book-table-id" value=<%= result.getString("id") %> />
										<button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#booking-confirm-modal" data-tableCapacity='<%= result.getString("capacity") %>'>
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-journal-check" viewBox="0 0 16 16">
											  <path fill-rule="evenodd" d="M10.854 6.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 8.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
											  <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
											  <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
											</svg>
										</button>
									</form>
								</td>
							</tr>
							<%
						}
					%>
				</tbody>
			</table>
			<%
			session.removeAttribute("seat-availability");
			session.removeAttribute("available");
		} else if (session.getAttribute("seat-availability-error") != null) {
			%>
			<hr>
			<span style="color: tomato; display: block; text-align: center;"><%= session.getAttribute("seat-availability-error") %></span>
			<%
			session.removeAttribute("seat-availability-error");
		}
	%>
	
	<script>
		var formToSubmit = null;
		function handleSubmit(event) {
			event.preventDefault();
			formToSubmit = event.target;
			
			modalText = document.getElementById("booking-confirm-modal-text")
			submitter = event.submitter;
			
			perSeatCharge = 200;
			seatTotal = (perSeatCharge * submitter.getAttribute('data-tableCapacity'));
			tax = Math.round((seatTotal * 18) / 100);
			
			modalText.innerHTML = '<b>Booking charge/table: </b><font color="green">' + perSeatCharge + ' INR</font><br><b>Total for seat:</b> <font color="green">' + seatTotal + ' INR</font><br><b>TAX & GST: </b><font color="green">' + tax + ' INR</font><br><b>Total payable: </b><font color="green">' + (seatTotal + tax) + ' INR </font><font color="red"><b><em>(Non-refundable)</em></b></font><br><font><b><em>You must report within 24hrs. of your booking or it will be considered cancelled</em></b></font>';
		}
		
		function bookNow(event) {
			if (formToSubmit != null)
				formToSubmit.submit();
		}
	</script>
</body>
</html>