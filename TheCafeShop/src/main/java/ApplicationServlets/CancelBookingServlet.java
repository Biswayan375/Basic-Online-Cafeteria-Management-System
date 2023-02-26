package ApplicationServlets;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBQuery;

@WebServlet(name = "CancelBookingServlet", value = { "/cancel-booking" })
public class CancelBookingServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		int tableId = Integer.parseInt(req.getParameter("table-id"));
		String bookingId = req.getParameter("book-table-id");
		HttpSession session = req.getSession();
		try {
			DBQuery.makeTableAvailable(getServletContext().getInitParameter("DB_NAME"), tableId);
			DBQuery.cancelBooking(getServletContext().getInitParameter("DB_NAME"), bookingId);
			session.setAttribute("flash-success-message", "Your booking has been cancelled!");
		} catch(Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-error-message", "An unexpected error has occurred, cannot cancel booking right now!");
		}
		
		res.sendRedirect(req.getContextPath() + "/home");
	}
}
