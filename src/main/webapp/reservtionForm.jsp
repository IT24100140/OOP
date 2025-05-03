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
  <title>Book a Room - Lanka Uyana Hotels</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .booking-form {
      background: white;
      padding: 30px;
      border-radius: 10px;
      margin-top: 60px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>

<div class="container">
  <div class="col-md-8 offset-md-2 booking-form">
    <h3 class="mb-4 text-center">📅 Book a Room</h3>

    <form action="ReservationServlet" method="post">
      <div class="mb-3">
        <label for="roomType" class="form-label">Room Type</label>
        <select class="form-select" id="roomType" name="roomType" required>
          <option value="">-- Select Room Type --</option>
          <option value="Standard">Standard</option>
          <option value="Deluxe">Deluxe</option>
          <option value="Suite">Suite</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="checkIn" class="form-label">Check-In Date</label>
        <input type="date" class="form-control" id="checkIn" name="checkIn" required>
      </div>

      <div class="mb-3">
        <label for="checkOut" class="form-label">Check-Out Date</label>
        <input type="date" class="form-control" id="checkOut" name="checkOut" required>
      </div>

      <div class="mb-3 form-check">
        <input class="form-check-input" type="checkbox" id="meal" name="meal" value="Yes">
        <label class="form-check-label" for="meal">Include Meal</label>
      </div>

      <div class="mb-3 form-check">
        <input class="form-check-input" type="checkbox" id="wifi" name="wifi" value="Yes">
        <label class="form-check-label" for="wifi">Include WiFi</label>
      </div>

      <div class="mb-3 form-check">
        <input class="form-check-input" type="checkbox" id="transport" name="transport" value="Yes">
        <label class="form-check-label" for="transport">Include Transport</label>
      </div>

      <button type="submit" class="btn btn-primary w-100">Confirm Booking</button>
    </form>

    <div class="text-center mt-4">
      <a href="dashboard.jsp" class="btn btn-outline-secondary">⬅ Back to Dashboard</a>
    </div>
  </div>
</div>

</body>
</html>
