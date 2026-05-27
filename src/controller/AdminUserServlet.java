package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.dao.UserDAO;

public class AdminUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        UserDAO dao = new UserDAO();
        String action = req.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = parseInt(req.getParameter("id"), 0);
                User user = dao.findById(id);

                if (user == null) {
                    res.sendRedirect(req.getContextPath() + "/admin/users?notFound=1");
                    return;
                }

                req.setAttribute("userToEdit", user);
                req.getRequestDispatcher("/View/admin/user-form.jsp").forward(req, res);
                return;
            }

            req.setAttribute("users", dao.findAll());
            req.getRequestDispatcher("/View/admin/users.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load users.");
            req.getRequestDispatcher("/View/admin/users.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        UserDAO dao = new UserDAO();
        String action = req.getParameter("action");

        try {
            if ("delete".equals(action)) {
                int id = parseInt(req.getParameter("id"), 0);

                if (dao.hasActiveOrders(id)) {
                    res.sendRedirect(req.getContextPath() + "/admin/users?deleteBlocked=1");
                    return;
                }

                if (dao.delete(id)) {
                    res.sendRedirect(req.getContextPath() + "/admin/users?deleted=1");
                } else {
                    res.sendRedirect(req.getContextPath() + "/admin/users?notFound=1");
                }
                return;
            }

            if ("update".equals(action)) {
                User user = readUser(req);

                if (user.getId() <= 0) {
                    res.sendRedirect(req.getContextPath() + "/admin/users?validationError=1");
                    return;
                }

                if (dao.update(user)) {
                    res.sendRedirect(req.getContextPath() + "/admin/users?updated=1");
                } else {
                    res.sendRedirect(req.getContextPath() + "/admin/users?duplicateEmail=1");
                }
                return;
            }

            res.sendRedirect(req.getContextPath() + "/admin/users?error=1");
        } catch (IllegalArgumentException e) {
            res.sendRedirect(req.getContextPath() + "/admin/users?validationError=1");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/admin/users?error=1");
        }
    }

    private User readUser(HttpServletRequest req) {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (isBlank(name) || isBlank(email) || isBlank(password)) {
            throw new IllegalArgumentException("Invalid user details.");
        }

        User user = new User();
        user.setId(parseInt(req.getParameter("id"), 0));
        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        return user;
    }

    private int parseInt(String value, int fallback) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return fallback;
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
