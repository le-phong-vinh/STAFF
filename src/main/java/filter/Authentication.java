package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "Authentication", urlPatterns = {"/*"})
public class Authentication implements Filter {

    @Override
    public void doFilter(ServletRequest sreq, ServletResponse sres, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) sreq;
        HttpServletResponse response = (HttpServletResponse) sres;

        HttpSession session = request.getSession(false);
        String path = request.getRequestURI().substring(request.getContextPath().length());

        // ✅ Các đường dẫn public (không cần đăng nhập)
        boolean isPublic = path.equals("/home")
                        || path.equals("/doctors")
                        || path.equals("/login")
                        || path.equals("/register")
                        || path.startsWith("/Asset/")   // file CSS/JS/ảnh
                        || path.startsWith("/images/")
                        || path.startsWith("/css/")
                        || path.startsWith("/js/");

        // ✅ Kiểm tra user login
        Object loggedUser = (session == null) ? null : session.getAttribute("loggedUser");

        if (isPublic || loggedUser != null) {
            // Cho phép truy cập
            chain.doFilter(request, response);
        } else {
            // Chặn và chuyển hướng về trang login
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
