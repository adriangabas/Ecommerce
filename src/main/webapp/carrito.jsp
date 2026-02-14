<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Carrito</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    <style>
        .cart-page{ padding: 28px 0 40px; }
        .cart-wrap{ background:#fff; border-radius:16px; padding:16px; box-shadow: var(--shadow); border:1px solid rgba(15,23,42,0.06); }
        .cart-row{ display:grid; grid-template-columns: 72px 1fr 140px 160px 110px; gap:12px; align-items:center; padding:12px 0; border-bottom:1px solid rgba(15,23,42,0.08); }
        .cart-row:last-child{ border-bottom:none; }
        .cart-thumb{ width:72px; height:54px; object-fit:contain; background:linear-gradient(135deg, rgba(11,87,208,0.10), rgba(34,197,94,0.08)); border-radius:14px; padding:8px; }
        .cart-actions form{ display:inline; }
        .btn-mini{ border:none; cursor:pointer; padding:8px 10px; border-radius:12px; font-weight:800; }
        .btn-mini.primary{ background:rgba(11,87,208,0.12); color:var(--primary); }
        .btn-mini.danger{ background:rgba(239,68,68,0.12); color:#991b1b; }
        .totals{ display:flex; justify-content:space-between; align-items:center; margin-top:14px; }
    </style>
</head>
<body>

<div class="container cart-page">
    <div class="section-title">
        <h2>🛒 Tu carrito</h2>
        <p class="section-subtitle">Revisa cantidades antes de tramitar el pedido.</p>
    </div>

    <div class="cart-wrap">

        <c:set var="cart" value="${sessionScope.cart}" />

        <c:if test="${empty cart}">
            <div class="empty-state">
                <i class="fas fa-shopping-cart"></i>
                <h3>Carrito vacío</h3>
                <p>Vuelve al catálogo y añade productos.</p>
                <a class="btn-secondary" href="<%= request.getContextPath() %>/productos">Ir a productos</a>
            </div>
        </c:if>

        <c:if test="${not empty cart}">
            <c:set var="total" value="0" />

            <c:forEach var="e" items="${cart}">
                <c:set var="it" value="${e.value}" />
                <c:set var="total" value="${total + it.subtotal}" />

                <div class="cart-row">
                    <img class="cart-thumb" src="<%= request.getContextPath() %>${it.imagen}" alt="${it.nombre}">

                    <div>
                        <div style="font-weight:900">${it.nombre}</div>
                        <div style="color:#64748b;font-size:13px">${it.categoria}</div>
                    </div>

                    <div style="font-weight:900">${it.precio} €</div>

                    <div class="cart-actions">
                        <form method="post" action="<%= request.getContextPath() %>/carrito">
                            <input type="hidden" name="action" value="dec">
                            <input type="hidden" name="id" value="${it.idProducto}">
                            <button class="btn-mini primary" type="submit">-</button>
                        </form>

                        <span style="display:inline-block;min-width:40px;text-align:center;font-weight:900">
                                ${it.cantidad}
                        </span>

                        <form method="post" action="<%= request.getContextPath() %>/carrito">
                            <input type="hidden" name="action" value="inc">
                            <input type="hidden" name="id" value="${it.idProducto}">
                            <button class="btn-mini primary" type="submit">+</button>
                        </form>

                        <form method="post" action="<%= request.getContextPath() %>/carrito">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="id" value="${it.idProducto}">
                            <button class="btn-mini danger" type="submit">Eliminar</button>
                        </form>
                    </div>

                    <div style="font-weight:900">${it.subtotal} €</div>
                </div>
            </c:forEach>

            <div class="totals">
                <form method="post" action="<%= request.getContextPath() %>/carrito">
                    <input type="hidden" name="action" value="clear">
                    <button class="btn-mini danger" type="submit">Vaciar carrito</button>
                </form>

                <div style="font-size:18px;font-weight:900">
                    Total: ${total} €
                </div>
            </div>

            <div style="margin-top:14px; display:flex; gap:12px; justify-content:flex-end;">
                <a class="btn-secondary" href="<%= request.getContextPath() %>/productos">Seguir comprando</a>
                <a class="submit-btn" style="width:auto; text-decoration:none; display:inline-block;"
                   href="<%= request.getContextPath() %>/checkout">Tramitar pedido</a>
            </div>
        </c:if>

    </div>
</div>

</body>
</html>
