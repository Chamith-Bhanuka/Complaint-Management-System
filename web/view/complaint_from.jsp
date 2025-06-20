<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 2:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page import="lk.ijse.CMS.model.User" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || !"employee".equals(user.getRole())) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Complaint</title>
</head>
<body>
<h2>Submit Complaint</h2>
<form action="../submitComplaint" method="post">
  <label>Title:</label><br/>
  <input type="text" name="title" required><br/><br/>

  <label>Description:</label><br/>
  <textarea name="description" rows="5" cols="30" required></textarea><br/><br/>

  <input type="submit" value="Submit Complaint">
</form>

<p><a href="dashboard.jsp">← Back to Dashboard</a></p>
</body>
</html>

