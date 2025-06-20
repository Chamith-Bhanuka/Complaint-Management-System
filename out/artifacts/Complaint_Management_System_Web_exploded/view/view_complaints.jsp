<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 3:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.CMS.model.Complaint" %>
<%@ page import="lk.ijse.CMS.model.User" %>
<%@ page import="lk.ijse.CMS.dao.ComplaintDAO" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<Complaint> complaints = ComplaintDAO.getComplaintsByUser(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
  <title>My Complaints</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #eef2f5;
      padding: 20px;
    }

    h2 {
      text-align: center;
    }

    .message {
      color: green;
      text-align: center;
      margin-bottom: 10px;
    }

    table {
      border-collapse: collapse;
      width: 100%;
      margin-top: 20px;
      background-color: white;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px;
      border: 1px solid #ddd;
      text-align: center;
    }

    th {
      background-color: #007bff;
      color: white;
    }

    .actions form {
      display: inline;
    }

    .actions input[type="submit"] {
      padding: 5px 10px;
      margin: 2px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .edit-btn {
      background-color: #28a745;
      color: white;
    }

    .delete-btn {
      background-color: #dc3545;
      color: white;
    }

    a.back-link {
      display: inline-block;
      margin-top: 20px;
      text-decoration: none;
      color: #007bff;
    }

    a.back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<h2>My Complaints</h2>

<% if ("true".equals(request.getParameter("edited"))) { %>
<div class="message">Complaint updated successfully!</div>
<% } %>
<% if ("true".equals(request.getParameter("deleted"))) { %>
<div class="message">Complaint deleted successfully!</div>
<% } %>

<table>
  <tr>
    <th>ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Status</th>
    <th>Remarks</th>
    <th>Created At</th>
    <th>Actions</th>
  </tr>
  <% for (Complaint c : complaints) { %>
  <tr>
    <td><%= c.getId() %></td>
    <td><%= c.getTitle() %></td>
    <td><%= c.getDescription() %></td>
    <td><%= c.getStatus() %></td>
    <td><%= c.getRemarks() == null ? "-" : c.getRemarks() %></td>
    <td><%= c.getCreatedAt() %></td>
    <td class="actions">
      <% if ("Pending".equalsIgnoreCase(c.getStatus())) { %>
      <form action="../editComplaint" method="get">
        <input type="hidden" name="id" value="<%= c.getId() %>">
        <input type="submit" value="Edit" class="edit-btn">
      </form>

      <form action="../deleteComplaint" method="post" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
        <input type="hidden" name="id" value="<%= c.getId() %>">
        <input type="submit" value="Delete" class="delete-btn">
      </form>
      <% } else { %>
      <em>No Actions</em>
      <% } %>
    </td>
  </tr>
  <% } %>
</table>

<a class="back-link" href="dashboard.jsp">← Back to Dashboard</a>

</body>
</html>

