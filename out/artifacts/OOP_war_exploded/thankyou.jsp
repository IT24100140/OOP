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
<html>
<head>
  <meta charset="UTF-8">
  <title>Booking Confirmation</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5 text-center">
  <div class="alert alert-success shadow-sm p-5">
    <h2 class="mb-4">✅ Booking Successful!</h2>
    <p>Thank you, <strong><%= username %></strong>, your room has been reserved.</p>
    <a href="dashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
  </div>
</div>

</body>
</html>
