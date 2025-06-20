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

@WebServlet("/deleteComplaint")
public class DeleteComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"employee".equals(user.getRole())) {
            res.sendRedirect("view/login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        Complaint complaint = ComplaintDAO.getComplaintById(id);

        if (complaint != null && complaint.getUserId() == user.getId()
                && "Pending".equalsIgnoreCase(complaint.getStatus())) {
            ComplaintDAO.deleteComplaint(id);
        }

        res.sendRedirect("view/view_complaints.jsp?deleted=true");
    }
}
