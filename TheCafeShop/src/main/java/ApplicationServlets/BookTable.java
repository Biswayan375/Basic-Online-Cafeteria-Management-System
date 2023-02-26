package ApplicationServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBConnection;

@WebServlet(name = "BookTableServlet", value = { "/book-seat" })
public class BookTable extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		HttpSession session = req.getSession();
		String tableId = req.getParameter("book-table-id"),
				user = (String) session.getAttribute("username");
		Connection conn = DBConnection.getConnection();
		
		try {
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			
			String query = "use " + getServletContext().getInitParameter("DB_NAME") + ";";
			stmt.execute(query);
			
			String uid = "";
			int n = 100;
			while (n != 0) {
				uid = "BOK" + UUID.randomUUID().toString().split("-")[0].toUpperCase();
				query = "select * from bookings where bid = '" + uid + "';";
				ResultSet result = stmt.executeQuery(query);
				result.last();
				n = result.getRow();
			}
			
			query = "insert into bookings(`bid`, `cid`, `tid`) values('" + uid + "', '" + user + "', '" + tableId + "')";
			stmt.execute(query);
			query = "update seating_table set is_available=0 where id=" + tableId + ";";
			stmt.execute(query);
			session.setAttribute("flash-success-message", "Table successfully booked :)");
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-error-message", "Booking cannot be done due to an unexpected error, sorry for the inconveinience :(");
		}
		res.sendRedirect(req.getContextPath() + "/home");
	}
}
