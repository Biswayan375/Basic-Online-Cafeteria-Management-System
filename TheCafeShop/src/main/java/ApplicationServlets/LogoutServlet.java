package ApplicationServlets;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", value = { "/logout" })
public class LogoutServlet extends HttpServlet {
	@Override
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		HttpSession session = req.getSession();
		if (session.getAttribute("username") != null) {
			session.removeAttribute("username");
			res.sendRedirect("login");
			session.setAttribute("flash-message", "Successfully logged out!");
			session.invalidate();
		}
	}
}
