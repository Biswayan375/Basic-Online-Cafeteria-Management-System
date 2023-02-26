package ApplicationServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBConnection;

@WebServlet(name = "LoginServlet", value = { "/login" })
public class LoginServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.getRequestDispatcher("Static/UnprotectedPages/Login.jsp").forward(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		String username = req.getParameter("username"),
				password = req.getParameter("password");
		HttpSession session = req.getSession();
		Connection conn = DBConnection.getConnection();
		try {
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String query = "use " + req.getServletContext().getInitParameter("DB_NAME") + ";";
			stmt.execute(query);
			query = "select * from users where username='" + username + "' and password='" + password + "';";
			ResultSet result = stmt.executeQuery(query);
			result.last();
			if (result.getRow() == 0) {
				// when no user is found of the given username and password
				session.setAttribute("flash-message", "Invalid credentials provided :(");
				res.sendRedirect(req.getContextPath() + "/login");
			} else {
				// when an user is found of the given username and password
				session.setAttribute("username", username);
				res.sendRedirect(req.getContextPath() + "/home");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-message", "An unexpected error has occurred!");
		}
	}
}
