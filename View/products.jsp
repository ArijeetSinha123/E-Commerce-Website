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
    <title>Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header class="site-header">
        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">Shop</a>
        <nav>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/orders">Orders</a>
        </nav>
    </header>
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
</body>
</html>
