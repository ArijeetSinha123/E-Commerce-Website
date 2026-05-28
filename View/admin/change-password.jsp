<%
    String error = request.getParameter("error");
    String required = request.getParameter("required");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Admin Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=20260523">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand brand-logo" href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
        </div>
    </nav>
    <main class="page narrow">
        <section class="card">
            <h1>Change Admin Password</h1>

            <% if ("1".equals(required)) { %>
                <p class="error">Please change the default admin password before opening the dashboard.</p>
            <% } %>
            <% if ("empty".equals(error)) { %>
                <p class="error">Please fill all password fields.</p>
            <% } else if ("mismatch".equals(error)) { %>
                <p class="error">New password and confirm password do not match.</p>
            <% } else if ("weak".equals(error)) { %>
                <p class="error">Use at least 8 characters and do not reuse the default or current password.</p>
            <% } else if ("current".equals(error)) { %>
                <p class="error">Current password is incorrect.</p>
            <% } else if ("server".equals(error)) { %>
                <p class="error">Unable to change password. Please try again.</p>
            <% } %>

            <form action="${pageContext.request.contextPath}/admin/change-password" method="post">
                <p><label>Current Password<br><input type="password" name="currentPassword" required></label></p>
                <p><label>New Password<br><input type="password" name="newPassword" minlength="8" required></label></p>
                <p><label>Confirm New Password<br><input type="password" name="confirmPassword" minlength="8" required></label></p>
                <button type="submit">Update Password</button>
            </form>
            <br>
            <form action="${pageContext.request.contextPath}/admin/logout" method="post">
                <button type="submit" class="secondary">Logout</button>
            </form>
        </section>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
