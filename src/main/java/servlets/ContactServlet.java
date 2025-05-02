package servlets;
import javax.servlet.http.HttpServlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // File path (in the deployed webapp directory)
        String filePath = getServletContext().getRealPath("/data/contacts.txt");


        // Append to contacts.txt
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath, true))) {
            writer.println("Name: " + name);
            writer.println("Email: " + email);
            writer.println("Subject: " + subject);
            writer.println("Message: " + message);
            writer.println("-------------------------------------");
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Redirect back to contact page or show a thank-you
        response.sendRedirect("thankyou.html");
        // You can also forward to a success.jsp page
    }
}
