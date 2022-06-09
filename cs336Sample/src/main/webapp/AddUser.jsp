<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add User</title>
</head>
<body>
<a href="ManageUsers.jsp">Back to Manage Users</a><br>
<%try{
	String email = request.getParameter("email");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String query = "select * from user where email='" + email + "'";
	
	ResultSet rs = stmt.executeQuery(query);
	
	while (rs.next()) {
		throw new Exception("user email already exists.");
	}
	
	query = "insert into user values('" + email + "','" + username + "','" + password + "')";
	
	int output = stmt.executeUpdate(query);%>
	
	User Successfully added.
<%} catch (Exception e) {
	out.print(e.getMessage());
} %>

</body>
</html>