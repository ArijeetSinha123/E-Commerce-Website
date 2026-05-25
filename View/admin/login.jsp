<%
    String error = request.getParameter("error");
    String logout = request.getParameter("logout");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=20260523">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand brand-logo" href="${pageContext.request.contextPath}/index.jsp">NexCart</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                    aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/index.jsp">Store</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/products">Products</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
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
            <br>
            <p><a href="${pageContext.request.contextPath}/index.jsp">Back to store</a></p>
        </section>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
