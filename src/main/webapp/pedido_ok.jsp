<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Pedido confirmado</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
  <style>
    .wrap{ padding: 34px 0; }
    .box{ background:#fff; border-radius:16px; padding:22px; box-shadow: var(--shadow); border:1px solid rgba(15,23,42,0.06); text-align:center; }
    .id{ font-size:22px; font-weight:900; }
  </style>
</head>
<body>

<div class="container wrap">
  <div class="box">
    <h2>✅ Pedido confirmado</h2>
    <p>Tu pedido se ha creado correctamente.</p>
    <p class="id">ID Pedido: ${pedidoId}</p>

    <div style="margin-top:14px;">
      <a class="btn-secondary" href="<%= request.getContextPath() %>/productos">Volver al catálogo</a>
    </div>
  </div>
</div>

</body>
</html>
