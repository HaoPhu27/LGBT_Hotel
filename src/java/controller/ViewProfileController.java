/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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
@WebServlet("/profile")
public class ViewProfileController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login"); // Hoặc login.jsp nếu cần
            return;
        }
        request.getRequestDispatcher("view/hotel/profile.jsp").forward(request, response);
    }
}

