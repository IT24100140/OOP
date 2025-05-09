package servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {

    private static final String ADMIN_EMAIL = "admin@hotel.com";
    private static final String ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null && password != null &&
                email.equalsIgnoreCase(ADMIN_EMAIL) && password.equals(ADMIN_PASSWORD)) {

            HttpSession session = request.getSession();
            session.setAttribute("username", "Admin");
            session.setAttribute("email", email);

            response.sendRedirect("adminDashboard.jsp");

        } else {
            request.setAttribute("error", "Invalid admin credentials.");
            request.setAttribute("loginType", "admin");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
