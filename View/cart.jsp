<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.CartItem" %>
<%
    Map<Integer, CartItem> cart = controller.CartController.getCart(session);
    BigDecimal total = BigDecimal.ZERO;
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Cart | E-Commerce Website</title>
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

    <main class="page">
        <section class="page-title">
            <h1>Your Cart</h1>
            <a class="button-link" href="${pageContext.request.contextPath}/products">Continue Shopping</a>
        </section>

        <% if ("empty".equals(error)) { %>
            <p class="error">Your cart is empty.</p>
        <% } else if ("1".equals(error)) { %>
            <p class="error">Unable to update cart.</p>
        <% } %>

        <% if (cart.isEmpty()) { %>
            <p>Your cart is empty.</p>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cart.values()) {
                            total = total.add(item.getSubtotal());
                        %>
                            <tr>
                                <td><%= item.getProduct().getName() %></td>
                                <td>Rs. <%= item.getProduct().getPrice() %></td>
                                <td>
                                    <form class="inline-form" action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="0" max="<%= item.getProduct().getStock() %>">
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
                    </tbody>
                </table>
            </div>

            <section class="cart-summary">
                <h2>Total: Rs. <%= total %></h2>
                <a class="button-link" href="${pageContext.request.contextPath}/checkout">Checkout</a>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="secondary">Clear Cart</button>
                </form>
            </section>
        <% } %>
    </main>
</body>
</html>
