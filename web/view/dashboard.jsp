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
<head>
  <title>Dashboard</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f2f5;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 600px;
      margin: 50px auto;
      background-color: white;
      padding: 30px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      border-radius: 10px;
    }

    h2 {
      text-align: center;
      color: #333;
    }

    .links {
      margin-top: 30px;
      display: flex;
      flex-direction: column;
      gap: 15px;
      align-items: center;
    }

    .links a {
      display: block;
      width: 80%;
      text-align: center;
      padding: 12px 0;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 6px;
      transition: background-color 0.3s ease;
    }

    .links a:hover {
      background-color: #0056b3;
    }

    .logout {
      text-align: center;
      margin-top: 20px;
    }

    .logout a {
      color: #dc3545;
      text-decoration: none;
      font-weight: bold;
    }

    .logout a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Welcome, <%= user.getName() %>!</h2>

  <div class="links">
    <% if ("employee".equalsIgnoreCase(user.getRole())) { %>
    <a href="complaint_form.jsp">📝 Submit New Complaint</a>
    <a href="view_complaints.jsp">📋 View My Complaints</a>
    <% } else if ("admin".equalsIgnoreCase(user.getRole())) { %>
    <a href="admin_complaints.jsp">📂 View All Complaints</a>
    <a href="manage_users.jsp">👥 Manage Users</a>
    <% } %>
  </div>

  <div class="logout">
    <p><a href="../logout">Logout</a></p>
  </div>
</div>
</body>
</html>
