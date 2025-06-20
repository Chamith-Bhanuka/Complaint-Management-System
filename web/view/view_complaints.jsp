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
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Complaints - CMS</title>
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
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .header {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      padding: 30px;
      margin-bottom: 30px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .header h2 {
      color: #1e293b;
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .header p {
      color: #64748b;
      font-size: 16px;
    }

    .message {
      background: linear-gradient(135deg, #48bb78, #38a169);
      color: white;
      padding: 15px 20px;
      border-radius: 10px;
      margin-bottom: 20px;
      text-align: center;
      font-weight: 500;
      box-shadow: 0 5px 15px rgba(72, 187, 120, 0.3);
    }

    .table-container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
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
      padding: 20px 15px;
      text-align: left;
      font-weight: 600;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    td {
      padding: 20px 15px;
      border-bottom: 1px solid #e2e8f0;
      color: #2d3748;
      font-size: 14px;
    }

    tr:hover {
      background-color: #f7fafc;
    }

    .status-badge {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .status-pending {
      background: #fed7d7;
      color: #c53030;
    }

    .status-resolved {
      background: #c6f6d5;
      color: #2f855a;
    }

    .status-in-progress {
      background: #feebc8;
      color: #d69e2e;
    }

    .actions {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .btn {
      padding: 8px 16px;
      border: none;
      border-radius: 8px;
      font-size: 12px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      text-decoration: none;
      display: inline-block;
    }

    .btn-edit {
      background: linear-gradient(135deg, #48bb78, #38a169);
      color: white;
    }

    .btn-edit:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(72, 187, 120, 0.4);
    }

    .btn-delete {
      background: linear-gradient(135deg, #f56565, #e53e3e);
      color: white;
    }

    .btn-delete:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(245, 101, 101, 0.4);
    }

    .no-actions {
      color: #a0aec0;
      font-style: italic;
      font-size: 12px;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: #9e7a18;
      color: white;
      padding: 12px 24px;
      border-radius: 10px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .back-link:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
      color: white;
      text-decoration: none;
    }

    .empty-state {
      text-align: center;
      padding: 60px 20px;
      color: #718096;
    }

    .empty-state h3 {
      font-size: 24px;
      margin-bottom: 10px;
      color: #4a5568;
    }

    .empty-state p {
      font-size: 16px;
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

      .actions {
        flex-direction: column;
        gap: 4px;
      }

      .btn {
        width: 100%;
        text-align: center;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <h2>My Complaints</h2>
    <p>Track and manage your submitted complaints</p>
  </div>

  <% if ("true".equals(request.getParameter("edited"))) { %>
  <div class="message">✓ Complaint updated successfully!</div>
  <% } %>
  <% if ("true".equals(request.getParameter("deleted"))) { %>
  <div class="message">✓ Complaint deleted successfully!</div>
  <% } %>

  <div class="table-container">
    <% if (complaints != null && !complaints.isEmpty()) { %>
    <div class="table-responsive">
      <table>
        <thead>
        <tr>
          <th>ID</th>
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
          <td><strong>#<%= c.getId() %></strong></td>
          <td><%= c.getTitle() %></td>
          <td><%= c.getDescription() %></td>
          <td>
                                <span class="status-badge <%= "Pending".equalsIgnoreCase(c.getStatus()) ? "status-pending" :
                                                              "Resolved".equalsIgnoreCase(c.getStatus()) ? "status-resolved" :
                                                              "status-in-progress" %>">
                                    <%= c.getStatus() %>
                                </span>
          </td>
          <td><%= c.getRemarks() == null ? "-" : c.getRemarks() %></td>
          <td><%= c.getCreatedAt() %></td>
          <td class="actions">
            <% if ("Pending".equalsIgnoreCase(c.getStatus())) { %>
            <form action="../editComplaint" method="get" style="display: inline;">
              <input type="hidden" name="id" value="<%= c.getId() %>">
              <input type="submit" value="Edit" class="btn btn-edit">
            </form>

            <form action="../deleteComplaint" method="post" style="display: inline;"
                  onsubmit="return confirmDelete();">
              <input type="hidden" name="id" value="<%= c.getId() %>">
              <input type="submit" value="Delete" class="btn btn-delete">
            </form>
            <% } else { %>
            <span class="no-actions">No Actions</span>
            <% } %>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <% } else { %>
    <div class="empty-state">
      <h3>No Complaints Found</h3>
      <p>You haven't submitted any complaints yet.</p>
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
