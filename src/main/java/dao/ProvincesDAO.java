package dao;

import db.DBContext;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class ProvincesDAO {

    // Lấy danh sách tỉnh dạng Map<provinceId, provinceName>
    public Map<Integer, String> getAllProvinces() {
        Map<Integer, String> map = new LinkedHashMap<>();
        String sql = "SELECT provinceId, provinceName FROM Provinces ORDER BY provinceId";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                map.put(rs.getInt("provinceId"), rs.getString("provinceName"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
    // Lấy provinceId theo tên tỉnh
    public int getProvinceIdByName(String provinceName) {
        String sql = "SELECT provinceId FROM Provinces WHERE provinceName = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, provinceName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("provinceId");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1; // default = Hà Nội nếu không tìm thấy
    }
}
