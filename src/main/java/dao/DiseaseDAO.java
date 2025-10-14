package dao;

import db.DBContext;
import java.sql.*;
import java.util.*;
import model.Disease;

/**
 *
 * @author Le Phong Vinh - CE181130
 */
public class DiseaseDAO extends DBContext {

    // Lấy tất cả bệnh
    public List<Disease> getAll() {
        List<Disease> list = new ArrayList<>();
        String sql = "SELECT * FROM Diseases";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Disease(
                        rs.getInt("diseaseId"),
                        rs.getString("diseaseName"),
                        rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm
    public List<Disease> search(String keyword) {
        List<Disease> list = new ArrayList<>();
        String sql = "SELECT * FROM Diseases WHERE diseaseName LIKE ? OR description LIKE ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Disease(
                            rs.getInt("diseaseId"),
                            rs.getString("diseaseName"),
                            rs.getString("description")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm
    public void insert(Disease d) {
        String sql = "INSERT INTO Diseases(diseaseName, description) VALUES(?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, d.getDiseaseName());
            ps.setString(2, d.getDescription());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật
    public void update(Disease d) {
        String sql = "UPDATE Diseases SET diseaseName=?, description=? WHERE diseaseId=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, d.getDiseaseName());
            ps.setString(2, d.getDescription());
            ps.setInt(3, d.getDiseaseId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa
    public void delete(int id) {
        String sql = "DELETE FROM Diseases WHERE diseaseId=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy theo ID
    public Disease getById(int id) {
        String sql = "SELECT * FROM Diseases WHERE diseaseId=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Disease(
                            rs.getInt("diseaseId"),
                            rs.getString("diseaseName"),
                            rs.getString("description")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
