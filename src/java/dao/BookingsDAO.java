package dao;

import java.math.BigDecimal;
import model.Bookings;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookingsDAO extends DBContext {

    // ✅ Lấy tất cả các đơn đặt phòng theo user_id (customer)
    public List<Bookings> getBookingsByCustomer(int customerId) {
        List<Bookings> list = new ArrayList<>();
        String sql = """
        SELECT b.*, r.room_number 
        FROM Bookings b
        JOIN Rooms r ON b.room_id = r.room_id
        WHERE b.customer_id = ?
        ORDER BY b.created_at DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("booking_id"));
                b.setRoomId(rs.getInt("room_id"));
                b.setRoomNumber(rs.getString("room_number")); // ✅
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(b);
            }

        } catch (Exception e) {
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

    public int createBookingReturnId(Bookings booking) {
        String sql = "INSERT INTO Bookings (customer_id, room_id, check_in, check_out, status, created_at) "
                + "OUTPUT INSERTED.booking_id VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, booking.getCustomerId());
            ps.setInt(2, booking.getRoomId());
            ps.setDate(3, booking.getCheckIn());
            ps.setDate(4, booking.getCheckOut());
            ps.setString(5, booking.getStatus());
            ps.setTimestamp(6, booking.getCreatedAt());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("booking_id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public boolean isRoomBookedInRange(int roomId, Date checkIn, Date checkOut) {
        String sql = "SELECT 1 FROM Bookings WHERE room_id = ? AND status != 'cancelled' AND "
                + "((check_in < ? AND check_out > ?) OR (check_in < ? AND check_out > ?) OR "
                + "(check_in >= ? AND check_out <= ?))";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setDate(2, checkOut);
            ps.setDate(3, checkIn);
            ps.setDate(4, checkOut);
            ps.setDate(5, checkIn);
            ps.setDate(6, checkIn);
            ps.setDate(7, checkOut);

            return ps.executeQuery().next(); // Nếu có kết quả -> trùng
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public void updateBookingStatus(int bookingId, String status, String paymentStatus) {
        String updateBookingSql = "UPDATE Bookings SET status = ? WHERE booking_id = ?";
        String updatePaymentSql = "UPDATE Payments SET status = ? WHERE booking_id = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement psBooking = connection.prepareStatement(updateBookingSql); PreparedStatement psPayment = connection.prepareStatement(updatePaymentSql)) {

                // Cập nhật status của Booking
                psBooking.setString(1, status);
                psBooking.setInt(2, bookingId);
                psBooking.executeUpdate();

                // Cập nhật payment status trong bảng Payments
                psPayment.setString(1, paymentStatus);
                psPayment.setInt(2, bookingId);
                psPayment.executeUpdate();

                connection.commit(); // Nếu thành công thì commit
            } catch (Exception e) {
                connection.rollback(); // Nếu lỗi thì rollback
                e.printStackTrace();
            } finally {
                connection.setAutoCommit(true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<String> getBookedDatesByRoomId(int roomId) {
        List<String> dates = new ArrayList<>();
        String sql = "SELECT check_in, check_out FROM Bookings WHERE room_id = ? AND status <> 'cancelled'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate in = rs.getDate("check_in").toLocalDate();
                LocalDate out = rs.getDate("check_out").toLocalDate();
                // ✅ Bao gồm cả ngày check_out
                while (!in.isAfter(out)) {
                    dates.add(in.toString());
                    in = in.plusDays(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dates;
    }

    public List<Bookings> getAllBookings() {
        List<Bookings> list = new ArrayList<>();
        String sql = """
        SELECT b.*, r.room_number, u.name AS customer_name,
               p.amount, p.status AS payment_status
        FROM Bookings b
        JOIN Rooms r ON b.room_id = r.room_id
        JOIN Users u ON b.customer_id = u.user_id
        LEFT JOIN Payments p ON b.booking_id = p.booking_id
        ORDER BY b.created_at DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("booking_id"));
                b.setRoomId(rs.getInt("room_id"));
                b.setRoomNumber(rs.getString("room_number"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setCustomerName(rs.getString("customer_name"));

                BigDecimal amount = rs.getBigDecimal("amount");
                if (amount != null) {
                    b.setTotalAmount(amount);
                }

                String paymentStatus = rs.getString("payment_status");
                b.setPaymentStatus(paymentStatus != null ? paymentStatus : "Chưa thanh toán");

                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Bookings getBookingAdminbyId(int id) {
        String sql = """
        SELECT b.*, r.room_number, u.name AS customer_name
        FROM Bookings b
        JOIN Rooms r ON b.room_id = r.room_id
        JOIN Users u ON b.customer_id = u.user_id
        WHERE b.booking_id = ?
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bookings b = new Bookings();
                b.setBookingId(rs.getInt("booking_id"));
                b.setCustomerId(rs.getInt("customer_id"));
                b.setRoomId(rs.getInt("room_id"));
                b.setRoomNumber(rs.getString("room_number"));
                b.setCustomerName(rs.getString("customer_name"));
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                return b;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getCustomerEmailByBookingId(int id) {
        String sql = """
        SELECT u.email
        FROM Bookings b
        JOIN Users u ON b.customer_id = u.user_id
        WHERE b.booking_id = ?
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public List<Map<String, Object>> getServiceDetailsForBooking(int bookingId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = """
        SELECT s.name, s.price, bs.quantity
        FROM BookingServices bs
        JOIN Services s ON bs.service_id = s.service_id
        WHERE bs.booking_id = ?
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("price", rs.getBigDecimal("price"));
                map.put("quantity", rs.getInt("quantity"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isRoomCurrentlyBooked(int roomId) {
        String sql = """
        SELECT 1 FROM Bookings 
        WHERE room_id = ? 
          AND status <> 'cancelled'
          AND check_out >= GETDATE()
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu có dòng nào -> phòng đang còn được đặt
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
