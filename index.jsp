<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String login = request.getParameter("login");
%>

<html>
    <h1>Server Tested Successfully</h1>

    <% if ("success".equals(login) && user != null) { %>
        <p style="color: green;">Login successful. Welcome, <%= user.getName() %>.</p>
    <% } %>

    <% if (user != null) { %>
        <p>You are logged in as <%= user.getEmail() %>.</p>
    <% } else { %>
        <a href="View/login.jsp">Login</a>
        <a href="View/register.jsp">Register</a>
    <% } %>
</html>
