<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String currentPage = request.getRequestURI();
%>

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
                    <a class="nav-link nav-text <%= currentPage.contains("index") ? "active" : "" %>" 
                       href="${pageContext.request.contextPath}/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-text <%= currentPage.contains("products") ? "active" : "" %>" 
                       href="${pageContext.request.contextPath}/products">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-text <%= currentPage.contains("cart") ? "active" : "" %>" 
                       href="${pageContext.request.contextPath}/cart">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-text <%= currentPage.contains("orders") ? "active" : "" %>" 
                       href="${pageContext.request.contextPath}/orders">Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-text <%= currentPage.contains("chat") ? "active" : "" %>" 
                       href="${pageContext.request.contextPath}/chat">Chat</a>
                </li>
                <% if (user != null) { %>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/register.jsp">Register</a>
                    </li>
                <% } %>
                <li class="nav-item">
                    <a class="nav-link nav-text" href="${pageContext.request.contextPath}/View/admin/login.jsp">Admin</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
