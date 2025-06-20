package lk.ijse.CMS.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.CMS.dao.ComplaintDAO;
import lk.ijse.CMS.model.User;

import java.io.IOException;

@WebServlet("/admin/updateComplaint")
public class UpdateComplaintStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            res.sendRedirect("../view/login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        boolean updated = ComplaintDAO.updateComplaintStatus(id, status, remarks);

        res.sendRedirect("complaints?updated=" + updated);
    }
}
