<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Bids</title>
</head>
<body>
<h2>Manage Bids</h2>
<a href="ManageAuctions.jsp">Back to Manage Auctions</a>
	<% try {
		String auction_id = request.getParameter("auction_id");
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String query = "select auction_posts.aID, item.item_name, auction_posts.current_price, auction_posts.seller_email from auction_posts inner join item on auction_posts.aID = item.aID where auction_posts.aID=" + auction_id;
		
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
			<%}%>
		</table>
		
		<h2>Delete Bid</h2>
		<form action="DeleteBid.jsp" method="POST">
		<label for="bid_id">Bid ID:</label>
		<input type="hidden" id="auction_id" name="auction_id" value=<%=auction_id %>>
		<input type="text" id="bid_id" name="bid_id" required="required"><br>
		<input type="submit" id="delete_bid" name="delete_bid" value="Delete Bid">
		</form>
		
		<h2>Current Bids</h2>
		
		<%query = "select * from bid where aID=" + auction_id;
		
		rs = stmt.executeQuery(query);%>
		
		<table>
		<tr>
			<td>Bid ID</td>
			<td>Email</td>
			<td>Current Bid</td>
		</tr>
		<% while (rs.next()) { %>
			<tr>
				<td><%=rs.getInt("bidID") %></td>
				<td><%=rs.getString("email") %></td>
				<td><%=rs.getDouble("current_bid") %></td>
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