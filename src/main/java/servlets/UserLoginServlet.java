package servlets;

import utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

public class UserLoginServlet extends HttpServlet {

    // ✅ Writable path outside WAR file for persistent access
    private static final String USER_FILE = System.getProperty("user.home") + "/hotelapp/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            System.out.println("❌ Email or password is empty.");
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        List<String> users = FileUtil.readAllLines(USER_FILE);

        boolean valid = false;
        String username = "";

        for (String line : users) {
            System.out.println("Checking line: [" + line + "]");
            String[] parts = line.split(",");
            if (parts.length >= 3) {
                String storedName = parts[0].trim();
                String storedEmail = parts[1].trim();
                String storedPassword = parts[2].trim();

                System.out.println("Comparing: [" + storedEmail + "] with [" + email.trim() + "]");
                System.out.println("Comparing: [" + storedPassword + "] with [" + password.trim() + "]");

                if (storedEmail.equalsIgnoreCase(email.trim()) && storedPassword.equals(password.trim())) {
                    valid = true;
                    username = storedName;
                    break;
                }
            }
        }

        if (valid) {
            System.out.println("✅ LOGIN SUCCESSFUL for " + username);
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("email", email);

            response.sendRedirect("dashboard.jsp");
        } else {
            System.out.println("❌ LOGIN FAILED for email: " + email);
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
