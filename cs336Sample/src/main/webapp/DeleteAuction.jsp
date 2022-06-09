<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Auction</title>
</head>
<body>
	<% try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String auction_id = request.getParameter("auction_id");
		String auction_del = "delete from auction_posts where aID=" + auction_id;
		String bid_del = "delete from bid where aID=" + auction_id;
		String item_del = "delete from item where aID=" + auction_id;
		
		
		int bid_out = stmt.executeUpdate(bid_del);
		int item_out = stmt.executeUpdate(item_del);
		int auction_out = stmt.executeUpdate(auction_del);
		out.println("Auction Deleted Successfully");
		stmt.close();
		con.close();
	} catch (Exception e) {
		out.print(e.getMessage());
	}
	%>
	<br><a href="ManageAuctions.jsp">Back to Manage Auctions</a>
</body>
</html>