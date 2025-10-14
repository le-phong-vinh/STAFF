package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Review {
    // Review
    private int reviewId;
    private int rating;
    private String comment;
    private int reviewStatus; // 1 = hiển thị, 0 = ẩn
    private Date reviewCreatedAt;

    // Appointment
    private int appointmentId;
    private Date bookedAt;
    private String serviceReason;
    private int appointmentStatus; // 1 = active, 0 = inactive

    // Patient
    private int patientId;
    private int patientUserId;
    private String patientName;

    // Schedule
    private int scheduleId;
    private Date scheduleDate;
    private String shiftName;
    private int roomId;
    private int scheduleStatus;

    // Doctor
    private int doctorUserId;
    private String doctorName;

    public Review() {}

    // Constructor từ ResultSet
    public Review(ResultSet rs) throws SQLException {
        // Review
        this.reviewId = rs.getInt("reviewId");
        this.rating = rs.getInt("rating");
        this.comment = rs.getString("comment");
        this.reviewStatus = rs.getInt("reviewStatus");
        this.reviewCreatedAt = rs.getTimestamp("reviewCreatedAt");

        // Appointment
        this.appointmentId = rs.getInt("appointmentId");
        this.bookedAt = rs.getTimestamp("bookedAt");
        this.serviceReason = rs.getString("serviceReason");
        this.appointmentStatus = rs.getInt("appointmentStatus");

        // Patient
        this.patientId = rs.getInt("patientId");
        this.patientUserId = rs.getInt("patientUserId");
        this.patientName = rs.getString("patientName");

        // Schedule
        this.scheduleId = rs.getInt("scheduleId");
        this.scheduleDate = rs.getTimestamp("scheduleDate");
        this.shiftName = rs.getString("shiftName");
        this.roomId = rs.getInt("roomId");
        this.scheduleStatus = rs.getInt("scheduleStatus");

        // Doctor
        this.doctorUserId = rs.getInt("doctorUserId");
        this.doctorName = rs.getString("doctorName");
    }

    // --- Getter & Setter ---
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public int getReviewStatus() { return reviewStatus; }
    public void setReviewStatus(int reviewStatus) { this.reviewStatus = reviewStatus; }

    public Date getReviewCreatedAt() { return reviewCreatedAt; }
    public void setReviewCreatedAt(Date reviewCreatedAt) { this.reviewCreatedAt = reviewCreatedAt; }

    public int getAppointmentId() { return appointmentId; }
    public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }

    public Date getBookedAt() { return bookedAt; }
    public void setBookedAt(Date bookedAt) { this.bookedAt = bookedAt; }

    public String getServiceReason() { return serviceReason; }
    public void setServiceReason(String serviceReason) { this.serviceReason = serviceReason; }

    public int getAppointmentStatus() { return appointmentStatus; }
    public void setAppointmentStatus(int appointmentStatus) { this.appointmentStatus = appointmentStatus; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getPatientUserId() { return patientUserId; }
    public void setPatientUserId(int patientUserId) { this.patientUserId = patientUserId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public int getScheduleId() { return scheduleId; }
    public void setScheduleId(int scheduleId) { this.scheduleId = scheduleId; }

    public Date getScheduleDate() { return scheduleDate; }
    public void setScheduleDate(Date scheduleDate) { this.scheduleDate = scheduleDate; }

    public String getShiftName() { return shiftName; }
    public void setShiftName(String shiftName) { this.shiftName = shiftName; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public int getScheduleStatus() { return scheduleStatus; }
    public void setScheduleStatus(int scheduleStatus) { this.scheduleStatus = scheduleStatus; }

    public int getDoctorUserId() { return doctorUserId; }
    public void setDoctorUserId(int doctorUserId) { this.doctorUserId = doctorUserId; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
}
