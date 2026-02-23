<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Checkout</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">

    <style>
        .wrap{ padding: 28px 0 40px; }
        .card{ background:#fff; border-radius:16px; padding:16px; box-shadow: var(--shadow); border:1px solid rgba(15,23,42,0.06); }
        .row{ display:grid; grid-template-columns: 1fr 360px; gap: 16px; align-items:start; }
        .sum{ color:#64748b; font-size:14px; }
        .total{ font-size:20px; font-weight:900; }
        .err{ background: rgba(239,68,68,0.12); color:#991b1b; padding:10px 12px; border-radius:12px; margin-bottom:12px; font-weight:800; }
        @media (max-width: 980px){ .row{ grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<div class="container wrap">
    <div class="section-title">
        <h2>📍 Checkout</h2>
        <p class="section-subtitle">Introduce la dirección y confirma el pedido.</p>
    </div>

    <div class="row">
        <!-- FORM -->
        <div class="card">
            <c:if test="${not empty error}">
                <div class="err">${error}</div>
            </c:if>

            <form method="post" action="<%= request.getContextPath() %>/checkout">
                <div class="form-group">
                    <label style="font-weight:900; display:block; margin-bottom:6px;">Dirección de envío</label>
                    <textarea name="direccion_envio" class="form-group" style="width:100%; min-height:110px; padding:12px; border-radius:14px; border:1px solid rgba(15,23,42,0.10);" required
                              placeholder="Calle, número, piso/puerta, CP, ciudad, provincia..."></textarea>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-credit-card"></i> Confirmar pedido
                </button>

                <div style="margin-top:12px;">
                    <a class="btn-secondary" href="<%= request.getContextPath() %>/carrito">⬅ Volver al carrito</a>
                </div>
            </form>
        </div>

        <div class="card">
            <h3 style="margin-top:0;">Resumen</h3>
            <p class="sum">Se creará el pedido y se actualizará el stock automáticamente.</p>
            <div class="total">Total: ${total} €</div>
        </div>
    </div>
</div>

</body>
</html>

