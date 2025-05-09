package servlets;

import utils.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class DeleteProfileServlet extends HttpServlet {

    private static final String USER_FILE = System.getProperty("user.home") + "/hotelapp/users.txt";
    private static final String BOOKING_FILE = System.getProperty("user.home") + "/hotelapp/reservations.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Delete user from users.txt
        FileUtil.deleteLineByEmail(USER_FILE, email);

        // ✅ Delete user's bookings from reservations.txt (only if file exists)
        File inputFile = new File(BOOKING_FILE);
        if (inputFile.exists()) {
            File tempFile = new File(BOOKING_FILE + ".tmp");

            try (
                    BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                    BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
            ) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.contains(email)) {
                        writer.write(line);
                        writer.newLine();
                    }
                }
            }

            // Safely replace file
            if (!inputFile.delete() || !tempFile.renameTo(inputFile)) {
                throw new IOException("❌ Failed to update reservations file.");
            }
        }

        // ✅ End session and redirect
        session.invalidate();
        response.sendRedirect("login.jsp?msg=deleted");
    }
}
