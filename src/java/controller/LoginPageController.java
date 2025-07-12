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
        // Hiển thị form đăng nhập
        request.getRequestDispatcher("/view/hotel/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        UserDAO dao = new UserDAO();
        Users user = dao.login(email, password);
        if (user != null) {
            // Đăng nhập thành công – lưu thông tin vào session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("username", user.getName());

            // Chuyển hướng theo vai trò
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/DashboardController");
                    break;
                case "staff":
                    response.sendRedirect(request.getContextPath() + "/staff/home");
                    break;
                case "customer":
                default:
                    response.sendRedirect(request.getContextPath() + "/home");
                    break;
            }

        } else {
            // Sai thông tin đăng nhập – quay lại login.jsp
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/hotel/login.jsp").forward(request, response);
        }
    }
}
