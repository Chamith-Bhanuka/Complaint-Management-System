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
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel - All Complaints</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: rgba(255, 255, 255, 0.95);
      min-height: 100vh;
      padding: 20px;
      color: #334155;
    }

    .container {
      max-width: 1400px;
      margin: 0 auto;
    }

    .header {
      background: #ffffff;
      border: 1px solid #e2e8f0;
      border-radius: 12px;
      padding: 30px;
      margin-bottom: 24px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .header h2 {
      color: #1e293b;
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 8px;
    }

    .header p {
      color: #64748b;
      font-size: 16px;
    }

    .message {
      background: #10b981;
      color: white;
      padding: 12px 20px;
      border-radius: 8px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 500;
      box-shadow: 0 2px 4px rgba(16, 185, 129, 0.2);
    }

    .table-container {
      background: #ffffff;
      border: 1px solid #e2e8f0;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      margin-bottom: 24px;
    }

    .table-responsive {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th {
      background: #1e293b;
      color: white;
      padding: 16px 12px;
      text-align: left;
      font-weight: 600;
      font-size: 13px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 1px solid #334155;
    }

    th:last-child {
      text-align: center;
      width: 200px;
    }

    td {
      padding: 16px 12px;
      border-bottom: 1px solid #f1f5f9;
      color: #334155;
      font-size: 14px;
      vertical-align: top;
    }

    td:last-child {
      text-align: center;
      vertical-align: middle;
    }

    tr:hover {
      background-color: #f8fafc;
    }

    tr:last-child td {
      border-bottom: none;
    }

    .admin-form {
      display: flex;
      flex-direction: column;
      gap: 8px;
      align-items: center;
      width: 100%;
      max-width: 180px;
      margin: 0 auto;
    }

    .form-row {
      display: flex;
      width: 100%;
      justify-content: center;
    }

    .form-control-sm {
      width: 100%;
      padding: 6px 10px;
      border: 1px solid #d1d5db;
      border-radius: 6px;
      font-size: 12px;
      transition: all 0.2s ease;
      background: #ffffff;
    }

    .form-control-sm:focus {
      outline: none;
      border-color: #3b82f6;
      box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.1);
    }

    .form-select-sm {
      width: 100%;
      padding: 6px 10px;
      border: 1px solid #d1d5db;
      border-radius: 6px;
      font-size: 12px;
      background: #ffffff;
      cursor: pointer;
    }

    .form-select-sm:focus {
      outline: none;
      border-color: #3b82f6;
    }

    .btn-sm {
      width: 100%;
      padding: 6px 12px;
      border: none;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s ease;
      text-decoration: none;
      display: inline-block;
      text-align: center;
    }

    .btn-update {
      background: #059669;
      color: white;
    }

    .btn-update:hover {
      background: #047857;
      transform: translateY(-1px);
    }

    .btn-delete {
      background: #dc2626;
      color: white;
    }

    .btn-delete:hover {
      background: #b91c1c;
      transform: translateY(-1px);
    }

    .status-badge {
      padding: 4px 12px;
      border-radius: 16px;
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      display: inline-block;
    }

    .status-pending {
      background: #fef3c7;
      color: #d97706;
      border: 1px solid #fbbf24;
    }

    .status-resolved {
      background: #d1fae5;
      color: #059669;
      border: 1px solid #34d399;
    }

    .status-in-progress {
      background: #dbeafe;
      color: #2563eb;
      border: 1px solid #60a5fa;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: #9e7a18;
      color: white;
      padding: 12px 20px;
      border-radius: 8px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.2s ease;
      box-shadow: 0 2px 4px rgba(30, 41, 59, 0.2);
    }

    .back-link:hover {
      background: #334155;
      transform: translateY(-1px);
      color: white;
      text-decoration: none;
      box-shadow: 0 4px 8px rgba(30, 41, 59, 0.3);
    }

    .empty-state {
      text-align: center;
      padding: 60px 20px;
      color: #64748b;
    }

    .empty-state h3 {
      font-size: 20px;
      margin-bottom: 8px;
      color: #475569;
    }

    .empty-state p {
      font-size: 16px;
    }

    .complaint-id {
      font-weight: 600;
      color: #1e293b;
    }

    .complaint-title {
      font-weight: 500;
      color: #334155;
      max-width: 200px;
      word-wrap: break-word;
    }

    .complaint-description {
      max-width: 250px;
      word-wrap: break-word;
      line-height: 1.4;
    }

    @media (max-width: 768px) {
      .container {
        padding: 10px;
      }

      .header {
        padding: 20px;
      }

      .header h2 {
        font-size: 24px;
      }

      th, td {
        padding: 12px 8px;
        font-size: 12px;
      }

      .admin-form {
        max-width: 140px;
      }

      .form-control-sm, .form-select-sm {
        font-size: 11px;
        padding: 5px 8px;
      }

      .btn-sm {
        font-size: 11px;
        padding: 5px 10px;
      }

      .complaint-title, .complaint-description {
        max-width: 150px;
      }
    }

    @media (max-width: 480px) {
      th:last-child, td:last-child {
        width: 160px;
      }

      .admin-form {
        max-width: 120px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <h2>Admin Panel</h2>
    <p>Manage and review all complaints</p>
  </div>

  <% if ("true".equals(request.getParameter("updated"))) { %>
  <div class="message">✓ Complaint updated successfully!</div>
  <% } else if ("true".equals(request.getParameter("deleted"))) { %>
  <div class="message">✓ Complaint deleted successfully!</div>
  <% } %>

  <div class="table-container">
    <% if (complaints != null && !complaints.isEmpty()) { %>
    <div class="table-responsive">
      <table>
        <thead>
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
        </thead>
        <tbody>
        <% for (Complaint c : complaints) { %>
        <tr>
          <td><span class="complaint-id">#<%= c.getId() %></span></td>
          <td><%= c.getUserId() %></td>
          <td><div class="complaint-title"><%= c.getTitle() %></div></td>
          <td><div class="complaint-description"><%= c.getDescription() %></div></td>
          <td>
            <span class="status-badge <%= "Pending".equalsIgnoreCase(c.getStatus()) ? "status-pending" :
                                          "Resolved".equalsIgnoreCase(c.getStatus()) ? "status-resolved" :
                                          "status-in-progress" %>">
              <%= c.getStatus() %>
            </span>
          </td>
          <td><%= c.getRemarks() == null ? "-" : c.getRemarks() %></td>
          <td><%= c.getCreatedAt() %></td>
          <td>
            <div class="admin-form">
              <form action="${pageContext.request.contextPath}/adminUpdateComplaint" method="post">
                <input type="hidden" name="id" value="<%= c.getId() %>">
                <div class="form-row">
                  <select name="status" class="form-select-sm">
                    <option value="Pending" <%= "Pending".equals(c.getStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="In Progress" <%= "In Progress".equals(c.getStatus()) ? "selected" : "" %>>In Progress</option>
                    <option value="Resolved" <%= "Resolved".equals(c.getStatus()) ? "selected" : "" %>>Resolved</option>
                  </select>
                </div>
                <div class="form-row">
                  <input type="text" name="remarks" class="form-control-sm"
                         placeholder="Add remarks..."
                         value="<%= c.getRemarks() != null ? c.getRemarks() : "" %>">
                </div>
                <input type="submit" value="Update" class="btn-sm btn-update">
              </form>
              <form action="${pageContext.request.contextPath}/adminDeleteComplaint" method="post"
                    onsubmit="return confirmDelete();">
                <input type="hidden" name="id" value="<%= c.getId() %>">
                <input type="submit" value="Delete" class="btn-sm btn-delete">
              </form>
            </div>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <% } else { %>
    <div class="empty-state">
      <h3>No Complaints Found</h3>
      <p>No complaints have been submitted yet.</p>
    </div>
    <% } %>
  </div>

  <a class="back-link" href="dashboard.jsp">Back to Dashboard</a>
</div>

<script>
  function confirmDelete() {
    return confirm('Are you sure you want to delete this complaint? This action cannot be undone.');
  }
</script>
</body>
</html>