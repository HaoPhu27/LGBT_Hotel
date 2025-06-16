package controller;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // ✅ Lấy cookie nếu có và gửi email xuống login.jsp
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie ck : cookies) {
                if ("rememberedEmail".equals(ck.getName())) {
                    request.setAttribute("rememberedEmail", ck.getValue());
                    break;
                }
            }
        }

        request.getRequestDispatcher("/view/hotel/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        UserDAO dao = new UserDAO();
        Users user = dao.login(email, password);

        if (user != null) {
            // ✅ Đăng nhập thành công – lưu vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // ✅ Ghi nhớ email nếu checkbox được chọn
            if ("on".equals(remember)) {
                Cookie cookie = new Cookie("rememberedEmail", email);
                cookie.setMaxAge(60 * 60 * 24 * 7); // 7 ngày
                response.addCookie(cookie);
            } else {
                // ✅ Xóa cookie nếu không chọn
                Cookie cookie = new Cookie("rememberedEmail", "");
                cookie.setMaxAge(0); // xóa
                response.addCookie(cookie);
            }

            // ✅ Chuyển hướng theo vai trò
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                    break;
                case "staff":
                    response.sendRedirect(request.getContextPath() + "/staff/home.jsp");
                    break;
                case "customer":
                default:
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                    break;
            }

        } else {
            // ❌ Sai thông tin – quay lại login.jsp
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/hotel/login.jsp").forward(request, response);
        }
    }
}
