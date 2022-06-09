<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Question Search</title>
	</head>
	
	<body>
							  
	<h1> Search Here For Any Questions </h1>
	
	Enter keywords for specific questions, or leave blank for all questions.
	<br>
	<br>
		<form method="get" action="showQuestions.jsp">
			<input type="text" name="search">
			<input type="submit" value="Search">
		</form>
	<br>

</body>
</html>