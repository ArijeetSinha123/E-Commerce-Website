package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        res.sendRedirect(req.getContextPath() + "/index.jsp?logout=success");
    }
}
