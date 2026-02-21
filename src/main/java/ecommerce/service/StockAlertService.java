package ecommerce.service;

import ecommerce.models.Producto;

import java.util.List;

public class StockAlertService {

    // SIEMPRE 127.0.0.1 (evitas movidas de localhost/IPv6)
    private static final String N8N_WEBHOOK_URL = "http://127.0.0.1:5678/webhook/stock-bajo";

    public static void notifyLowStockFireAndForget(int pedidoId, List<Producto> lowStockProducts) {

        if (lowStockProducts == null || lowStockProducts.isEmpty()) {
            System.out.println("ℹ️ No hay stock bajo, no se envía aviso.");
            return;
        }

        String json = buildPayload(pedidoId, lowStockProducts);

        System.out.println("📦 JSON enviado a n8n -> " + json);
        System.out.println("📨 POST (fire & forget) -> " + N8N_WEBHOOK_URL);

        N8nService.postFireAndForget(N8N_WEBHOOK_URL, json);
        System.out.println("✅ Webhook enviado a n8n (fire & forget)");
    }

    private static String buildPayload(int pedidoId, List<Producto> lowStockProducts) {

        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"evento\":\"stock_bajo\",");
        sb.append("\"pedidoId\":").append(pedidoId).append(",");
        sb.append("\"totalProductos\":").append(lowStockProducts.size()).append(",");
        sb.append("\"productos\":[");

        for (int i = 0; i < lowStockProducts.size(); i++) {
            Producto p = lowStockProducts.get(i);

            sb.append("{")
                    .append("\"id\":").append(p.getId()).append(",")
                    .append("\"nombre\":\"").append(escape(p.getNombre())).append("\",")
                    .append("\"categoria\":\"").append(escape(p.getCategoria())).append("\",")
                    .append("\"stock\":").append(p.getStock()).append(",")
                    .append("\"stock_min\":").append(p.getStock_min()).append(",")
                    .append("\"emailAviso\":\"").append(escape(p.getEmailAviso())).append("\"")
                    .append("}");

            if (i < lowStockProducts.size() - 1) sb.append(",");
        }

        sb.append("]}");
        return sb.toString();
    }

    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
