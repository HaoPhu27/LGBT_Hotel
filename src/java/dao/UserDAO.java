package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Customers;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO extends DBContext {

    // Đăng ký người dùng với vai trò xác định
    public boolean register(Customers user) {
        String sql = "INSERT INTO Users (name, gender, role, phone, email, address, id_number, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            ps.setString(1, user.getName());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getRole()); // 'customer', 'staff', 'admin'
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getIdNumber());
            ps.setString(8, hashedPassword);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đăng nhập (email + password) và kiểm tra role
    public Customers login(String email, String password) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHash = rs.getString("password");
                if (BCrypt.checkpw(password, storedHash)) {
                    Customers user = new Customers();
                    user.setUserId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setGender(rs.getString("gender"));
                    user.setRole(rs.getString("role"));
                    user.setPhone(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setAddress(rs.getString("address"));
                    user.setIdNumber(rs.getString("id_number"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách tất cả người dùng
    public List<Customers> getAllUsers() {
        List<Customers> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customers u = new Customers();
                u.setUserId(rs.getInt("user_id"));
                u.setName(rs.getString("name"));
                u.setGender(rs.getString("gender"));
                u.setRole(rs.getString("role"));
                u.setPhone(rs.getString("phone"));
                u.setEmail(rs.getString("email"));
                u.setAddress(rs.getString("address"));
                u.setIdNumber(rs.getString("id_number"));
                // không cần password
                list.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm người dùng theo ID
    public Customers getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customers u = new Customers();
                u.setUserId(rs.getInt("user_id"));
                u.setName(rs.getString("name"));
                u.setGender(rs.getString("gender"));
                u.setRole(rs.getString("role"));
                u.setPhone(rs.getString("phone"));
                u.setEmail(rs.getString("email"));
                u.setAddress(rs.getString("address"));
                u.setIdNumber(rs.getString("id_number"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
