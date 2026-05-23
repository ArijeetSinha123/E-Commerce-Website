<%
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/products">Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/cart">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/orders">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page narrow">
        <section class="card">
            <h1>Create Account</h1>
            <% if ("empty".equals(error)) { %>
                <p class="error">Please fill all fields.</p>
            <% } else if ("password".equals(error)) { %>
                <p class="error">Password and confirm password do not match.</p>
            <% } else if ("1".equals(error)) { %>
                <p class="error">Registration failed. This email may already be registered.</p>
            <% } else if ("server".equals(error)) { %>
                <p class="error">Something went wrong while creating your account. Please try again.</p>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <p><label>Name<br><input type="text" name="name" required></label></p>
                <p><label>Email<br><input type="email" name="email" required></label></p>
                <p><label>Password<br><input type="password" name="password" required></label></p>
                <p><label>Confirm Password<br><input type="password" name="confirmPassword" required></label></p>
                <button type="submit">Register</button>
            </form>
            <p>Already have an account? <a href="${pageContext.request.contextPath}/View/login.jsp">Login here</a></p>
        </section>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
