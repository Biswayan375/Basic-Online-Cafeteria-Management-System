<%@page import="ApplicationUtils.DateFormatter"%>
<%@page import="ApplicationUtils.ResultSetAndStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
	<%
		if (session.getAttribute("flash-mybookingshistory-error-message") != null) {
			%>
			<span style="display: block; text-align: center;"><%= session.getAttribute("flash-mybookingshistory-error-message") %></span>
			<%
			session.removeAttribute("flash-mybookingshistory-error-message");
		} else if (session.getAttribute("flash-mybookingshistory") != null) {
			ResultSetAndStatement result = (ResultSetAndStatement)session.getAttribute("flash-mybookingshistory");
			for (int i = 0; i < (int)session.getAttribute("all-bookingshistory"); i++, result.rs.next()) {
				%>
				<jsp:include page="./booking-record-component.jsp">
					<jsp:param value='<%= result.rs.getString("date") %>' name="date"/>
					<jsp:param value='<%= result.rs.getString("time") %>' name="time"/>
					<jsp:param value='<%= result.rs.getString("table_no") %>' name="table-no"/>
					<jsp:param value='<%= result.rs.getString("bid") %>' name="booking-no"/>
					<jsp:param value='<%= result.rs.getString("capacity") %>' name="capacity"/>
					<jsp:param value='<%= result.rs.getString("remarks") %>' name="remarks"/>
				</jsp:include>
				<%
			}
			
			result.doneWithIt();
			session.removeAttribute("flash-mybookingshistory");
			session.removeAttribute("all-bookingshistory");
		}
	%>
</body>
</html>