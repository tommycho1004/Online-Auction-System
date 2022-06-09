<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User</title>
</head>
<body>
<a href="ManageUsers.jsp">Back to Manage Users</a><br>
<% try {
	String delete_checkbox = request.getParameter("delete_user");
	String old_email = request.getParameter("email");
	
	if (delete_checkbox == null) {
		String new_email = request.getParameter("new_email");
		String new_username = request.getParameter("new_username");
		String new_password = request.getParameter("new_password");
		
		if ((new_email.length() == new_username.length()) && (new_email.length() == new_password.length()) && new_email.length() == 0) {
			throw new Exception("All fields are empty.");
		}
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String query_p1 = "update user set ";
		String query_p2 = "where email='" + old_email + "'";
		String email_query = " email='" + new_email + "' ";
		String username_query = " username='" + new_username + "' ";
		String password_query = " password='" + new_password +"' ";
		
		if (new_username.length() > 0) {
			String query2 = query_p1 + username_query + query_p2;
			//out.println(query2);
			int output = stmt.executeUpdate(query2);
		}
		
		if (new_password.length() > 0) {
			String query3 = query_p1 + password_query + query_p2;
			//out.print(query3);
			int output = stmt.executeUpdate(query3);
		} 
		
		if (new_email.length() > 0) {
			String query1 = query_p1 + email_query + query_p2;
			//out.println(query1);
			int output = stmt.executeUpdate(query1);
		}
		stmt.close();
		con.close();
		%>
		
	<% } else {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement st = con.createStatement();
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		
		String delete_query = "delete from user where email='" + old_email + "'";
		
		int x = st.executeUpdate(delete_query);
		
		String query = "select * from auction_posts where buyer_email is NULL";
		//ArrayList<Integer> list = new ArrayList<Integer>();
		
		ResultSet rs = stmt.executeQuery(query);
		
		String buyer_email = "NULL";
		Double current_bid = 0.0;
		int auction_id = 0;
		ResultSet helper_rs;
		/*
		while (rs.next()) {
			out.print(rs.getInt("aID"));
		}
		*/
		
		while (rs.next()) {
			//list.add(rs.getInt("aID"));
			auction_id = rs.getInt("aID");
			out.print(auction_id);
			current_bid = rs.getDouble("initial_price");
			
			query = "select * from bid where aID=" + auction_id + " order by current_bid desc";
			
			helper_rs = stmt2.executeQuery(query);
			
			while (helper_rs.next()) {
				buyer_email = helper_rs.getString("email");
				current_bid = helper_rs.getDouble("current_bid");
				break;
			}
			if ((buyer_email.equals("NULL")) == false) {
				buyer_email = "'" + buyer_email + "'";
			}
			//out.print("xxxx");
			query = "update auction_posts set buyer_email=" + buyer_email + ", current_price=" + current_bid + " where aID=" + auction_id;

			int output = stmt2.executeUpdate(query);

			helper_rs.close();	
		}
		

		rs.close();
		stmt.close();
		con.close();
	}%>
	Information Successfully Updated
<%} catch (Exception e) {
	out.print(e.getMessage());
}%>

</body>
</html>