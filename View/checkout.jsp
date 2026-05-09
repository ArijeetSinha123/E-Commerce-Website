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
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout | E-Commerce Website</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header class="site-header">
        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">E-Commerce Website</a>
        <nav>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/orders">Orders</a>
        </nav>
    </header>

    <main class="page narrow">
        <h1>Checkout</h1>

        <% if ("1".equals(error)) { %>
            <p class="error">Unable to place order. Please try again.</p>
        <% } %>

        <% if (user == null) { %>
            <p>Please login before checkout.</p>
            <a class="button-link" href="${pageContext.request.contextPath}/View/login.jsp">Login</a>
        <% } else if (cart.isEmpty()) { %>
            <p>Your cart is empty.</p>
            <a class="button-link" href="${pageContext.request.contextPath}/products">Browse Products</a>
        <% } else { %>
            <section class="checkout-box">
                <h2>Order Summary</h2>
                <p>Customer: <%= user.getName() %></p>
                <p>Email: <%= user.getEmail() %></p>
                <p>Total items: <%= cart.size() %></p>
                <h3>Total: Rs. <%= total %></h3>
                <form action="${pageContext.request.contextPath}/checkout" method="post">
                    <button type="submit">Place Order</button>
                </form>
            </section>
        <% } %>
    </main>
</body>
</html>
