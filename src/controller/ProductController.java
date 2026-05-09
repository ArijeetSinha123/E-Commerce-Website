package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.dao.ProductDAO;

public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String search = req.getParameter("q");
            ProductDAO dao = new ProductDAO();
            List<Product> products = dao.findAll(search);

            req.setAttribute("products", products);
            req.setAttribute("search", search);
            req.getRequestDispatcher("/View/products.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load products right now.");
            req.getRequestDispatcher("/View/products.jsp").forward(req, res);
        }
    }
}
