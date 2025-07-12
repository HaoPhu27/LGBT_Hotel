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
import model.Users;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author admin
 */
@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Boolean verified = (Boolean) session.getAttribute("otpVerified");
        Integer userId = (Integer) session.getAttribute("resetUserId");

        if (verified == null || !verified || userId == null) {
            response.sendRedirect(request.getContextPath() + "/login"); // ✅ đường dẫn bạn mong muốn
            return;
        }

        String newPassword = request.getParameter("newPassword");

        // ✅ Kiểm tra độ mạnh của mật khẩu
        if (!newPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$")) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
            return;
        }

        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        UserDAO dao = new UserDAO();
        dao.updatePassword(userId, hashedPassword);

        // Xoá session liên quan
        session.removeAttribute("otpVerified");
        session.removeAttribute("resetUserId");
        session.removeAttribute("resetOtp");

        response.sendRedirect(request.getContextPath() + "/login?reset=success"); // ✅ thành công, về login
    }
}
