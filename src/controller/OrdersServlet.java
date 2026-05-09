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
            req.setAttribute("error", "Unable to load orders right now.");
            req.getRequestDispatcher("/View/orders.jsp").forward(req, res);
        }
    }
}
