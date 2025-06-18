package controller;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class InsertController extends HttpServlet {

    // ✅ Regex kiểm tra mật khẩu: 8-14 ký tự, 1 hoa, 1 số, 1 đặc biệt
    private boolean isValidPassword(String password) {
        String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,14}$";
        return password != null && password.matches(regex);
    }

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
        String confirmPassword = request.getParameter("confirmPassword");

        // ✅ Kiểm tra xác nhận mật khẩu
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/view/hotel/register.jsp").forward(request, response);
            return;
        }

        // ✅ Kiểm tra độ mạnh mật khẩu
        if (!isValidPassword(password)) {
            request.setAttribute("error", "Mật khẩu phải dài 8-14 ký tự, có chữ hoa, số và ký tự đặc biệt.");
            request.getRequestDispatcher("/view/hotel/register.jsp").forward(request, response);
            return;
        }

        // ✅ Tạo đối tượng user
        Users user = new Users();
        user.setName(name);
        user.setGender(gender);
        user.setPhone(phone);
        user.setEmail(email);
        user.setAddress(address);
        user.setIdNumber(idNumber);
        user.setPassword(password); // Sẽ được mã hóa trong DAO
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
