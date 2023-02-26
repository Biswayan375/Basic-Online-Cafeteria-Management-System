package ApplicationServlets;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBQuery;

@WebServlet(name = "CancelOrderServlet", value = { "/cancel-order" })
public class CancelOrderServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		String orderNo = req.getParameter("order-no"), message = "", error = "",quantity=req.getParameter("quantity");
		HttpSession session = req.getSession();
		
		try {
			String item = DBQuery.getItemName(req.getServletContext().getInitParameter("DB_NAME"), orderNo);
			int orderCount = Integer.parseInt(quantity);
			if (item != null && orderCount != -1) {
				if (DBQuery.increateItemCount(req.getServletContext().getInitParameter("DB_NAME"), item, orderCount)) {
					if (DBQuery.cancelOrder(req.getServletContext().getInitParameter("DB_NAME"), orderNo)) {
						message = "Successfully cancelled your order";
					} else
						error = "Something went wrong - Cannot delete order right now, sorry for the inconvinience :(";
				} else {
					error = "Something went wrong - Cannot delete order right now, sorry for the inconvinience :(";
				}
			} else {
				error = "Something went wrong - Cannot delete order right now, sorry for the inconvinience :(";
			}
			
			if (message.equals(""))
				session.setAttribute("flash-my-orders-error-message", error);
			else 
				session.setAttribute("flash-my-orders-success-message", message);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-my-orders-error-message", "Something went wrong - " + e.getMessage());
		}
		
		res.sendRedirect(req.getContextPath() + "/my-orders");
	}
}
