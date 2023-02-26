package Main;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Data {
	
	public static ResultSet getPendingBookings() {
		ResultSet rs=null;
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select cid,table_no,capacity,date,time,bid,tid from bookings as b,seating_table as s where b.tid=s.id and b.remarks='PENDING'";
	 
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getSetteledBookings() {
		ResultSet rs=null;
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select cid,table_no,capacity,date,time,bid from bookings as b,seating_table as s where b.tid=s.id and b.remarks='SETTLED'";
	 
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getCancelledBookings() {
		ResultSet rs=null;
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select cid,table_no,capacity,date,time,bid from bookings as b,seating_table as s where b.tid=s.id and b.remarks='CANCELLED'";
	 
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public static boolean updateBooking(String bid,int tid,char s) {
		boolean status=false;
		String remarks;
		if(s=='c')
			remarks="CANCELLED";
		else
			remarks="SETTLED";
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query0="update bookings set remarks='"+remarks+"' where bid='"+bid+"'";
		String query1="update seating_table set is_available=1 where id="+tid;
		
		try {
			con.createStatement().executeUpdate(query0);
			con.createStatement().executeUpdate(query1);
			status=true;
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return status;
	}
	
	public static ResultSet getPendingOrderDetails() {
		ResultSet rs=null;
		
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select order_no,cid,address,mobile_no,order_date,order_time,item_name,item_quantity,item_price,delivery_charges from order_details where order_status='PENDING'";
		
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public static ResultSet getDeliveredOrderDetails() {
		ResultSet rs=null;
		
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select order_no,cid,address,mobile_no,order_date,order_time,item_name,item_quantity,item_price,delivery_charges from order_details where order_status='DELIVERED'";
		
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
 
	public static ResultSet getCancelledOrderDetails() {
		ResultSet rs=null;
		
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select order_no,cid,address,mobile_no,order_date,order_time,item_name,item_quantity,item_price,delivery_charges from order_details where order_status='CANCELLED'";
		
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
 
	public static ResultSet getOnTheWayOrderDetails() {
		ResultSet rs=null;
		
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="select order_no,cid,address,mobile_no,order_date,order_time,item_name,item_quantity,item_price,delivery_charges from order_details where order_status='ON THE WAY'";
		
		try {
			rs=con.createStatement().executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public static void updateOrderDetails(String id,String status) {
		
		Connection con=DBConnect.getConnection(DBConnect.database, DBConnect.user, DBConnect.password);
		String query="update order_details set order_status='"+status+"' where order_no='"+id+"'";
		String query1="update product set quantity=quantity+(select item_quantity from order_details where order_no='"+id+"') where name=(select item_name from order_details where order_no='"+id+"')";
		try {
			con.createStatement().executeUpdate(query);
			if(status.equals("CANCELLED"))
				con.createStatement().executeUpdate(query1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
