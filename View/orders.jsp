<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <main class="page">
        <div class="page-title">
            <h1>My Orders</h1>
            <a class="button-link" href="${pageContext.request.contextPath}/products">Shop More</a>
        </div>
        <% if (request.getParameter("placed") != null) { %>
            <p class="success">Order placed successfully.</p>
        <% } %>
        <% if (request.getParameter("cancelled") != null) { %>
            <p class="success">Order cancelled successfully.</p>
        <% } %>
        <% if (request.getParameter("cancelError") != null) { %>
            <p class="error">This order cannot be cancelled now.</p>
        <% } %>
        <% if (orders == null || orders.isEmpty()) { %>
            <p>No orders yet.</p>
        <% } else { %>
            <table>
                <tr><th>ID</th><th>Total</th><th>Status</th><th>Date</th><th>Action</th></tr>
                <% for (Order order : orders) { %>
                    <tr>
                        <td>#<%= order.getId() %></td>
                        <td>Rs. <%= order.getTotalAmount() %></td>
                        <td><%= order.getStatus() %></td>
                        <td><%= order.getCreatedAt() %></td>
                        <td>
                            <% if ("PLACED".equals(order.getStatus()) || "PROCESSING".equals(order.getStatus())) { %>
                                <form action="${pageContext.request.contextPath}/orders" method="post">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <button type="submit" class="secondary">Cancel</button>
                                </form>
                            <% } else { %>
                                -
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>
    </main>
</body>
</html>
