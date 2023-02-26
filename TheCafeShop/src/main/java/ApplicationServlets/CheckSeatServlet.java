package ApplicationServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBConnection;

@WebServlet(name = "CheckSeatServlet", value = { "/check-seat" })
public class CheckSeatServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		String forHowMany = req.getParameter("table-select");
		HttpSession session = req.getSession();
		Connection conn = DBConnection.getConnection();
		
		try {
			int n;
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String query = "use " + getServletContext().getInitParameter("DB_NAME") + ";";
			stmt.execute(query);
			query = "select id, table_no, capacity from seating_table where is_available=1 and capacity=" + forHowMany + ";";
			ResultSet result = stmt.executeQuery(query);
			result.last();
			n = result.getRow();
			result.first();
			
			if (n == 0) {
				session.setAttribute("seat-availability-error", "Sorry, we are currently full :(");
			} else {
				session.setAttribute("seat-availability", result);
				session.setAttribute("available", n);
			}
			
//			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("seat-availability-error", "An unexpected error has occurred :(");
		}
		
		res.sendRedirect(req.getContextPath() + "/home");
	}
}
