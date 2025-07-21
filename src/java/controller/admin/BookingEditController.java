/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.BookingsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import model.Bookings;

/**
 *
 * @author admin
 */
public class BookingEditController extends HttpServlet {
 private BookingsDAO bookingDAO = new BookingsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));

        // Lấy dữ liệu cần thiết
        Bookings booking = bookingDAO.getBookingAdminbyId(bookingId);
        String email = bookingDAO.getCustomerEmailByBookingId(bookingId);
        List<Map<String, Object>> services = bookingDAO.getServiceDetailsForBooking(bookingId);

        request.setAttribute("booking", booking);
        request.setAttribute("email", email);
        request.setAttribute("services", services);

        request.getRequestDispatcher("/view/admin/edit-booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String bookingStatus = request.getParameter("bookingStatus");
        String paymentStatus = request.getParameter("paymentStatus");

        bookingDAO.updateBookingStatus(bookingId, bookingStatus, paymentStatus);

        response.sendRedirect(request.getContextPath() + "/bookingadmin");
    }
}
