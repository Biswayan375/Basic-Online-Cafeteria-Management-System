package ApplicationServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ApplicationUtils.DBConnection;

@WebServlet(name = "RegisterServlet", value = { "/register" })
public class RegisterServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		req.getRequestDispatcher("Static/UnprotectedPages/Register.jsp").forward(req, res);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws IOException{
		String username = req.getParameter("username"),
				email = req.getParameter("email"),
				password = req.getParameter("password");
		
		Connection conn = DBConnection.getConnection();
		HttpSession session = req.getSession();
		try {
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String query = "select * from mcasem1project.users where email='" + email + "'";
			ResultSet result = stmt.executeQuery(query);
			result.last();
			if (result.getRow() == 0) {
				// when given email does not exist in the database already.
				query = "select * from mcasem1project.users where username='" + username + "'";
				result = stmt.executeQuery(query);
				result.last();
				if (result.getRow() == 0) {
					// when the given username is unique
					query = "insert into mcasem1project.users values('" + username + "', '" + email + "', '" + password + "');";
					stmt.execute(query);
					session.setAttribute("flash-message", "Successfully registered user :)");
					res.sendRedirect(req.getContextPath() + "/login");
				} else {
					// when the given username is not unique
					session.setAttribute("flash-message", "Username already exists :(");
					res.sendRedirect(req.getContextPath() + "/register");
				}
			} else {
				// when given email already exists in the database, new record cannot be inserted.
				session.setAttribute("flash-message", "Email id already registered, try logging in!");
				res.sendRedirect(req.getContextPath() + "/register");
			}
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("flash-message", "An unexpected error has occurred :(");
			res.sendRedirect(req.getContextPath() + "/register");
		}
	}
}
