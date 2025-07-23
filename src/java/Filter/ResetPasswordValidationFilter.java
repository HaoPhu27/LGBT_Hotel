package Filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Filter dùng để kiểm tra:
 * - Session có xác thực OTP chưa
 * - Mật khẩu mới có hợp lệ không (nếu cần)
 */
public class ResetPasswordValidationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        if ("POST".equalsIgnoreCase(req.getMethod())) {
            HttpSession session = req.getSession(false);
            Boolean verified = (Boolean) session.getAttribute("otpVerified");
            Integer userId = (Integer) session.getAttribute("resetUserId");

            if (verified == null || !verified || userId == null) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            String newPassword = req.getParameter("newPassword");

            boolean isPasswordValid = newPassword != null &&
                    newPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$");

            if (!isPasswordValid) {
                req.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
                req.getRequestDispatcher("/view/auth/reset-password.jsp").forward(req, res);
                return;
            }
        }

        // Nếu hợp lệ hoặc là GET thì cho qua
        chain.doFilter(request, response);
    }
}
