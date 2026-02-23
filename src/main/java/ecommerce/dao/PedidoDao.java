package ecommerce.dao;

import ecommerce.database.Database;
import ecommerce.models.LineaPedido;
import ecommerce.models.Pedido;
import ecommerce.models.Producto;

import java.sql.*;
import java.util.List;

public class PedidoDao {

    public int create(Pedido pedido, List<LineaPedido> lineas) throws SQLException {

        String sqlPedido = "INSERT INTO pedidos (estado, total, direccion_envio, id_usuario) VALUES (?, ?, ?, ?)";
        String sqlLinea  = "INSERT INTO lineas_pedido (cantidad, precio_unitario, subtotal, id_producto, id_pedido) VALUES (?, ?, ?, ?, ?)";

        Connection conn = null;

        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false);


            int idPedidoGenerado;

            try (PreparedStatement stmtPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS)) {
                stmtPedido.setString(1, pedido.getEstado());
                stmtPedido.setDouble(2, pedido.getTotal());
                stmtPedido.setString(3, pedido.getDireccion_envio());
                stmtPedido.setInt(4, pedido.getIdUsuario());

                stmtPedido.executeUpdate();

                try (ResultSet keys = stmtPedido.getGeneratedKeys()) {
                    if (keys.next()) {
                        idPedidoGenerado = keys.getInt(1);
                    } else {
                        throw new SQLException("No se pudo obtener el ID del pedido generado.");
                    }
                }
            }

            ProductoDao productoDao = new ProductoDao();

            for (LineaPedido lp : lineas) {

                try (PreparedStatement stmtLinea = conn.prepareStatement(sqlLinea)) {
                    stmtLinea.setInt(1, lp.getCantidad());
                    stmtLinea.setDouble(2, lp.getPrecioUnitario());
                    stmtLinea.setDouble(3, lp.getSubtotal());
                    stmtLinea.setInt(4, lp.getIdProducto());
                    stmtLinea.setInt(5, idPedidoGenerado);
                    stmtLinea.executeUpdate();
                }

                Producto p = productoDao.getById(lp.getIdProducto(), conn);
                if (p == null) {
                    throw new SQLException("Producto no encontrado. id=" + lp.getIdProducto());
                }

                int nuevoStock = p.getStock() - lp.getCantidad();
                if (nuevoStock < 0) {
                    throw new SQLException("Stock insuficiente para producto id=" + p.getId() +
                            " (stock=" + p.getStock() + ", pedido=" + lp.getCantidad() + ")");
                }

                boolean ok = productoDao.updateStock(lp.getIdProducto(), nuevoStock, conn);
                if (!ok) {
                    throw new SQLException("No se pudo actualizar stock del producto id=" + lp.getIdProducto());
                }
            }

            conn.commit();
            return idPedidoGenerado;

        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
}
