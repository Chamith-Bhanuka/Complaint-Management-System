<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 3:57 PM
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
  if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<Complaint> complaints = ComplaintDAO.getAllComplaints();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin - All Complaints</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f6f9;
      padding: 20px;
    }

    h2 {
      text-align: center;
      color: #333;
    }

    .message {
      text-align: center;
      color: green;
      font-weight: bold;
      margin-bottom: 20px;
    }

    table {
      border-collapse: collapse;
      width: 100%;
      margin-top: 20px;
      background-color: white;
      box-shadow: 0 0 8px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px;
      border: 1px solid #ddd;
      text-align: center;
      vertical-align: middle;
    }

    th {
      background-color: #007bff;
      color: white;
    }

    input[type="text"], select {
      padding: 5px;
      width: 120px;
      font-size: 14px;
    }

    input[type="submit"] {
      padding: 6px 12px;
      margin-top: 5px;
      font-size: 14px;
      border-radius: 4px;
      cursor: pointer;
      border: none;
    }

    input[type="submit"][value='Update'] {
      background-color: #28a745;
      color: white;
    }

    input[type="submit"][value='Update']:hover {
      background-color: #218838;
    }

    input[type="submit"][value='Delete'] {
      background-color: #dc3545;
      color: white;
    }

    input[type="submit"][value='Delete']:hover {
      background-color: #c82333;
    }

    .back-link {
      display: inline-block;
      margin-top: 20px;
      text-decoration: none;
      color: #007bff;
    }

    .back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<h2>All Complaints (Admin Panel)</h2>

<% if ("true".equals(request.getParameter("updated"))) { %>
<div class="message">Complaint updated successfully!</div>
<% } else if ("true".equals(request.getParameter("deleted"))) { %>
<div class="message">Complaint deleted successfully!</div>
<% } %>

<table>
  <tr>
    <th>ID</th>
    <th>User ID</th>
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
    <td><%= c.getUserId() %></td>
    <td><%= c.getTitle() %></td>
    <td><%= c.getDescription() %></td>
    <td><%= c.getStatus() %></td>
    <td><%= c.getRemarks() == null ? "-" : c.getRemarks() %></td>
    <td><%= c.getCreatedAt() %></td>
    <td>
      <form action="updateComplaint" method="post">
        <input type="hidden" name="id" value="<%= c.getId() %>">
        <select name="status">
          <option value="Pending" <%= "Pending".equals(c.getStatus()) ? "selected" : "" %>>Pending</option>
          <option value="In Progress" <%= "In Progress".equals(c.getStatus()) ? "selected" : "" %>>In Progress</option>
          <option value="Resolved" <%= "Resolved".equals(c.getStatus()) ? "selected" : "" %>>Resolved</option>
        </select>
        <input type="text" name="remarks" value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>">
        <input type="submit" value="Update">
      </form>
      <form action="deleteComplaint" method="post" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
        <input type="hidden" name="id" value="<%= c.getId() %>">
        <input type="submit" value="Delete">
      </form>
    </td>
  </tr>
  <% } %>
</table>

<a class="back-link" href="dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
