/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RoomDAO;
import java.sql.SQLException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import model.Rooms;

/**
 *
 * @author admin
 */
@WebServlet("/searchRoom")
public class SearchRoomController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("search");
        String minStr = req.getParameter("minPrice");
        String maxStr = req.getParameter("maxPrice");
        String status = req.getParameter("status");
        String type = req.getParameter("type");
        String sort = req.getParameter("sort");

        BigDecimal min = null, max = null;
        try {
            if (minStr != null && !minStr.isEmpty()) {
                min = new BigDecimal(minStr);
            }
            if (maxStr != null && !maxStr.isEmpty()) {
                max = new BigDecimal(maxStr);
            }
        } catch (NumberFormatException ignored) {
        }
        int page = 1;
        int limit = 6; // phòng mỗi trang
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception e) {
        }

        int offset = (page - 1) * limit;

        try {
            RoomDAO dao = new RoomDAO();
            List<Rooms> rooms = dao.searchRoomsPaginated(keyword, min, max, status, type, sort, offset, limit);
            int total = dao.countSearchRooms(keyword, min, max, status, type);
            int totalPages = (int) Math.ceil((double) total / limit);

            req.setAttribute("rooms", rooms);

            // Truyền lại các giá trị để giữ form
            req.setAttribute("keyword", keyword);
            req.setAttribute("minPrice", minStr);
            req.setAttribute("maxPrice", maxStr);
            req.setAttribute("status", status);
            req.setAttribute("type", type);
            req.setAttribute("sort", sort);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentPage", page);
            req.getRequestDispatcher("/view/hotel/rooms.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Lỗi khi tìm kiếm phòng.");
            req.getRequestDispatcher("/view/hotel/rooms.jsp").forward(req, resp);
        }
    }
}
