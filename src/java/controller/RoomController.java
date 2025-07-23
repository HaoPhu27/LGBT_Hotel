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
import java.math.BigDecimal;
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
        bookingsDAO = new BookingsDAO(); 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Đọc tham số lọc
            String keyword = request.getParameter("search");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String status = request.getParameter("status");
            String type = request.getParameter("type");
            String sort = request.getParameter("sort");

            // Phân trang
            int page = 1;
            int limit = 6; // phòng mỗi trang
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (Exception e) {
            }

            int offset = (page - 1) * limit;

            // Parse giá
            BigDecimal minPrice = (minPriceStr != null && !minPriceStr.isEmpty())
                    ? new BigDecimal(minPriceStr) : null;
            BigDecimal maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty())
                    ? new BigDecimal(maxPriceStr) : null;

            // Gọi DAO
            List<Rooms> rooms = roomDAO.searchRoomsPaginated(keyword, minPrice, maxPrice, status, type, sort, offset, limit);
            int total = roomDAO.countSearchRooms(keyword, minPrice, maxPrice, status, type);
            int totalPages = (int) Math.ceil((double) total / limit);

            // Gọi các dữ liệu còn lại
            List<Service> services = serviceDAO.getAllServices();
            Map<Integer, List<String>> roomBookedDatesMap = new HashMap<>();
            for (Rooms room : rooms) {
                List<String> dates = bookingsDAO.getBookedDatesByRoomId(room.getRoomId());
                roomBookedDatesMap.put(room.getRoomId(), dates);
            }

            // Đẩy lên view
            request.setAttribute("rooms", rooms);
            request.setAttribute("services", services);
            request.setAttribute("roomBookedDatesMap", roomBookedDatesMap);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            // Đẩy lại các tham số lọc để giữ nguyên
            request.setAttribute("keyword", keyword);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
            request.setAttribute("status", status);
            request.setAttribute("type", type);
            request.setAttribute("sort", sort);

        } catch (SQLException ex) {
            Logger.getLogger(RoomController.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Không thể tải danh sách phòng hoặc dịch vụ.");
        }

        RequestDispatcher rd = request.getRequestDispatcher("/view/hotel/rooms.jsp");
        rd.forward(request, response);
    }

}
