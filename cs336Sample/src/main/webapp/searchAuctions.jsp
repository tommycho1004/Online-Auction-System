<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Auction and Item Search</title>
	</head>
	
	<body>

		<h1> Search for Items </h1>
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<!-- forms are used to collect user input 
			The default method when submitting form data is GET.
			However, when GET is used, the submitted form data will be visible in the page address field-->
		<form method="post" action="showSearch.jsp">
		<label for="categories">Choose categories to search for:</label>
		   <input type="checkbox" id="cat1" name="Category1" value="Shirts">
  			<label for="cat1"> Shirts</label>
  			<input type="checkbox" id="cat2" name="Category2" value="Pants">
  			<label for="cat2"> Pants</label>
  			<input type="checkbox" id="cat3" name="Category3" value="Shoes">
  			<label for="cat3"> Shoes</label><br><br>
  			<label for="sorting">Sort By:</label>
			  <select name="sorting" id="sorting">
			    <option value="price: low to high">Price: Low to High</option>
			    <option value="price: high to low">Price: High to Low</option>
			    <option value="name: A-Z">Name: A-Z</option>
			  </select>
			  <br><br>
		  <input type="submit" value="Search" />
		</form>
		<br>
	
	
	</body>
</html>