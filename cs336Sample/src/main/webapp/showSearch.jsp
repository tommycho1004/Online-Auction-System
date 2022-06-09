<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String cat1 = request.getParameter("Category1");
			String cat2 = request.getParameter("Category2");
			String cat3 = request.getParameter("Category3");
			String sortCriteria = request.getParameter("sorting");
			
			ArrayList<Item> item_list = new ArrayList<Item>();

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM item";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				int itemID = result.getInt("itemID");
				int aID = result.getInt("aID");
				String name = result.getString("item_name");
				String type = result.getString("item_type");
				double curr_price = 0.0;
				java.sql.Time close_time = null;
				java.sql.Date close_date = null;
				String buyer_email = null;
				String seller_email = null;
				
				
				Statement inner_stmt = con.createStatement();
				String inner_str = "SELECT * FROM auction_posts WHERE aID=" + aID;
				ResultSet inner_result = inner_stmt.executeQuery(inner_str);
				while (inner_result.next()) {
					curr_price = inner_result.getDouble("current_price");
					close_time = inner_result.getTime("close_time");
					close_date = inner_result.getDate("close_date");
					buyer_email = inner_result.getString("buyer_email");
					seller_email = inner_result.getString("seller_email");
					
				}
				
				Item curr_item = new Item();
				curr_item.itemID = itemID;
				curr_item.aID = aID;
				curr_item.name = name;
				curr_item.type = type;
				curr_item.curr_price = curr_price;
				curr_item.close_time = close_time;
				curr_item.close_date = close_date;
				curr_item.buyer_email = buyer_email;
				curr_item.seller_email = seller_email;
				
				if (cat1 == null && cat2 == null && cat3 == null) {
					item_list.add(curr_item);
					continue;
				}
				
				if (cat1 != null) {
					if (type.toLowerCase().equals(cat1.toLowerCase())) {
						item_list.add(curr_item);
						continue;
					}
				}
				
				if (cat2 != null) {
					if (type.toLowerCase().equals(cat2.toLowerCase())) {
						item_list.add(curr_item);
						continue;
					}
				}
				
				if (cat3 != null) {
					if (type.toLowerCase().equals(cat3.toLowerCase())) {
						item_list.add(curr_item);
						continue;
					}
				}
				
				
			}
			
			if (sortCriteria.equals("price: low to high")) {
				Collections.sort(item_list, new PriceLowToHighComparator());
			} else if (sortCriteria.equals("price: high to low")) {
				Collections.sort(item_list, new PriceLowToHighComparator());
				Collections.reverse(item_list);
			} else {
				Collections.sort(item_list, new NameComparator());
			}
			
			java.util.Date d = new java.util.Date();
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Auction ID</td>
			<td>Name</td>
			<td>Type</td>
			<td>Current Price</td>
			<td>Close Time</td>
			<td>Close Date</td>
			<td>Status</td>
			<td>Buyer</td>
			<td>Seller</td>
		</tr>
			<%
			//parse out the results
			for (int i = 0; i < item_list.size(); i++) { %>
				<tr>
					<td><a href=<%= "/cs336Sample/AuctionBids.jsp?aID=" + item_list.get(i).aID + "&name=" +  item_list.get(i).name %>" >
					<%= item_list.get(i).aID %></a>
					</td>    
					<td><%= item_list.get(i).name %></td>
					<td><%= item_list.get(i).type %></td>
					<td>$<%= item_list.get(i).curr_price %></td>
					<td><%= item_list.get(i).close_time %></td>
					<td><%= item_list.get(i).close_date %></td>
					<td><%= d.compareTo(item_list.get(i).close_date) < 0 ? "OPEN" : "CLOSED" %></td>
					<td><a href="/cs336Sample/UserAuctionHistory.jsp?email=<%=  item_list.get(i).buyer_email %>">
					<%= item_list.get(i).buyer_email %></a>
					</td>
					<td><a href="/cs336Sample/UserAuctionHistory.jsp?email=<%=  item_list.get(i).seller_email %>">
					<%= item_list.get(i).seller_email %></a>
					</td>
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
