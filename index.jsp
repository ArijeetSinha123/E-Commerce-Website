<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String login = request.getParameter("login");
    String logout = request.getParameter("logout");
%>

<!DOCTYPE html>
<html>
<head>
    <title>JackBuy</title>
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
        </nav>
    </header>

    <main class="page hero">
        <section>
            <h1>Shop everyday essentials in one place, delivered right to your door.</h1>
            <p>Browse products, add items to cart, and place orders through the MVC flow.</p>

            <% if ("success".equals(login) && user != null) { %>
                <p class="success">Login successful. Welcome, <%= user.getName() %>.</p>
            <% } %>

            <% if ("success".equals(logout)) { %>
                <p class="success">You have logged out successfully.</p>
            <% } %>

            <div class="hero-actions">
                <a class="button-link" href="${pageContext.request.contextPath}/products">Browse Products</a>
                <a class="button-link" href="${pageContext.request.contextPath}/cart">View Cart</a>
            </div>
        </section>

        <aside class="hero-panel">
            <% if (user != null) { %>
                <h2>Welcome, <%= user.getName() %></h2>
                <p>You are logged in with <%= user.getEmail() %>.</p>
                <form action="<%= request.getContextPath() %>/logout" method="post">
                    <button type="submit">Logout</button>
                </form>
            <% } else { %>
                <h2>Account</h2>
                <p>Login or register to place orders and view your order history.</p>
                <div class="auth-actions">
                    <a class="button-link" href="View/login.jsp">Login</a>
                    <a class="button-link" href="View/register.jsp">Register</a>
                </div>
            <% } %>
        </aside>
    </main>
</body>
</html>
