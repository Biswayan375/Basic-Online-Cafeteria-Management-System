package ApplicationUtils;

import java.sql.ResultSet;
import java.sql.Statement;

/**
 * A collection of a Statement object and its corresponding ResultSet object.
 * */
public class ResultSetAndStatement {
	public Statement stmt;
	public ResultSet rs;
	
	public ResultSetAndStatement(Statement stmt, ResultSet rs) { this.stmt = stmt; this.rs = rs; }
	
	/**
	 * Closes the Statement
	 * */
	public void doneWithIt() { 
		try {
			this.stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
