package account;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="LogoutServlet", urlPatterns={"/logout"})
public class LogoutController extends HttpServlet {
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
       HttpSession session = request.getSession(false);
if (session != null) {
  session.removeAttribute("loggedUser"); // hoặc session.invalidate();
}
response.sendRedirect(request.getContextPath() + "/home");
    }
}
