package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import model.dao.UserDAO;
import model.User;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (isBlank(email) || isBlank(password)) {
            res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=empty");
            return;
        }

        try {
            UserDAO dao = new UserDAO();
            User user = dao.login(email, password);

            if (user != null) {
                req.getSession().setAttribute("user", user);
                res.sendRedirect(req.getContextPath() + "/index.jsp?login=success");
            } else {
                res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=1");
            }

        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=server");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
