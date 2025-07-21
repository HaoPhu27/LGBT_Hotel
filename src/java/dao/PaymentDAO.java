package dao;

import java.math.BigDecimal;
import model.Payment;
import java.sql.*;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author admin
 */
public class PaymentDAO extends DBContext {

    public Payment getPaymentByBookingId(int bookingId) {
        String sql = "SELECT * FROM Payments WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setBookingId(rs.getInt("booking_id"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setMethod(rs.getString("method"));
                p.setPaidAt(rs.getTimestamp("paid_at"));
                p.setStatus(rs.getString("status"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertPayment(Payment payment) throws SQLException {
        String sql = "INSERT INTO Payments (booking_id, amount, method, paid_at, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payment.getBookingId());
            ps.setBigDecimal(2, payment.getAmount());
            ps.setString(3, payment.getMethod());
            ps.setTimestamp(4, payment.getPaidAt());  // Có thể null nếu chưa thanh toán
            ps.setString(5, payment.getStatus());     // "paid" hoặc "unpaid"
            ps.executeUpdate();
        }
    }

    public BigDecimal calculateTotalRevenue() throws SQLException {
        String sql = "SELECT SUM(amount) AS total FROM Payments WHERE status = 'paid'";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getBigDecimal("total") != null ? rs.getBigDecimal("total") : BigDecimal.ZERO;
            }
        }
        return BigDecimal.ZERO;
    }
}
