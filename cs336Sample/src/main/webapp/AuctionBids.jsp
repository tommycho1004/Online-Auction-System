<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bid for <%= request.getParameter("name") %></title>
</head>
<body>
<h1><%= request.getParameter("name") %></h1>
<table>
		<tr>    
			<td>Bidder Email</td>
			<td>Bidder's Current Bid</td>
		</tr>
<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			int aID = Integer.parseInt(request.getParameter("aID"));
			
			ArrayList<Item> item_list = new ArrayList<Item>();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM bid WHERE aID=" + aID;
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			
			while (result.next()) {
			
				
				String email = result.getString("email");
				int bidID = result.getInt("bidID");
				int currentBid = result.getInt("current_bid");
				
				%>
				
				<tr>
					<td><%= email %></td>
					<td><%= currentBid %></td>
				</tr>
				
				<% 
				
				
			}
		%>
			
			<% 
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		
		<h2> Bid for <%= request.getParameter("name") %></h2>
	<br>
		<form method="get" action="bidInserted.jsp">
			<table>
				<tr>    
					<td>Bid</td><td><input type="text" name="bid_price"></td>
				</tr>
				<tr>    
					<td>aID</td><td><input type="text" name="aID" value=<%= request.getParameter("aID") %>></td>
				</tr>
			</table>
			<input type="submit" value="Bid!">
		</form>
	<br>
		<form method="get" action="autoBidInserted.jsp">
			<table>
				<tr>    
					<td>Starting Bid</td><td><input type="text" name="autobid_start"></td>
				</tr>
				<tr>    
					<td>Maximum Bid</td><td><input type="text" name="autobid_max"></td>
				</tr>
				<tr>    
					<td>Auto-Increment</td><td><input type="text" name="autobid_increment"></td>
				</tr>
				<tr>    
					<td>aID</td><td><input type="text" name="aID" value=<%= request.getParameter("aID") %>></td>
				</tr>
			</table>
			<input type="submit" value="Auto-Bid!">
		</form>
		
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>
