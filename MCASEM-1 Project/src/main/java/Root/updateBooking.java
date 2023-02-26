package Root;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Main.Data;
@WebServlet("/updateBooking")
public class updateBooking extends HttpServlet {
 @Override
 protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	int tid=Integer.parseInt(req.getParameter("tid"));
	String bid=req.getParameter("bid");
	char c=req.getParameter("op").charAt(0);
	Data.updateBooking(bid, tid, c);
	res.sendRedirect("admin3.jsp");
 }
}
