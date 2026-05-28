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

        if (admin.isForcePasswordChange() && !isPasswordChangeRequest(req)) {
            res.sendRedirect(req.getContextPath() + "/admin/change-password?required=1");
            return false;
        }

        return true;
    }

    private static boolean isPasswordChangeRequest(HttpServletRequest req) {
        String path = req.getRequestURI().substring(req.getContextPath().length());
        return path.equals("/admin/change-password") || path.equals("/admin/logout");
    }
}
