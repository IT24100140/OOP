<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-option {
            margin-top: 100px;
            text-align: center;
        }
        .form-container {
            display: none;
            max-width: 400px;
            margin: 30px auto;
        }
    </style>
</head>
<body class="bg-light">

<div class="container">
    <div class="login-option">
        <h2>Welcome to Lanka Uyana Hotels</h2>
        <p>Please select your login type:</p>
        <button class="btn btn-primary me-2" onclick="showForm('user')">Login as User</button>
        <button class="btn btn-dark" onclick="showForm('admin')">Login as Admin</button>
    </div>

    <!-- User Login Form -->
    <!-- User Login Form -->
    <div id="userForm" class="form-container card p-4 shadow-sm">
        <h4 class="mb-3 text-center">User Login</h4>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="UserLoginServlet" method="post">
            <div class="mb-3">
                <label for="userEmail" class="form-label">Email</label>
                <input type="email" class="form-control" id="userEmail" name="email" required>
            </div>
            <div class="mb-3">
                <label for="userPassword" class="form-label">Password</label>
                <input type="password" class="form-control" id="userPassword" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="text-center mt-3">
            <a href="signup.jsp">Don't have an account? Sign up</a>
        </div>
    </div>

    <!-- Admin Login Form -->
    <div id="adminForm" class="form-container card p-4 shadow-sm">
        <h4 class="mb-3 text-center">Admin Login</h4>
        <form action="AdminLoginServlet" method="post">
            <div class="mb-3">
                <label for="adminEmail" class="form-label">Email</label>
                <input type="email" class="form-control" id="adminEmail" name="email" required>
            </div>
            <div class="mb-3">
                <label for="adminPassword" class="form-label">Password</label>
                <input type="password" class="form-control" id="adminPassword" name="password" required>
            </div>
            <button type="submit" class="btn btn-dark w-100">Login</button>
        </form>
    </div>
</div>

<script>
    function showForm(type) {
        document.getElementById('userForm').style.display = (type === 'user') ? 'block' : 'none';
        document.getElementById('adminForm').style.display = (type === 'admin') ? 'block' : 'none';
    }
</script>

</body>
</html>