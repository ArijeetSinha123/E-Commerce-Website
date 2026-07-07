package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ChatAssistant;

public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ChatAssistant assistant = new ChatAssistant();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/View/chat.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String message = req.getParameter("message");

        req.setAttribute("message", message);
        req.setAttribute("reply", assistant.replyTo(message));
        req.getRequestDispatcher("/View/chat.jsp").forward(req, res);
    }
}
