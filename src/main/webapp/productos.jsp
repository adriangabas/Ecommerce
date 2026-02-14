<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background:#f7f7f7; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px; }
        .card { background: #fff; border-radius: 12px; padding: 16px; box-shadow: 0 4px 10px rgba(0,0,0,0.08); }
        .name { font-size: 18px; font-weight: bold; margin-bottom: 6px; }
        .cat { color: #666; font-size: 13px; margin-bottom: 10px; }
        .price { font-size: 16px; font-weight: bold; margin-top: 10px; }
        .stock { margin-top: 6px; font-size: 13px; }
        a { text-decoration:none; font-weight:bold; }
        .top { margin-bottom: 18px; }
        .empty { background: #fff; padding: 16px; border-radius: 12px; }
    </style>
</head>
<body>

<div class="top">
    <h1>📦 Catálogo de productos</h1>
    <p><a href="<%= request.getContextPath() %>/">⬅ Volver al inicio</a></p>
</div>

<c:if test="${empty productos}">
    <div class="empty">
        ⚠️ No hay productos activos en la BD.
    </div>
</c:if>

<c:if test="${not empty productos}">
    <div class="grid">
        <c:forEach var="p" items="${productos}">
            <div class="card">
                <div class="name">${p.nombre}</div>
                <div class="cat">${p.categoria}</div>
                <div>${p.descripcion}</div>

                <div class="price">${p.precio} €</div>
                <div class="stock">Stock: ${p.stock} (mín: ${p.stock_min})</div>
            </div>
        </c:forEach>
    </div>
</c:if>

</body>
</html>

