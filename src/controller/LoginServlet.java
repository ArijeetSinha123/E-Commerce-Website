package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.dao.UserDAO;
import model.User;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            UserDAO dao = new UserDAO();
            User user = dao.login(email, password);

            if (user != null) {
                req.getSession().setAttribute("user", user);
                res.sendRedirect(req.getContextPath() + "/index.jsp");
            } else {
                res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=1");
            }

        } catch (Exception e) {
            throw new ServletException("Login failed", e);
        }
    }
}
