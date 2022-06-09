<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Post</title>
</head>
<body>
<a href="#deadlink.jsp">Back to user page</a>
<% try {
	String email = "";
	email = session.getAttribute("user_email").toString();
	String question = request.getParameter("question");
	int id = 0;
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String helper_query = "select max(qID) from question";
	
	ResultSet rs = stmt.executeQuery(helper_query);
	
	while (rs.next()) {
		id = rs.getInt(1) + 1;
	}
	
	String str = "insert into question values(" + id + ",'" + question + "',NULL,'" + email + "')";
	//out.print(str);
	
	int output = stmt.executeUpdate(str);
	%>
	<br>Question Posted.
<%} catch (Exception e) {
	out.print(e);
}
%>

</body>
</html>