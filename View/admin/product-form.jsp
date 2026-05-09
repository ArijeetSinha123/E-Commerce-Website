<%@ page import="model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
    boolean editing = product != null;
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= editing ? "Edit" : "Add" %> Product</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
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
</body>
</html>
