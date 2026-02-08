package ecommerce.database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private static final String URL = "jdbc:mariadb://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "1234";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, DB_USER, DB_PASS);
    }
}