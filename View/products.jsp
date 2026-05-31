<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String search = (String) request.getAttribute("search");
    String error = (String) request.getAttribute("error");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String minPrice = (String) request.getAttribute("minPrice");
    String maxPrice = (String) request.getAttribute("maxPrice");
    String stock = (String) request.getAttribute("stock");
    String sort = (String) request.getAttribute("sort");
    String[] categories = {"Electronics", "Fashion", "Home & Living", "Sports", "Beauty & Care", "Grocery", "Books & Stationery"};
    Map<String, List<Product>> categorizedProducts = new LinkedHashMap<>();
    for (String categoryName : categories) {
        categorizedProducts.put(categoryName, new ArrayList<Product>());
    }

    if (products != null) {
        for (Product product : products) {
            String category = resolveCategory(product);
            if (!categorizedProducts.containsKey(category)) {
                categorizedProducts.put(category, new ArrayList<Product>());
            }
            categorizedProducts.get(category).add(product);
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

    private String selected(String value, String current) {
        return value.equals(current) ? "selected" : "";
    }

    private String productInitial(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "?";
        }
        return name.trim().substring(0, 1).toUpperCase();
    }

    private String truncate(String text, int maxLength) {
        if (text == null || text.trim().isEmpty()) {
            return "No description available.";
        }
        if (text.length() <= maxLength) {
            return text;
        }
        return text.substring(0, maxLength - 3) + "...";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260531">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css?v=20260531">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=20260531">
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
            <div>
                <h1>Products</h1>
                <p>Browse the full catalog first, then narrow it by category, budget, availability, or sorting.</p>
            </div>
        </div>

        <section class="catalog-filter-panel">
            <form action="${pageContext.request.contextPath}/products" method="get" class="catalog-filter-form">
                <label>
                    Search
                    <input type="search" name="q" value="<%= search == null ? "" : search %>" placeholder="Search products">
                </label>
                <label>
                    Category
                    <select name="category">
                        <option value="">All products</option>
                        <% for (String categoryName : categories) { %>
                            <option value="<%= categoryName %>" <%= selected(categoryName, selectedCategory) %>><%= categoryName %></option>
                        <% } %>
                    </select>
                </label>
                <label>
                    Min price
                    <input type="number" name="minPrice" value="<%= minPrice == null ? "" : minPrice %>" min="0" step="1" placeholder="Rs. 0">
                </label>
                <label>
                    Max price
                    <input type="number" name="maxPrice" value="<%= maxPrice == null ? "" : maxPrice %>" min="0" step="1" placeholder="Rs. 5000">
                </label>
                <label>
                    Stock
                    <select name="stock">
                        <option value="" <%= selected("", stock) %>>All stock</option>
                        <option value="in" <%= selected("in", stock) %>>In stock</option>
                        <option value="out" <%= selected("out", stock) %>>Out of stock</option>
                    </select>
                </label>
                <label>
                    Sort
                    <select name="sort">
                        <option value="" <%= selected("", sort) %>>Newest first</option>
                        <option value="price_asc" <%= selected("price_asc", sort) %>>Price: low to high</option>
                        <option value="price_desc" <%= selected("price_desc", sort) %>>Price: high to low</option>
                        <option value="name_asc" <%= selected("name_asc", sort) %>>Name: A to Z</option>
                        <option value="name_desc" <%= selected("name_desc", sort) %>>Name: Z to A</option>
                    </select>
                </label>
                <div class="catalog-filter-actions">
                    <button type="submit">Apply Filters</button>
                    <a class="button-link secondary-link" href="${pageContext.request.contextPath}/products">Reset</a>
                </div>
            </form>
        </section>

        <% if ("added".equals(request.getParameter("cart"))) { %>
            <p class="success">Product added to cart.</p>
        <% } %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>

        <% if (products == null || products.isEmpty()) { %>
            <section class="empty-store">
                <span class="empty-kicker">No matching items</span>
                <h3>No products found.</h3>
                <p>Try clearing filters, widening the price range, or searching for another product name.</p>
                <a class="button-link" href="${pageContext.request.contextPath}/products">View all products</a>
            </section>
        <% } else { %>
            <section class="category-nav" aria-label="Product categories">
                <a href="${pageContext.request.contextPath}/products">All Products</a>
                <% for (Map.Entry<String, List<Product>> entry : categorizedProducts.entrySet()) { %>
                    <% if (!entry.getValue().isEmpty()) { %>
                        <a href="${pageContext.request.contextPath}/products?category=<%= java.net.URLEncoder.encode(entry.getKey(), "UTF-8") %>">
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
                                    <div class="catalog-card-body">
                                                        <div class="product-image">
                                            <span><%= productInitial(product.getName()) %></span>
                                        </div>
                                        <div class="product-badges">
                                            <span class="badge"><%= entry.getKey() %></span>
                                            <span class="badge <%= product.getStock() > 0 ? "in-stock" : "out-of-stock" %>">
                                                <%= product.getStock() > 0 ? product.getStock() + " in stock" : "Out of stock" %>
                                            </span>
                                        </div>
                                        <h2 title="<%= product.getName() %>"><%= product.getName() %></h2>
                                        <p><%= truncate(product.getDescription(), 112) %></p>
                                        <div class="catalog-buy-row">
                                            <strong>Rs. <%= product.getPrice() %></strong>
                                            <form action="${pageContext.request.contextPath}/cart" method="post" class="quick-add-form">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="button button-primary" <%= product.getStock() <= 0 ? "disabled" : "" %>>Add to Cart</button>
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
