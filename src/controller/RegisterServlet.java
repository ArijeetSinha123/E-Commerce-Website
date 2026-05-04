package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;
import model.dao.UserDAO;

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (isBlank(name) || isBlank(email) || isBlank(password) || isBlank(confirmPassword)) {
            res.sendRedirect(req.getContextPath() + "/View/register.jsp?error=empty");
            return;
        }

        if (!password.equals(confirmPassword)) {
            res.sendRedirect(req.getContextPath() + "/View/register.jsp?error=password");
            return;
        }

        try {
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);

            UserDAO dao = new UserDAO();
            boolean registered = dao.register(user);

            if (registered) {
                res.sendRedirect(req.getContextPath() + "/View/login.jsp?registered=1");
            } else {
                res.sendRedirect(req.getContextPath() + "/View/register.jsp?error=1");
            }
        } catch (Exception e) {
            throw new ServletException("Registration failed", e);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
