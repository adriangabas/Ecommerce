<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ecommerce</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
      background: #f7f7f7;
    }
    .box {
      background: white;
      padding: 25px;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.08);
      max-width: 700px;
    }
    a {
      display: inline-block;
      margin-top: 10px;
      text-decoration: none;
      color: #0b57d0;
      font-weight: bold;
    }
    .ok {
      color: green;
      font-weight: bold;
    }
    .mini {
      color: #666;
      margin-top: 12px;
      font-size: 14px;
    }
    code {
      background: #eee;
      padding: 2px 6px;
      border-radius: 6px;
    }
  </style>
</head>

<body>

<div class="box">
  <h1>🛒 Ecommerce</h1>

  <p class="ok">✅ Si ves esta página, Tomcat está desplegando tu proyecto correctamente.</p>

  <hr>

  <h3>Pruebas rápidas</h3>

  <p>
    👉 Probar servlet:
    <a href="<%= request.getContextPath() %>/test">Ir a /test</a>
  </p>

  <p>
    👉 Ver catálogo:
    <a href="<%= request.getContextPath() %>/productos">Ir a /productos</a>
  </p>

  <p class="mini">
    Si el servlet funciona, verás un texto en pantalla.
  </p>

  <hr>

  <h3>Próximos pasos (cuando quieras)</h3>
  <ul>
    <li>📦 Listar productos desde MariaDB</li>
    <li>🛒 Añadir al carrito (sesión)</li>
    <li>📍 Confirmar pedido y guardar en BD</li>
  </ul>

  <p class="mini">
    Contexto actual: <code><%= request.getContextPath() %></code>
  </p>
</div>

</body>
</html>
