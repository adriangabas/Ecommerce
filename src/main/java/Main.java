import ecommerce.database.Database;

import java.sql.Connection;

public class Main {

    public static void main(String[] args) {
        try (Connection conn = Database.getConnection()) {
            System.out.println("✅ Conexión a la base de datos OK");
        } catch (Exception e) {
            System.out.println("❌ Error de conexión");
            e.printStackTrace();
        }
    }
}
