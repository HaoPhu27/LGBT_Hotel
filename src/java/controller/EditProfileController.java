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
import model.Users;

/**
 *
 * @author admin
 */
@WebServlet("/edit-profile")
public class EditProfileController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String newPhone = request.getParameter("phone");
        String newAddress = request.getParameter("address");

        // Cập nhật trong DB
        UserDAO userDAO = new UserDAO();
        boolean updated = userDAO.updatePhoneAndAddress(user.getUserId(), newPhone, newAddress);

        if (updated) {
            // Cập nhật session
            user.setPhone(newPhone);
            user.setAddress(newAddress);
            request.getSession().setAttribute("user", user);
        }

        response.sendRedirect("profile");
    }
}
