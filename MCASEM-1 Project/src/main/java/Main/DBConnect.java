package Main;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	
	public final static String database="mca_cafeteria_project",
				mediaBasePath = "C:\\Users\\hp\\Desktop\\Dump\\MCA-Java-Project\\Project - UPDATED\\MCASEM-1 Project\\src\\main\\webapp\\resource\\",
				user="root",
				password="";
	
	public static Connection getConnection(String database,String user,String password) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database,user,password);
			return con;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}
}
