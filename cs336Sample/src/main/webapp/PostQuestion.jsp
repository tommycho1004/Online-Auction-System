<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Post Question</title>
</head>
<body>
<h1>Post Question</h1>

<form action="Post.jsp" method="POST">
	<label for="question">Question: </label>
	<input type="text" id="question" name="question" required="required"><br>
	<input type="submit" id="submit" name="submit" value="Post">
</form>

</body>
</html>