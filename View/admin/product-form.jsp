<%@ page import="model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
    boolean editing = product != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editing ? "Edit" : "Add" %> Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
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
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/index.jsp">Store</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page narrow">
        <h1><%= editing ? "Edit" : "Add" %> Product</h1>
        <form action="${pageContext.request.contextPath}/admin/products" method="post" class="card">
            <input type="hidden" name="action" value="<%= editing ? "update" : "create" %>">
            <% if (editing) { %>
                <input type="hidden" name="id" value="<%= product.getId() %>">
            <% } %>
            <p><label>Name<br><input type="text" name="name" value="<%= editing ? product.getName() : "" %>" required></label></p>
            <p><label>Description<br><input type="text" name="description" value="<%= editing ? product.getDescription() : "" %>"></label></p>
            <p><label>Price<br><input type="number" name="price" value="<%= editing ? product.getPrice() : "" %>" step="0.01" min="0" required></label></p>
            <p><label>Stock<br><input type="number" name="stock" value="<%= editing ? product.getStock() : "0" %>" min="0" required></label></p>
            <p><label>Image URL<br><input type="text" name="imageUrl" value="<%= editing && product.getImageUrl() != null ? product.getImageUrl() : "" %>"></label></p>
            <button type="submit">Save Product</button>
        </form>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
