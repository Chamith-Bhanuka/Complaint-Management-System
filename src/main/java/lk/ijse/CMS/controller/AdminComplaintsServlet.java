package lk.ijse.CMS.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.CMS.dao.ComplaintDAO;
import lk.ijse.CMS.model.Complaint;
import lk.ijse.CMS.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/complaints")
public class AdminComplaintsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            res.sendRedirect("../view/login.jsp");
            return;
        }

        List<Complaint> complaints = ComplaintDAO.getAllComplaints();
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/view/admin_complaints.jsp").forward(req, res);
    }
}
