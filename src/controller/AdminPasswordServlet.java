package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Admin;
import model.dao.AdminDAO;

public class AdminPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int MIN_PASSWORD_LENGTH = 8;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        req.getRequestDispatcher("/View/admin/change-password.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        Admin admin = (Admin) req.getSession().getAttribute("admin");
        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
            res.sendRedirect(req.getContextPath() + "/admin/change-password?error=empty");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            res.sendRedirect(req.getContextPath() + "/admin/change-password?error=mismatch");
            return;
        }

        if (newPassword.length() < MIN_PASSWORD_LENGTH || newPassword.equals(currentPassword)
                || "admin123".equals(newPassword)) {
            res.sendRedirect(req.getContextPath() + "/admin/change-password?error=weak");
            return;
        }

        try {
            boolean changed = new AdminDAO().changePassword(admin.getId(), currentPassword, newPassword);

            if (!changed) {
                res.sendRedirect(req.getContextPath() + "/admin/change-password?error=current");
                return;
            }

            admin.setPassword(newPassword);
            admin.setForcePasswordChange(false);
            req.getSession().setAttribute("admin", admin);
            res.sendRedirect(req.getContextPath() + "/admin/dashboard?passwordChanged=1");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/admin/change-password?error=server");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
