package lk.ijse.CMS.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.CMS.dao.UserDAO;
import lk.ijse.CMS.model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = UserDAO.login(email, password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            res.sendRedirect("view/dashboard.jsp");
        } else {
            res.sendRedirect("view/login.jsp?error=true");
        }
    }
}
