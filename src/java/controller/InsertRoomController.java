package controller;

import dao.RoomDAO;
import model.Rooms;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.math.BigDecimal;
import java.nio.file.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "RoomController", urlPatterns = {"/RoomController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class InsertRoomController extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/images/rooms";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 1. Nhận dữ liệu từ form
        String roomNumber = req.getParameter("roomCode");
        String type       = req.getParameter("roomType");
        BigDecimal price  = new BigDecimal(req.getParameter("roomPrice"));
        String note       = req.getParameter("roomDescription");

        // 2. Upload ảnh
        Part filePart = req.getPart("roomImage"); // <input name="roomImage">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        Files.createDirectories(Paths.get(uploadPath)); // Tạo folder nếu chưa có

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Đường dẫn ảnh dùng trong HTML
        String imageUrl = req.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;

        // 3. Tạo đối tượng Room và lưu DB
        Rooms room = new Rooms();
        room.setRoomNumber(roomNumber);
        room.setType(type);
        room.setPrice(price);
        room.setStatus("empty");
        room.setNote(note);
        room.setImageUrl(imageUrl);

        // Gọi DAO
        RoomDAO dao = new RoomDAO();
        try {
            dao.insertRoom(room);  // nhớ phương thức phải tên insertRoom như mình đã gợi ý
        } catch (SQLException ex) {
            Logger.getLogger(InsertRoomController.class.getName()).log(Level.SEVERE, null, ex);
        }

        // 4. Redirect
        resp.sendRedirect(req.getContextPath() + "/view/admin/dashboard.jsp");
    }
}
