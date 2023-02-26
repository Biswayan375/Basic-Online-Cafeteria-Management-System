package ApplicationUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

import javax.servlet.http.HttpSession;

public class DBQuery {
	private static Connection conn = DBConnection.getConnection();
	
	private final static Statement getStatement() {
		try {
			return conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private final static void useDatabase(String DB)
			throws SQLException {
		Statement stmt = getStatement();
		stmt.execute("use " + DB + ";");
		stmt.close();
	}
	
	/**
	 * Fetches all pending booking records for a specific user and returns it.
	 * It is your responsibility to close the Statement.
	 * @param DB, user
	 * @return ResultSetAndStatement
	 * */
	public static ResultSetAndStatement getAllPendingBookingRecords(String DB, String user)
			throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "select b.date, b.time, b.bid, t.id, t.capacity, t.table_no, b.remarks from bookings b, seating_table t where "
				+ "b.cid='" + user + "' and b.tid=t.id and b.remarks='PENDING';";
		ResultSet rs = stmt.executeQuery(query);
		
		return new ResultSetAndStatement(stmt, rs);
	}
	
	/**
	 * Fetches all settled or cancelled booking records for a specific user and returns it.
	 * It is your responsibility to close the Statement.
	 * @param DB, user
	 * @return ResultSetAndStatement
	 * */
	public static ResultSetAndStatement getAllNonPendingBookingRecords(String DB, String user) 
		throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "select b.bid, t.id, t.capacity, t.table_no, b.date, b.time, b.remarks from bookings b, seating_table t where "
				+ "b.tid=t.id and "
				+ "b.remarks!='PENDING' and "
				+ "b.cid='" + user + "';";
		ResultSet rs = stmt.executeQuery(query);
		
		return new ResultSetAndStatement(stmt, rs);
	}
	
	/**
	 * Makes the table available
	 * @param DB, tableID
	 * */
	public static void makeTableAvailable(String DB, int tableID)
			throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "update seating_table set is_available=1 where table_no=" + tableID + ";";
		stmt.execute(query);
		stmt.close();
	}
	
	/**
	 * Marks the table booking as CANCELLED
	 * @param DB, bookingID
	 * */
	public static void cancelBooking(String DB, String bookingID)
		throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "update bookings set remarks='CANCELLED' where bid='" + bookingID + "';";
		stmt.execute(query);
		stmt.close();
	}
	
	public static ResultSetAndStatement getAllProducts(String DB)
			throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "select * from product;";
		ResultSet result = stmt.executeQuery(query);
		
		return new ResultSetAndStatement(stmt, result);
	}
	
	public static Boolean placeOrder(String DB, String username, String itemName, String itemPrice, String itemQuantity, String deliveryCharge, String address, String mobile, String imagePath) {
		
		try {
			useDatabase(DB);
			Statement stmt = getStatement();
			
			String uid = "", query;
			int n = 100;
			
			while (n != 0) {
				uid = "OOK" + UUID.randomUUID().toString().split("-")[0].toUpperCase();
				query = "select item_name from order_details where order_no = '" + uid + "';";
				ResultSet res = stmt.executeQuery(query);
				res.last();
				n = res.getRow();
			}
			
			query = "insert into order_details(`order_no`, `item_name`, `item_quantity`, `item_price`, `delivery_charges`, `item_image`, `cid`, `address`, `order_status`, `mobile_no`) values("
					+ "	   '" + uid + "',"
					+ "    '" + itemName + "',"
					+ "    " + itemQuantity + ","
					+ "    " + itemPrice + ","
					+ "    " + deliveryCharge + ","
					+ "    '" + imagePath + "',"
					+ "    '" + username + "',"
					+ "    '" + address + "',"
					+ "    'PENDING', "
					+ "		'" + mobile + "'"
					+ ");";
			
			stmt.executeUpdate(query);
			stmt.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static Boolean cancelOrder(String DB, String orderNo) {
		try {
			useDatabase(DB);
			Statement stmt = getStatement();
			
			String query = "update order_details set order_status = 'CANCELLED' where order_no = '" + orderNo + "';";
			int n = stmt.executeUpdate(query);
			stmt.close();
			
			if (n > 0)
				return true;
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static Boolean decreaseItemCount(String DB, String itemName, int orderedQuantity) {
		try {
			useDatabase(DB);
			Statement stmt = getStatement();
			
			String query = "select quantity from product where name = '" + itemName + "'";
			ResultSet result = stmt.executeQuery(query);
			result.first();
			
			int currentCount = result.getInt("quantity") - orderedQuantity;
			
			query = "update product set quantity=" + currentCount + " where name = '" + itemName + "'";
			int updateCount = stmt.executeUpdate(query);
			stmt.close();
			
			if (updateCount > 0)
				return true;
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static Boolean increateItemCount(String DB, String itemName, int increaseQuantity) {
		try {
			useDatabase(DB);
			Statement stmt = getStatement();
			
			String query = "select quantity from product where name = '" + itemName + "'";
			ResultSet result = stmt.executeQuery(query);
			result.first();
			
			int currentCount = result.getInt("quantity") + increaseQuantity;
			
			query = "update product set quantity=" + currentCount + " where name = '" + itemName + "'";
			System.out.println(query);
			int updateCount = stmt.executeUpdate(query);
			stmt.close();
			
			if (updateCount > 0)
				return true;
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static ResultSetAndStatement getOrderDetails(String DB, String user, String status)
			throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "select * from order_details where cid = '" + user + "' and order_status = '" + status + "'";
		ResultSet rs = stmt.executeQuery(query);
		
		return new ResultSetAndStatement(stmt, rs);
	}
	
	public static ResultSetAndStatement getPreviousOrderDetails(String DB, String user)
			throws SQLException {
		useDatabase(DB);
		Statement stmt = getStatement();
		
		String query = "select * from order_details where cid = '" + user + "' and order_status != 'PENDING'";
		ResultSet rs = stmt.executeQuery(query);
		
		return new ResultSetAndStatement(stmt, rs);
	}
	
	public static String getItemName(String DB, String order_no) {
		try {
			useDatabase(DB);
			Statement stmt = getStatement();
			
			String query = "select name from product p, order_details o where p.name = o.item_name and o.order_no = '" + order_no + "';", item = null;
			ResultSet rs = stmt.executeQuery(query);
			rs.first();
			
			if (rs.getRow() > 0)
				item = rs.getString("name");
			
			stmt.close();
			return item;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static int getOrderCount(String DB, String order_no) {
		try {
			useDatabase(DB);
			Statement stmt = getStatement();
			
			String query = "select quantity from product p, order_details o where p.name = o.item_name and o.order_no = '" + order_no + "';";
			int count = -1;
			ResultSet rs = stmt.executeQuery(query);
			rs.first();
			
			if (rs.getRow() > 0)
				count = Integer.parseInt(rs.getString("quantity"));
			
			stmt.close();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
}
