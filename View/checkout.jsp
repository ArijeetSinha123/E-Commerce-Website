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
    <title>Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
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
</body>
</html>
