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
    <title>Cart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header class="site-header">
        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">Shop</a>
        <nav>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
        </nav>
    </header>
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
</body>
</html>
