package ecommerce.dao;

import ecommerce.database.Database;
import ecommerce.models.Producto;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


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
            stmt.setString(7, producto.getEmailAviso());

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

    public List<Producto> getAll() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE activo = 1 ORDER BY fecha_creacion DESC";

        try (Connection conn = Database.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                productos.add(mapProducto(rs));
            }

        }
        return productos;
    }

    public Producto findById(int id) throws SQLException {
        String sql = "SELECT * FROM productos WHERE id = ?";

        try (Connection conn = Database.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapProducto(rs);
                }
            }
        }
        return null;
    }

    public boolean updateStock(int productoId, int newStock) throws SQLException {
        String sql = "UPDATE productos SET stock = ? WHERE id = ?";

        try (Connection conn = Database.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newStock);
            stmt.setInt(2, productoId);

            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    public List<Producto> findLowStock() throws SQLException {

        List<Producto> low = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE activo = 1 AND stock <= stock_min ORDER BY stock ASC";

        try (Connection conn = Database.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                    low.add(mapProducto(rs));
            }
        }
        return low;
    }

    private Producto mapProducto(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        producto.setId(rs.getInt("id"));
        producto.setNombre(rs.getString("nombre"));
        producto.setDescripcion(rs.getString("descripcion"));
        producto.setCategoria(rs.getString("categoria"));
        producto.setPrecio(rs.getDouble("precio"));
        producto.setStock(rs.getInt("stock"));
        producto.setStock_min(rs.getInt("stock_min"));
        producto.setEmailAviso(rs.getString("email_aviso"));

        Timestamp ts = rs.getTimestamp("fecha_creacion");
        if (ts != null) {
            producto.setFecha_creacion(ts.toLocalDateTime());
        }

    producto.setActivo(rs.getBoolean("activo"));
    return producto;
    }

}
