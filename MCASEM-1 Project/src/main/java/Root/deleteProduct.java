package Root;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Main.DBConnect;
@WebServlet("/deleteProduct")
public class deleteProduct extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String name=req.getParameter("name");
		String query="delete from product where name=?";
		String subquery="select image from product where name=?";
		Connection con= DBConnect.getConnection(DBConnect.database,DBConnect.user,DBConnect.password);
		try {
			PreparedStatement ps=con.prepareStatement(subquery);
			ps.setString(1, name);
			ResultSet rs= ps.executeQuery();
			rs.next();
			new File(DBConnect.mediaBasePath+rs.getString(1)).delete();
			rs.close();
			ps.close();
			ps=con.prepareStatement(query);
			ps.setString(1,name);
			ps.executeUpdate();
			ps.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		res.sendRedirect("admin1.jsp");
	}
}
