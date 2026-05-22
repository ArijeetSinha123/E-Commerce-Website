package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.OrderDAO;

public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        try {
            req.setAttribute("orders", new OrderDAO().findAll());
            req.getRequestDispatcher("/View/admin/orders.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load orders.");
            req.getRequestDispatcher("/View/admin/orders.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");

            if (!OrderDAO.isValidStatus(status)) {
                res.sendRedirect(req.getContextPath() + "/admin/orders?invalidStatus=1");
                return;
            }

            new OrderDAO().updateStatus(orderId, status);
            res.sendRedirect(req.getContextPath() + "/admin/orders?updated=1");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/admin/orders?error=1");
        }
    }
}
