package servlets;

import utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UserSignupServlet extends HttpServlet {

    private static final String USER_FILE = "/data/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        String filePath = getServletContext().getRealPath(USER_FILE);

        if (FileUtil.emailExists(filePath, email)) {
            request.setAttribute("error", "❌ Email already exists. Try logging in.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            String line = name + "," + email + "," + password;
            FileUtil.appendToFile(filePath, line);
            request.setAttribute("success", "✅ Account created! Please login.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
