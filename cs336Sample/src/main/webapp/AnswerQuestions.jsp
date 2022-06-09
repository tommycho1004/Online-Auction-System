<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Answer Questions</title>
</head>
<body>
<h1>Answer Questions</h1>
<a href="CustomerRepLanding.jsp">Back to Customer Rep Page</a>

<h2>Update Answer</h2>
<form action="UpdateAnswer.jsp" method="POST">
	<label for="question_id">Question ID: </label>
	<input type="text" id="question_id" name="question_id" required="required"><br>
	<label for="answer">Answer: </label>
	<input type="text" id="answer" name="answer" required="required"><br>
	<input type="submit" id="submit_answer" name="submit_anwer" value="Submit">
</form>

<h2>Questions</h2>
<% try {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String query = "select * from question";
	
	ResultSet rs = stmt.executeQuery(query);%>
	
	<table>
		<tr>
			<td>Question ID</td>
			<td>Email</td>
			<td>Question</td>
			<td>Answer</td>
		</tr>
		<% while (rs.next()) {%>
			<tr>
			<td><%=rs.getInt("qID") %></td>
			<td><%=rs.getString("user") %></td>
			<td><%=rs.getString("question") %></td>
			<td><%=rs.getString("answer") %></td>
			</tr>
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