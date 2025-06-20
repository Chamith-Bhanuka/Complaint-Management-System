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
<head><title>Sign Up</title></head>
<body>
<h2>Register</h2>
<form action="../signup" method="post">
    Name: <input type="text" name="name" required><br/>
    Email: <input type="email" name="email" required><br/>
    Password: <input type="password" name="password" required><br/>
    <input type="submit" value="Register">
</form>
</body>
</html>

