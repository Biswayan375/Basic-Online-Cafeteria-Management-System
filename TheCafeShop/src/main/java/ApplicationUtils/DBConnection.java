package ApplicationUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	private static Connection conn = null;
	private static Statement stmt = null;
	private final static String URL = "jdbc:mysql://localhost:3306",
			USERNAME = "root",
			PASSWORD = "";
	
	private DBConnection() { }
	
	public final static Connection getConnection() {
		if (conn == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			} catch (Exception e) {
				e.printStackTrace();
				conn = null;
			}
		}
		
		return conn;
	}
}
