package ecommerce.models;

import java.time.LocalDateTime;

public class Pedido {
    private int id;
    private LocalDateTime fecha_pedido;
    private String estado;
    private double total;
    private String direccion_envio;
    private int idUsuario;

    public Pedido() {

    }

    public Pedido(int id, LocalDateTime fecha_pedido, String estado, double total, String direccion_envio, int idUsuario) {
        this.id = id;
        this.fecha_pedido = fecha_pedido;
        this.estado = estado;
        this.total = total;
        this.direccion_envio = direccion_envio;
        this.idUsuario = idUsuario;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public LocalDateTime getFecha_pedido() {
        return fecha_pedido;
    }
    public void setFecha_pedido(LocalDateTime fecha_pedido) {
        this.fecha_pedido = fecha_pedido;
    }
    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
    public double getTotal() {
        return total;
    }
    public void setTotal(double total) {
        this.total = total;
    }
    public String getDireccion_envio() {
        return direccion_envio;
    }
    public void setDireccion_envio(String direccion_envio) {
        this.direccion_envio = direccion_envio;
    }
    public int getIdUsuario() {
        return idUsuario;
    }
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
}
