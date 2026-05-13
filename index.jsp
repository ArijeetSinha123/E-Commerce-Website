<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String login = request.getParameter("login");
    String logout = request.getParameter("logout");
%>
<!DOCTYPE html>
<html>
<head>
    <title>E-Commerce Website</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/script.js" defer></script>
</head>
<body>
    <header class="site-header">
        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">JackBuy</a>
        <nav>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/orders">Orders</a>
            <a href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin Login</a>
        </nav>
    </header>

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
</body>
</html>
