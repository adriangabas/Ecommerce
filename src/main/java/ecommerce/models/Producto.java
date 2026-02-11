package ecommerce.models;

import java.time.LocalDateTime;

public class Producto {
    private int id;
    private String nombre;
    private String descripcion;
    private String categoria;
    private double precio;
    private int stock;
    private int stock_min;
    private String emailAviso;
    private LocalDateTime fecha_creacion;
    private boolean activo;

    public Producto() {

    }

    public Producto(int id,String nombre,String descripcion,String categoria,double precio,int stock,int stock_min,String emailAviso,LocalDateTime fecha_creacion,boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.precio = precio;
        this.stock = stock;
        this.stock_min = stock_min;
        this.emailAviso = emailAviso;
        this.fecha_creacion = fecha_creacion;
        this.activo = activo;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public String getCategoria() {
        return categoria;
    }
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    public double getPrecio() {
        return precio;
    }
    public void setPrecio(double precio) {
        this.precio = precio;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public int getStock_min() {
        return stock_min;
    }
    public void setStock_min(int stock_min) {
        this.stock_min = stock_min;
    }
    public String getEmailAviso() {
        return emailAviso;
    }
    public void setEmailAviso(String email_aviso) {
        this.emailAviso = emailAviso;
    }
    public LocalDateTime getFecha_creacion() {
        return fecha_creacion;
    }
    public void setFecha_creacion(LocalDateTime fecha_creacion) {
        this.fecha_creacion = fecha_creacion;
    }
    public boolean isActivo() {
        return activo;
    }
    public void setActivo(boolean activo) {
        this.activo = activo;
    }

}

