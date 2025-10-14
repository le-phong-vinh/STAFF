package dao;

import db.DBContext;
import model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

public class PatientsDAO {

 // Lấy tất cả bệnh nhân
public ArrayList<Patient> getAllPatients() {
    ArrayList<Patient> list = new ArrayList<>();
    String sql = "SELECT p.patientId, u.fullName, p.dob, p.gender, "
               + "p.insuranceNumber, pr.provinceName, p.emergencyContact, u.phone, "
               + "p.userId, p.provinceId "
               + "FROM Patients p "
               + "JOIN Users u ON p.userId = u.userId "
               + "JOIN Provinces pr ON p.provinceId = pr.provinceId";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Patient p = new Patient(); // khởi tạo trước

            // patientId
            Integer patientId = rs.getInt("patientId");
            if (rs.wasNull()) patientId = null;
            p.setPatientId(patientId);

            // userId
            Integer userId = rs.getInt("userId");
            if (rs.wasNull()) userId = null;
            p.setUserId(userId);

            // các trường khác
            p.setFullName(rs.getString("fullName"));
            p.setDob(rs.getDate("dob"));
            p.setGender(rs.getString("gender"));
            p.setInsuranceNumber(rs.getString("insuranceNumber"));
            p.setProvinceName(rs.getString("provinceName"));

            Integer provinceId = rs.getInt("provinceId");
            if (rs.wasNull()) provinceId = null;
            p.setProvinceId(provinceId);

            p.setEmergencyContact(rs.getString("emergencyContact"));
            p.setPhone(rs.getString("phone"));

            list.add(p);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
 // Kiểm tra trùng số điện thoại (username/phone)
    public boolean isPhoneExists(String phone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ? OR phone = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng email
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
public void insertPatient(Patient p) {
    String insertUserSql = "INSERT INTO Users (role, username, password, fullName, email, phone, status, createdAt) " +
                           "OUTPUT INSERTED.userId " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";

    String insertPatientSql = "INSERT INTO Patients (userId, dob, gender, provinceId, insuranceNumber, emergencyContact) " +
                              "VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection conn = new DBContext().getConnection()) {
        conn.setAutoCommit(false);

        // 1. Thêm User
        int newUserId = 0;
        try (PreparedStatement psUser = conn.prepareStatement(insertUserSql)) {
            psUser.setString(1, "patient");
            psUser.setString(2, p.getPhone()); // username = phone
            psUser.setString(3, "123456");     // password mặc định
            psUser.setString(4, p.getFullName());
            psUser.setString(5, p.getEmail());
            psUser.setString(6, p.getPhone());
            psUser.setInt(7, 1); // status

            ResultSet rs = psUser.executeQuery();
            if (rs.next()) {
                newUserId = rs.getInt(1);
            } else {
                throw new SQLException("Không lấy được userId mới.");
            }
        }

        // 2. Thêm Patient
        try (PreparedStatement psPatient = conn.prepareStatement(insertPatientSql)) {
            psPatient.setInt(1, newUserId);
            psPatient.setDate(2, p.getDob());
            psPatient.setString(3, p.getGender());
            psPatient.setInt(4, p.getProvinceId());
            psPatient.setString(5, p.getInsuranceNumber());
            psPatient.setString(6, p.getEmergencyContact());

            psPatient.executeUpdate();
        }

        conn.commit();
    } catch (Exception e) {
        e.printStackTrace();
    }
}



    // Cập nhật bệnh nhân
    public void updatePatient(Patient p) {
        String sql = "UPDATE Patients SET dob=?, gender=?, insuranceNumber=?, emergencyContact=? WHERE patientId=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, p.getDob());
            ps.setString(2, p.getGender());
            ps.setString(3, p.getInsuranceNumber());
            ps.setString(4, p.getEmergencyContact());
            ps.setInt(5, p.getPatientId());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa bệnh nhân
    public void deletePatient(int patientId) {
        String sql = "DELETE FROM Patients WHERE patientId=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy bệnh nhân theo ID
    public Patient getPatientById(int patientId) {
        Patient p = null;
        String sql = "SELECT p.patientId, u.fullName, p.dob, p.gender, "
                   + "p.insuranceNumber, pr.provinceName, p.emergencyContact, u.phone "
                   + "FROM Patients p "
                   + "JOIN Users u ON p.userId = u.userId "
                   + "JOIN Provinces pr ON p.provinceId = pr.provinceId "
                   + "WHERE p.patientId = ?";

   p = new Patient(); // khởi tạo trước

try (Connection conn = new DBContext().getConnection();
     PreparedStatement ps = conn.prepareStatement(sql)) {

    ps.setInt(1, patientId);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        // set từng giá trị một
        p.setPatientId(rs.getInt("patientId"));
        p.setFullName(rs.getString("fullName"));
        p.setDob(rs.getDate("dob"));
        p.setGender(rs.getString("gender"));
        p.setInsuranceNumber(rs.getString("insuranceNumber"));
        p.setProvinceName(rs.getString("provinceName"));
        p.setEmergencyContact(rs.getString("emergencyContact"));
        p.setPhone(rs.getString("phone"));
        
        // nếu userId hoặc provinceId nullable
        Integer userId = rs.getInt("userId");
        if (rs.wasNull()) userId = null;
        p.setUserId(userId);

        Integer provinceId = rs.getInt("provinceId");
        if (rs.wasNull()) provinceId = null;
        p.setProvinceId(provinceId);
    }

    rs.close();
} catch (Exception e) {
    e.printStackTrace();
}

return p;
    }

    // Tìm kiếm bệnh nhân
 // Tìm kiếm bệnh nhân
public ArrayList<Patient> searchPatients(String keyword) {
    ArrayList<Patient> list = new ArrayList<>();
    String sql = "SELECT p.patientId, u.fullName, p.dob, p.gender, "
               + "p.insuranceNumber, pr.provinceName, p.emergencyContact, u.phone, "
               + "p.userId, p.provinceId "
               + "FROM Patients p "
               + "JOIN Users u ON p.userId = u.userId "
               + "JOIN Provinces pr ON p.provinceId = pr.provinceId "
               + "WHERE u.fullName LIKE ? OR p.insuranceNumber LIKE ? OR p.emergencyContact LIKE ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, "%" + keyword + "%");
        ps.setString(2, "%" + keyword + "%");
        ps.setString(3, "%" + keyword + "%");

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Patient p = new Patient(); // khởi tạo trước

            // set từng trường
            Integer patientId = rs.getInt("patientId");
            if (rs.wasNull()) patientId = null;
            p.setPatientId(patientId);

            Integer userId = rs.getInt("userId");
            if (rs.wasNull()) userId = null;
            p.setUserId(userId);

            p.setFullName(rs.getString("fullName"));
            p.setDob(rs.getDate("dob"));
            p.setGender(rs.getString("gender"));
            p.setInsuranceNumber(rs.getString("insuranceNumber"));
            p.setProvinceName(rs.getString("provinceName"));

            Integer provinceId = rs.getInt("provinceId");
            if (rs.wasNull()) provinceId = null;
            p.setProvinceId(provinceId);

            p.setEmergencyContact(rs.getString("emergencyContact"));
            p.setPhone(rs.getString("phone"));

            list.add(p);
        }
        rs.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

}
