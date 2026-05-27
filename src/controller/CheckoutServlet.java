package controller;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.User;
import model.dao.OrderDAO;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (req.getSession().getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=login_required");
            return;
        }

        req.getRequestDispatcher("/View/checkout.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/View/login.jsp?error=login_required");
            return;
        }

        Map<Integer, CartItem> cart = CartController.getCart(session);
        if (cart.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/cart?error=empty");
            return;
        }

        try {
            int orderId = new OrderDAO().createOrder(user.getId(), cart);
            cart.clear();
            res.sendRedirect(req.getContextPath() + "/orders?placed=" + orderId);
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/checkout?error=1");
        }
    }
}
