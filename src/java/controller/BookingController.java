package controller;

import dao.BookingsDAO;
import dao.RoomDAO;
import model.Bookings;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/book")
public class BookingController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Users user = (Users) (session != null ? session.getAttribute("user") : null);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int customerId = user.getUserId();
        LocalDate today = LocalDate.now();

        Bookings booking = new Bookings();
        booking.setCustomerId(customerId);
        booking.setRoomId(roomId);
        booking.setCheckIn(Date.valueOf(today));
        booking.setCheckOut(Date.valueOf(today.plusDays(1)));
        booking.setStatus("booked");

        BookingsDAO dao = new BookingsDAO();
        boolean success = dao.createBooking(booking);

        if (success) {
            new RoomDAO().updateRoomStatus(roomId, "occupied");
            response.sendRedirect(request.getContextPath() + "/my-bookings");
        } else {
            request.setAttribute("error", "Đặt phòng thất bại.");
            request.getRequestDispatcher("/rooms").forward(request, response);
        }
    }
}
