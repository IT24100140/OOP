package servlets;

import utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

public class UserLoginServlet extends HttpServlet {

    private static final String USER_FILE = "/data/users.txt";

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

        String filePath = getServletContext().getRealPath(USER_FILE);
        List<String> users = FileUtil.readAllLines(filePath);

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

            System.out.println("Redirecting to dashboard.jsp...");
            response.sendRedirect("dashboard.jsp");
        } else {
            System.out.println("❌ LOGIN FAILED for email: " + email);
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}