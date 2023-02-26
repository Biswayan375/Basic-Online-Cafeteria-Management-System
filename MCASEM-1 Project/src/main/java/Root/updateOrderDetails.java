package Root;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Main.Data;
@WebServlet("/updateOrder")
public class updateOrderDetails extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String id=req.getParameter("id");
		String status=req.getParameter("status");
		Data.updateOrderDetails(id, status);
		res.sendRedirect("admin2.jsp");
	}
}
