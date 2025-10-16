//package account;
//
///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//import dao.CustomerDAO;
//import dao.UserDAO;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import model.User;
//
///**
// *
// * @author Le Minh Nhut - CE190737
// */
//@WebServlet(urlPatterns = {"/register"})
//public class RegisterServlet extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SigninServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SigninServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String view = request.getParameter("view");
//        if (view == null) {
//            request.getRequestDispatcher("/WEB-INF/Account/register.jsp").forward(request, response);
//        } else if (view.equalsIgnoreCase("usernameCheck")) {
//            String username = request.getParameter("username");
//            UserDAO userDAO = new UserDAO();
//            User existedUser = userDAO.findByUsename(username);
//
//            if (existedUser != null) {
//                response.getWriter().write("exists"); // ✅ Username đã có
//            } else {
//                response.getWriter().write("available"); // ✅ Username chưa có
//            }
//        }
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String fullName = request.getParameter("fullName");
//        String phone = request.getParameter("phone");
//        String email = request.getParameter("email");
//        String address = request.getParameter("address");
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        String role = "user";
//
//        try {
//            UserDAO userDAO = new UserDAO();
//            CustomerDAO cusDAO = new CustomerDAO();
//
//            int userId = userDAO.insertUser(username, password, role);
//            boolean success = cusDAO.insertCustomer(userId, fullName, phone, email, address);
//            HttpSession session = request.getSession();
//            response.sendRedirect("home");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
