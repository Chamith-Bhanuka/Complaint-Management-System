package lk.ijse.CMS.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.CMS.dao.ComplaintDAO;
import lk.ijse.CMS.model.Complaint;
import lk.ijse.CMS.model.User;

import java.io.IOException;

@WebServlet("/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"employee".equals(user.getRole())) {
            res.sendRedirect("view/login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");

        Complaint c = new Complaint();
        c.setUserId(user.getId());
        c.setTitle(title);
        c.setDescription(description);

        boolean success = ComplaintDAO.saveComplaint(c);
        res.sendRedirect("view/dashboard.jsp?submitted=" + success);
    }
}
