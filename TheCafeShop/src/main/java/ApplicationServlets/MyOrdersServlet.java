package ApplicationServlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBQuery;
import ApplicationUtils.ResultSetAndStatement;

@WebServlet(name = "MyOrdersServlet", value = { "/my-orders" })
public class MyOrdersServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		RequestDispatcher dis = req.getRequestDispatcher("/Static/ProtectedPages/MyOrders.jsp");
		getCurrentRecords(req);
		getPreviousRecords(req);
		dis.forward(req, res);
	}
	
	
	
	
	// utility methods
	private static void getCurrentRecords(HttpServletRequest req) {
		HttpSession session = req.getSession();
		try {
			ResultSetAndStatement result = DBQuery.getOrderDetails(req.getServletContext().getInitParameter("DB_NAME"), (String)session.getAttribute("username"), "PENDING");
			session.setAttribute("flash-my-orders", result);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-my-orders-error-message", "Cannot fetch results - " + e.getMessage());
		}
	}
	
	private static void getPreviousRecords(HttpServletRequest req) {
		HttpSession session = req.getSession();
		try {
			ResultSetAndStatement result = DBQuery.getPreviousOrderDetails(req.getServletContext().getInitParameter("DB_NAME"), (String)session.getAttribute("username"));
			session.setAttribute("flash-my-orders-history", result);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-my-orders-error-message", "Cannot fetch results - " + e.getMessage());
		}
	}
}
