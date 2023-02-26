package Root;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.mysql.cj.xdevapi.PreparableStatement;

import Main.DBConnect;

@MultipartConfig
@WebServlet("/updateProduct")
public class updateProduct extends HttpServlet {
 @Override
protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    String name=req.getParameter("cname");
		String price=req.getParameter("price");		
		String query="update product set price=? where name=?";
		String query1="select image from product where name='"+name+"'";
		String query2="update product set image=? where name=?";
		String temp;
		ResultSet rs;
		Connection con= DBConnect.getConnection(DBConnect.database,DBConnect.user,DBConnect.password);
		
		Part part=req.getPart("image");
		if(part.getSize()!=0) {
			try {
				rs=con.createStatement().executeQuery(query1);
				rs.next();
				temp=rs.getString(1);
				char t[]=temp.toCharArray();
				new File("C:\\Users\\hp\\Desktop\\Dump\\MCA-Java-Project\\Project - UPDATED\\MCASEM-1 Project\\src\\main\\webapp\\resource\\"+temp).delete();
				temp=String.copyValueOf(t,0,temp.lastIndexOf('.'));
				String filename=part.getSubmittedFileName();
				char c[]=filename.toCharArray();
				String ext="";
				ext=String.copyValueOf(c, filename.lastIndexOf("."), filename.length()-filename.lastIndexOf("."));
				byte b[]=part.getInputStream().readAllBytes();
				File file=new File("C:\\Users\\hp\\Desktop\\Dump\\MCA-Java-Project\\Project - UPDATED\\MCASEM-1 Project\\src\\main\\webapp\\resource\\"+temp+ext);
				FileOutputStream fos=new FileOutputStream(file);
				fos.write(b);
				fos.close();
				rs.close();
				PreparedStatement ps=con.prepareStatement(query2);
				ps.setString(1, temp+ext);
				ps.setString(2,name);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		if(!price.equals("")) {
		try {
			PreparedStatement ps= con.prepareStatement(query);
			ps.setInt(1, Integer.parseInt(price));
			ps.setString(2, name);
			ps.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		}
		res.sendRedirect("admin1.jsp");
}
}
