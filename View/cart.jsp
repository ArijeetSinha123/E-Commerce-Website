<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.CartItem" %>
<%
    Map<Integer, CartItem> cart = controller.CartController.getCart(session);
    BigDecimal total = BigDecimal.ZERO;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>
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
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/chat">Chat</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page">
        <div class="page-title">
            <h1>Cart</h1>
            <a class="button-link" href="${pageContext.request.contextPath}/products">Continue Shopping</a>
        </div>

        <% if (cart.isEmpty()) { %>
            <p>Your cart is empty.</p>
        <% } else { %>
            <table>
                <tr><th>Product</th><th>Price</th><th>Quantity</th><th>Subtotal</th><th></th></tr>
                <% for (CartItem item : cart.values()) {
                    total = total.add(item.getSubtotal());
                %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td>Rs. <%= item.getProduct().getPrice() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="inline-form">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="0">
                                <button type="submit">Update</button>
                            </form>
                        </td>
                        <td>Rs. <%= item.getSubtotal() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                <button type="submit" class="secondary">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
            <div class="summary">
                <h2>Total: Rs. <%= total %></h2>
                <a class="button-link" href="${pageContext.request.contextPath}/checkout">Checkout</a>
            </div>
        <% } %>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
