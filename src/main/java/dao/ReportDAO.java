package dao;

import db.DBContext;
import java.sql.*;
import java.math.BigDecimal;
import java.util.*;

public class ReportDAO {
    private Connection con;

    public ReportDAO() throws Exception {
        con = new DBContext().getConnection();
    }

    // ================== Doanh thu nhanh ==================
    public BigDecimal getRevenueToday() {
        String sql = "SELECT SUM(totalAmount) FROM Invoices " +
                     "WHERE CAST(issuedAt AS DATE) = CAST(GETDATE() AS DATE) AND status=1";
        return getRevenue(sql);
    }

    public BigDecimal getRevenueThisWeek() {
        String sql = "SELECT SUM(totalAmount) FROM Invoices " +
                     "WHERE DATEPART(WEEK, issuedAt)=DATEPART(WEEK, GETDATE()) " +
                     "AND YEAR(issuedAt)=YEAR(GETDATE()) AND status=1";
        return getRevenue(sql);
    }

    public BigDecimal getRevenueThisMonth() {
        String sql = "SELECT SUM(totalAmount) FROM Invoices " +
                     "WHERE MONTH(issuedAt)=MONTH(GETDATE()) AND YEAR(issuedAt)=YEAR(GETDATE()) AND status=1";
        return getRevenue(sql);
    }

    public BigDecimal getRevenueThisYear() {
        String sql = "SELECT SUM(totalAmount) FROM Invoices " +
                     "WHERE YEAR(issuedAt)=YEAR(GETDATE()) AND status=1";
        return getRevenue(sql);
    }

    private BigDecimal getRevenue(String sql) {
        BigDecimal revenue = BigDecimal.ZERO;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal(1) != null) {
                revenue = rs.getBigDecimal(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenue;
    }

    // ================== Doanh thu theo dịch vụ ==================
    public List<Map<String, Object>> getRevenueByService() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.serviceName, COUNT(a.id) as totalBookings, " +
                     "SUM(s.price * a.quantity) as revenue " +
                     "FROM AppointmentServices a " +
                     "JOIN Services s ON a.serviceId = s.serviceId " +
                     "JOIN Invoices i ON i.appointmentId = a.appointmentId " +
                     "WHERE i.status = 1 " +
                     "GROUP BY s.serviceName";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("serviceName", rs.getString("serviceName"));
                row.put("count", rs.getInt("totalBookings"));
                row.put("revenue", rs.getBigDecimal("revenue"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================== Thống kê bệnh nhân theo bệnh ==================
    public List<Map<String, Object>> getPatientsByDisease() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT d.diseaseName, COUNT(er.resultId) as totalPatients " +
                     "FROM Examination_Result er " +
                     "JOIN Diseases d ON er.diseaseId = d.diseaseId " +
                     "GROUP BY d.diseaseName";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("diseaseName", rs.getString("diseaseName"));
                row.put("count", rs.getInt("totalPatients"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
