<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    Map<Integer, CartItem> cart = controller.CartController.getCart(session);
    BigDecimal total = BigDecimal.ZERO;
    for (CartItem item : cart.values()) {
        total = total.add(item.getSubtotal());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
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
        <h1>Checkout</h1>
        <% if (user == null) { %>
            <p>Please login before checkout.</p>
            <a class="button-link" href="${pageContext.request.contextPath}/View/login.jsp">Login</a>
        <% } else if (cart.isEmpty()) { %>
            <p>Your cart is empty.</p>
            <a class="button-link" href="${pageContext.request.contextPath}/products">Browse Products</a>
        <% } else { %>
            <section class="card">
                <p>Customer: <%= user.getName() %></p>
                <p>Email: <%= user.getEmail() %></p>
                <h2>Total: Rs. <%= total %></h2>
                <form action="${pageContext.request.contextPath}/checkout" method="post">
                    <button type="submit">Place Order</button>
                </form>
            </section>
        <% } %>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
