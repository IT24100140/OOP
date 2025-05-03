package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String roomType = request.getParameter("roomType");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        String meal = request.getParameter("meal") != null ? "Yes" : "No";
        String wifi = request.getParameter("wifi") != null ? "Yes" : "No";
        String transport = request.getParameter("transport") != null ? "Yes" : "No";

        // Assume current user email is saved in session (set during login)
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        // Generate a unique booking ID and timestamp
        String bookingId = "RES" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());

        // File path to write
        String filePath = getServletContext().getRealPath("/data/reservations.txt");

        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath, true))) {
            writer.println(bookingId + " | " + userEmail + " | " + roomType + " | " + meal + " | "
                    + wifi + " | " + transport + " | " + checkIn + " | " + checkOut + " | " + timestamp);
        }

        // Redirect to thank you or dashboard
        response.sendRedirect("thankyou.html");  // or userDashboard.html
    }
}
