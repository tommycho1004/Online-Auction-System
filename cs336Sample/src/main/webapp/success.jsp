<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
    if ((session.getAttribute("user") == null)) {
%>
	You are not logged in<br/>
	<a href="login.jsp">Please Login</a>
	<% } else { 
		
		String user_email = session.getAttribute("user_email").toString();
//this will display the username that is stored in the session.dda %>

	Welcome <%=session.getAttribute("user")%>  
	<a href='logout.jsp'>Log out</a> <br/>
	Today's date: <%= (new java.util.Date()).toLocaleString()%>
	<h2>Search Auctions</h2>
	<br>
		<form method="post" action="searchAuctions.jsp">
		<input type="submit" value="Search Me!">
		</form>
	<br>
	<h2>Search Questions</h2>
	<br>
		<form method="post" action="QuestionSearch.jsp">
		<input type="submit" value="Search Me!">
		</form>
	<br>
	<h1>Post Question</h1>
	<br>
		<form action="Post.jsp" method="POST">
			<label for="question">Question: </label>
			<input type="text" id="question" name="question" required="required"><br>
			<input type="submit" id="submit" name="submit" value="Post">
		</form>
	<br>
	<h2>List item for sale</h2>
	<br>
		<form method="post" action="newItemSale.jsp">
		<table>
		<tr>    
		<td>Item Name</td><td><input type="text" name="item_name"></td>
		</tr>
		<tr>
		<td>Item Type</td><td><select name="item_type">
    		<option value="shirts">Shirts</option>
    		<option value="pants">Pants</option>
    		<option value="shoes">Shoes</option>
  		</select></td>
		</tr>
		<tr>
		<td>Closing Date</td><td><input type="date" name="closing_date"></td>
		</tr>
		<tr>
		<td>Closing Time</td><td><input type="time" name="closing_time"></td>
		</tr>
		<tr>
		<td>Starting Price</td><td><input type="text" name="initial_price"></td>
		</tr>
		<tr>
		<td>Increment</td><td><input type="text" name="increment"></td>
		</tr>
		<tr>
		<td>Reserve Price (optional)</td><td><input type="text" name="min_price"></td>
		</tr>
		</table>
		<input type="submit" value="Add me!">
		</form>
	<br>
		<h2>Set Alerts</h2>
	<form method="post" action="setAlerts.jsp">
		<label for="categories">Add categories to set an alert for when they're available:</label>
		   <input type="checkbox" id="cat1" name="Category1" value="Shirts">
  			<label for="cat1"> Shirts</label>
  			<input type="checkbox" id="cat2" name="Category2" value="Pants">
  			<label for="cat2"> Pants</label>
  			<input type="checkbox" id="cat3" name="Category3" value="Shoes">
  			<label for="cat3"> Shoes</label><br><br>
		  <input type="submit" value="Submit" />
		</form>
<%
	ApplicationDB db = new ApplicationDB();	
  	Connection con = db.getConnection();		
  	Statement stmt = con.createStatement();
  	
  	String str = "SELECT * FROM item, alerts, auction_posts"
  			+ " WHERE auction_posts.close_date > CURDATE() AND"
  			+ " item.aID=auction_posts.aID"
  			+ " AND alerts.type=item.item_type"
  			+ " AND alerts.user_email='" + user_email + "'";
  			
  	ResultSet result = stmt.executeQuery(str);
  	
  	%>
  	<h2>Alerts</h2>
  	<table>
		<tr>    
			<td>Auction ID</td>
			<td>Name</td>
			<td>Close Date</td>
			<td>Current Price</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getInt("aID") %></td>
					<td>
						<%= result.getString("item_name") %>
					</td>
					<td><%= result.getDate("close_date") %></td>
					<td><%= result.getDouble("current_price") %></td>
				</tr>
				

			<% }
		
			%>
		</table>	
  			
	<%
	
	Statement alertStatement = con.createStatement();
	String manual_alert = "SELECT B.email, A.aID FROM auction_posts A, bid B WHERE A.aID = B.aID AND B.current_bid < A.current_price AND B.is_autobid = 0";
	ResultSet alertResult = alertStatement.executeQuery(manual_alert);
	while (alertResult.next())
	{
		if(alertResult.getString("email").equals(user_email))
		out.print("Someone has outbid you on auction ID: " + alertResult.getInt("aID") + "   ");
	}
	
	Statement autoAlertStatement = con.createStatement();
	String auto_alert = "SELECT B.email, A.aID FROM auction_posts A, bid B WHERE A.aID = B.aID AND B.current_bid < A.current_price AND B.is_autobid = 1";
	ResultSet autoAlertResult = autoAlertStatement.executeQuery(auto_alert);
	while (autoAlertResult.next())
	{
		if(autoAlertResult.getString("email").equals(user_email))
		out.print("Someone has surpassed your autobid maximum on auction ID: " + autoAlertResult.getInt("aID"));
	}
	
	//close the connection.
	db.closeConnection(con);		
			
	ApplicationDB db2 = new ApplicationDB();	
  	Connection con2 = db2.getConnection();		
  	Statement stmt2 = con2.createStatement();
  	
  	String str2 = "SELECT * FROM auction_posts A, item I"
  	  		+ " WHERE if(A.close_date = CURDATE(), A.close_time < CURTIME(), A.close_date < CURDATE())"
  	  		+ " AND A.buyer_email ='" + user_email + "'"
  	  		+ " AND A.aID = I.aID"
  	  		+ " AND A.current_price >= A.reserve_price";
  	ResultSet result2 = stmt2.executeQuery(str2);
  	
  	%>
  	<h2>Winning Auctions</h2>
  	<table>
		<tr>    
			<td>Auction ID</td>
			<td>Item Name</td>
			<td>Close Date</td>
			<td>Sale Price</td>
			<td>Buyer Email</td>
		</tr>
			<%
			//parse out the results
			while (result2.next()) { %>
				<tr>    
					<td><%= result2.getInt("aID") %></td>
					<td>
						<%= result2.getString("item_name") %>
					</td>
					<td><%= result2.getDate("close_date") %></td>
					<td><%= result2.getDouble("current_price") %></td>
					<td><%= result2.getString("buyer_email") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con2);
	}	
			%>
		</table>		