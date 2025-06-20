package lk.ijse.CMS.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.CMS.dao.UserDAO;
import lk.ijse.CMS.model.User;

import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("employee");

        boolean success = UserDAO.registerUser(user);
        res.sendRedirect(success ? "jsp/login.jsp" : "jsp/signup.jsp?error=true");
    }
}
