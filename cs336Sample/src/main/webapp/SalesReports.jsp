<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Reports</title>
</head>
<body>
<h1>Sales Report</h1>

<a href="AdminLanding.jsp">Back to Admin Landing Page</a>
<% try {
	java.sql.Timestamp current_timestamp = new java.sql.Timestamp(new java.util.Date().getTime());
	ArrayList<Integer> closed_list = new ArrayList<Integer>();%>
	
	<h3><%=current_timestamp.toString() %></h3>
	<%
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();

	
	String query = "select * from auction_posts";
	ResultSet rs = stmt.executeQuery(query);
	
		while (rs.next()) {

			int aID =rs.getInt("aID");
			String close_date = rs.getString("close_date");
			String close_time = rs.getString("close_time");
			

			java.sql.Timestamp ts = java.sql.Timestamp.valueOf(close_date + " " + close_time);

			if (current_timestamp.compareTo(ts) > 0) {
				closed_list.add(aID);
			}
			
		}
		
		
		for (int x : closed_list) {
			query = "update auction_posts set closed=1 where aID=" + x;
			int output = stmt.executeUpdate(query);
		}
		
		String total_earnings = "select sum(current_price) as total from auction_posts where (auction_posts.reserve_price is null or auction_posts.current_price >= auction_posts.reserve_price) and auction_posts.closed = 1";
		
		rs = stmt.executeQuery(total_earnings);
		rs.next();%>
		
		<h3 style="display:inline">Total Earnings: </h3>$<%=rs.getDouble("total") %>
		
		<h3>Earnings per Item</h3>
		<%String per_item = "select sum(auction_posts.current_price) as total, item.item_name, item.item_type, auction_posts.current_price, auction_posts.buyer_email, auction_posts.seller_email from auction_posts inner join item on item.aID = auction_posts.aID where (auction_posts.reserve_price is null or auction_posts.current_price >= auction_posts.reserve_price) and auction_posts.closed = 1 group by item_name";
		
		rs = stmt.executeQuery(per_item);%>
		
		<table>
			<tr>
				<td>Item Name</td>
				<td>Earnings</td>
			</tr>
		
		<%
		while (rs.next()) {%>
			<tr>
			<td><%=rs.getString("item_name") %></td>
			<td><%=rs.getDouble("total") %></td>
			</tr>
		<%}%>
		</table>
		
		<h3>Earnings per Item Type</h3>
		<%
		String per_type = "select sum(auction_posts.current_price) as total, item.item_name, item.item_type, auction_posts.current_price, auction_posts.buyer_email, auction_posts.seller_email from auction_posts inner join item on item.aID = auction_posts.aID where (auction_posts.reserve_price is null or auction_posts.current_price >= auction_posts.reserve_price) and auction_posts.closed = 1 group by item_type";
		
		rs = stmt.executeQuery(per_type);%>
		
		<table>
			<tr>
			<td>Item Type</td>
			<td>Earnings</td>
			</tr>
		
		<% while(rs.next()) {%>
			<tr>
			<td><%=rs.getString("item_type") %></td>
			<td><%=rs.getDouble("total") %>
			</tr>
		<%}%>
		</table>
		
		<h3>Earnings per User</h3>
		<%
		String per_user = "select sum(auction_posts.current_price) as total, item.item_name, item.item_type, auction_posts.current_price, auction_posts.buyer_email, auction_posts.seller_email from auction_posts inner join item on item.aID = auction_posts.aID where (auction_posts.reserve_price is null or auction_posts.current_price >= auction_posts.reserve_price) and auction_posts.closed = 1 group by buyer_email";
		
		rs = stmt.executeQuery(per_user);%>
		
		<table>
			<tr>
			<td>User Email</td>
			<td>Earnings</td>
			</tr>
			
			<% while(rs.next()) {%>
				<tr>
				<td><%=rs.getString("buyer_email") %>
				<td><%=rs.getDouble("total") %>
			<%} %>
		</table>
		
		<h3>Top 10 Best Selling Items</h3>
		<%
		String best_items = "select sum(auction_posts.current_price) as total, item.item_name, item.item_type, auction_posts.current_price, auction_posts.buyer_email, auction_posts.seller_email from auction_posts inner join item on item.aID = auction_posts.aID where (auction_posts.reserve_price is null or auction_posts.current_price >= auction_posts.reserve_price) and auction_posts.closed = 1 group by item_name order by total desc limit 10";
		
		rs = stmt.executeQuery(best_items);%>
		
		<table>
		<tr>
		<td>Item Name</td>
		<td>Item Type</td>
		</tr>
		
		<% while (rs.next()) {%>
			<tr>
			<td><%=rs.getString("item_name") %></td>
			<td><%=rs.getString("item_type") %></td>
		<%} %>
		</table>
		
		<h3>Top 10 Buyers</h3>
		<%
		String best_buyers = "select sum(auction_posts.current_price) as total, item.item_name, item.item_type, auction_posts.current_price, auction_posts.buyer_email, user.username, auction_posts.seller_email from auction_posts inner join item on item.aID = auction_posts.aID inner join user on user.email = auction_posts.buyer_email where (auction_posts.reserve_price is null or auction_posts.current_price >= auction_posts.reserve_price) and auction_posts.closed = 1 group by buyer_email order by total desc limit 10";
	
		rs = stmt.executeQuery(best_buyers);%>		
		
		<table>
		<tr>
		<td>Username</td>
		<td>User Email</td>
		</tr>
		
		<% while (rs.next()) {%>
		<tr>
		<td><%=rs.getString("username") %></td>
		<td><%=rs.getString("buyer_email") %></td>
	<%} %>
	</table>
			
<%} catch (Exception e) {
	out.print(e);
} %>

</body>
</html>