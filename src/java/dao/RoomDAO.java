package dao;

import model.Rooms;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class RoomDAO extends DBContext {

    // ✅ Lấy tất cả phòng có trạng thái "available"
    public List<Rooms> getAvailableRooms() {
        List<Rooms> list = new ArrayList<>();
        String sql = "SELECT * FROM Rooms WHERE status = 'available'";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setType(rs.getString("type"));
                room.setPrice(rs.getBigDecimal("price"));
                room.setStatus(rs.getString("status"));
                room.setNote(rs.getString("note"));
                room.setImageUrl(rs.getString("image_url"));
                list.add(room);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Lấy thông tin một phòng theo ID
    public Rooms getRoomById(int roomId) {
        String sql = "SELECT * FROM Rooms WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setType(rs.getString("type"));
                room.setPrice(rs.getBigDecimal("price"));
                room.setStatus(rs.getString("status"));
                room.setNote(rs.getString("note"));
                room.setImageUrl(rs.getString("image_url"));
                return room;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // (Tuỳ chọn): Cập nhật trạng thái phòng (khi đã book)
    public boolean updateRoomStatus(int roomId, String newStatus) {
        String sql = "UPDATE Rooms SET status = ? WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void insertRoom(Rooms r) throws SQLException {
        String sql = "INSERT INTO Rooms (room_number, type, price, status, note, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, r.getRoomNumber());
            ps.setString(2, r.getType());
            ps.setBigDecimal(3, r.getPrice());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getNote());
            ps.setString(6, r.getImageUrl());
            ps.executeUpdate();
        }
    }

    public List<Rooms> getAllRooms() throws SQLException {
        List<Rooms> list = new ArrayList<>();
        String sql = "SELECT * FROM Rooms";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Rooms r = new Rooms();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setType(rs.getString("type"));
                r.setPrice(rs.getBigDecimal("price"));
                r.setStatus(rs.getString("status"));
                r.setNote(rs.getString("note"));
                r.setImageUrl(rs.getString("image_url"));
                list.add(r);
            }
        }
        return list;
    }

    public List<Rooms> searchRooms(String keyword, BigDecimal minPrice, BigDecimal maxPrice,
            String status, String type, String sortOrder) throws SQLException {
        List<Rooms> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Rooms WHERE 1=1");

        List<Object> params = new ArrayList<>();

        // Từ khóa
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (room_number LIKE ? OR note LIKE ? OR type LIKE ?)");
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

        // Giá
        sql.append(" AND price >= ? AND price <= ?");
        params.add(minPrice != null ? minPrice : BigDecimal.ZERO);
        params.add(maxPrice != null ? maxPrice : new BigDecimal("99999999"));

        // Status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        // Type
        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }

        // Sắp xếp
        if ("desc".equalsIgnoreCase(sortOrder)) {
            sql.append(" ORDER BY price DESC");
        } else {
            sql.append(" ORDER BY price ASC");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rooms r = new Rooms();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setType(rs.getString("type"));
                r.setPrice(rs.getBigDecimal("price"));
                r.setStatus(rs.getString("status"));
                r.setNote(rs.getString("note"));
                r.setImageUrl(rs.getString("image_url"));
                list.add(r);
            }
        }
        return list;
    }

    public boolean deleteRoomById(int roomId) {
        String sql = "DELETE FROM Rooms WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRoom(Rooms room) {
        String sql = "UPDATE Rooms SET room_number = ?, type = ?, price = ?, status = ?, note = ?, image_url = ? WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getType());
            ps.setBigDecimal(3, room.getPrice());
            ps.setString(4, room.getStatus());
            ps.setString(5, room.getNote());
            ps.setString(6, room.getImageUrl());
            ps.setInt(7, room.getRoomId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isRoomNumberExists(String roomNumber) {
        String sql = "SELECT COUNT(*) FROM Rooms WHERE room_number = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, roomNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isRoomNumberExistsExcept(String roomNumber, int currentRoomId) {
        String sql = "SELECT COUNT(*) FROM Rooms WHERE room_number = ? AND room_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, roomNumber);
            ps.setInt(2, currentRoomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Rooms> searchRoomsPaginated(String keyword, BigDecimal minPrice, BigDecimal maxPrice,
            String status, String type, String sortOrder,
            int offset, int limit) throws SQLException {
        List<Rooms> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Rooms WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (room_number LIKE ? OR note LIKE ? OR type LIKE ?)");
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

        sql.append(" AND price >= ? AND price <= ?");
        params.add(minPrice != null ? minPrice : BigDecimal.ZERO);
        params.add(maxPrice != null ? maxPrice : new BigDecimal("99999999"));

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }

        sql.append(" ORDER BY price ").append("desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rooms r = new Rooms();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setType(rs.getString("type"));
                r.setPrice(rs.getBigDecimal("price"));
                r.setStatus(rs.getString("status"));
                r.setNote(rs.getString("note"));
                r.setImageUrl(rs.getString("image_url"));
                list.add(r);
            }
        }
        return list;
    }

    public int countSearchRooms(String keyword, BigDecimal minPrice, BigDecimal maxPrice,
            String status, String type) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Rooms WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (room_number LIKE ? OR note LIKE ? OR type LIKE ?)");
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

        sql.append(" AND price >= ? AND price <= ?");
        params.add(minPrice != null ? minPrice : BigDecimal.ZERO);
        params.add(maxPrice != null ? maxPrice : new BigDecimal("99999999"));

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

}
