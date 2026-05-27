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
                if (product.getId() <= 0) {
                    res.sendRedirect(req.getContextPath() + "/admin/products?validationError=1");
                    return;
                }
                if (dao.update(product)) {
                    res.sendRedirect(req.getContextPath() + "/admin/products?updated=1");
                } else {
                    res.sendRedirect(req.getContextPath() + "/admin/products?notFound=1");
                }
            } else {
                if (dao.save(product)) {
                    res.sendRedirect(req.getContextPath() + "/admin/products?created=1");
                } else {
                    res.sendRedirect(req.getContextPath() + "/admin/products?error=1");
                }
            }
        } catch (IllegalArgumentException e) {
            res.sendRedirect(req.getContextPath() + "/admin/products?validationError=1");
        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/admin/products?error=1");
        }
    }

    private Product readProduct(HttpServletRequest req) {
        Product product = new Product();
        String name = req.getParameter("name");
        String category = req.getParameter("category");
        BigDecimal price = parsePrice(req.getParameter("price"));
        int stock = parseInt(req.getParameter("stock"), -1);

        if (isBlank(name) || isBlank(category) || price.compareTo(BigDecimal.ZERO) < 0 || stock < 0) {
            throw new IllegalArgumentException("Invalid product details.");
        }

        product.setId(parseInt(req.getParameter("id"), 0));
        product.setName(name.trim());
        product.setDescription(req.getParameter("description"));
        product.setPrice(price);
        product.setStock(stock);
        product.setImageUrl(req.getParameter("imageUrl"));
        product.setCategory(category.trim());
        return product;
    }

    private BigDecimal parsePrice(String value) {
        try {
            return new BigDecimal(value);
        } catch (Exception e) {
            throw new IllegalArgumentException("Invalid product price.");
        }
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
