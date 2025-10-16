/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InvoiceDAO;
import model.Invoice;
import model.InvoiceDetail;
import java.io.OutputStream;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dao.InvoiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;
import model.Invoice;

/**
 *
 * @author lepho
 */
@WebServlet(name = "StaffViewPrescriptionServlet", urlPatterns = {"/staffViewPrescription"})
public class StaffViewPrescriptionServlet extends HttpServlet {
    private InvoiceDAO dao = new InvoiceDAO();
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
            out.println("<title>Servlet StaffViewPrescriptionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffViewPrescriptionServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String idStr = request.getParameter("invoiceId");
        Integer id = null;
        try {
            if (idStr != null && !idStr.trim().isEmpty()) {
                id = Integer.parseInt(idStr);
            }
        } catch (NumberFormatException e) {
            // Nếu id lỗi, quay về danh sách
            response.sendRedirect("staffViewPrescription");
            return;
        }

        // --- Xem chi tiết ---
        if ("detail".equals(action) && id != null) {
            dao.updateInvoiceTotal(id); // Cập nhật tổng tiền trước khi xem
            Invoice invoice = dao.getById(id);
            List<InvoiceDetail> details = dao.getInvoiceDetails(id);

            request.setAttribute("selectedInvoice", invoice);
            request.setAttribute("details", details);

            // --- Thanh toán (chuyển sang POST rồi, GET chỉ redirect nếu có lỗi) ---
        } else if ("pay".equals(action)) {
            response.sendRedirect("staffViewPrescription");
            return;

            // --- In / Hiển thị hóa đơn (dạng JSP in PDF) ---
        } else if ("print".equals(action) && id != null) {
            Invoice invoice = dao.getById(id);
            List<InvoiceDetail> details = dao.getInvoiceDetails(id);

            if (invoice != null) {
                request.setAttribute("invoice", invoice);
                request.setAttribute("details", details);
                request.getRequestDispatcher("/WEB-INF/Staff/invoicePrint.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect("staffViewPrescription");
                return;
            }

        }

        // --- Tìm kiếm hoặc hiển thị danh sách ---
        String keyword = request.getParameter("keyword");
        List<Invoice> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.searchInvoices(keyword);
        } else {
            list = dao.getAll();
            for (Invoice inv : list) {
                dao.updateInvoiceTotal(inv.getInvoiceId());
            }
            list = dao.getAll(); // reload sau cập nhật
        }

        request.setAttribute("list", list);
        request.getRequestDispatcher("/WEB-INF/Staff/staffViewPrescription.jsp").forward(request, response);
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
