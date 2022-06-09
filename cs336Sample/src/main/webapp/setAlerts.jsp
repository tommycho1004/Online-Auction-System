<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create new alert</title>
	</head>
	<body>
		
		
		<%
	    if ((session.getAttribute("user") == null)) { %>
		You are not logged in<br/>
		<a href="login.jsp">Please Login</a>
		
		<% } else {
			try {
		
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String cat1 = request.getParameter("Category1");
			String cat2 = request.getParameter("Category2");
			String cat3 = request.getParameter("Category3");
			String user_email = session.getAttribute("user_email").toString();
			
			String insert = "INSERT INTO alerts(user_email, type)"
					+ "VALUES (?, ?)";
			
			if (cat1 == null && cat2 == null && cat3 == null) {
				out.println("No category was selected");
				return;
			}
			
			if (cat1 != null) {
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, user_email);
				ps.setString(2, cat1.toLowerCase());
				ps.executeUpdate();
			}
			
			if (cat2 != null) {
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, user_email);
				ps.setString(2, cat2.toLowerCase());
				ps.executeUpdate();
			}
			
			if (cat3 != null) {
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, user_email);
				ps.setString(2, cat3.toLowerCase());
				ps.executeUpdate();
			}

			out.print("Insert succeeded!");
			
			
	
			
			//close the connection.
			db.closeConnection(con);
			
		} catch (Exception e) {
			out.print("Already set that alert. Go back and add a different one");
		}}%>
	

	</body>
</html>