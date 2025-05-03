package servlets;

import utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UserSignupServlet extends HttpServlet {

    // ✅ Use a consistent writable path outside the WAR deployment directory
    private static final String USER_FILE = System.getProperty("user.home") + "/hotelapp/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "❌ All fields are required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (FileUtil.emailExists(USER_FILE, email)) {
            request.setAttribute("error", "❌ Email already exists. Try logging in.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            String line = name + "," + email + "," + password;
            FileUtil.appendToFile(USER_FILE, line);
            request.setAttribute("success", "✅ Account created! Please login.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
