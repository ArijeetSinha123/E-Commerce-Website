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
        Map<Integer, CartItem> cart = getCart(req.getSession());

        try {
            int productId = parseInt(req.getParameter("productId"), 0);

            if ("add".equals(action)) {
                Product product = new ProductDAO().findById(productId);
                if (product != null && product.getStock() > 0) {
                    int quantity = Math.max(1, parseInt(req.getParameter("quantity"), 1));
                    CartItem item = cart.get(productId);

                    if (item == null) {
                        cart.put(productId, new CartItem(product, Math.min(quantity, product.getStock())));
                    } else {
                        item.setQuantity(Math.min(item.getQuantity() + quantity, product.getStock()));
                    }
                }
                res.sendRedirect(req.getContextPath() + "/products?cart=added");
                return;
            }

            if ("update".equals(action)) {
                int quantity = parseInt(req.getParameter("quantity"), 1);
                CartItem item = cart.get(productId);
                if (item != null) {
                    if (quantity <= 0) {
                        cart.remove(productId);
                    } else {
                        item.setQuantity(Math.min(quantity, item.getProduct().getStock()));
                    }
                }
            } else if ("remove".equals(action)) {
                cart.remove(productId);
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

    private int parseInt(String value, int fallback) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return fallback;
        }
    }
}
