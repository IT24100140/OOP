package servlets;

import utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

public class AdminLoginServlet extends HttpServlet {

    private final String ADMIN_FILE = "/data/admins.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String filePath = getServletContext().getRealPath(ADMIN_FILE);
        List<String> admins = FileUtil.readAllLines(filePath);

        boolean valid = false;
        String adminName = "";

        for (String line : admins) {
            String[] parts = line.split(",");
            if (parts.length >= 3 && parts[1].equals(email) && parts[2].equals(password)) {
                adminName = parts[0];
                valid = true;
                break;
            }
        }

        if (valid) {
            HttpSession session = request.getSession();
            session.setAttribute("adminname", adminName);
            session.setAttribute("email", email);
            response.sendRedirect("adminDashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid admin credentials.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}