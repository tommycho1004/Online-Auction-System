<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Landing Page</title>
</head>
<body>
<h1>Admin Page</h1>
<a href="logout.jsp">Logout</a>
<ul>
<li> <a href="StaffManagement.jsp">Manage Staff</a> </li>
<li> <a href="CustomerRepLanding.jsp">Customer Representative Page</a> </li>
<li> <a href="SalesReports.jsp">Generate Sales Reports</a></li>
</ul>
</body>
</html>