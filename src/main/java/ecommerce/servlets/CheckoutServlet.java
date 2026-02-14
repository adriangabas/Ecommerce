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
        for (CarritoItem it : cart.values()) {
            total += it.getSubtotal();
        }
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

        String direccion = req.getParameter("direccion_envio");
        if (direccion == null || direccion.trim().isEmpty()) {
            req.setAttribute("error", "La dirección de envío es obligatoria.");
            req.setAttribute("total", calcTotal(cart));
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
            return;
        }

        // ✅ Si todavía no tienes login, usamos usuario 1 por defecto
        int idUsuario = 1;
        Object userIdSession = session.getAttribute("userId");
        if (userIdSession instanceof Integer) {
            idUsuario = (Integer) userIdSession;
        }

        // 1) Construir Pedido
        Pedido pedido = new Pedido();
        pedido.setEstado("pendiente");
        pedido.setTotal(calcTotal(cart));
        pedido.setDireccion_envio(direccion.trim());
        pedido.setIdUsuario(idUsuario);

        // 2) Construir lineas
        List<LineaPedido> lineas = new ArrayList<>();
        for (CarritoItem it : cart.values()) {
            LineaPedido lp = new LineaPedido();
            lp.setIdProducto(it.getIdProducto());
            lp.setCantidad(it.getCantidad());
            lp.setPrecioUnitario(it.getPrecio());
            lp.setSubtotal(it.getSubtotal());
            lineas.add(lp);
        }

        // 3) Guardar en BD (tu transacción: inserta pedido + lineas + resta stock)
        PedidoDao pedidoDao = new PedidoDao();

        int idPedidoCreado;
        try {
            idPedidoCreado = pedidoDao.create(pedido, lineas);
        } catch (SQLException e) {
            throw new ServletException("Error creando el pedido en BD", e);
        }

        // 4) Vaciar carrito
        cart.clear();
        session.setAttribute("cart", cart);

        // 5) Comprobar stock bajo y notificar (a n8n webhook)
        try {
            ProductoDao productoDao = new ProductoDao();
            List<Producto> low = productoDao.findLowStock();
            if (!low.isEmpty()) {
                StockAlertService.notifyLowStock(low);
            }
        } catch (Exception e) {
            // No rompemos el checkout si falla el aviso (solo log)
            e.printStackTrace();
        }

        // 6) Mostrar OK
        req.setAttribute("pedidoId", idPedidoCreado);
        req.getRequestDispatcher("/pedido_ok.jsp").forward(req, resp);
    }
}