<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");

    if (username == null || email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h3 class="text-danger text-center mb-3">🗑️ Delete My Profile</h3>
        <p class="text-center">Are you sure you want to delete your profile, <strong><%= username %></strong>?<br>
            This will remove your account and all your bookings permanently.</p>

        <form action="DeleteProfileServlet" method="post" class="text-center mt-4">
            <button type="submit" class="btn btn-danger px-5">Yes, Delete My Profile</button>
            <a href="dashboard.jsp" class="btn btn-secondary ms-3">Cancel</a>
        </form>
    </div>
</div>

</body>
</html>
