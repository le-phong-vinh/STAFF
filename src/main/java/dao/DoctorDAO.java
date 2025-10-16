/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Doctor;
import model.Room;
import model.Schedule;
import model.Specialty;

/**
 *
 * @author ourki
 */
public class DoctorDAO {
    // Cập nhật lịch bác sĩ
public boolean insertSchedule(Schedule s) {
    String sql = "INSERT INTO Schedules (doctorId, roomId, date, shiftName, status) VALUES (?, ?, ?, ?, ?)";
    boolean success = false;

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, s.getDoctorId());
        ps.setInt(2, s.getRoomId());
        ps.setDate(3, s.getDate()); // nếu s.getDate() là String
        ps.setString(4, s.getShiftName());
        ps.setInt(5, 1);

        success = ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}
public boolean deleteSchedulesByDoctorAndShift(String doctorId, String dateStr, String shiftName) {
    String sql = "DELETE FROM Schedules WHERE doctorId = ? AND [date] = ? AND shiftName = ? AND [status] = 1";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, doctorId);
        ps.setString(2, dateStr);
        ps.setString(3, shiftName);

        int rows = ps.executeUpdate();
        return rows > 0;

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

// Hàm kiểm tra xem bác sĩ có bận trong một buổi cụ thể hay không
    public boolean checkSchedule(int doctorId, String date, String shiftName) {
        String sql = "SELECT COUNT(*) AS count FROM [HospitalDB].[dbo].[Schedules] " +
                     "WHERE doctorId = ? AND [date] = ? AND shiftName = ? AND [status] = 1";
        boolean isBusy = false;

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            ps.setString(2, date); // Giả định date là String ở định dạng YYYY-MM-DD
            ps.setString(3, shiftName);

            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt("count") > 0) {
                isBusy = true; // Bác sĩ đã có lịch trong ca này
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isBusy;
    }
public boolean updateSchedule(Schedule s) {
    String sql = "UPDATE Schedules SET doctorId = ?, roomId = ?, date = ?, shiftName = ?, status = ? WHERE scheduleId = ?";
    boolean success = false;

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, s.getDoctorId());
        ps.setInt(2, s.getRoomId());
        ps.setDate(3, s.getDate()); // nếu s.getDate() là java.sql.Date
        ps.setString(4, s.getShiftName());
        ps.setInt(5, 1); // ví dụ 1 = active
        ps.setInt(6, s.getScheduleId()); // dùng scheduleId để update đúng bản ghi

        success = ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}
public boolean deleteSchedule(int scheduleId) {
    String sql = "DELETE FROM Schedules WHERE scheduleId = ?";
    boolean success = false;

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, scheduleId);
        success = ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}



public List<Room> getAllRooms() {
    List<Room> list = new ArrayList<>();
    String sql = "SELECT roomId, roomNumber, roomType, capacity FROM Rooms";
    
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Room r = new Room();
            r.setRoomId(rs.getInt("roomId"));
            r.setRoomNumber(rs.getString("roomNumber"));
            r.setRoomType(rs.getString("roomType"));
            r.setCapacity(rs.getInt("capacity"));
            list.add(r);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
 public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT scheduleId, doctorId, roomId, date, shiftName, status FROM Schedules";

      try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Schedule s = new Schedule();
                s.setScheduleId(rs.getInt("scheduleId"));
                s.setDoctorId(rs.getInt("doctorId"));
                s.setRoomId(rs.getInt("roomId"));
                s.setDate(rs.getDate("date"));
                s.setShiftName(rs.getString("shiftName"));
                s.setStatus(rs.getString("status"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

 // Cập nhật thông tin Bác sĩ
public void updateDoctor(Doctor d) {
    String sqlUser = "UPDATE Users SET fullName=?, phone=?, email=? WHERE userId=?";
    String sqlDoctor = "UPDATE Doctors SET specialtyId=?, licenseNumber=? WHERE doctorId=?";
    String sqlSchedule = "UPDATE Schedules SET status=? WHERE doctorId=?";

    try (Connection conn = new DBContext().getConnection()) {
        // Update Users
        try (PreparedStatement ps = conn.prepareStatement(sqlUser)) {
            ps.setString(1, d.getFullName());
            ps.setString(2, d.getPhone());
            ps.setString(3, d.getEmail());
            ps.setInt(4, d.getUserId());
            ps.executeUpdate();
        }

        // Update Doctors
        try (PreparedStatement ps = conn.prepareStatement(sqlDoctor)) {
            ps.setInt(1, d.getSpecialtyId());
            ps.setString(2, d.getLicenseNumber());
            ps.setInt(3, d.getDoctorId());
            ps.executeUpdate();
        }

        // Update Schedules (status)
        try (PreparedStatement ps = conn.prepareStatement(sqlSchedule)) {
            ps.setString(1, d.getScheduleStatus()); // giả sử status là String, nếu int thì đổi setInt
            ps.setInt(2, d.getDoctorId());
            ps.executeUpdate();
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}

public List<Specialty> getAllSpecialties() {
    List<Specialty> list = new ArrayList<>();
    String sql = "SELECT specialtyId, specialtyName FROM Specialties";
     try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Specialty sp = new Specialty();
            sp.setSpecialtyId(rs.getInt("specialtyId"));
            sp.setSpecialtyName(rs.getString("specialtyName"));
            list.add(sp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    public ArrayList<Doctor> getAllDoctors() {
        ArrayList<Doctor> list = new ArrayList<>();
        String sql = "SELECT DISTINCT  d.doctorId, d.licenseNumber,\n" +
"       u.userId, u.role, u.username, u.fullName, u.email, u.phone,\n" +
"       sp.specialtyId, sp.specialtyName,\n" +
"       s.status\n" +
"FROM HospitalDB.dbo.Doctors d\n" +
"JOIN HospitalDB.dbo.Specialties sp ON d.specialtyId = sp.specialtyId\n" +
"JOIN HospitalDB.dbo.Users u ON d.userId = u.userId\n" +
"JOIN HospitalDB.dbo.Schedules s ON d.doctorId = s.doctorId\n" +
"WHERE u.role = 'doctor'\n" +
"";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
          

          while (rs.next()) {
    Doctor d = new Doctor();

    // Doctor
    d.setDoctorId(rs.getInt("doctorId"));
    d.setLicenseNumber(rs.getString("licenseNumber"));

    // User
    d.setUserId(rs.getInt("userId"));
    d.setRole(rs.getString("role"));
    d.setUsername(rs.getString("username"));
    d.setFullName(rs.getString("fullName"));
    d.setEmail(rs.getString("email"));
    d.setPhone(rs.getString("phone"));
    // Specialty
    d.setSpecialtyId(rs.getInt("specialtyId"));
    d.setSpecialtyName(rs.getString("specialtyName"));
    d.setScheduleStatus(rs.getString("status"));
d.printInfo();
    list.add(d);
}


        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Doctor> getAll() {
    return getAllDoctors();
}

}
