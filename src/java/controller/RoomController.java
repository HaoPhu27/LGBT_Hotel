/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.RoomDAO;
import jakarta.servlet.RequestDispatcher;
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
import model.Rooms;

/**
 *
 * @author admin
 */
@WebServlet("/rooms")
public class RoomController extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() {
        // Ở đây giả sử bạn khởi tạo DAO trực tiếp.
        // Thực tế có thể lấy DataSource từ context hoặc DI framework (Spring, CDI, …).
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Rooms> rooms = null; // Ghi log chi tiết và đẩy ra trang lỗi tùy ý
        try {
            rooms = roomDAO.getAllRooms(); // gọi phương thức bạn đã có
        } catch (SQLException ex) {
            Logger.getLogger(RoomController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("rooms", rooms);          // gán vào request
        RequestDispatcher rd = request.getRequestDispatcher("/view/hotel/rooms.jsp");
        rd.forward(request, response);                 // chuyển tiếp tới view
    }

    // Nếu sau này cần đặt phòng, lọc phòng, … bạn có thể override doPost/doPut
}
