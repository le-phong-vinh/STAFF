/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package account;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Le Minh Nhut - CE190737
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
    request.getRequestDispatcher("/WEB-INF/Login/login.jsp").forward(request, response);
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
        String username = request.getParameter("username");
        String password = request.getParameter("password"); //raw password

        //DAO
        UserDAO uDAO = new UserDAO();

      User loggedUser = uDAO.login(username, password);

if (loggedUser != null) {
    // (1) Tránh session fixation: huỷ session cũ (nếu có) rồi tạo session mới
    HttpSession old = request.getSession(false);
    if (old != null) old.invalidate();
    HttpSession session = request.getSession(true);

    // (2) Lưu user + role vào session
    session.setAttribute("loggedUser", loggedUser);
    String role = (loggedUser.getRole() == null) ? "" : loggedUser.getRole().trim().toLowerCase();
    session.setAttribute("role", role);

    // (3) Điều hướng theo role
    String ctx = request.getContextPath();
    String target;
    switch (role) {
        case "admin":
            target = ctx + "/admin/dashboard";
            break;
        case "doctor":
            target = ctx + "/doctor/home";
            break;
        case "staff":
            target = ctx + "/staffHome";
            break;
        case "patient":
            // nếu bạn có trang riêng cho patient thì đổi thành /patient/home
            target = ctx + "/home";
            break;
        default:
            // role lạ hoặc rỗng → về trang public
            target = ctx + "/home";
    }

    // (4) (Tuỳ chọn) Cookie để client dùng nhẹ nhàng (không chứa thông tin nhạy cảm)
    /*
    Cookie uCookie = new Cookie("username", loggedUser.getUsername());
    Cookie rCookie = new Cookie("role", role);
    uCookie.setMaxAge(3 * 24 * 60 * 60);
    rCookie.setMaxAge(3 * 24 * 60 * 60);
    uCookie.setHttpOnly(true);
    rCookie.setHttpOnly(true);
    response.addCookie(uCookie);
    response.addCookie(rCookie);
    */

    response.sendRedirect(target);

} else {
    // Login fail
    response.sendRedirect(request.getContextPath() + "/login");
}
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
