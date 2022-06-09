<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Management</title>
<body>
<h1>Staff Management</h1>
<a href="AdminLanding.jsp">Back to Admin Page</a>
<h2>Create Staff</h2>
 <form action="createStaff.jsp" method="POST" >
  <label for="email">Email:</label>
  <input type="text" id="email" name="email" required="required"><br>
  <label for="username">Username:</label>
  <input type="text" id="username" name="username" required="required"><br>
  <label for="password">Password:</label>
  <input type="text" id="password" name="password" required="required"><br>
  <input type="submit" id="create" name="create" value="Create Staff">
</form>

<h2>Remove Staff</h2>
<form action="RemoveStaff.jsp" method="POST">
	<label for="staffid">Staff ID:</label>
  <input type="text" id="staff_id" name="staff_id" required="required"><br>
  <input type="submit" id="remove_staff" name="remove_staff" value="Remove Staff">
</form>

<h2>Staff List</h2>
	<% try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String query = "select * from staff";
		
		ResultSet rs = stmt.executeQuery(query);%>
		
		<table>
			<tr>
				<td>Staff ID</td>
				<td>Username</td>
				<td>Email</td>
			</tr>
		<% while (rs.next()) { %>
			<tr>
				<td><%=rs.getInt("staffID")%></td>
				<td><%=rs.getString("username") %></td>
				<td><%=rs.getString("email") %></td>
			</tr>
		<%}
		// close all statements
		rs.close();
		stmt.close();
		con.close();%>
		</table>
	<%} catch (Exception e){
		out.print(e);
	}%>
 
</body>
</html>