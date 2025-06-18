package dao;

import model.Services;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ServicesDAO extends DBContext {

    // ✅ Thêm dịch vụ mới cho booking
    public boolean insertService(Services s) {
        String sql = "INSERT INTO Services (booking_id, name, price) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, s.getBookingId());
            ps.setString(2, s.getName());
            ps.setBigDecimal(3, s.getPrice());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Lấy tất cả dịch vụ theo booking_id
    public List<Services> getByBookingId(int bookingId) {
        List<Services> list = new ArrayList<>();
        String sql = "SELECT * FROM Services WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Services s = new Services();
                s.setServiceId(rs.getInt("service_id"));
                s.setBookingId(rs.getInt("booking_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getBigDecimal("price"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Xóa dịch vụ theo ID
    public boolean deleteService(int serviceId) {
        String sql = "DELETE FROM Services WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // (Tuỳ chọn) Sửa dịch vụ
    public boolean updateService(Services s) {
        String sql = "UPDATE Services SET name = ?, price = ? WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setBigDecimal(2, s.getPrice());
            ps.setInt(3, s.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
