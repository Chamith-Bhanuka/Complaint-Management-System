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

@WebServlet("/adminUpdateComplaint")
public class AdminUpdateComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            res.sendRedirect("view/login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        Complaint complaint = ComplaintDAO.getComplaintById(id);
        if (complaint != null) {
            complaint.setStatus(status);
            complaint.setRemarks(remarks);
            ComplaintDAO.updateComplaint(complaint);
        }

        res.sendRedirect("view/admin_complaints.jsp?updated=true");
    }
}
