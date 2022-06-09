<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Bid Placed!</title>
	</head>
	
	<body>
<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		double price = Double.valueOf(request.getParameter("bid_price"));
		int aID = Integer.valueOf(request.getParameter("aID"));
		String user_email = session.getAttribute("user_email").toString();

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO bid(email, aID, bidID, current_bid)"
				+ "VALUES (?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, user_email);
		ps.setInt(2, aID);
		ps.setInt(3, (int)Math.floor(Math.random() * 100000));
		ps.setDouble(4, price);
		//Run the query against the DB
		ps.executeUpdate();
		
		String update = "UPDATE auction_posts SET current_price = " + price + ",buyer_email = '"
			    + user_email + "' WHERE aID = " + aID;
		con.createStatement().executeUpdate(update);
		//out.print("Price being updated to auction_posts: $" +price+"\n");

		Statement stmt2 = con.createStatement();
		String select = "SELECT bidID FROM bid WHERE aID = " + aID + " AND is_autobid = 1";
		ResultSet result = stmt2.executeQuery(select);
		ArrayList<Integer> bidID_list = new ArrayList<Integer>();
		
		while(result.next())
		{
			bidID_list.add(result.getInt("bidID"));
		}
		//found
		
		Statement getMax = con.createStatement();
		String getMaxQuery = "SELECT current_price FROM auction_posts WHERE auction_posts.aID = " + aID; 
		ResultSet maxResult = getMax.executeQuery(getMaxQuery);
		maxResult.first();
		double maximum = maxResult.getDouble("current_price");
		//out.print("Maximum Bid price is: $" +maximum +"\n");
		int bidID = 0;
		double current = 0.0;
		double increment = 0.0;
		double maximum_bid = 0.0;
		int count = 0;
		Statement stmt3 = con.createStatement();
		String autobidUpdate;
		while (bidID_list.size() > count)
		{
			bidID = bidID_list.get(count);
			//out.print("Current bidID being modified: " +bidID);
			Statement stmt4 = con.createStatement();
			String select2 = "SELECT current_bid,increment,maximum_bid FROM bid WHERE bidID = " + bidID+"\n";
			ResultSet result2 = stmt4.executeQuery(select2);
			result2.first();
			current = result2.getFloat("current_bid");
			//out.print("Current bid price: $" +current+"\n");
			increment = result2.getFloat("increment");
			//out.print("Increment: $" + increment+"\n");
			maximum_bid = result2.getFloat("maximum_bid");
			//out.print("Maximum bid for this autobid: $" + maximum_bid+"\n");
			while(current < maximum && (current + increment) <= maximum_bid)
			{
				current = current + increment;
			}
			//out.print("New Current: $" + current+"\n");
			autobidUpdate = "UPDATE bid SET current_bid = " + current + "WHERE bidID = " + bidID;
			con.createStatement().executeUpdate(autobidUpdate);	
			count++;
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Insert succeeded!");
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
</body>
</html>