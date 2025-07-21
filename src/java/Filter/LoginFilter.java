/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Filter;

import dao.UserDAO;
import model.Users;
import jakarta.servlet.*;

import jakarta.servlet.http.*;

import java.io.IOException;

/**
 *
 * @author admin
 */

public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        if ("POST".equalsIgnoreCase(req.getMethod()) && req.getRequestURI().endsWith("/login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            UserDAO dao = new UserDAO();
            Users user = dao.login(email, password); 

            if (user == null) {
                req.setAttribute("error", "Email hoặc mật khẩu không đúng");
                req.getRequestDispatcher("/view/hotel/login.jsp").forward(req, res);
                return;
            }

            req.setAttribute("userLogin", user);
        }

        chain.doFilter(request, response);
    }
}
