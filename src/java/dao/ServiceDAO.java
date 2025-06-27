package dao;

import model.Service;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ServiceDAO extends DBContext {

    // ✅ Lấy tất cả dịch vụ
    public List<Service> getAllServices() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Services";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setPrice(rs.getBigDecimal("price"));
                list.add(service);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Thêm dịch vụ mới
    public void insertService(Service s) throws SQLException {
        String sql = "INSERT INTO Services (name, price) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setBigDecimal(2, s.getPrice());
            ps.executeUpdate();
        }
    }

    // ✅ Cập nhật dịch vụ
    public boolean updateService(Service s) throws SQLException {
        String sql = "UPDATE Services SET name = ?, price = ? WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setBigDecimal(2, s.getPrice());
            ps.setInt(3, s.getServiceId());
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Xoá dịch vụ
    public boolean deleteService(int id) throws SQLException {
        String sql = "DELETE FROM Services WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // (Tuỳ chọn): Lấy theo ID
    public Service getServiceById(int id) throws SQLException {
        String sql = "SELECT * FROM Services WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Service s = new Service();
                    s.setServiceId(rs.getInt("service_id"));
                    s.setName(rs.getString("name"));
                    s.setPrice(rs.getBigDecimal("price"));
                    return s;
                }
            }
        }
        return null;
    }
} 