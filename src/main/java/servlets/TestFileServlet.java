package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

public class TestFileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filePath = getServletContext().getRealPath("/data/test.txt");

        PrintWriter out = response.getWriter();
        response.setContentType("text/plain");

        // Try writing to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write("Test line at " + System.currentTimeMillis());
            writer.newLine();
        } catch (Exception e) {
            out.println("❌ Failed to write to file: " + e.getMessage());
            return;
        }

        // Try reading the file
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            out.println("✅ File contents:");
            String line;
            while ((line = reader.readLine()) != null) {
                out.println(line);
            }
        } catch (Exception e) {
            out.println("❌ Failed to read from file: " + e.getMessage());
        }
    }
}