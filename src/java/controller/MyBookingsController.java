package controller;

import dao.BookingsDAO;
import model.Bookings;
import model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-bookings")
public class MyBookingsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        BookingsDAO dao = new BookingsDAO();
        List<Bookings> list = dao.getBookingsByCustomer(user.getUserId());
        request.setAttribute("bookings", list);

        request.getRequestDispatcher("/view/hotel/my-bookings.jsp").forward(request, response);
    }
}
