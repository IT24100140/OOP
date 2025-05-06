<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<%
  String email = (String) session.getAttribute("email");
  if (email == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<String> userBookings = new ArrayList<>();
  String reservationFilePath = System.getProperty("user.home") + "/hotelapp/reservations.txt";
  File file = new File(reservationFilePath);
  if (file.exists()) {
    try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
      String line;
      while ((line = reader.readLine()) != null) {
        if (line.contains(email)) {
          userBookings.add(line);
        }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>My Bookings</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="card p-4 shadow-sm">
    <h3 class="mb-4 text-center">📖 My Bookings</h3>

    <% if (userBookings.isEmpty()) { %>
    <div class="alert alert-info text-center">You have no bookings yet.</div>
    <% } else { %>
    <table class="table table-bordered table-hover">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Room</th>
        <th>Meal</th>
        <th>WiFi</th>
        <th>Transport</th>
        <th>Check-In</th>
        <th>Check-Out</th>
        <th>Time</th>
      </tr>
      </thead>
      <tbody>
      <% for (String booking : userBookings) {
        String[] parts = booking.split("\\|");
        if (parts.length == 9) {
      %>
      <tr>
        <td><%= parts[0].trim() %></td>
        <td><%= parts[2].trim() %></td>
        <td><%= parts[3].trim() %></td>
        <td><%= parts[4].trim() %></td>
        <td><%= parts[5].trim() %></td>
        <td><%= parts[6].trim() %></td>
        <td><%= parts[7].trim() %></td>
        <td><%= parts[8].trim() %></td>
      </tr>
      <% }} %>
      </tbody>
    </table>
    <% } %>

    <div class="text-center mt-3">
      <a href="dashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
    </div>
  </div>
</div>

</body>
</html>
