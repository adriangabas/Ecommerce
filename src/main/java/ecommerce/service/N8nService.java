package ecommerce.service;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class N8nService {

    /**
     * FIRE & FORGET real:
     * - No bloquea el checkout
     * - No espera respuesta (si tarda, no te rompe nada)
     * - Timeouts pequeños para no colgar hilos
     */
    public static void postFireAndForget(String url, String jsonBody) {

        new Thread(() -> {
            HttpURLConnection con = null;
            try {
                URL u = new URL(url);
                con = (HttpURLConnection) u.openConnection();
                con.setRequestMethod("POST");
                con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
                con.setDoOutput(true);

                // Timeouts pequeños para no “colgar” el hilo si pasa algo raro
                con.setConnectTimeout(1500);
                con.setReadTimeout(1500);

                byte[] bytes = jsonBody.getBytes(StandardCharsets.UTF_8);
                try (OutputStream os = con.getOutputStream()) {
                    os.write(bytes);
                    os.flush();
                }

                int status = con.getResponseCode();
                System.out.println("✅ n8n POST enviado. HTTP=" + status);

            } catch (Exception e) {
                System.out.println("⚠️ n8n POST fallo (no rompe checkout): " + e.getMessage());
            } finally {
                if (con != null) con.disconnect();
            }
        }, "n8n-webhook-thread").start();
    }
}
