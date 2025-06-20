<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/20/2025
  Time: 2:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            padding: 50px;
        }
        form {
            max-width: 400px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Sign Up</h2>
<form action="../signup" method="post">
    <%--@declare id="role"--%><input type="text" name="name" placeholder="Full Name" required>
    <input type="email" name="email" placeholder="Email" required>
    <input type="password" name="password" placeholder="Password" required>

    <!-- ✅ Role selection -->
    <label for="role">Role:</label>
    <select name="role" required>
        <option value="employee">Employee</option>
        <option value="admin">Admin</option>
    </select>

    <input type="submit" value="Sign Up">
</form>
</body>
</html>


