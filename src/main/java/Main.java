import ecommerce.dao.ProductoDao;
import ecommerce.models.Producto;
import java.util.List;
import ecommerce.dao.PedidoDao;
import ecommerce.models.LineaPedido;
import ecommerce.models.Pedido;
import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {

        try {
            // ✅ CAMBIA ESTOS IDS SEGÚN TU BD
            int idUsuario = 1;
            int idProducto = 1;
            int cantidad = 2;   // para ver cómo baja el stock

            ProductoDao productoDao = new ProductoDao();

            // 1) Ver stock ANTES
            Producto pAntes = productoDao.getById(idProducto);
            if (pAntes == null) {
                System.out.println("❌ No existe el producto con id=" + idProducto + " (o está inactivo).");
                return;
            }

            System.out.println("📦 Stock ANTES -> " + pAntes.getNombre() + " = " + pAntes.getStock());

            // 2) Crear pedido
            Pedido pedido = new Pedido();
            pedido.setEstado("pendiente");
            pedido.setTotal(pAntes.getPrecio() * cantidad);
            pedido.setDireccion_envio("Calle Mayor 10, Zaragoza");
            pedido.setIdUsuario(idUsuario);

            // 3) Crear línea del pedido
            LineaPedido lp = new LineaPedido();
            lp.setIdProducto(idProducto);
            lp.setCantidad(cantidad);
            lp.setPrecioUnitario(pAntes.getPrecio());
            lp.setSubtotal(pAntes.getPrecio() * cantidad);

            List<LineaPedido> lineas = new ArrayList<>();
            lineas.add(lp);

            // 4) Guardar en BD (transacción)
            PedidoDao pedidoDao = new PedidoDao();
            int idPedidoCreado = pedidoDao.create(pedido, lineas);

            System.out.println("✅ Pedido creado con ID: " + idPedidoCreado);

            // 5) Ver stock DESPUÉS
            Producto pDespues = productoDao.getById(idProducto);
            System.out.println("📦 Stock DESPUÉS -> " + pDespues.getNombre() + " = " + pDespues.getStock());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}