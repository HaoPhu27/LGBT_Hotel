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
        Users user = (Users) request.getAttribute("userLogin"); // lấy từ Filter

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("username", user.getName());

            // Điều hướng theo role
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/DashboardController");
                    break;
                case "customer":
                default:
                    response.sendRedirect(request.getContextPath() + "/home");
                    break;
            }
        } else {
            // Không cần xử lý vì filter đã forward nếu login sai
        }
    }
}
