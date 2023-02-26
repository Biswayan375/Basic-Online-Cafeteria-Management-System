package Root;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class login extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String user=req.getParameter("user");
		String password=req.getParameter("password");
		HttpSession s=req.getSession();
		s.setAttribute("status",false);
		if(user.equals("admin") && password.equals("password")) {
			s.setAttribute("status",true);
		}
		res.sendRedirect("admin0.jsp");
	}
}
