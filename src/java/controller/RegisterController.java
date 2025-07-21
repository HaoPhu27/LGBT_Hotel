package controller;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/hotel/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String idNumber = request.getParameter("idNumber");
        String password = request.getParameter("password");

        // ✅ Tạo đối tượng user
        Users user = new Users();
        user.setName(name);
        user.setGender(gender);
        user.setPhone(phone);
        user.setEmail(email);
        user.setAddress(address);
        user.setIdNumber(idNumber);
        user.setPassword(password); // Sẽ được mã hóa trong DAO nếu có
        user.setRole("customer");

        // ✅ Gọi DAO để xử lý đăng ký
        UserDAO dao = new UserDAO();
        boolean success = dao.register(user);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/register?success=1");
        } else {
            request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/view/hotel/register.jsp").forward(request, response);
        }
    }
}
