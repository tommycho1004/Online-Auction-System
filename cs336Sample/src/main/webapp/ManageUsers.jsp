<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users</title>
</head>
<body>
<h2>Manage Users</h2>
<a href="CustomerRepLanding.jsp">Back to Customer Rep Page</a>

<h2>Add User</h2>
<form action="AddUser.jsp" method="POST">
<label for="email">User email: </label>
<input type="text" id="email" name="email" required="required"><br>
<label for="username">Username: </label>
<input type="text" id="username" name="username" required="required"><br>
<label for="password">Password</label>
<input type="text" id="password" name="password" required="required"><br>
<input type="submit" id="submit" name="submit" value="Submit">
</form>

<h2>Update User Details</h2>

<form action="UpdateUser.jsp" method="POST">
<label for="email">User Email: </label>
<input type="text" id="email" name="email" required="required"><br>
<label for="text">Enter new information in fields that you want to update</label><br>
<label for="new_email">New Email: </label>
<input type="text" id="new_enail" name="new_email"><br>
<label for="username">New Username: </label>
<input type="text" id="new_username" name="new_username"><br>
<label for="new_password">New Password</label>
<input type="text" id="new_password" name="new_password"><br>
<label for="delete_user_text">Delete User? </label>
<input type="checkbox" id="delete_user" name="delete_user"><br>
<input type="submit" id="submit" name="submit" value="Submit">
</form>

<h2>List of Users</h2>

<% try {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String query = "select * from user";
	
	ResultSet rs = stmt.executeQuery(query);%>
	<table>
		<tr>
			<td>Email</td>
			<td>Username</td>
		</tr>
		<%while (rs.next()) { %>
			<tr>
			<td><%=rs.getString("email") %></td>
			<td><%=rs.getString("username") %></td>
			<tr>
		<%}
		rs.close();
		stmt.close();
		con.close();%>
	</table>
<%} catch (Exception e) {
	out.print(e);
}%>

</body>
</html>