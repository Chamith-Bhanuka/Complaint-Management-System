<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 3:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page import="java.util.*, lk.ijse.CMS.model.*, lk.ijse.CMS.dao.ComplaintDAO" %>
<%@ page import="lk.ijse.CMS.model.Complaint" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || !"employee".equals(user.getRole())) {
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
    table { border-collapse: collapse; width: 80%; margin: auto; }
    th, td { padding: 10px; border: 1px solid #ccc; }
    h2 { text-align: center; }
  </style>
</head>
<body>
<h2>Your Complaints</h2>
<table>
  <tr>
    <th>Title</th>
    <th>Description</th>
    <th>Status</th>
    <th>Remarks</th>
    <th>Actions</th>
  </tr>
  <% for (Complaint c : complaints) { %>
  <tr>
    <td><%= c.getTitle() %></td>
    <td><%= c.getDescription() %></td>
    <td><%= c.getStatus() %></td>
    <td><%= c.getRemarks() != null ? c.getRemarks() : "-" %></td>
    <td>
      <% if ("Pending".equalsIgnoreCase(c.getStatus())) { %>
      <form action="../editComplaint" method="get" style="display:inline;">
        <input type="hidden" name="id" value="<%= c.getId() %>">
        <input type="submit" value="Edit">
      </form>
      <form action="../deleteComplaint" method="post" style="display:inline;" onsubmit="return confirm('Delete this complaint?');">
        <input type="hidden" name="id" value="<%= c.getId() %>">
        <input type="submit" value="Delete">
      </form>
      <% } else { %>
      <em>Resolved</em>
      <% } %>
    </td>
  </tr>
  <% } %>
</table>

<div style="text-align:center; margin-top:20px;">
  <a href="dashboard.jsp">← Back to Dashboard</a>
</div>
</body>
</html>

