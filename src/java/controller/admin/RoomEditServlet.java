package controller.admin;

import dao.RoomDAO;
import model.Rooms;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import jakarta.servlet.annotation.MultipartConfig;

@MultipartConfig
public class RoomEditServlet extends HttpServlet {

    RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println(">> Bắt đầu EditRoomServlet");
            int roomId = Integer.parseInt(request.getParameter("id"));
            System.out.println(">> roomId: " + roomId);
            Rooms room = roomDAO.getRoomById(roomId);
            if (room == null) {
                System.out.println(">> Không tìm thấy phòng");
            } else {
                System.out.println(">> Tìm thấy phòng: " + room.getRoomNumber());
            }

            request.setAttribute("room", room);
            request.getRequestDispatcher("/view/admin/edit-room.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();  
            response.sendRedirect("rooms");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String roomNumber = request.getParameter("roomNumber");
            String type = request.getParameter("type");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String status = request.getParameter("status");
            String note = request.getParameter("note");

            // ✅ Check trùng số phòng (trừ chính nó)
            if (roomDAO.isRoomNumberExistsExcept(roomNumber, roomId)) {
                request.setAttribute("room", roomDAO.getRoomById(roomId)); // để hiển thị lại form
                request.setAttribute("error", "⚠️ Số phòng đã tồn tại, vui lòng nhập số phong khác.");
                request.getRequestDispatcher("/view/admin/edit-room.jsp").forward(request, response);
                return;
            }

            Part filePart = request.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = getServletContext().getRealPath("/") + "assets/images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            if (fileName != null && !fileName.isEmpty()) {
                filePart.write(uploadPath + File.separator + fileName);
            }

            Rooms room = new Rooms();
            room.setRoomId(roomId);
            room.setRoomNumber(roomNumber);
            room.setType(type);
            room.setPrice(price);
            room.setStatus(status);
            room.setNote(note);

            if (fileName != null && !fileName.isEmpty()) {
                room.setImageUrl(fileName);
            } else {
                room.setImageUrl(roomDAO.getRoomById(roomId).getImageUrl());
            }

            boolean success = roomDAO.updateRoom(room);
            response.sendRedirect(request.getContextPath() + "/roomadmin");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/roomadmin");
        }
    }

}
