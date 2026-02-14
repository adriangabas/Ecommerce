package ecommerce.servlets;

import ecommerce.models.CarritoItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    private Map<Integer, CarritoItem> getCart(HttpSession session) {
        Object obj = session.getAttribute("cart");
        if (obj == null) {
            Map<Integer, CarritoItem> cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
            return cart;
        }
        return (Map<Integer, CarritoItem>) obj;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ver carrito
        req.getRequestDispatcher("/carrito.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession(true);
        Map<Integer, CarritoItem> cart = getCart(session);

        String action = req.getParameter("action");
        if (action == null) action = "add";

        switch (action) {
            case "add": {
                int id = Integer.parseInt(req.getParameter("id"));
                String nombre = req.getParameter("nombre");
                String categoria = req.getParameter("categoria");
                double precio = Double.parseDouble(req.getParameter("precio"));
                String imagen = req.getParameter("imagen"); // "/img/xxx.png"

                CarritoItem item = cart.get(id);
                if (item == null) {
                    cart.put(id, new CarritoItem(id, nombre, categoria, precio, 1, imagen));
                } else {
                    item.setCantidad(item.getCantidad() + 1);
                }
                break;
            }
            case "inc": {
                int id = Integer.parseInt(req.getParameter("id"));
                CarritoItem item = cart.get(id);
                if (item != null) item.setCantidad(item.getCantidad() + 1);
                break;
            }
            case "dec": {
                int id = Integer.parseInt(req.getParameter("id"));
                CarritoItem item = cart.get(id);
                if (item != null) {
                    int nueva = item.getCantidad() - 1;
                    if (nueva <= 0) cart.remove(id);
                    else item.setCantidad(nueva);
                }
                break;
            }
            case "remove": {
                int id = Integer.parseInt(req.getParameter("id"));
                cart.remove(id);
                break;
            }
            case "clear": {
                cart.clear();
                break;
            }
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/carrito");
    }
}