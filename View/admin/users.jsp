<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=20260523">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand brand-logo" href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                    aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/admin/products">Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/admin/users">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page">
        <div class="page-title">
            <h1>Manage Users</h1>
            <div class="inline-actions">
                <a class="button-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            </div>
        </div>

        <% if ("1".equals(request.getParameter("updated"))) { %>
            <p class="success">User updated.</p>
        <% } %>
        <% if ("1".equals(request.getParameter("deleted"))) { %>
            <p class="success">User removed.</p>
        <% } %>
        <% if ("1".equals(request.getParameter("deleteBlocked"))) { %>
            <p class="error">This user has active orders and cannot be removed.</p>
        <% } %>
        <% if ("1".equals(request.getParameter("duplicateEmail"))) { %>
            <p class="error">That email is already used by another user.</p>
        <% } %>
        <% if ("1".equals(request.getParameter("validationError"))) { %>
            <p class="error">Please enter a valid name, email, and password.</p>
        <% } %>
        <% if ("1".equals(request.getParameter("notFound"))) { %>
            <p class="error">User not found.</p>
        <% } %>
        <% if ("1".equals(request.getParameter("error")) || request.getAttribute("error") != null) { %>
            <p class="error">Unable to update users.</p>
        <% } %>

        <% if (users == null || users.isEmpty()) { %>
            <p>No users found.</p>
        <% } else { %>
            <table>
                <tr><th>ID</th><th>Name</th><th>Email</th><th>Actions</th></tr>
                <% for (User user : users) { %>
                    <tr>
                        <td>#<%= user.getId() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td class="inline-actions">
                            <a class="button-link" href="${pageContext.request.contextPath}/admin/users?action=edit&id=<%= user.getId() %>">Edit</a>
                            <form action="${pageContext.request.contextPath}/admin/users" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= user.getId() %>">
                                <button type="submit" class="secondary">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
