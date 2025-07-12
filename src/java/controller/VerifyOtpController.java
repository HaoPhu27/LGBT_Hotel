package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verify-otp")
public class VerifyOtpController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String userInput = request.getParameter("otp");
        HttpSession session = request.getSession(false);

        String otp = (String) session.getAttribute("resetOtp");
        Integer userId = (Integer) session.getAttribute("resetUserId");

        // Debug nếu cần
        System.out.println("OTP session: " + otp);
        System.out.println("OTP người dùng nhập: " + userInput);

        if (otp != null && otp.equals(userInput)) {
            session.setAttribute("otpVerified", true);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true}");
        } else {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            response.getWriter().write("{\"error\":\"Mã OTP không đúng\"}");
        }
    }
}
