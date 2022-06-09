<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Remove Staff</title>
</head>
<body>
<% try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	String staffID = request.getParameter("staff_id");
	
	if (staffID.equals("1")) {
		throw new Exception("Cannot delete admin");
	}

	String str = "delete from staff where staffID='" + staffID + "'";
	
	int output = stmt.executeUpdate(str);
	out.println("Staff deleted Successfully");
	
	stmt.close();
	con.close();

} catch (Exception e) {
	out.print(e.getMessage());
} %>
<br><a href="StaffManagement.jsp">Back to Staff Management</a>
</body>
</html>