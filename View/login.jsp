<%
    String registered = request.getParameter("registered");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login | E-Commerce Website</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header class="site-header">
        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">E-Commerce Website</a>
        <nav>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
        </nav>
    </header>

    <main class="page narrow">
        <section class="checkout-box">
            <h1>Login</h1>

            <% if ("1".equals(registered)) { %>
                <p class="success">Registration successful. Please login.</p>
            <% } %>

            <% if ("empty".equals(error)) { %>
                <p class="error">Please enter email and password.</p>
            <% } else if ("1".equals(error)) { %>
                <p class="error">Invalid email or password.</p>
            <% } else if ("server".equals(error)) { %>
                <p class="error">Something went wrong while logging in. Please try again.</p>
            <% } else if ("login_required".equals(error)) { %>
                <p class="error">Please login to continue.</p>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <p><label>Email<br><input type="email" name="email" required></label></p>
                <p><label>Password<br><input type="password" name="password" required></label></p>
                <button type="submit">Login</button>
            </form>

            <p>New user? <a href="${pageContext.request.contextPath}/View/register.jsp">Register here</a></p>
        </section>
    </main>
</body>
</html>
