package dao;

import db.DBContext;
import model.Invoice;
import model.InvoiceDetail;

import java.sql.*;
import java.util.*;

public class InvoiceDAO extends DBContext {

    // Lấy tất cả hóa đơn kèm tên bệnh nhân và totalAmount (đã lưu trong Invoices)
    public List<Invoice> getAll() {
        List<Invoice> list = new ArrayList<>();

        String sql = "SELECT i.invoiceId, i.appointmentId, i.paymentMethod, i.issuedAt, i.status, u.fullName AS patientName, "
                + "       COALESCE(SUM(s.price * asv.quantity), 0) AS totalAmount "
                + "FROM Invoices i "
                + "JOIN Appointments a ON i.appointmentId = a.appointmentId "
                + "JOIN Patients p ON a.patientId = p.patientId "
                + "JOIN Users u ON p.userId = u.userId "
                + "LEFT JOIN AppointmentServices asv ON a.appointmentId = asv.appointmentId "
                + "LEFT JOIN Services s ON asv.serviceId = s.serviceId "
                + "GROUP BY i.invoiceId, i.appointmentId, i.paymentMethod, i.issuedAt, i.status, u.fullName";

        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Invoice(
                        rs.getInt("invoiceId"),
                        rs.getInt("appointmentId"),
                        rs.getDouble("totalAmount"), // luôn tính mới
                        rs.getString("paymentMethod"),
                        rs.getTimestamp("issuedAt"),
                        rs.getBoolean("status"),
                        rs.getString("patientName")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

  // Lấy chi tiết hóa đơn (dịch vụ + thuốc, thuốc không tính tiền)
public List<InvoiceDetail> getInvoiceDetails(int invoiceId) {
    List<InvoiceDetail> details = new ArrayList<>();

    String sqlServices =
        "SELECT s.serviceName, SUM(aps.quantity) AS quantity, s.price " +
        "FROM Invoices i " +
        "JOIN Appointments a ON i.appointmentId = a.appointmentId " +
        "JOIN AppointmentServices aps ON a.appointmentId = aps.appointmentId " +
        "JOIN Services s ON aps.serviceId = s.serviceId " +
        "WHERE i.invoiceId = ? " +
        "GROUP BY s.serviceName, s.price";

    // Thuốc KHÔNG lấy giá (chỉ lấy thông tin đơn thuốc)
    String sqlMedicines =
        "SELECT m.name AS medicineName, pm.quantity, pm.dosage, pm.duration " +
        "FROM Invoices i " +
        "JOIN Appointments a ON i.appointmentId = a.appointmentId " +
        "JOIN Prescriptions p ON a.appointmentId = p.appointmentId " +
        "JOIN Prescription_Medicine pm ON p.prescriptionId = pm.prescriptionId " +
        "JOIN Medicines m ON pm.medicineId = m.medicineId " +
        "WHERE i.invoiceId = ?";

    try (Connection con = getConnection()) {

        // --- Dịch vụ ---
        try (PreparedStatement ps = con.prepareStatement(sqlServices)) {
            ps.setInt(1, invoiceId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                details.add(new InvoiceDetail(
                    "service",
                    rs.getString("serviceName"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                ));
            }
        }

        // --- Thuốc (gom và xử lý duration xN) ---
        try (PreparedStatement ps = con.prepareStatement(sqlMedicines)) {
            ps.setInt(1, invoiceId);
            ResultSet rs = ps.executeQuery();

            Map<String, InvoiceDetail> medicineMap = new HashMap<>();

            while (rs.next()) {
                String name = rs.getString("medicineName");
                int quantity = rs.getInt("quantity");
                String dosage = rs.getString("dosage");
                String duration = rs.getString("duration");

                String key = name + "|" + dosage; // gom theo tên + liều dùng
                if (medicineMap.containsKey(key)) {
                    InvoiceDetail exist = medicineMap.get(key);
                    exist.setQuantity(exist.getQuantity() + quantity);

                    // gom duration xN
                    String oldDuration = exist.getDuration();
                    if (oldDuration.contains(duration)) {
                        // nếu duration đã có thì tăng số lần xN
                        if (oldDuration.matches(".*x\\d+$")) {
                            int count = Integer.parseInt(oldDuration.replaceAll(".*x", ""));
                            exist.setDuration(duration + " x" + (count + 1));
                        } else {
                            exist.setDuration(duration + " x2");
                        }
                    } else {
                        exist.setDuration(oldDuration + "; " + duration);
                    }

                } else {
                    medicineMap.put(key, new InvoiceDetail(
                        "medicine",
                        name,
                        quantity,
                        0.0,  // thuốc không tính tiền
                        dosage,
                        duration
                    ));
                }
            }
            details.addAll(medicineMap.values());
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return details;
}


    // Cập nhật trạng thái thanh toán
    public void updateStatus(int invoiceId, boolean status) {
        String sql = "UPDATE Invoices SET status = ? WHERE invoiceId = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ps.setInt(2, invoiceId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy 1 hóa đơn theo ID
    public Invoice getById(int invoiceId) {
        String sql = "SELECT i.invoiceId, i.appointmentId, i.totalAmount, i.paymentMethod, i.issuedAt, i.status, u.fullName AS patientName "
                + "FROM Invoices i "
                + "JOIN Appointments a ON i.appointmentId = a.appointmentId "
                + "JOIN Patients p ON a.patientId = p.patientId "
                + "JOIN Users u ON p.userId = u.userId "
                + "WHERE i.invoiceId = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, invoiceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Invoice(
                        rs.getInt("invoiceId"),
                        rs.getInt("appointmentId"),
                        rs.getDouble("totalAmount"),
                        rs.getString("paymentMethod"),
                        rs.getTimestamp("issuedAt"),
                        rs.getBoolean("status"),
                        rs.getString("patientName")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật lại totalAmount trong bảng Invoices từ dịch vụ
    public void updateInvoiceTotal(int invoiceId) {
        String sql = "UPDATE Invoices "
                + "SET totalAmount = ("
                + "   SELECT ISNULL(SUM(s.price * asv.quantity),0) "
                + "   FROM AppointmentServices asv "
                + "   JOIN Services s ON asv.serviceId = s.serviceId "
                + "   JOIN Appointments a ON asv.appointmentId = a.appointmentId "
                + "   WHERE a.appointmentId = Invoices.appointmentId"
                + ") "
                + "WHERE invoiceId = ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, invoiceId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Tìm kiếm hóa đơn theo mã, tên bệnh nhân, hoặc ngày lập
    public List<Invoice> searchInvoices(String keyword) {
        List<Invoice> list = new ArrayList<>();
        String sql = "SELECT i.invoiceId, i.appointmentId, i.paymentMethod, i.issuedAt, i.status, "
                + "       u.fullName as patientName, "
                + "       ISNULL(SUM(s.price * asv.quantity),0) as totalAmount "
                + "FROM Invoices i "
                + "JOIN Appointments a ON i.appointmentId = a.appointmentId "
                + "JOIN Patients p ON a.patientId = p.patientId "
                + "JOIN Users u ON p.userId = u.userId "
                + "LEFT JOIN AppointmentServices asv ON a.appointmentId = asv.appointmentId "
                + "LEFT JOIN Services s ON asv.serviceId = s.serviceId "
                + "WHERE u.fullName LIKE ? OR CAST(i.invoiceId AS NVARCHAR) LIKE ? "
                + "GROUP BY i.invoiceId, i.appointmentId, i.paymentMethod, i.issuedAt, i.status, u.fullName";

        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Invoice(
                        rs.getInt("invoiceId"),
                        rs.getInt("appointmentId"),
                        rs.getDouble("totalAmount"),
                        rs.getString("paymentMethod"),
                        rs.getTimestamp("issuedAt"),
                        rs.getBoolean("status"),
                        rs.getString("patientName")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void updatePayment(int invoiceId, String method) {
    String sql = "UPDATE Invoices SET status = 1, paymentMethod = ?, issuedAt = GETDATE() WHERE invoiceId = ?";
    try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, method);
        ps.setInt(2, invoiceId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

   
}


