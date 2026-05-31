package controller;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.ProductDAO;

public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        try {
            BigDecimal minPrice = parsePrice(req.getParameter("minPrice"));
            BigDecimal maxPrice = parsePrice(req.getParameter("maxPrice"));

            req.setAttribute("products", new ProductDAO().findAll(
                    req.getParameter("q"),
                    req.getParameter("category"),
                    minPrice,
                    maxPrice,
                    req.getParameter("stock"),
                    req.getParameter("sort")));
            req.setAttribute("search", req.getParameter("q"));
            req.setAttribute("selectedCategory", req.getParameter("category"));
            req.setAttribute("minPrice", req.getParameter("minPrice"));
            req.setAttribute("maxPrice", req.getParameter("maxPrice"));
            req.setAttribute("stock", req.getParameter("stock"));
            req.setAttribute("sort", req.getParameter("sort"));
            req.getRequestDispatcher("/View/products.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load products.");
            req.getRequestDispatcher("/View/products.jsp").forward(req, res);
        }
    }

    private BigDecimal parsePrice(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            BigDecimal price = new BigDecimal(value.trim());
            return price.compareTo(BigDecimal.ZERO) >= 0 ? price : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
