package dao;

///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */


import db.DBContext;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;



/**
 *
 * @author Le Minh Nhut - CE190737
 */
public class UserDAO extends DBContext {

    public static void main(String[] args) {
        User test = new UserDAO().login("customer", "customer");
        if (test == null) {
            System.out.println("sai oif kia");
        } else {
            System.out.println("dung oi ");
            System.out.println(test.getId() + test.getUsername());
        }
    }

    public int insertUser(String username, String password, String role) {
        int userId = -1;
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        try ( Connection conn = this.getConnection();  PreparedStatement st
                = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, username);
            st.setString(2, hashMd5(password));
            st.setString(3, role);

            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    userId = rs.getInt(1);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error inserting user");
        }

        return userId;
    }

 public User login(String username, String password) {
    String hashed = hashMd5(password);
    String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, username);
        ps.setString(2, hashed);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int userId = rs.getInt("userId");
                String fullName = rs.getString("fullName");
                String role = rs.getString("role");

                System.out.println("✅ Login success for: " + username);
                return new User(userId, username, fullName, role);
            } else {
                System.out.println("❌ Login failed: invalid username or password.");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("⚠️ Database error during login.");
    }

    return null;
}

 ///
// public User login(String username, String password) {
//    String hashed = hashMd5(password);
//    String sql =  "SELECT * FROM Users WHERE username = ? AND password = ?";
//    boolean success = false;
//
//    try (Connection conn = new DBContext().getConnection();
//         PreparedStatement ps = conn.prepareStatement(sql)) {
//
//       ps.setString(1, username);
//        ps.setString(2, hashed);
//
//          ResultSet rs = ps.executeQuery();
//
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//
//
//    return null;
//}
// 
 
 
 
 
 
    public User findById(int id) {
        User user = null;
        try {
            String query = "select * from user where userid=?";
            PreparedStatement st = this.getConnection().prepareStatement(query);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                user = new User(rs.getInt(1), rs.getString(2), rs.getString(2), rs.getString(2));
            }

        } catch (SQLException e) {
        }
        return user;
    }

    public User findByUsename(String username) {
        User user = null;
        try {
            String query = "select * from users where username=?";
            PreparedStatement st = this.getConnection().prepareStatement(query);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                user = new User(rs.getInt(1), rs.getString(2), null, rs.getString(4));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Phuong thuc ma hoa password
    private String hashMd5(String raw) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] mess = md.digest(raw.getBytes());

            StringBuilder sb = new StringBuilder();
            for (byte b : mess) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }
}
