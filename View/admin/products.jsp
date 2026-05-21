<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Products</title>
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
    <main class="page">
        <div class="page-title">
            <h1>Manage Products</h1>
            <a class="button-link" href="${pageContext.request.contextPath}/admin/products?action=new">Add Product</a>
        </div>
        <% if (products == null || products.isEmpty()) { %>
            <p>No products found.</p>
        <% } else { %>
            <table>
                <tr><th>Name</th><th>Price</th><th>Stock</th><th>Actions</th></tr>
                <% for (Product product : products) { %>
                    <tr>
                        <td><%= product.getName() %></td>
                        <td>Rs. <%= product.getPrice() %></td>
                        <td><%= product.getStock() %></td>
                        <td class="inline-actions">
                            <a class="button-link" href="${pageContext.request.contextPath}/admin/products?action=edit&id=<%= product.getId() %>">Edit</a>
                            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= product.getId() %>">
                                <button type="submit" class="secondary">Delete</button>
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
