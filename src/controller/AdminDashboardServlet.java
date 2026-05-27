package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.OrderDAO;
import model.dao.ProductDAO;
import model.dao.UserDAO;

public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        try {
            req.setAttribute("productCount", new ProductDAO().countProducts());
            req.setAttribute("orderCount", new OrderDAO().countOrders());
            req.setAttribute("userCount", new UserDAO().countUsers());
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load dashboard stats.");
        }

        req.getRequestDispatcher("/View/admin/dashboard.jsp").forward(req, res);
    }
}
