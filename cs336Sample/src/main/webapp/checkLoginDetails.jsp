<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>



<%@ page import ="java.sql.*" %>
<%
	ApplicationDB db = new ApplicationDB();
	String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    Statement st2 = con.createStatement();
    Statement st3 = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from user where username='" + userid + "' and password='" + pwd + "'");
    ResultSet rs_admin = st2.executeQuery("SELECT * FROM staff WHERE username='" + userid + "' AND password= '" + pwd + "' AND isAdmin= '1'");
    ResultSet rs_cr = st3.executeQuery("SELECT * FROM staff WHERE username='" + userid + "' AND password= '" + pwd + "' AND isAdmin= '0'");
    if (rs.next()) {
    	String user_email = rs.getString("email");
        session.setAttribute("user", userid); // the username will be stored in the session
        session.setAttribute("user_email", user_email);
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
    	if (rs_admin.next()) {
	    	String user_email = rs_admin.getString("email");
	        session.setAttribute("user", userid); // the username will be stored in the session
	        session.setAttribute("user_email", user_email);
	        out.println("welcome " + userid);
	        out.println("<a href='logout.jsp'>Log out</a>");
	        response.sendRedirect("AdminLanding.jsp");
    	} else {
    		if (rs_cr.next()) {
    			String user_email = rs_cr.getString("email");
    	        session.setAttribute("user", userid); // the username will be stored in the session
    	        session.setAttribute("user_email", user_email);
    	        out.println("welcome " + userid);
    	        out.println("<a href='logout.jsp'>Log out</a>");
    	        response.sendRedirect("CustomerRepLanding.jsp");
    		} else {
    			out.println("Invalid password <a href='login.jsp'>try again</a>");
    		}
    	}
    }
%>
