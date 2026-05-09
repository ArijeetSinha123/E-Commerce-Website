<%
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Register | E-Commerce Website</title>
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
</body>
</html>
