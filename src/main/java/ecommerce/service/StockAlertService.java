package ecommerce.service;

import ecommerce.models.Producto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StockAlertService {

    // 🔥 PON AQUÍ TU WEBHOOK DE N8N (cuando lo tengas)
    // Ej: "http://localhost:5678/webhook/stock-bajo"
    private static final String N8N_WEBHOOK_URL = "http://localhost:5678/webhook/stock-bajo";

    public static void notifyLowStock(List<Producto> lowStockProducts) throws Exception {

        // Construimos un JSON sencillo
        // { "evento":"stock_bajo", "productos":[{id,nombre,stock,stock_min,emailAviso}, ...] }
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"evento\":\"stock_bajo\",");
        sb.append("\"productos\":[");

        for (int i = 0; i < lowStockProducts.size(); i++) {
            Producto p = lowStockProducts.get(i);
            sb.append("{")
                    .append("\"id\":").append(p.getId()).append(",")
                    .append("\"nombre\":\"").append(escape(p.getNombre())).append("\",")
                    .append("\"stock\":").append(p.getStock()).append(",")
                    .append("\"stock_min\":").append(p.getStock_min()).append(",")
                    .append("\"emailAviso\":\"").append(escape(p.getEmailAviso())).append("\"")
                    .append("}");
            if (i < lowStockProducts.size() - 1) sb.append(",");
        }

        sb.append("]}");

        N8nService.post(N8N_WEBHOOK_URL, sb.toString());
    }

    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}