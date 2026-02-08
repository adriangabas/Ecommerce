package ecommerce.models;

import java.time.LocalDate;

public class Usuario {
    private int id;
    private String nombre;
    private String apellido;
    private String email;
    private String password;
    private String rol;
    private String telefono;
    private LocalDate fecharegistro;
    private boolean activo;

    public Usuario() {

    }

    public Usuario(int id, String nombre, String apellido, String email, String password, String rol, String telefono, String fecharegistro, boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.password = password;
        this.rol = rol;
        this.telefono = fecharegistro;
        this.activo = activo;
    }




}
