import ecommerce.dao.ProductoDao;
import ecommerce.database.Database;
import ecommerce.models.Producto;

import java.sql.Connection;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        try {
            ProductoDao dao = new ProductoDao();

            List<Producto> productos = dao.getAll();
            System.out.println("✅ Productos activos: " + productos.size());

            for (Producto p : productos) {
                System.out.println(p.getId() + " - " + p.getNombre() +
                        " | stock=" + p.getStock() +
                        " | min=" + p.getStock_min());
            }

            List<Producto> low = dao.findLowStock();
            System.out.println("⚠️ Stock bajo: " + low.size());

            for (Producto p : low) {
                System.out.println("🔻 " + p.getNombre() + " -> stock=" + p.getStock() +
                        " (min=" + p.getStock_min() + ") email=" + p.getEmail_aviso());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
