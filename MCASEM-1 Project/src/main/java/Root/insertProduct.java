package Root;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import Main.DBConnect;
@MultipartConfig
@WebServlet("/insertProduct")
public class insertProduct extends HttpServlet {
@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String name=req.getParameter("name");
		String price=req.getParameter("price");
		String quantity=req.getParameter("quantity");
		Part part=req.getPart("image");
		String filename=part.getSubmittedFileName();
		char c[]=filename.toCharArray();
		String ext="";
		ext=String.copyValueOf(c, filename.lastIndexOf("."), filename.length()-filename.lastIndexOf("."));
		byte b[]=part.getInputStream().readAllBytes();
		
		String query="insert into product values ('"+name+"',"+price+","+quantity+",'"+name.replace(' ','_')+ext+"')";
		
		File file=new File(DBConnect.mediaBasePath+name.replace(' ','_')+ext);
		FileOutputStream fos=new FileOutputStream(file);
		fos.write(b);
		fos.close();
		
		Connection con= DBConnect.getConnection(DBConnect.database,DBConnect.user,DBConnect.password);
		try {
			con.createStatement().executeUpdate(query);
			con.close();
		} catch (SQLException e) {
			res.getWriter().print("Error[*product name must be unique*]");
			e.printStackTrace();
		}
		
		res.sendRedirect("admin1.jsp");
		
	}
}
