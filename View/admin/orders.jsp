<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <main class="page">
        <div class="page-title">
            <h1>Manage Orders</h1>
            <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        </div>
        <% if (orders == null || orders.isEmpty()) { %>
            <p>No orders found.</p>
        <% } else { %>
            <table>
                <tr><th>ID</th><th>Customer</th><th>Total</th><th>Status</th><th>Date</th><th>Update</th></tr>
                <% for (Order order : orders) { %>
                    <tr>
                        <td>#<%= order.getId() %></td>
                        <td><%= order.getCustomerName() %></td>
                        <td>Rs. <%= order.getTotalAmount() %></td>
                        <td><%= order.getStatus() %></td>
                        <td><%= order.getCreatedAt() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="inline-form">
                                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                <select name="status">
                                    <option value="PLACED">PLACED</option>
                                    <option value="PROCESSING">PROCESSING</option>
                                    <option value="SHIPPED">SHIPPED</option>
                                    <option value="DELIVERED">DELIVERED</option>
                                    <option value="CANCELLED">CANCELLED</option>
                                </select>
                                <button type="submit">Save</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>
    </main>
</body>
</html>
