package ecommerce.models;

public class LineaPedido {
    private int id;
    private int cantidad;
    private double precioUnitario;
    private double  subtotal;
    private int idProducto;
    private int idPedido;

    public LineaPedido() {

    }

    public LineaPedido(int id, int cantidad, double precioUnitario, double subtotal, int idproducto, int idpedido) {
        this.id = id;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = subtotal;
        this.idProducto = idproducto;
        this.idPedido = idpedido;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getCantidad() {
        return cantidad;
    }
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    public double getPrecioUnitario() {
        return precioUnitario;
    }
    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
    public double getSubtotal() {
        return subtotal;
    }
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    public int getIdProducto() {
        return idProducto;
    }
    public void setIdProducto(int idproducto) {
        this.idProducto = idproducto;
    }
    public int getIdPedido() {
        return idPedido;
    }
    public void setIdPedido(int idpedido) {
        this.idPedido = idpedido;
    }
}
