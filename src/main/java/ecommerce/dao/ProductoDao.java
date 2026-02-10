package ecommerce.dao;

import ecommerce.database.Database;
import ecommerce.models.Producto;

import java.sql.*;
import java.time.LocalDateTime;

public class ProductoDao {

    public int create(Producto producto) throws SQLException {

        String sql = "INSERT INTO productos " +
                "(nombre, descripcion, categoria, precio, stock, stock_min, email_aviso, fecha_creacion, activo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setString(3, producto.getCategoria());
            stmt.setDouble(4, producto.getPrecio());
            stmt.setInt(5, producto.getStock());
            stmt.setInt(6, producto.getStock_min());
            stmt.setString(7, producto.getEmail_aviso());

            LocalDateTime fr = (producto.getFecha_creacion() != null)
                    ? producto.getFecha_creacion()
                    : LocalDateTime.now();
            stmt.setTimestamp(8, Timestamp.valueOf(fr));

            stmt.setBoolean(9, producto.isActivo());

            stmt.executeUpdate();

            try (ResultSet keys = stmt.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        }

        return -1;
    }
}
