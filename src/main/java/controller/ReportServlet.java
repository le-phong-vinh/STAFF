/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
/**
 *
 * @author lepho
 */
@WebServlet(name = "ReportServlet", urlPatterns = {"/report"})
public class ReportServlet extends HttpServlet {

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
            out.println("<title>Servlet ReportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReportServlet at " + request.getContextPath() + "</h1>");
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
    try {
        ReportDAO dao = new ReportDAO();

        // --- Lấy parameter lọc ---
        String serviceName = request.getParameter("serviceName");
        String diseaseName = request.getParameter("diseaseName");

        // --- 4 thống kê nhanh ---
        request.setAttribute("revToday", dao.getRevenueToday());
        request.setAttribute("revWeek", dao.getRevenueThisWeek());
        request.setAttribute("revMonth", dao.getRevenueThisMonth());
        request.setAttribute("revYear", dao.getRevenueThisYear());

        // --- Doanh thu theo dịch vụ (có lọc nếu nhập tên) ---
        if (serviceName != null && !serviceName.trim().isEmpty()) {
            request.setAttribute("serviceRevenue", dao.getRevenueByServiceName(serviceName.trim()));
        } else {
            request.setAttribute("serviceRevenue", dao.getRevenueByService());
        }

        // --- Thống kê bệnh nhân theo loại bệnh (có lọc nếu nhập tên) ---
        if (diseaseName != null && !diseaseName.trim().isEmpty()) {
            request.setAttribute("diseaseStats", dao.getPatientsByDiseaseName(diseaseName.trim()));
        } else {
            request.setAttribute("diseaseStats", dao.getPatientsByDisease());
        }

        // Giữ lại giá trị đã nhập để hiện trong ô tìm kiếm
        request.setAttribute("serviceName", serviceName);
        request.setAttribute("diseaseName", diseaseName);

    } catch (Exception e) {
        e.printStackTrace();
    }

    request.getRequestDispatcher("/WEB-INF/Staff/statisticAndReport.jsp").forward(request, response);
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
        processRequest(request, response);
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

}
