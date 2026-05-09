<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String search = (String) request.getAttribute("search");
    String cartMessage = request.getParameter("cart");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Products | E-Commerce Website</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header class="site-header">
        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">E-Commerce Website</a>
        <nav>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/orders">Orders</a>
        </nav>
    </header>

    <main class="page">
        <section class="page-title">
            <h1>Products</h1>
            <form class="search-form" action="${pageContext.request.contextPath}/products" method="get">
                <input type="search" name="q" value="<%= search == null ? "" : search %>" placeholder="Search products">
                <button type="submit">Search</button>
            </form>
        </section>

        <% if ("added".equals(cartMessage)) { %>
            <p class="success">Product added to cart.</p>
        <% } %>

        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>

        <section class="product-grid">
            <% if (products == null || products.isEmpty()) { %>
                <p>No products found. Run database/schema.sql to add the sample products.</p>
            <% } else { %>
                <% for (Product product : products) { %>
                    <article class="product-card">
                        <div class="product-image">
                            <span><%= product.getName().substring(0, 1).toUpperCase() %></span>
                        </div>
                        <div class="product-info">
                            <h2><%= product.getName() %></h2>
                            <p><%= product.getDescription() %></p>
                            <strong>Rs. <%= product.getPrice() %></strong>
                            <small><%= product.getStock() %> in stock</small>
                        </div>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <input type="number" name="quantity" value="1" min="1" max="<%= product.getStock() %>">
                            <button type="submit" <%= product.getStock() <= 0 ? "disabled" : "" %>>Add to Cart</button>
                        </form>
                    </article>
                <% } %>
            <% } %>
        </section>
    </main>
</body>
</html>
