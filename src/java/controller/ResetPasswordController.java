package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
      
        Integer userId = (Integer) session.getAttribute("resetUserId");
        String newPassword = request.getParameter("newPassword");

        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        UserDAO dao = new UserDAO();
        dao.updatePassword(userId, hashedPassword);

        session.removeAttribute("otpVerified");
        session.removeAttribute("resetUserId");
        session.removeAttribute("resetOtp");

        response.sendRedirect(request.getContextPath() + "/login?reset=success");
    }
}
