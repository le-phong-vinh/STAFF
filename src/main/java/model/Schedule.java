package model;

import java.sql.Date;

public class Schedule {
    private int scheduleId;
    private int doctorId;
    private int roomId;
    private Date date;
    private String shiftName;
    private String status;

    public Schedule() {}

    public Schedule(int scheduleId, int doctorId, int roomId, Date date, String shiftName, String status) {
        this.scheduleId = scheduleId;
        this.doctorId = doctorId;
        this.roomId = roomId;
        this.date = date;
        this.shiftName = shiftName;
        this.status = status;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
