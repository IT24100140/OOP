<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>User Signup</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
    <h3 class="text-center mb-4">Create Your Account</h3>

    <% String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
    %>

    <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } else if (success != null) { %>
    <div class="alert alert-success"><%= success %></div>
    <% } %>

    <form action="UserSignupServlet" method="post">
      <div class="mb-3">
        <label class="form-label">Full Name</label>
        <input type="text" class="form-control" name="name" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Email address</label>
        <input type="email" class="form-control" name="email" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" class="form-control" name="password" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">Sign Up</button>
    </form>
    <div class="text-center mt-3">
      <a href="login.jsp">Already have an account? Login</a>
    </div>
  </div>
</div>

</body>
</html>
