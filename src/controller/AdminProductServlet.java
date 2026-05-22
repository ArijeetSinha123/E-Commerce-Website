package controller;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.dao.ProductDAO;

public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        ProductDAO dao = new ProductDAO();
        String action = req.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = parseInt(req.getParameter("id"), 0);
                req.setAttribute("product", dao.findById(id));
                req.getRequestDispatcher("/View/admin/product-form.jsp").forward(req, res);
                return;
            }

            if ("new".equals(action)) {
                req.getRequestDispatcher("/View/admin/product-form.jsp").forward(req, res);
                return;
            }

            req.setAttribute("products", dao.findAll(null));
            req.getRequestDispatcher("/View/admin/products.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load admin products.");
            req.getRequestDispatcher("/View/admin/products.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!AdminAuth.requireAdmin(req, res)) {
            return;
        }

        ProductDAO dao = new ProductDAO();
        String action = req.getParameter("action");

        try {
            if ("delete".equals(action)) {
                int id = parseInt(req.getParameter("id"), 0);

                if (dao.existsInOrders(id)) {
                    res.sendRedirect(req.getContextPath() + "/admin/products?deleteBlocked=1");
                    return;
                }

                if (dao.delete(id)) {
                    res.sendRedirect(req.getContextPath() + "/admin/products?deleted=1");
                } else {
                    res.sendRedirect(req.getContextPath() + "/admin/products?error=1");
                }
                return;
            }

            Product product = readProduct(req);
            if ("update".equals(action)) {
                dao.update(product);
                res.sendRedirect(req.getContextPath() + "/admin/products?updated=1");
            } else {
                dao.save(product);
                res.sendRedirect(req.getContextPath() + "/admin/products?created=1");
            }
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/admin/products?error=1");
        }
    }

    private Product readProduct(HttpServletRequest req) {
        Product product = new Product();
        product.setId(parseInt(req.getParameter("id"), 0));
        product.setName(req.getParameter("name"));
        product.setDescription(req.getParameter("description"));
        product.setPrice(new BigDecimal(req.getParameter("price")));
        product.setStock(parseInt(req.getParameter("stock"), 0));
        product.setImageUrl(req.getParameter("imageUrl"));
        return product;
    }

    private int parseInt(String value, int fallback) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return fallback;
        }
    }
}
