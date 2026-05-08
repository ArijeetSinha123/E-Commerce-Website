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
        <h2>Welcome, <%= user.getName() %></h2>
        <p>You are logged in with <%= user.getEmail() %>.</p>
    <% } else { %>
        <a href="View/login.jsp">Login</a>
        <a href="View/register.jsp">Register</a>
    <% } %>
</html>
