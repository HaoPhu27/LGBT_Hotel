/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Rooms;
import jakarta.servlet.http.Part;
/**
 *
 * @author admin
 */
public class RoomAdminController extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() {
        roomDAO = new RoomDAO();
    }

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
            out.println("<title>Servlet RoomAdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RoomAdminController at " + request.getContextPath() + "</h1>");
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

        try {
            List<Rooms> rooms = roomDAO.getAllRooms();
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/view/admin/rooms.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(RoomAdminController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            // Lấy dữ liệu từ form
            String roomNumber = request.getParameter("roomCode");
            String type = request.getParameter("roomType");
            BigDecimal price = new BigDecimal(request.getParameter("roomPrice"));
            String note = request.getParameter("roomDescription");

            // Xử lý ảnh
            Part imagePart = request.getPart("roomImage");
            String imageName = imagePart.getSubmittedFileName();
            String imagePath = "images/" + imageName;
            String savePath = getServletContext().getRealPath("/") + imagePath;
            imagePart.write(savePath);

            // Tạo đối tượng room
            Rooms room = new Rooms();
            room.setRoomNumber(roomNumber);
            room.setType(type);
            room.setPrice(price);
            room.setNote(note);
            room.setImageUrl(imagePath);
            room.setStatus("available");

            // Lưu vào DB
            roomDAO.insertRoom(room);

            // Redirect về danh sách phòng
            response.sendRedirect(request.getContextPath() + "/admin/rooms");

        } catch (Exception ex) {
            Logger.getLogger(RoomAdminController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thêm phòng");
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
