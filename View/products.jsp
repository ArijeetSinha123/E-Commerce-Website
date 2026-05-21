<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String search = (String) request.getAttribute("search");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand brand-logo" href="${pageContext.request.contextPath}/index.jsp">JackBuy</a>
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
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page">
        <div class="page-title">
            <h1>Products</h1>
            <form action="${pageContext.request.contextPath}/products" method="get" class="inline-form">
                <input type="search" name="q" value="<%= search == null ? "" : search %>" placeholder="Search products">
                <button type="submit">Search</button>
            </form>
        </div>

        <% if ("added".equals(request.getParameter("cart"))) { %>
            <p class="success">Product added to cart.</p>
        <% } %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>

        <section class="product-grid">
            <% if (products == null || products.isEmpty()) { %>
                <p>No products found.</p>
            <% } else { %>
                <% for (Product product : products) { %>
                    <article class="card">
                        <div class="product-image"><%= product.getName().substring(0, 1).toUpperCase() %></div>
                        <h2><%= product.getName() %></h2>
                        <p><%= product.getDescription() %></p>
                        <strong>Rs. <%= product.getPrice() %></strong>
                        <small><%= product.getStock() %> in stock</small>
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="inline-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <input type="number" name="quantity" value="1" min="1" max="<%= product.getStock() %>">
                            <button type="submit">Add</button>
                        </form>
                    </article>
                <% } %>
            <% } %>
        </section>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
