<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String placed = request.getParameter("placed");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Orders | E-Commerce Website</title>
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
            <h1>Orders</h1>
            <a class="button-link" href="${pageContext.request.contextPath}/products">Shop More</a>
        </section>

        <% if (placed != null) { %>
            <p class="success">Order #<%= placed %> placed successfully.</p>
        <% } %>

        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>

        <% if (orders == null || orders.isEmpty()) { %>
            <p>No orders yet.</p>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order order : orders) { %>
                            <tr>
                                <td>#<%= order.getId() %></td>
                                <td>Rs. <%= order.getTotalAmount() %></td>
                                <td><%= order.getStatus() %></td>
                                <td><%= order.getCreatedAt() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </main>
</body>
</html>
