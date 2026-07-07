<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
