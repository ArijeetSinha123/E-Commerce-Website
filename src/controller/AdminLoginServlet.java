package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Admin;
import model.dao.AdminDAO;

public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (isBlank(email) || isBlank(password)) {
            res.sendRedirect(req.getContextPath() + "/View/admin/login.jsp?error=empty");
            return;
        }

        email = email.trim();

        try {
            Admin admin = new AdminDAO().login(email, password);

            if (admin != null) {
                req.getSession().setAttribute("admin", admin);
                res.sendRedirect(req.getContextPath() + "/admin/dashboard?login=success");
            } else {
                res.sendRedirect(req.getContextPath() + "/View/admin/login.jsp?error=1");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/View/admin/login.jsp?error=server");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
