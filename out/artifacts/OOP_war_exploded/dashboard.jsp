<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
  String username = (String) session.getAttribute("username");
  if (username == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
    }
    .dashboard-container {
      max-width: 700px;
      margin: 60px auto;
    }
    .dashboard-card {
      padding: 30px;
      border-radius: 12px;
      background-color: white;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .btn-lg {
      padding: 15px 30px;
      font-size: 18px;
    }
  </style>
</head>
<body>

<div class="dashboard-container">
  <div class="dashboard-card text-center">
    <h2 class="mb-4">Welcome, <%= username %>&nbsp;🎉</h2>

    <div class="d-grid gap-3">
      <a href="reservtionForm.jsp" class="btn btn-primary btn-lg">📅&nbsp;Book a Room</a>
      <a href="myBookings.jsp" class="btn btn-success btn-lg">📖&nbsp;View My Bookings</a>
      <a href="deleteProfile.jsp" class="btn btn-danger btn-lg">🗑️&nbsp;Delete My Profile</a>
      <a href="logout.jsp" class="btn btn-secondary btn-lg">🚪&nbsp;Logout</a>
    </div>
  </div>
</div>

</body>
</html>
