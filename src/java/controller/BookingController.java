/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingsDAO;
import dao.BookingServiceDAO;
import dao.PaymentDAO;
import dao.RoomDAO;
import dao.ServiceDAO;

import model.Bookings;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import model.Payment;
import model.Rooms;

/**
 *
 * @author admin
 */
@WebServlet("/book")
public class BookingController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Users user = (Users) (session != null ? session.getAttribute("user") : null);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int customerId = user.getUserId();
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));
            String paymentStatus = request.getParameter("paymentStatus");

            BookingsDAO bookingsDAO = new BookingsDAO();
            RoomDAO roomDAO = new RoomDAO();
            ServiceDAO serviceDAO = new ServiceDAO(); // ✅ Thêm dòng này
            
            Rooms room = roomDAO.getRoomById(roomId);
            BigDecimal roomPrice = room.getPrice();

            // Kiểm tra trùng lịch
            if (bookingsDAO.isRoomBookedInRange(roomId, checkIn, checkOut)) {
                request.setAttribute("error", "Phòng này đã được đặt trong khoang thời gian bạn chọn.");
                request.getRequestDispatcher("/view/hotel/rooms.jsp").forward(request, response);
                return;
            }

            // Tạo đơn đặt phòng
            Bookings booking = new Bookings();
            booking.setCustomerId(customerId);
            booking.setRoomId(roomId);
            booking.setCheckIn(checkIn);
            booking.setCheckOut(checkOut);
            booking.setStatus("booked");
            booking.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

            int bookingId = bookingsDAO.createBookingReturnId(booking);
            roomDAO.updateRoomStatus(roomId, "booked");
            // Dịch vụ thêm
            String[] serviceIds = request.getParameterValues("serviceIds");
            if (serviceIds != null && bookingId > 0) {
                BookingServiceDAO bsDAO = new BookingServiceDAO();
                for (String sid : serviceIds) {
                    int serviceId = Integer.parseInt(sid);
                    bsDAO.insertServiceForBooking(bookingId, serviceId, 1);
                }
            }

            // Tính tổng tiền
            long millis = checkOut.getTime() - checkIn.getTime();
            int nights = (int) TimeUnit.MILLISECONDS.toDays(millis);
            BigDecimal total = roomPrice.multiply(BigDecimal.valueOf(nights));

            if (serviceIds != null) {
                for (String sid : serviceIds) {
                    int serviceId = Integer.parseInt(sid);
                    BigDecimal servicePrice = serviceDAO.getPriceById(serviceId);
                    total = total.add(servicePrice);
                }
            }

            // Thêm vào bảng thanh toán
            PaymentDAO paymentDAO = new PaymentDAO();
            Payment payment = new Payment(bookingId, total, "cash", null, paymentStatus);
            paymentDAO.insertPayment(payment);

            response.sendRedirect(request.getContextPath() + "/my-bookings");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đặt phòng thất bại.");
            request.getRequestDispatcher("/rooms").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
