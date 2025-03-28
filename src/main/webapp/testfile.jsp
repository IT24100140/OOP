<%@ page import="java.io.*, java.util.*" %>
<%
  String filePath = application.getRealPath("/data/test.txt");

  // Write to file
  try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
    writer.write("Test line - " + new Date());
    writer.newLine();
  } catch (Exception e) {
    out.println("❌ Write failed: " + e.getMessage());
  }

  // Read from file
  try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
    out.println("✅ Reading from: " + filePath + "<br><br>");
    String line;
    while ((line = reader.readLine()) != null) {
      out.println(line + "<br>");
    }
  } catch (Exception e) {
    out.println("❌ Read failed: " + e.getMessage());
  }
%>