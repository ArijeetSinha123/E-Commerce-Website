package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.dao.OrderDAO;

public class OrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=login_required");
            return;
        }

        try {
            req.setAttribute("orders", new OrderDAO().findByUserId(user.getId()));
            req.getRequestDispatcher("/View/orders.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load orders.");
            req.getRequestDispatcher("/View/orders.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=login_required");
            return;
        }

        String action = req.getParameter("action");
        if (!"cancel".equals(action)) {
            res.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            boolean cancelled = new OrderDAO().cancelByUser(orderId, user.getId());

            if (cancelled) {
                res.sendRedirect(req.getContextPath() + "/orders?cancelled=1");
            } else {
                res.sendRedirect(req.getContextPath() + "/orders?cancelError=1");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/orders?cancelError=1");
        }
    }
}
