package controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;
import model.dao.ProductDAO;

public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/View/cart.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = getCart(session);

        try {
            if ("add".equals(action)) {
                addItem(req, cart);
                res.sendRedirect(req.getContextPath() + "/products?cart=added");
                return;
            }

            if ("update".equals(action)) {
                updateItem(req, cart);
            } else if ("remove".equals(action)) {
                removeItem(req, cart);
            } else if ("clear".equals(action)) {
                cart.clear();
            }

            res.sendRedirect(req.getContextPath() + "/cart");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/cart?error=1");
        }
    }

    @SuppressWarnings("unchecked")
    public static Map<Integer, CartItem> getCart(HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void addItem(HttpServletRequest req, Map<Integer, CartItem> cart) throws Exception {
        int productId = parseInt(req.getParameter("productId"), 0);
        int quantity = Math.max(1, parseInt(req.getParameter("quantity"), 1));

        Product product = new ProductDAO().findById(productId);
        if (product == null || product.getStock() <= 0) {
            return;
        }

        int finalQuantity = Math.min(quantity, product.getStock());
        CartItem existing = cart.get(productId);
        if (existing == null) {
            cart.put(productId, new CartItem(product, finalQuantity));
        } else {
            existing.setQuantity(Math.min(existing.getQuantity() + finalQuantity, product.getStock()));
        }
    }

    private void updateItem(HttpServletRequest req, Map<Integer, CartItem> cart) {
        int productId = parseInt(req.getParameter("productId"), 0);
        int quantity = parseInt(req.getParameter("quantity"), 1);

        CartItem item = cart.get(productId);
        if (item == null) {
            return;
        }

        if (quantity <= 0) {
            cart.remove(productId);
        } else {
            item.setQuantity(Math.min(quantity, item.getProduct().getStock()));
        }
    }

    private void removeItem(HttpServletRequest req, Map<Integer, CartItem> cart) {
        int productId = parseInt(req.getParameter("productId"), 0);
        cart.remove(productId);
    }

    private int parseInt(String value, int fallback) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return fallback;
        }
    }
}
