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
        try {
            String query = "select * from users where username = ? and password = ? ";
            Object[] params = {username, hashMd5(password)};
            ResultSet rs = this.executeSelectQuery(query, params);

//            System.out.println("ResultSet next: " + rs.next());
            if (rs.next()) {
                System.out.println(rs.getInt(1) + "Username: " + rs.getString(2));
                System.out.println(password);
                System.out.println(rs.getString("password"));
//                System.out.println("Password: " + rs.getString(3));
//                System.out.println("Hashed: " + hashMd5(password));

                return new User(rs.getInt(1), rs.getString(2), null, rs.getString("role"));
            }
        } catch (Exception e) {
            System.out.println("error");
        }
        return null;
    }

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
