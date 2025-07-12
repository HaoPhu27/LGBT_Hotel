/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.UUID;
import model.Users;
import service.MailService;

/**
 *
 * @author admin
 */
@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        UserDAO dao = new UserDAO();
        Users user = dao.getUserByEmail(email);

        if (user != null) {
            try {
                String otp = String.valueOf((int) (Math.random() * 900000) + 100000);

                HttpSession session = request.getSession();
                session.setAttribute("resetOtp", otp);
                session.setAttribute("resetUserId", user.getUserId());

                String content = "<p>Mã xác nhận khôi phục mật khẩu của bạn là:</p>" +
                                 "<h2 style='color:#4f46e5;'>" + otp + "</h2>" +
                                 "<p>Vui lòng nhập mã này để tiếp tục.</p>";
                MailService.send(email, "Mã xác nhận đặt lại mật khẩu", content);

                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true}");

            } catch (Exception e) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Gửi email thất bại.\"}");
            }

        } else {
            // ✅ Trả JSON thay vì HTML lỗi 404
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"Email không tồn tại.\"}");
        }
    }
}

