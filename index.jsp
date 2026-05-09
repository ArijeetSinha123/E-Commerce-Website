<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String login = request.getParameter("login");
    String logout = request.getParameter("logout");
%>

<html>
    <h1>Server Tested Successfully</h1>

    <% if ("success".equals(login) && user != null) { %>
        <p style="color: green;">Login successful. Welcome, <%= user.getName() %>.</p>
    <% } %>

    <% if ("success".equals(logout)) { %>
        <p style="color: green;">You have logged out successfully.</p>
    <% } %>

    <% if (user != null) { %>
        <h2>Welcome, <%= user.getName() %></h2>
        <p>You are logged in with <%= user.getEmail() %>.</p>
        <form action="<%= request.getContextPath() %>/logout" method="post">
            <button type="submit">Logout</button>
        </form>
    <% } else { %>
        <a href="View/login.jsp">Login</a>
        <a href="View/register.jsp">Register</a>
    <% } %>
</html>
