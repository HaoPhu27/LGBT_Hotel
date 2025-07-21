/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Filter;
import dao.BookingsDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
/**
 *
 * @author admin
 */
public class RoomDeleteFilter implements Filter{
      private BookingsDAO bookingsDAO;

    @Override
    public void init(FilterConfig filterConfig) {
        bookingsDAO = new BookingsDAO(); // Khởi tạo DAO
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        try {
            int roomId = Integer.parseInt(req.getParameter("roomId"));

            if (bookingsDAO.isRoomCurrentlyBooked(roomId)) {
                req.getSession().setAttribute("error", "Không thể xoá phòng vì còn đơn đặt chưa checkout.");
                res.sendRedirect(req.getContextPath() + "/roomadmin");
                return;
            }

            // Nếu không bị chặn thì cho đi tiếp
            chain.doFilter(request, response);

        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", "Lỗi dữ liệu: roomId không hợp lệ.");
            res.sendRedirect(req.getContextPath() + "/roomadmin");
        }
    }

    @Override
    public void destroy() {
        // Không cần gì ở đây
    }
}
