package ApplicationServlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBQuery;
import ApplicationUtils.ResultSetAndStatement;

@WebServlet(name = "OrderPageServet", value = { "/order" })
public class OrderPageServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		getAllProducts(req, res);
		
		req.getRequestDispatcher("Static/ProtectedPages/Order.jsp").forward(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		HttpSession session = req.getSession();
		
		String itemName = req.getParameter("item-name"),
			username = (String) session.getAttribute("username"),
			itemPrice = req.getParameter("item-price"),
			deliveryCharge = req.getParameter("delivery-charge"),
			quantity = req.getParameter("item-quantity"),
			address = req.getParameter("delivery-address"),
			mobile = req.getParameter("customer-mobile"),
			imagePath = req.getParameter("image-path");
		
		Boolean isDecreased = DBQuery.decreaseItemCount(req.getServletContext().getInitParameter("DB_NAME"), itemName, Integer.parseInt(quantity));
		
		if (isDecreased) {
			Boolean isInserted = DBQuery.placeOrder(req.getServletContext().getInitParameter("DB_NAME"), username, itemName, itemPrice, quantity, deliveryCharge, address, mobile, imagePath);
			if (isInserted)
				session.setAttribute("flash-orderfood-success-message", "Thank you for ordering :)");
			else
				session.setAttribute("flash-orderfood-error-message", "We cannot take your order now, please try again in some time. Sorry for the inconveinience :(");
		} else {
			session.setAttribute("flash-orderfood-error-message", "We cannot take your order now, please try again in some time. Sorry for the inconveinience :(");
		}
		
		res.sendRedirect(req.getContextPath() + "/order");
	}
	
	
	
	
	
	
	// utility methods
	private void getAllProducts(HttpServletRequest req, HttpServletResponse res) {
		ServletContext ctx = req.getServletContext();
		HttpSession session = req.getSession();
		
		try {
			ResultSetAndStatement result = DBQuery.getAllProducts(ctx.getInitParameter("DB_NAME"));
			result.rs.last();
			if (result.rs.getRow() != 0) {
				session.setAttribute("all-orders", result.rs.getRow());
				result.rs.first();
				session.setAttribute("flash-orderfood", result);
			} else {
				session.setAttribute("flash-orderfood-error-message", "Something went wrong maybe, we are out of products currently :(");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			session.setAttribute("flash-orderfood-error-message", "A database error has occurred - " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-orderfood-error-message", "An unexpected error has occurred while fetching products - " + e.getMessage());
		}
	}
}
