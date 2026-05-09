package controller;

import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Admin;

public final class AdminAuth {
    private AdminAuth() {
    }

    public static boolean requireAdmin(HttpServletRequest req, HttpServletResponse res) throws IOException {
        Admin admin = (Admin) req.getSession().getAttribute("admin");

        if (admin == null) {
            res.sendRedirect(req.getContextPath() + "/View/admin/login.jsp?error=login_required");
            return false;
        }

        return true;
    }
}
