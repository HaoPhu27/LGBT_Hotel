package controller;

import dao.RoomDAO;
import model.Rooms;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class AvailableRoomsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        RoomDAO dao = new RoomDAO();
        List<Rooms> availableRooms = dao.getAvailableRooms();
        request.setAttribute("rooms", availableRooms);
        request.getRequestDispatcher("/view/hotel/available-rooms.jsp").forward(request, response);
    }
}
