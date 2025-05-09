<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");

    if (email == null || !email.equalsIgnoreCase("admin@hotel.com")) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Load all bookings
    List<String> allBookings = new ArrayList<>();
    String reservationFilePath = System.getProperty("user.home") + "/hotelapp/reservations.txt";
    File resFile = new File(reservationFilePath);
    if (resFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(resFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                allBookings.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Load all users
    List<String> allUsers = new ArrayList<>();
    String userFilePath = System.getProperty("user.home") + "/hotelapp/users.txt";
    File userFile = new File(userFilePath);
    if (userFile.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(userFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                allUsers.add(line);
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
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card p-4 shadow-sm mb-5">
        <h3 class="mb-4 text-center">📋 All Reservations</h3>

        <% if (allBookings.isEmpty()) { %>
        <div class="alert alert-info text-center">No bookings found.</div>
        <% } else { %>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Room</th>
                <th>Meal</th>
                <th>WiFi</th>
                <th>Transport</th>
                <th>Check-In</th>
                <th>Check-Out</th>
                <th>Booked At</th>
            </tr>
            </thead>
            <tbody>
            <% for (String booking : allBookings) {
                String[] parts = booking.split("\\|");
                if (parts.length == 9) {
            %>
            <tr>
                <td><%= parts[0].trim() %></td>
                <td><%= parts[1].trim() %></td>
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
    </div>

    <div class="card p-4 shadow-sm">
        <h3 class="mb-4 text-center">👤 All Registered Users</h3>

        <% if (allUsers.isEmpty()) { %>
        <div class="alert alert-info text-center">No registered users found.</div>
        <% } else { %>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <!-- Uncomment below to show passwords -->
                <!-- <th>Password</th> -->
            </tr>
            </thead>
            <tbody>
            <% for (String user : allUsers) {
                String[] parts = user.split(",");
                if (parts.length >= 2) {
            %>
            <tr>
                <td><%= parts[0].trim() %></td>
                <td><%= parts[1].trim() %></td>
                <!-- <td><%= parts[2].trim() %></td> -->
            </tr>
            <% }} %>
            </tbody>
        </table>
        <% } %>

        <div class="text-center mt-4">
            <a href="logout.jsp" class="btn btn-danger">🚪 Logout</a>
        </div>
    </div>
</div>

</body>
</html>
