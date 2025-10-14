package dao;

import db.DBContext;
import model.Review;
import java.sql.*;
import java.util.ArrayList;

public class ReviewDAO {

    // Lấy tất cả review kèm thông tin patient, appointment, schedule, doctor
    public ArrayList<Review> getAllReviews() {
        ArrayList<Review> list = new ArrayList<>();
        String sql = "SELECT "
                + "r.reviewId, r.rating, r.comment, r.status AS reviewStatus, r.createdAt AS reviewCreatedAt, "
                + "a.appointmentId, a.bookedAt, a.reason AS serviceReason, a.status AS appointmentStatus, "
                + "p.patientId, p.userId AS patientUserId, uPatient.fullName AS patientName, "
                + "s.scheduleId, s.date AS scheduleDate, s.shiftName, s.roomId, s.status AS scheduleStatus, "
                + "uStaff.userId AS doctorUserId, uStaff.fullName AS doctorName "
                + "FROM Reviews r "
                + "INNER JOIN Appointments a ON r.appointmentId = a.appointmentId "
                + "INNER JOIN Patients p ON a.patientId = p.patientId "
                + "INNER JOIN Users uPatient ON p.userId = uPatient.userId "
                + "INNER JOIN Schedules s ON a.scheduleId = s.scheduleId "
                + "INNER JOIN Users uStaff ON s.doctorId = uStaff.userId "
                + "ORDER BY r.createdAt DESC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Review review = new Review();

                // Review
                review.setReviewId(rs.getInt("reviewId"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewStatus(rs.getInt("reviewStatus")); // chuyển int sang String nếu cần
                review.setReviewCreatedAt(rs.getTimestamp("reviewCreatedAt"));

                // Appointment
                review.setAppointmentId(rs.getInt("appointmentId"));
                review.setBookedAt(rs.getTimestamp("bookedAt"));
                review.setServiceReason(rs.getString("serviceReason"));
                review.setAppointmentStatus(rs.getInt("appointmentStatus"));

                // Patient
                review.setPatientId(rs.getInt("patientId"));
                review.setPatientUserId(rs.getInt("patientUserId"));
                review.setPatientName(rs.getString("patientName"));

                // Schedule
                review.setScheduleId(rs.getInt("scheduleId"));
                review.setScheduleDate(rs.getTimestamp("scheduleDate"));
                review.setShiftName(rs.getString("shiftName"));
                review.setRoomId(rs.getInt("roomId"));
                review.setScheduleStatus(rs.getInt("scheduleStatus"));

                // Doctor
                review.setDoctorUserId(rs.getInt("doctorUserId"));
                review.setDoctorName(rs.getString("doctorName"));

                list.add(review);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

   public void hideReview(String id) {
    String sql = "UPDATE Reviews SET status = ? WHERE reviewId = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, "0"); // Ẩn review
        ps.setString(2, id);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
  
public void showReview(String id) {
    String sql = "UPDATE Reviews SET status = ? WHERE reviewId = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, "1"); 
        ps.setString(2, id);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    public boolean deleteReview(String id) {
        String sql = "DELETE FROM Reviews WHERE reviewId = ?";
        boolean success = false;

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
}
