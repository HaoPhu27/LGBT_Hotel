package dao;

import model.Bookings;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingsDAO extends DBContext {

    // ✅ Lấy tất cả các đơn đặt phòng theo user_id (customer)
    public List<Bookings> getBookingsByCustomer(int customerId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE customer_id = ? ORDER BY created_at DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("booking_id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setRoomId(rs.getInt("room_id"));
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(b);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Tạo mới một đơn đặt phòng
    public boolean createBooking(Bookings booking) {
        String sql = "INSERT INTO Bookings (customer_id, room_id, check_in, check_out, status) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, booking.getCustomerId());
            ps.setInt(2, booking.getRoomId());
            ps.setDate(3, booking.getCheckIn());
            ps.setDate(4, booking.getCheckOut());
            ps.setString(5, booking.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // (Tuỳ chọn) Lấy 1 đơn đặt phòng theo booking_id
    public Bookings getBookingById(int bookingId) {
        String sql = "SELECT * FROM Bookings WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("booking_id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setRoomId(rs.getInt("room_id"));
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                return b;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
