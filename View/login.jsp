<%
    String registered = request.getParameter("registered");
    String error = request.getParameter("error");
%>

<h2>Login</h2>

<% if ("1".equals(registered)) { %>
    <p style="color: green;">Registration successful. Please login.</p>
<% } %>

<% if ("empty".equals(error)) { %>
    <p style="color: red;">Please enter email and password.</p>
<% } else if ("1".equals(error)) { %>
    <p style="color: red;">Invalid email or password.</p>
<% } else if ("server".equals(error)) { %>
    <p style="color: red;">Something went wrong while logging in. Please try again.</p>
<% } %>

<form action="${pageContext.request.contextPath}/login" method="post">

    Email: <input type="email" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>

</form>

<p>New user? <a href="${pageContext.request.contextPath}/View/register.jsp">Register here</a></p>
