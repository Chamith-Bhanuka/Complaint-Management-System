package lk.ijse.CMS.controller;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.CMS.model.Complaint;
import lk.ijse.CMS.model.User;
import lk.ijse.CMS.dao.ComplaintDAO;

import java.io.IOException;

public class EditComplaintServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"employee".equals(user.getRole())) {
            res.sendRedirect("jsp/login.jsp");
            return;
        }

        int complaintId = Integer.parseInt(req.getParameter("id"));
        Complaint c = ComplaintDAO.getComplaintById(complaintId);

        if (c == null || c.getUserId() != user.getId() || !"Pending".equalsIgnoreCase(c.getStatus())) {
            res.sendRedirect("jsp/view_complaints.jsp?unauthorized=true");
            return;
        }

        session.setAttribute("complaintToEdit", c);
        res.sendRedirect("jsp/edit_complaint.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        Complaint original = (Complaint) session.getAttribute("complaintToEdit");

        if (user == null || original == null || original.getUserId() != user.getId()) {
            res.sendRedirect("jsp/view_complaints.jsp?unauthorized=true");
            return;
        }

        String newTitle = req.getParameter("title");
        String newDesc = req.getParameter("description");

        original.setTitle(newTitle);
        original.setDescription(newDesc);

        ComplaintDAO.updateComplaint(original);

        session.removeAttribute("complaintToEdit");
        res.sendRedirect("jsp/view_complaints.jsp?edited=true");
    }
}
