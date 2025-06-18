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
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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

    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
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
}
