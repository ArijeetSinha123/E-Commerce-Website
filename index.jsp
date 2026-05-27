<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>
<%@ page import="model.dao.ProductDAO" %>
<%
    User user = (User) session.getAttribute("user");
    String login = request.getParameter("login");
    String logout = request.getParameter("logout");
    List<Product> products = null;
    String productError = null;

    try {
        products = new ProductDAO().findAll(null);
    } catch (Exception e) {
        productError = "Unable to load products right now.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexCart - E-Commerce Website</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260525">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css?v=20260523">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=20260523">
    <script src="${pageContext.request.contextPath}/assets/js/script.js" defer></script>
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

    <main class="page home-page">
        <section class="home-hero">
            <div class="home-hero-content">
                <p class="home-kicker">Fresh picks, fast checkout</p>
                <h1>NexCart</h1>
                <p class="home-lead">Shop the latest products added to the store, manage your cart, and place orders with a smooth shopping experience.</p>

                <% if ("success".equals(login) && user != null) { %>
                    <p class="success home-alert">Login successful. Welcome, <%= user.getName() %>.</p>
                <% } %>
                <% if ("success".equals(logout)) { %>
                    <p class="success home-alert">You have logged out successfully.</p>
                <% } %>
                <% if (user != null) { %>
                    <p class="home-user">Welcome back, <strong><%= user.getName() %></strong>. You are logged in with <%= user.getEmail() %>.</p>
                    <div class="inline-actions">
                        <a class="button-link" href="${pageContext.request.contextPath}/products">Start Shopping</a>
                        <form action="<%= request.getContextPath() %>/logout" method="post">
                            <button type="submit" class="secondary">Logout</button>
                        </form>
                    </div>
                <% } else { %>
                    <div class="inline-actions">
                        <a class="button-link" href="${pageContext.request.contextPath}/products">Browse Products</a>
                        <a class="button-link secondary-link" href="View/login.jsp">Login</a>
                        <a class="button-link secondary-link" href="View/register.jsp">Register</a>
                    </div>
                <% } %>
            </div>
            <div class="home-hero-panel">
                <span class="hero-stat"><strong><%= products == null ? "0" : products.size() %></strong> products live</span>
                <span class="hero-stat"><strong>24/7</strong> shopping</span>
                <span class="hero-stat"><strong>Easy</strong> cart management</span>
            </div>
        </section>

        <section class="storefront-section">
            <div class="section-heading">
                <div>
                    <p class="home-kicker">Catalog</p>
                    <h2>Our Products</h2>
                </div>
                <a class="text-link" href="${pageContext.request.contextPath}/products">View full catalog</a>
            </div>

            <% if (productError != null) { %>
                <p class="error"><%= productError %></p>
            <% } %>

            <div class="home-product-grid">
                <% if (products == null || products.isEmpty()) { %>
                    <article class="empty-store">
                        <h3>No products available yet</h3>
                        <p>Products added by the admin will appear here automatically.</p>
                        <a class="button-link" href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin Login</a>
                    </article>
                <% } else { %>
                    <% for (Product product : products) {
                        String name = product.getName() == null ? "Product" : product.getName();
                        String description = product.getDescription() == null || product.getDescription().trim().isEmpty()
                                ? "Quality product available now on NexCart."
                                : product.getDescription();
                        String imageUrl = product.getImageUrl();
                        String cleanName = name.trim();
                        String initial = cleanName.isEmpty() ? "N" : cleanName.substring(0, 1).toUpperCase();
                    %>
                        <article class="home-product-card">
                            <div class="home-product-media">
                                <% if (imageUrl != null && !imageUrl.trim().isEmpty()) { %>
                                    <img src="<%= imageUrl %>" alt="<%= name %>">
                                <% } else { %>
                                    <span><%= initial %></span>
                                <% } %>
                            </div>
                            <div class="home-product-body">
                                <div class="product-meta">
                                    <span><%= product.getStock() > 0 ? "In stock" : "Out of stock" %></span>
                                    <span><%= product.getStock() %> left</span>
                                </div>
                                <h3><%= name %></h3>
                                <p><%= description %></p>
                                <div class="product-buy-row">
                                    <strong>Rs. <%= product.getPrice() %></strong>
                                    <% if (product.getStock() > 0) { %>
                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="quick-add-form">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit">Add to Cart</button>
                                        </form>
                                    <% } else { %>
                                        <button type="button" class="secondary" disabled>Unavailable</button>
                                    <% } %>
                                </div>
                            </div>
                        </article>
                    <% } %>
                <% } %>
            </div>
        </section>

        <section class="home-service-strip">
            <div>
                <strong>Curated Products</strong>
                <p>Every item added by the store admin appears on the home page.</p>
            </div>
            <div>
                <strong>Simple Checkout</strong>
                <p>Add products to cart and place orders in a few clicks.</p>
            </div>
            <div>
                <strong>Account Friendly</strong>
                <p>Login to track your shopping and order history.</p>
            </div>
        </section>

        <% if (user == null) { %>
            <section class="home-admin-link">
                <span>Store Admin?</span>
                <a href="${pageContext.request.contextPath}/View/admin/login.jsp">Go to Admin Login</a>
            </section>
        <% } %>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    <jsp:include page="View/includes/footer.jsp" />
</body>
</html>
