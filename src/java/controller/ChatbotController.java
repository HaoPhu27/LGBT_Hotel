package controller;

import Service.ChatbotService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ChatbotController extends HttpServlet {

    private final ChatbotService chatService = new ChatbotService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/hotel/chatbot.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String userMessage = request.getParameter("message");
        String botReply = null;
        try {
            botReply = chatService.chatWithGemini(userMessage != null ? userMessage : "");
        } catch (SQLException ex) {
            Logger.getLogger(ChatbotController.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Gửi về JSON
        String json = "{\"response\": " + escapeJson(botReply) + "}";
        try (PrintWriter out = response.getWriter()) {
            out.print(json);
        }
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "\"\"";
        }
        return "\"" + s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "") + "\"";
    }
}
