/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Filter;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.regex.*;

/**
 *
 * @author admin
 */
public class RegisterValidationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Chỉ kiểm tra khi method là POST
        if ("POST".equalsIgnoreCase(req.getMethod())) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");
            boolean isEmailValid = email != null && email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
            boolean isPasswordValid = password != null
                    && password.length() >= 8 && password.length() <= 14
                    && password.matches(".*[A-Z].*")
                    && password.matches(".*\\d.*")
                    && password.matches(".*[!@#$%^&*()].*");
             boolean isPasswordMatch = password != null && password.equals(confirmPassword);

            UserDAO dao = new UserDAO();
            boolean isEmailExist = dao.getUserByEmail(email) != null;

            // Gửi lỗi về register.jsp nếu có lỗi
            if (!isEmailValid || !isPasswordValid || isEmailExist) {
                req.setAttribute("emailValid", isEmailValid);
                req.setAttribute("passwordValid", isPasswordValid);
                req.setAttribute("emailExist", isEmailExist);
                req.setAttribute("passwordMatch", isPasswordMatch);
                req.getRequestDispatcher("/view/hotel/register.jsp").forward(req, res);
                return;
            }
        }

        // Nếu hợp lệ hoặc là GET thì cho đi tiếp
        chain.doFilter(request, response);
    }
}
