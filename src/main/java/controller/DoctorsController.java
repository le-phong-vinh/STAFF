/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DoctorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import dao.PatientsDAO;
import dao.ProvincesDAO;
import model.Patient;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;
import model.Doctor;
import model.Specialty;

/**
 *
 * @author ourki
 */
@WebServlet(name = "DoctorsController", urlPatterns = {"/DoctorsController"})
public class DoctorsController extends HttpServlet {
  private DoctorDAO dao;

    @Override
    public void init() {
        dao = new DoctorDAO();
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DoctorsController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorsController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Specialty> specialties = dao.getAllSpecialties();
request.setAttribute("specialties", specialties);
// cũng set doctors
        list(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    List<Specialty> specialties = dao.getAllSpecialties();
    request.setAttribute("specialties", specialties);

   if ("update".equals(action)) {
    updateDoctor(request, response);
}
    // ... các action khác nếu cần
}

private void printDoctor(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    try {
        // Lấy dữ liệu từ form
        String fullName      = request.getParameter("fullName");
        String doctorIdStr   = request.getParameter("doctorId"); // nếu field bị disabled thì sẽ null
        String licenseNumber = request.getParameter("licenseNumber");
        String specialtyId   = request.getParameter("specialtyId");
        String phone         = request.getParameter("phone");
        String email         = request.getParameter("email");
        String status        = request.getParameter("status");

        // In ra để debug
        System.out.println("=== UPDATE DOCTOR FORM DATA ===");
        System.out.println("doctorId: " + doctorIdStr);
        System.out.println("fullName: " + fullName);
        System.out.println("licenseNumber: " + licenseNumber);
        System.out.println("specialtyId: " + specialtyId);
        System.out.println("phone: " + phone);
        System.out.println("email: " + email);
        System.out.println("status: " + status);
        System.out.println("================================");

        // TODO: chuyển dữ liệu thành Doctor/User object và gọi DAO update
        // ví dụ:
        // Doctor d = new Doctor();
        // d.setDoctorId(Integer.parseInt(doctorIdStr));
        // d.setFullName(fullName);
        // ...
        // dao.updateDoctor(d);

        response.sendRedirect("DoctorsController");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error updating doctor");
    }
}

    
    private void updateDoctor(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    Doctor d = new Doctor();
      
    // Lấy từ form
    d.setDoctorId(Integer.parseInt(request.getParameter("doctorId")));
    d.setUserId(Integer.parseInt(request.getParameter("userId")));
    d.setFullName(request.getParameter("fullName"));
    d.setPhone(request.getParameter("phone"));
    d.setEmail(request.getParameter("email"));
    d.setSpecialtyId(Integer.parseInt(request.getParameter("specialtyId")));
    d.setLicenseNumber(request.getParameter("licenseNumber"));
    d.setScheduleStatus(request.getParameter("status")); // nếu status là String
    // nếu status là int: d.setScheduleStatus(Integer.parseInt(request.getParameter("status")));
        System.out.println("update");
d.printInfo();
    // Gọi DAO update
    dao.updateDoctor(d);

    // Redirect về danh sách Doctor
    response.sendRedirect("DoctorsController");
}


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

     private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Doctor> list = dao.getAllDoctors();
        request.setAttribute("doctors", list);

        // Load provinces
        ProvincesDAO provDao = new ProvincesDAO();
        request.setAttribute("provinces", provDao.getAllProvinces());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Staff/manageDoctor.jsp");
        dispatcher.forward(request, response);
    }
}
