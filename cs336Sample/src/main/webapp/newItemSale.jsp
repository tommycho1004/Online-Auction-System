<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String item_name = request.getParameter("item_name");
		String item_type = request.getParameter("item_type");
		String closing_time = request.getParameter("closing_time");
		// getDate
		LocalDate closing_date = LocalDate.parse(request.getParameter("closing_date"));
		java.sql.Date c_date = java.sql.Date.valueOf(closing_date);
		
		double initial_price = Double.valueOf(request.getParameter("initial_price"));
		double increment = Double.valueOf(request.getParameter("increment"));
		String reserve_price = request.getParameter("min_price");
		double rp = -1;
		if (!reserve_price.isEmpty()) {
			rp = Double.valueOf(reserve_price);
		}
		String user_email = session.getAttribute("user_email").toString();
		String str = "SELECT MAX(aID) as max FROM auction_posts";
		//Run the query to find next aID
		ResultSet result = stmt.executeQuery(str);
		result.first();
		int aID = result.getInt("max") + 1;
		//Make an insert statement for the auction_posts table:
		String insert = "INSERT INTO auction_posts(aID,close_time,close_date,increment,initial_price,current_price,reserve_price,seller_email)"
				+ "VALUES (?,?,?,?,?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, aID);
		ps.setString(2, closing_time);
		ps.setDate(3, c_date);
		ps.setDouble(4,increment);
		ps.setDouble(5,initial_price);
		ps.setDouble(6,initial_price);
		if (rp != -1) {
			ps.setDouble(7, rp);
		} else {
			ps.setNull(7, Types.DOUBLE);
		}
		ps.setString(8,user_email);
		
		ps.executeUpdate();

		

		
		//Make an insert statement for the item table:
		insert = "INSERT INTO item(itemID, aID, item_name, item_type)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, aID);
		ps.setInt(2, aID);
		ps.setString(3, item_name);
		ps.setString(4, item_type);
		//Run the query against the DB
		ps.executeUpdate();
		//Run the query against the DB
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>
</body>
</html>