package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "deptrai0315";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=LGBTHotel;encrypt=false;trustServerCertificate=true";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);

            System.out.println("✅ Kết nối DB thành công: " + (connection != null));
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Không tìm thấy driver JDBC SQLServer");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Lỗi SQL khi kết nối DB");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("❌ Lỗi khác khi kết nối DB");
            e.printStackTrace();
        }
    }
}
