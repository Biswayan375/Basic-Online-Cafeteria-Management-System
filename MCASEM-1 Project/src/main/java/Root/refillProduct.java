package Root;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Main.DBConnect;
@WebServlet("/refillProduct")
public class refillProduct extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String name=req.getParameter("name");
		String quantity=req.getParameter("quantity");
		String query="update product set quantity=? where name=?";
		
		Connection con= DBConnect.getConnection(DBConnect.database,DBConnect.user,DBConnect.password);
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, Integer.parseInt(quantity));
			ps.setString(2, name);
			ps.executeUpdate();
			ps.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		res.sendRedirect("admin1.jsp");
		
	}
}
