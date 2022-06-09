<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Answer</title>
</head>
<body>
	<%try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String question_id = request.getParameter("question_id");
		String answer = request.getParameter("answer");
		
		String str = "update question set answer='" + answer + "' where qID=" + question_id;
		//out.print(str);
		
		int output = stmt.executeUpdate(str);
		out.println("Answer updated");
	} catch (Exception e) {
		out.print(e);
	}
	%>
	<br><a href="AnswerQuestions.jsp">Back to Answer Questions</a>
</body>
</html>