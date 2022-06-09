<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Bid</title>

</head>
<body>
	<% try{
		String auction_id = request.getParameter("auction_id");
		String bid_id = request.getParameter("bid_id");
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String query = "delete from bid where aID=" + auction_id + " and bidID=" + bid_id;
		out.print(query);
		int x = stmt.executeUpdate(query);
		
		query = "select * from auction_posts where aID=" + auction_id;
		
		ResultSet rs = stmt.executeQuery(query);
		
		int bidID = 0;
		String buyer_email="NULL";
		Double current_bid=0.0;
		
		while (rs.next()) {
			current_bid = rs.getDouble("initial_price");
			break;
		}
		
		
		//next highest bid
		query = "select * from bid where aID=" + auction_id + " order by current_bid desc";
		rs = stmt.executeQuery(query);
		
		
		while (rs.next()) {
			bidID = rs.getInt("bidID");
			buyer_email = rs.getString("email");
			current_bid = rs.getDouble("current_bid");
			break;
		}
		%>
		<% 
		if ((buyer_email.equals("NULL")) == false) {
			buyer_email = "'" + buyer_email + "'";
		}
		query = "update auction_posts set buyer_email=" + buyer_email + ", current_price=" + current_bid + " where aID=" + auction_id;

		int output = stmt.executeUpdate(query);
		rs.close();
		stmt.close();
		con.close();
		%>
		Deleted Bid <br>
		<a href="ManageAuctions.jsp">Back to Manage Auctions</a>
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>