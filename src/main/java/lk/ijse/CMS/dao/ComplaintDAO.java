package lk.ijse.CMS.dao;

import lk.ijse.CMS.model.Complaint;
import lk.ijse.CMS.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ComplaintDAO {
    public static boolean saveComplaint(Complaint c) {
        String sql = "INSERT INTO complaints (user_id, title, description) VALUES (?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, c.getUserId());
            ps.setString(2, c.getTitle());
            ps.setString(3, c.getDescription());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
