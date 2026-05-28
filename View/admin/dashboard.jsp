<%@ page import="model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
            <h1>Admin Dashboard</h1>
            <div class="inline-actions">
                <a class="button-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <form action="${pageContext.request.contextPath}/admin/logout" method="post">
                    <button type="submit" class="secondary">Admin Logout</button>
                </form>
            </div>
        </div>
        <% if ("1".equals(request.getParameter("passwordChanged"))) { %>
            <p class="success">Admin password updated.</p>
        <% } %>
        <p>Welcome, <%= admin.getName() %>.</p>
        <section class="product-grid">
            <article class="card">
                <h2>Products</h2>
                <p><%= request.getAttribute("productCount") %> total products</p>
                <a class="button-link" href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            </article>
            <article class="card">
                <h2>Orders</h2>
                <p><%= request.getAttribute("orderCount") %> total orders</p>
                <a class="button-link" href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            </article>
            <article class="card">
                <h2>Users</h2>
                <p><%= request.getAttribute("userCount") %> total users</p>
                <a class="button-link" href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
            </article>
        </section>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
