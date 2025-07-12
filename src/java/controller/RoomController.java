package controller;

import dao.BookingsDAO;
import dao.RoomDAO;
import dao.ServiceDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Rooms;
import model.Service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/rooms")
public class RoomController extends HttpServlet {

    private RoomDAO roomDAO;
    private ServiceDAO serviceDAO;
    private BookingsDAO bookingsDAO;

    @Override
    public void init() {
        roomDAO = new RoomDAO();
        serviceDAO = new ServiceDAO();
        bookingsDAO = new BookingsDAO(); // ✅ Khai báo đúng biến
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Rooms> rooms = roomDAO.getAllRooms(); // ✅ lấy danh sách phòng
            List<Service> services = serviceDAO.getAllServices(); // ✅ lấy danh sách dịch vụ

            request.setAttribute("rooms", rooms);
            request.setAttribute("services", services);
            Map<Integer, List<String>> roomBookedDatesMap = new HashMap<>();
            for (Rooms room : rooms) {
                List<String> dates = bookingsDAO.getBookedDatesByRoomId(room.getRoomId());
                roomBookedDatesMap.put(room.getRoomId(), dates);
            }
            request.setAttribute("roomBookedDatesMap", roomBookedDatesMap);
        } catch (SQLException ex) {
            Logger.getLogger(RoomController.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Không thể tải danh sách phòng hoặc dịch vụ.");
        }

        RequestDispatcher rd = request.getRequestDispatcher("/view/hotel/rooms.jsp");
        rd.forward(request, response);
    }
}
