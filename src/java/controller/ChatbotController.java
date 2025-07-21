package controller;

import Service.ChatbotService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class ChatbotController extends HttpServlet {

    private final ChatbotService chatService = new ChatbotService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<String[]> history = (List<String[]>) session.getAttribute("history");

        if (history == null) {
            history = new ArrayList<>();
            session.setAttribute("history", history);
        }

        request.setAttribute("history", history);
        request.getRequestDispatcher("/view/hotel/chatbot.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");

        String userMessage = request.getParameter("message");
        String botReply = chatService.chatWithGemini(userMessage);

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<String[]> history = (List<String[]>) session.getAttribute("history");

        if (history == null) {
            history = new ArrayList<>();
        }

        history.add(new String[]{userMessage, botReply});
        session.setAttribute("history", history);

        response.getWriter().write(botReply);
    }
}
