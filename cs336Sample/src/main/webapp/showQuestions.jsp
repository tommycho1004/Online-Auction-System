<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Questions and Answers</title>
</head>
<body>
<h1>Q&A Results</h1>
<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String keywords = request.getParameter("search");
			String str = "SELECT * FROM question";
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			
			if (keywords != null) {
				str += " WHERE question LIKE ";
				String[] res = keywords.split(" ");
				for (String word : res) {
					str += "'%" + word + "%' OR question LIKE ";
				}
				
			}
			
			str = str.substring(0, str.length() - 18);
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Question</td>
			<td>Answer</td>
			<td>Posted By</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("question") %></td>
					<td>
						<% if (result.getString("answer") != null){ %>
							<%= result.getString("answer")%>
						<% }else{ %>
							No response yet.
						<% } %>
					</td>
					<td><%= result.getString("user") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</body>
</html>