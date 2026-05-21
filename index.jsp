<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String login = request.getParameter("login");
    String logout = request.getParameter("logout");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce Website</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/script.js" defer></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand brand-logo" href="${pageContext.request.contextPath}/index.jsp">JackBuy</a>
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

    <main class="page">
        <section class="card">
            <h1>E-Commerce Website</h1>
            <p>Browse products, manage your cart, and place orders.</p>

            <% if ("success".equals(login) && user != null) { %>
                <p class="success">Login successful. Welcome, <%= user.getName() %>.</p>
            <% } %>
            <% if ("success".equals(logout)) { %>
                <p class="success">You have logged out successfully.</p>
            <% } %>
            <% if (user != null) { %>
                <h2>Welcome, <%= user.getName() %></h2>
                <p>You are logged in with <%= user.getEmail() %>.</p>
                <div class="inline-actions">
                    <a class="button-link" href="${pageContext.request.contextPath}/products">Start Shopping</a>
                    <form action="<%= request.getContextPath() %>/logout" method="post">
                        <button type="submit" class="secondary">Logout</button>
                    </form>
                </div>
            <% } else { %>
                <div class="inline-actions">
                    <a class="button-link" href="View/login.jsp">Login</a>
                    <a class="button-link" href="View/register.jsp">Register</a>
                    <a class="button-link" href="View/admin/login.jsp">Admin Login</a>
                    <a class="button-link" href="${pageContext.request.contextPath}/products">Browse Products</a>
                </div>
            <% } %>
        </section>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
