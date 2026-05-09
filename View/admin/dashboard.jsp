<%@ page import="model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <main class="page">
        <div class="page-title">
            <h1>Admin Dashboard</h1>
            <form action="${pageContext.request.contextPath}/admin/logout" method="post">
                <button type="submit" class="secondary">Admin Logout</button>
            </form>
        </div>
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
        </section>
    </main>
</body>
</html>
