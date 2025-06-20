package lk.ijse.CMS.dao;

import lk.ijse.CMS.model.Complaint;
import lk.ijse.CMS.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public static List<Complaint> getComplaintsByUser(int userId) {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Complaint c = new Complaint();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setRemarks(rs.getString("remarks"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
