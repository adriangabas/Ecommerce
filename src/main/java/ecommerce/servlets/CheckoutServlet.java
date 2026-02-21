package ecommerce.servlets;

import ecommerce.dao.PedidoDao;
import ecommerce.dao.ProductoDao;
import ecommerce.models.CarritoItem;
import ecommerce.models.LineaPedido;
import ecommerce.models.Pedido;
import ecommerce.models.Producto;
import ecommerce.service.StockAlertService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    private Map<Integer, CarritoItem> getCart(HttpSession session) {
        Object obj = session.getAttribute("cart");
        if (obj == null) return new LinkedHashMap<>();
        return (Map<Integer, CarritoItem>) obj;
    }

    private double calcTotal(Map<Integer, CarritoItem> cart) {
        double total = 0;
        for (CarritoItem it : cart.values()) total += it.getSubtotal();
        return total;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(true);
        Map<Integer, CarritoItem> cart = getCart(session);

        if (cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/carrito");
            return;
        }

        req.setAttribute("total", calcTotal(cart));
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(true);
        Map<Integer, CarritoItem> cart = getCart(session);

        if (cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/carrito");
            return;
        }

        // 1) Validar dirección
        String direccion = req.getParameter("direccion_envio");
        if (direccion == null || direccion.trim().isEmpty()) {
            req.setAttribute("error", "La dirección de envío es obligatoria.");
            req.setAttribute("total", calcTotal(cart));
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
            return;
        }

        // 2) Usuario (si no hay login, 1 por defecto)
        int idUsuario = 1;
        Object userIdSession = session.getAttribute("userId");
        if (userIdSession instanceof Integer) idUsuario = (Integer) userIdSession;

        // 3) Construir Pedido
        Pedido pedido = new Pedido();
        pedido.setEstado("pendiente");
        pedido.setTotal(calcTotal(cart));
        pedido.setDireccion_envio(direccion.trim());
        pedido.setIdUsuario(idUsuario);

        // 4) Construir líneas + IDs de producto del pedido
        List<LineaPedido> lineas = new ArrayList<>();
        Set<Integer> idsProductoPedido = new LinkedHashSet<>();

        for (CarritoItem it : cart.values()) {
            LineaPedido lp = new LineaPedido();
            lp.setIdProducto(it.getIdProducto());
            lp.setCantidad(it.getCantidad());
            lp.setPrecioUnitario(it.getPrecio());
            lp.setSubtotal(it.getSubtotal());
            lineas.add(lp);

            idsProductoPedido.add(it.getIdProducto());
        }

        // 5) Guardar en BD (pedido + lineas + resta stock)
        int idPedidoCreado;
        try {
            PedidoDao pedidoDao = new PedidoDao();
            idPedidoCreado = pedidoDao.create(pedido, lineas);
            System.out.println("✅ Pedido creado OK. idPedidoCreado=" + idPedidoCreado);
        } catch (SQLException e) {
            throw new ServletException("Error creando el pedido en BD", e);
        }

        // 6) Vaciar carrito
        cart.clear();
        session.setAttribute("cart", cart);

        // 7) Aviso stock bajo SOLO de productos del pedido (🔥 FIRE & FORGET)
        try {
            ProductoDao productoDao = new ProductoDao();

            List<Producto> low = productoDao.findLowStockByIds(new ArrayList<>(idsProductoPedido));
            System.out.println("DEBUG lowStockByIds size=" + (low == null ? 0 : low.size()));

            if (low != null && !low.isEmpty()) {
                StockAlertService.notifyLowStockFireAndForget(idPedidoCreado, low);
                System.out.println("✅ Aviso stock bajo enviado a n8n (" + low.size() + ")");
            } else {
                System.out.println("ℹ️ No hay stock bajo en productos del pedido, no se envía aviso.");
            }

        } catch (Exception e) {
            System.out.println("❌ Fallo preparando aviso stock bajo a n8n: " + e.getMessage());
            e.printStackTrace();
        }

        // 8) Mostrar OK
        req.setAttribute("pedidoId", idPedidoCreado);
        req.getRequestDispatcher("/pedido_ok.jsp").forward(req, resp);
    }
}
