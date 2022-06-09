<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<% try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	String email = request.getParameter("email");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	int id = 0;
	boolean exists = false;
	
	String check_query = "select * from staff where email='" + email + "'";
	ResultSet rs = stmt.executeQuery(check_query);
	
	while (rs.next()) {
		exists = true;
	}
	
	if (!exists) {
		String helper_query = "select max(staffID) from staff";
		
		rs = stmt.executeQuery(helper_query);
		
		while (rs.next()) {
			id = rs.getInt(1) + 1;
		}
		
		String str = "insert into staff values(" + id +",'" + email + "','" + password + "','" + username + "',0,1)";
		//out.println(str);
		
		int i = stmt.executeUpdate(str);
		out.print("Staff created successfully");
	} else {
		out.print("Staff already exists");
	}%>
	
<% } catch (Exception e) {
	out.print(e);
} %>
<br><a href="StaffManagement.jsp">Back to Staff Management</a>
</body>
</html>