package ApplicationServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TestServlet", value = { "/test" })
public class Test extends HttpServlet {
	@Override public void service(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		req.getRequestDispatcher("Static/order-record-component.jsp").forward(req, res);
	}
}
