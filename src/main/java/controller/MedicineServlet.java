/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.MedicineDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Medicine;

/**
 *
 * @author Le Phong Vinh - CE181130
 */
@WebServlet(name = "MedicineServlet", urlPatterns = {"/manageMedicine"})
public class MedicineServlet extends HttpServlet {

    private MedicineDAO dao = new MedicineDAO();

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
            out.println("<title>Servlet MedicineServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MedicineServlet at " + request.getContextPath() + "</h1>");
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
        String keyword = request.getParameter("keyword");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("medicineId"));
            Medicine m = dao.getById(id);
            request.setAttribute("editMedicine", m);
        }

        List<Medicine> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.search(keyword);
        } else {
            list = dao.getAll();
        }

        request.setAttribute("list", list);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/Staff/manageMedicine.jsp").forward(request, response);
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

        if ("add".equals(action)) {
            dao.insert(new Medicine(
                    request.getParameter("name"),
                    request.getParameter("description"),
                    request.getParameter("unit")
            ));
        } else if ("update".equals(action)) {
            dao.update(new Medicine(
                    Integer.parseInt(request.getParameter("medicineId")),
                    request.getParameter("name"),
                    request.getParameter("description"),
                    request.getParameter("unit")
            ));
        } else if ("delete".equals(action)) {
            dao.delete(Integer.parseInt(request.getParameter("medicineId")));
        }

        response.sendRedirect("manageMedicine");
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
