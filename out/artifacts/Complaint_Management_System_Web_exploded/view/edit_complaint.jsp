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
    <title>Edit Complaint</title>
</head>
<body>
<h2>Edit Complaint</h2>
<form action="../editComplaint" method="post">
    <label>Title:</label><br/>
    <input type="text" name="title" value="<%= complaint.getTitle() %>" required><br/><br/>

    <label>Description:</label><br/>
    <textarea name="description" rows="5" cols="30" required><%= complaint.getDescription() %></textarea><br/><br/>

    <input type="submit" value="Update Complaint">
</form>

<p><a href="view_complaints.jsp">← Back to My Complaints</a></p>
</body>
</html>

