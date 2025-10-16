package dao;

//package dao;
//
//import db.DBContext;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import model.Customer;
//
///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
///**
// *
// * @author Le Minh Nhut - CE190737
// */
//public class CustomerDAO extends DBContext {
//
//    public static void main(String[] args) {
//
//        Customer c = new dao.CustomerDAO().getCustomerByOrderId(3);
//        System.out.println(c.getFullName());
//    }
//
//    public boolean insertCustomer(int userId, String fullName, String phone, String email, String address) {
//        int affectedRows = 0;
//        try {
//            String query = "INSERT INTO Customers (UserID, FullName, Phone, Email, Address)\n"
//                    + "VALUES (?,?,?,?,?);";
//            Object[] params = {userId, fullName, phone, email, address};
//            affectedRows = this.executeQuery(query, params);
//
//        } catch (Exception e) {
//        }
//
//        return affectedRows > 0;
//    }
//
//    public Customer getCustomerByUserId(int userId) {
//        try {
//            String query = "select * from Customers where userid = ?";
//            Object[] params = {userId};
//            ResultSet rs = this.executeSelectQuery(query, params);
//
//            if (rs.next()) {
//                int custId = rs.getInt(1);
//                String name = rs.getString(3);
//                String phone = rs.getString(4);
//                String email = rs.getString(5);
//                String address = rs.getString(6);
//
//                return new Customer(custId, userId, name, phone, email, address);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return null;
//    }
//
//    public Customer getCustomerByOrderId(int orderId) {
//        try {
//            String query = "select c.CustomerID, c.UserID, c.FullName,\n"
//                    + "c.Phone, c.Email, c.Address\n"
//                    + "from Customers c join [Order] o\n"
//                    + "on c.UserID = o.UserID\n"
//                    + "where o.orderid = ?";
//            Object[] params = {orderId};
//            ResultSet rs = this.executeSelectQuery(query, params);
//
//            if (rs.next()) {
//                int custId = rs.getInt(1);
//                int userId = rs.getInt(2);
//                String name = rs.getString(3);
//                String phone = rs.getString(4);
//                String email = rs.getString(5);
//                String address = rs.getString(6);
//
//                return new Customer(custId, userId, name, phone, email, address);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return null;
//    }
//}
