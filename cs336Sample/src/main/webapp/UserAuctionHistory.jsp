<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= request.getParameter("email") %>'s Auction History</title>
</head>
<body>
<h1><%= request.getParameter("email") %>'s Auction History</h1>
<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String email = request.getParameter("email");

			
			ArrayList<Item> item_list = new ArrayList<Item>();

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM auction_posts WHERE buyer_email='" + email + "' OR seller_email='" + email +"'";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				int aID = result.getInt("aID");
				java.sql.Time close_time = result.getTime("close_time");
				java.sql.Date close_date = result.getDate("close_date");
				double curr_price = result.getDouble("current_price");
				double initial_price = result.getDouble("initial_price");
				
				Statement inner_stmt = con.createStatement();
				String inner_str = "SELECT * FROM item WHERE aID=" + aID;
				String name = null;
				String type = null;
				
				ResultSet inner_result = inner_stmt.executeQuery(inner_str);
				while (inner_result.next()) {
					name = inner_result.getString("item_name");
					type = inner_result.getString("item_type");
				}
				
				Item curr_item = new Item();
				curr_item.aID = aID;
				curr_item.name = name;
				curr_item.type = type;
				curr_item.curr_price = curr_price;
				curr_item.initial_price = initial_price;
				curr_item.close_time = close_time;
				curr_item.close_date = close_date;
				
				item_list.add(curr_item);
				
			}

			
			java.util.Date d = new java.util.Date();
		%>
		
		<table>
		<tr>    
			<td>Name</td>
			<td>Type</td>
			<td>Initial Price</td>
			<td>Current Price</td>
			<td>Close Time</td>
			<td>Close Date</td>
			<td>Status</td>
		</tr>
			<%
			//parse out the results
			for (int i = 0; i < item_list.size(); i++) { %>
				<tr>    
					<td><%= item_list.get(i).name %></td>
					<td><%= item_list.get(i).type %></td>
					<td>$<%= item_list.get(i).initial_price %></td>
					<td>$<%= item_list.get(i).curr_price %></td>
					<td><%= item_list.get(i).close_time %></td>
					<td><%= item_list.get(i).close_date %></td>
					<td><%= d.compareTo(item_list.get(i).close_date) < 0 ? "OPEN" : "CLOSED" %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>