package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.BookingService;
import java.sql.ResultSet;
public class BookingServiceDAO extends DBContext {

    public void insertServiceForBooking(int bookingId, int serviceId, int quantity) throws SQLException {
        String sql = "INSERT INTO BookingServices (booking_id, service_id, quantity) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, serviceId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        }
    }

    public List<BookingService> getServicesByBookingId(int bookingId) throws SQLException {
        List<BookingService> list = new ArrayList<>();

        String sql = """
            SELECT bs.service_id, s.name AS service_name, s.price, bs.quantity
            FROM BookingServices bs
            JOIN Services s ON bs.service_id = s.service_id
            WHERE bs.booking_id = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingService bs = new BookingService();
                bs.setServiceId(rs.getInt("service_id"));
                bs.setServiceName(rs.getString("service_name"));
                bs.setPrice(rs.getBigDecimal("price"));
                bs.setQuantity(rs.getInt("quantity"));
                list.add(bs);
            }
        }

        return list;
    }

}
