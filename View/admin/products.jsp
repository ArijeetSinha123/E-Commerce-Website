<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
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
</body>
</html>
