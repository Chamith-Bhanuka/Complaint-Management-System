<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 2:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page import="lk.ijse.CMS.model.User" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head><title>Dashboard</title></head>
<body>
<h2>Welcome, <%= user.getName() %>!</h2>

<% if ("employee".equals(user.getRole())) { %>
<a href="complaint_from.jsp">Submit New Complaint</a><br/>
<% } else { %>
<p>You are an admin. Complaint management features will go here.</p>
<% } %>

<a href="../logout">Logout</a>
</body>
</html>
