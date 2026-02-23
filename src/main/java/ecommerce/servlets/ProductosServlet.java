package ecommerce.servlets;

import ecommerce.dao.ProductoDao;
import ecommerce.models.Producto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/productos")
public class ProductosServlet extends HttpServlet {

    private final ProductoDao productoDao = new ProductoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            List<Producto> productos = productoDao.getAll();
            req.setAttribute("productos", productos);

            req.getRequestDispatcher("/productos.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Error cargando productos", e);
        }
    }
}