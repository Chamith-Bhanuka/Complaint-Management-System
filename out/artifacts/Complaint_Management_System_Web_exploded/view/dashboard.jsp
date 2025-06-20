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
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard - CMS</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: #2C2A2D;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .dashboard-container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      padding: 40px;
      width: 100%;
      max-width: 600px;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .welcome-header {
      text-align: center;
      margin-bottom: 40px;
    }

    .welcome-header h2 {
      color: #2d3748;
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .welcome-header .role-badge {
      display: inline-block;
      padding: 8px 16px;
      background: linear-gradient(135deg, #2C2A2D 0%, #E1B12C 100%);
      color: white;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .navigation-links {
      display: flex;
      flex-direction: column;
      gap: 16px;
      margin-bottom: 30px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 16px 20px;
      background: #9e7a18;
      color: white;
      text-decoration: none;
      border-radius: 12px;
      font-weight: 500;
      font-size: 16px;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .nav-link:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
      color: white;
      text-decoration: none;
    }

    .nav-link .icon {
      font-size: 20px;
    }

    .logout-section {
      text-align: center;
      padding-top: 20px;
      border-top: 1px solid #e2e8f0;
    }

    .logout-link {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      color: #e53e3e;
      text-decoration: none;
      font-weight: 500;
      padding: 8px 16px;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .logout-link:hover {
      background-color: #fed7d7;
      color: #c53030;
      text-decoration: none;
    }

    @media (max-width: 768px) {
      .dashboard-container {
        padding: 30px 20px;
      }

      .welcome-header h2 {
        font-size: 24px;
      }

      .nav-link {
        padding: 14px 16px;
        font-size: 14px;
      }
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <div class="welcome-header">
    <h2>Welcome, <%= user.getName() %>!</h2>
    <span class="role-badge"><%= user.getRole() %></span>
  </div>

  <div class="navigation-links">
    <% if ("employee".equalsIgnoreCase(user.getRole())) { %>
    <a href="complaint_from.jsp" class="nav-link">
      <span>Submit New Complaint</span>
    </a>
    <a href="view_complaints.jsp" class="nav-link">
      <span>View My Complaints</span>
    </a>
    <% } else if ("admin".equalsIgnoreCase(user.getRole())) { %>
    <a href="admin_complaints.jsp" class="nav-link">
      <span>View All Complaints</span>
    </a>
    <a href="manage_users.jsp" class="nav-link">
      <span>Manage Users</span>
    </a>
    <% } %>
  </div>

  <div class="logout-section">
    <a href="login.jsp" class="logout-link">
      <span>Logout</span>
    </a>
  </div>
</div>
</body>
</html>
