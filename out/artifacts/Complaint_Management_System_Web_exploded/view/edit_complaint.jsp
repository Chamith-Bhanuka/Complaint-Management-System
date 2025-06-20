<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 3:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page import="lk.ijse.CMS.model.Complaint" %>
<%@ page session="true" %>
<%
    Complaint complaint = (Complaint) session.getAttribute("complaintToEdit");
    if (complaint == null) {
        response.sendRedirect("view_complaints.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Complaint - CMS</title>
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

        .edit-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 600px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .edit-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .edit-header h2 {
            color: #2d3748;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .edit-header p {
            color: #718096;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2d3748;
            font-weight: 500;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #ffffff;
            font-family: 'Inter', sans-serif;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control.textarea {
            resize: vertical;
            min-height: 120px;
        }

        .btn-primary {
            width: 100%;
            padding: 14px;
            background: #9e7a18;
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
            padding: 8px 0;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: #764ba2;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .edit-container {
                padding: 30px 20px;
            }

            .edit-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<div class="edit-container">
    <div class="edit-header">
        <h2>Edit Complaint</h2>
        <p>Update your complaint details</p>
    </div>

    <form action="../editComplaint" method="post">
        <div class="form-group">
            <label for="title">Title</label>
            <input type="text" name="title" id="title" class="form-control"
                   value="<%= complaint.getTitle() %>" required>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea name="description" id="description" class="form-control textarea"
                      required><%= complaint.getDescription() %></textarea>
        </div>

        <button type="submit" class="btn-primary">Update Complaint</button>
    </form>

    <a href="view_complaints.jsp" class="back-link">
        ← Back to My Complaints
    </a>
</div>
</body>
</html>

