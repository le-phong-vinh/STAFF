package model;

import java.sql.Date;

public class Patient {
    private int patientId;
    private int userId;
    private String fullName;        // từ Users.fullName
    private String gender;          // từ Patients.gender
    private Date dob;               // từ Patients.dob
    private String insuranceNumber; // từ Patients.insuranceNumber
    private String emergencyContact;// từ Patients.emergencyContact
    private int provinceId;         // từ Patients.provinceId
    private String provinceName;    // từ Provinces.provinceName
    private String username;        // từ Users.username
    private String email;           // từ Users.email
    private String phone;           // từ Users.phone
    private String role;            // từ Users.role
    private String status;          // từ Users.status
    private Date createdAt;         // từ Users.createdAt

    public Patient() {}

    public Patient(int patientId, int userId, String fullName, String gender, Date dob,
                   String insuranceNumber, String emergencyContact, int provinceId, String provinceName,
                   String username, String email, String phone, String role, String status, Date createdAt) {
        this.patientId = patientId;
        this.userId = userId;
        this.fullName = fullName;
        this.gender = gender;
        this.dob = dob;
        this.insuranceNumber = insuranceNumber;
        this.emergencyContact = emergencyContact;
        this.provinceId = provinceId;
        this.provinceName = provinceName;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
    }

    // ----------- Getter & Setter -----------

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }

    public String getInsuranceNumber() { return insuranceNumber; }
    public void setInsuranceNumber(String insuranceNumber) { this.insuranceNumber = insuranceNumber; }

    public String getEmergencyContact() { return emergencyContact; }
    public void setEmergencyContact(String emergencyContact) { this.emergencyContact = emergencyContact; }

    public int getProvinceId() { return provinceId; }
    public void setProvinceId(int provinceId) { this.provinceId = provinceId; }

    public String getProvinceName() { return provinceName; }
    public void setProvinceName(String provinceName) { this.provinceName = provinceName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
