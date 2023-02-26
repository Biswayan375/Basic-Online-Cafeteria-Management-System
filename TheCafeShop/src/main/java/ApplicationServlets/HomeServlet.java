package ApplicationServlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBQuery;
import ApplicationUtils.ResultSetAndStatement;

@WebServlet(name = "HomeServlet", value = { "/home" })
public class HomeServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		getAllBookings(req, res);
		getBookingHistory(req, res);
		
		req.getRequestDispatcher("Static/ProtectedPages/Home.jsp").forward(req, res);
	}
	
	
	
	
	// utility methods
	private void getBookingHistory(HttpServletRequest req, HttpServletResponse res) {
		HttpSession session = req.getSession();
		
		try {
			ResultSetAndStatement result = DBQuery.getAllNonPendingBookingRecords(getServletContext().getInitParameter("DB_NAME"), (String)session.getAttribute("username"));
			
			result.rs.last();
			if (result.rs.getRow() != 0) {
				session.setAttribute("all-bookingshistory", result.rs.getRow());
				result.rs.first();
				session.setAttribute("flash-mybookingshistory", result);
			} else {
				session.setAttribute("flash-mybookingshistory-error-message", "You have currently no booking history!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			session.setAttribute("flash-mybookingshistory-error-message", "A database error has occurred - " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-mybookingshistory-error-message", "An unexpected error has occurred while fetching booking details - " + e.getMessage());
		}
	}
	
	
	
	private void getAllBookings(HttpServletRequest req, HttpServletResponse res) {
		HttpSession session = req.getSession();
		
		try {
			ResultSetAndStatement result = DBQuery.getAllPendingBookingRecords(getServletContext().getInitParameter("DB_NAME"), (String)session.getAttribute("username"));
			
			result.rs.last();
			if (result.rs.getRow() != 0) {
				session.setAttribute("all-bookings", result.rs.getRow());
				result.rs.first();
				session.setAttribute("flash-mybookings", result);
			} else {
				session.setAttribute("flash-mybookings-error-message", "You have currently no pending bookings!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			session.setAttribute("flash-mybookings-error-message", "A database error has occurred - " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-mybookings-error-message", "An unexpected error has occurred while fetching booking details - " + e.getMessage());
		}
	}
}
