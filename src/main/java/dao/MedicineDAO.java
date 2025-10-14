package dao;

import db.DBContext;
import model.Medicine;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Le Phong Vinh - CE181130
 */
public class MedicineDAO extends DBContext {

    public List<Medicine> getAll() {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicines";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Medicine(
                        rs.getInt("medicineId"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("unit")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Medicine> search(String keyword) {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicines WHERE name LIKE ? OR description LIKE ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Medicine(
                            rs.getInt("medicineId"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("unit")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(Medicine m) {
        String sql = "INSERT INTO Medicines (name, description, unit) VALUES (?, ?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getDescription());
            ps.setString(3, m.getUnit());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Medicine m) {
        String sql = "UPDATE Medicines SET name=?, description=?, unit=? WHERE medicineId=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getDescription());
            ps.setString(3, m.getUnit());
            ps.setInt(4, m.getMedicineId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Medicines WHERE medicineId=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Medicine getById(int id) {
        String sql = "SELECT * FROM Medicines WHERE medicineId=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Medicine(
                            rs.getInt("medicineId"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("unit")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
