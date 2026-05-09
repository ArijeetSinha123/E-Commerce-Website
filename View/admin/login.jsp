<%
    String error = request.getParameter("error");
    String logout = request.getParameter("logout");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <main class="page narrow">
        <section class="card">
            <h1>Admin Login</h1>

            <% if ("success".equals(logout)) { %>
                <p class="success">Admin logged out successfully.</p>
            <% } %>
            <% if ("empty".equals(error)) { %>
                <p class="error">Please enter admin email and password.</p>
            <% } else if ("1".equals(error)) { %>
                <p class="error">Invalid admin email or password.</p>
            <% } else if ("server".equals(error)) { %>
                <p class="error">Admin login failed. Please try again.</p>
            <% } else if ("login_required".equals(error)) { %>
                <p class="error">Admin login required.</p>
            <% } %>

            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <p><label>Email<br><input type="email" name="email" required></label></p>
                <p><label>Password<br><input type="password" name="password" required></label></p>
                <button type="submit">Login as Admin</button>
            </form>

            <p><a href="${pageContext.request.contextPath}/index.jsp">Back to store</a></p>
        </section>
    </main>
</body>
</html>
