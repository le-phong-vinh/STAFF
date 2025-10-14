package model;

public class Doctor {
    // Thông tin lịch
    private int scheduleId;
    private String shiftName;
    private String scheduleStatus;

    // Thông tin bác sĩ
    private int doctorId;
    private String licenseNumber;

    // Thông tin user
    private int userId;
     private int roomID;
    private String role;
    private String username;
    private String fullName;
    private String email;
    private String phone;

    // Thông tin specialty
    private int specialtyId;
    private String specialtyName;

    public Doctor() {}
//      list.add(new Doctor(id, name, spec));
    public Doctor(int doctorId, String fullName, String specialtyName){
        this.doctorId = doctorId;
        this.fullName = fullName;
        this.specialtyName = specialtyName;
    }
    public Doctor(int scheduleId, String shiftName, String scheduleStatus,
                  int doctorId, String licenseNumber,
                  int userId, String role, String username, String fullName, String email, String phone,
                  int specialtyId, String specialtyName) {
        this.scheduleId = scheduleId;
        this.shiftName = shiftName;
        this.scheduleStatus = scheduleStatus;
        this.doctorId = doctorId;
        this.licenseNumber = licenseNumber;
        this.userId = userId;
        this.role = role;
        this.username = username;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.specialtyId = specialtyId;
        this.specialtyName = specialtyName;
    }

    // Getters & Setters
    public int getScheduleId() { return scheduleId; }
    public void setScheduleId(int scheduleId) { this.scheduleId = scheduleId; }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getRoomID() {
        return roomID;
    }

    public String getShiftName() { return shiftName; }
    public void setShiftName(String shiftName) { this.shiftName = shiftName; }

    public String getScheduleStatus() { return scheduleStatus; }
    public void setScheduleStatus(String scheduleStatus) { this.scheduleStatus = scheduleStatus; }

    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getSpecialtyId() { return specialtyId; }
    public void setSpecialtyId(int specialtyId) { this.specialtyId = specialtyId; }

    public String getSpecialtyName() { return specialtyName; }
    public void setSpecialtyName(String specialtyName) { this.specialtyName = specialtyName; }

    public void setScheduleStatus(int status) {
         this.scheduleStatus = status+""; 
    }
    @Override
public String toString() {
    return "Doctor{" +
            "scheduleId=" + scheduleId +
            ", shiftName='" + shiftName + '\'' +
            ", scheduleStatus='" + scheduleStatus + '\'' +
            ", doctorId=" + doctorId +
            ", licenseNumber='" + licenseNumber + '\'' +
            ", userId=" + userId +
            ", role='" + role + '\'' +
            ", username='" + username + '\'' +
            ", fullName='" + fullName + '\'' +
            ", email='" + email + '\'' +
            ", phone='" + phone + '\'' +
            ", specialtyId=" + specialtyId +
            ", specialtyName='" + specialtyName + '\'' +
            '}';
}
public void printInfo() {
    System.out.println(this.toString());
}

}
