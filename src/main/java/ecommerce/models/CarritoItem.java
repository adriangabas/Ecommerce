package ecommerce.models;

public class CarritoItem {
    private int idProducto;
    private String nombre;
    private String categoria;
    private double precio;
    private int cantidad;
    private String imagen; // ruta web: /img/cajakarton.png

    public CarritoItem() {}

    public CarritoItem(int idProducto, String nombre, String categoria, double precio, int cantidad, String imagen) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.cantidad = cantidad;
        this.imagen = imagen;
    }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }

    public double getSubtotal() { return precio * cantidad; }
}