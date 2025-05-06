<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h1><%= request.getAttribute("adminMessage") %></h1>
<p>This is your admin dashboard. Here you can manage rooms, bookings, and more.</p>
<ul>
    <li><a href="manage_rooms.jsp">Manage Rooms</a></li>
    <li><a href="manage_reservations.jsp">Manage Reservations</a></li>
</ul>
</body>
</html>
