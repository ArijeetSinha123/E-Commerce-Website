<%
    String error = request.getParameter("error");
%>

<h2>Create Account</h2>

<% if ("empty".equals(error)) { %>
    <p style="color: red;">Please fill all fields.</p>
<% } else if ("password".equals(error)) { %>
    <p style="color: red;">Password and confirm password do not match.</p>
<% } else if ("1".equals(error)) { %>
    <p style="color: red;">Registration failed. This email may already be registered.</p>
<% } %>

<form action="${pageContext.request.contextPath}/register" method="post">

    Name: <input type="text" name="name" required><br><br>
    Email: <input type="email" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    Confirm Password: <input type="password" name="confirmPassword" required><br><br>

    <button type="submit">Register</button>

</form>

<p>Already have an account? <a href="${pageContext.request.contextPath}/View/login.jsp">Login here</a></p>
