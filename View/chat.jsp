<%
    String message = (String) request.getAttribute("message");
    String reply = (String) request.getAttribute("reply");
%>
<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexCart Assistant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260707">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css?v=20260707">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=20260707">
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
                        <a class="nav-link nav-text active" href="${pageContext.request.contextPath}/chat">Chat</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="page narrow">
        <section class="chat-panel">
            <div class="page-title">
                <div>
                    <h1>Assistant</h1>
                    <p>Ask about products, carts, orders, returns, cancellations, checkout, delivery, or accounts.</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/chat" method="post" class="chat-form">
                <label for="message">Message</label>
                <div class="chat-input-row">
                    <input id="message" type="text" name="message" value="<%= escapeHtml(message) %>" placeholder="How do I return an order?" autocomplete="off" required>
                    <button type="submit">Send</button>
                </div>
            </form>

            <div class="chat-window" aria-live="polite">
                <% if (message != null && !message.trim().isEmpty()) { %>
                    <div class="chat-message user-message">
                        <span>You</span>
                        <p><%= escapeHtml(message) %></p>
                    </div>
                <% } %>

                <div class="chat-message bot-message">
                    <span>NexCart Assistant</span>
                    <p><%= escapeHtml(reply == null ? "Hi, I am ready to help with your NexCart questions." : reply) %></p>
                </div>
            </div>
        </section>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <jsp:include page="includes/footer.jsp" />
</body>
</html>
