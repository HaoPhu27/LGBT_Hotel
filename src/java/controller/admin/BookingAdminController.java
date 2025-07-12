/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.BookingsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bookings;

/**
 *
 * @author admin
 */
@WebServlet(name = "BookingAdminController", urlPatterns = {"/bookingadmin"})
public class BookingAdminController extends HttpServlet {

    private BookingsDAO bookingsDAO;

    @Override
    public void init() {
        bookingsDAO = new BookingsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Bookings> bookings = bookingsDAO.getAllBookings();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/view/admin/bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String status = request.getParameter("status");

            bookingsDAO.updateBookingStatus(bookingId, status);
            response.sendRedirect(request.getContextPath() + "/bookingadmin");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
