package controller;

import java.io.IOException;

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
            req.setAttribute("products", new ProductDAO().findAll(req.getParameter("q")));
            req.setAttribute("search", req.getParameter("q"));
            req.getRequestDispatcher("/View/products.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load products.");
            req.getRequestDispatcher("/View/products.jsp").forward(req, res);
        }
    }
}
