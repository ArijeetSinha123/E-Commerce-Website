<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String search = (String) request.getAttribute("search");
    String error = (String) request.getAttribute("error");
    Map<String, List<Product>> categorizedProducts = new LinkedHashMap<>();
    categorizedProducts.put("Electronics", new ArrayList<Product>());
    categorizedProducts.put("Fashion", new ArrayList<Product>());
    categorizedProducts.put("Home & Living", new ArrayList<Product>());
    categorizedProducts.put("Sports", new ArrayList<Product>());
    categorizedProducts.put("Beauty & Care", new ArrayList<Product>());

    if (products != null) {
        for (Product product : products) {
            String category = resolveCategory(product);
            if (categorizedProducts.containsKey(category)) {
                categorizedProducts.get(category).add(product);
            }
        }
    }
%>
<%!
    private String resolveCategory(Product product) {
        if (product.getCategory() == null || product.getCategory().trim().isEmpty()) {
            return "Electronics";
        }
        return product.getCategory().trim();
    }

    private String productInitial(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return "N";
        }
        return product.getName().trim().substring(0, 1).toUpperCase();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
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

        <% if (products == null || products.isEmpty()) { %>
            <section class="empty-store">
                <h3>No products found.</h3>
                <p>Try another search or check back after new products are added.</p>
            </section>
        <% } else { %>
            <section class="category-nav" aria-label="Product categories">
                <% for (Map.Entry<String, List<Product>> entry : categorizedProducts.entrySet()) { %>
                    <% if (!entry.getValue().isEmpty()) { %>
                        <a href="#category-<%= entry.getKey().replace(" & ", "-").replace(" ", "-").toLowerCase() %>">
                            <%= entry.getKey() %>
                        </a>
                    <% } %>
                <% } %>
            </section>

            <% for (Map.Entry<String, List<Product>> entry : categorizedProducts.entrySet()) { %>
                <% if (!entry.getValue().isEmpty()) { %>
                    <section class="catalog-section" id="category-<%= entry.getKey().replace(" & ", "-").replace(" ", "-").toLowerCase() %>">
                        <div class="catalog-heading">
                            <div>
                                <span><%= entry.getValue().size() %> products</span>
                                <h2><%= entry.getKey() %></h2>
                            </div>
                        </div>

                        <div class="product-grid catalog-grid">
                            <% for (Product product : entry.getValue()) { %>
                                <article class="card catalog-card">
                                    <div class="product-image catalog-image">
                                        <%= productInitial(product) %>
                                    </div>
                                    <div class="catalog-card-body">
                                        <div class="product-meta">
                                            <span><%= entry.getKey() %></span>
                                            <% if (product.getStock() > 0) { %>
                                                <span><%= product.getStock() %> in stock</span>
                                            <% } else { %>
                                                <span>Out of stock</span>
                                            <% } %>
                                        </div>
                                        <h2><%= product.getName() %></h2>
                                        <p><%= product.getDescription() == null ? "No description available." : product.getDescription() %></p>
                                        <div class="catalog-buy-row">
                                            <strong>Rs. <%= product.getPrice() %></strong>
                                            <form action="${pageContext.request.contextPath}/cart" method="post" class="quick-add-form">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" <%= product.getStock() <= 0 ? "disabled" : "" %>>Add to Cart</button>
                                            </form>
                                        </div>
                                    </div>
                                </article>
                            <% } %>
                        </div>
                    </section>
                <% } %>
            <% } %>
        <% } %>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
