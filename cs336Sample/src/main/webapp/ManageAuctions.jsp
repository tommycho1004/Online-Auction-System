<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Auctions</title>
</head>
<body>
<h1>Manage Auctions</h1>

<a href="CustomerRepLanding.jsp">Back to Customer Rep Page</a>

<h2>Delete Auction</h2>
<form action="DeleteAuction.jsp" method="POST">
	<label for="auction_id">Auction ID: </label>
	<input type="text" id="auction_id" name="auction_id" required="required"><br>
	<input type="submit" id="delete" name="delete" value="Delete Auction">
</form>

<h2>manage Bids</h2>
<form action="ManageBids.jsp" method="POST">
	<label for="auction_id">Auction ID:</label>
	<input type="text" id="auction_id" name="auction_id" required="required"><br>
	<input type="submit" id="manage_bids" name="manage_bids" value="Manage Bids">
</form>

<h2>Auction List</h2>
<% try {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
			
	String query = "select auction_posts.aID, item.item_name, auction_posts.current_price, auction_posts.seller_email from auction_posts inner join item on auction_posts.aID = item.aID;";
			
	ResultSet rs = stmt.executeQuery(query);%>
	<table>
		<tr>
			<td>Auction ID</td>
			<td>Item Name</td>
			<td>Current Price</td>
			<td>Seller Email</td>
		</tr>
		<% while (rs.next()) { %>
			<tr>
				<td><%=rs.getInt("aID") %></td>
				<td><%=rs.getString("item_name") %></td>
				<td><%=rs.getDouble("current_price") %></td>
				<td><%=rs.getString("seller_email") %></td>
			</tr>
			<%}
			rs.close();
			stmt.close();
			con.close();%>
	</table>
<%} catch (Exception e) {
	out.print(e);
} %>
</body>
</html>