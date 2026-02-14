<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>E-commerce | Catálogo</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>

<body>

<!-- HEADER -->
<header>
    <div class="container header-container">

        <a class="logo" href="<%= request.getContextPath() %>/productos">
            <i class="fas fa-box"></i>
            Ecommerce<span>Logística</span>
        </a>

        <button class="hamburger" id="hamburger" aria-label="Abrir menú">
            <i class="fas fa-bars"></i>
        </button>

        <nav>
            <ul id="nav-menu">
                <li><a href="<%= request.getContextPath() %>/productos" class="active">Productos</a></li>
                <li><a href="#contact">Contacto</a></li>
                <li><a href="#footer">Empresa</a></li>
            </ul>
        </nav>

        <div class="header-actions">
            <!-- Buscador visual (sin JS no filtra) -->
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Buscar cajas, palets, bandejas...">
            </div>

            <!-- Carrito REAL: te lleva a /carrito -->
            <a class="cart-icon" href="<%= request.getContextPath() %>/carrito" title="Ver carrito" style="text-decoration:none;">
                <i class="fas fa-shopping-cart"></i>

                <!-- contador: número de items en sesión -->
                <c:set var="cart" value="${sessionScope.cart}" />
                <c:set var="count" value="0" />

                <c:if test="${not empty cart}">
                    <c:forEach var="e" items="${cart}">
                        <c:set var="count" value="${count + e.value.cantidad}" />
                    </c:forEach>
                </c:if>

                <span class="cart-count">${count}</span>
            </a>
        </div>
    </div>
</header>

<!-- PRODUCTOS -->
<section class="products-section" id="products">
    <div class="container">

        <div class="section-title">
            <h2>Catálogo de productos</h2>
            <p class="section-subtitle">Embalaje y logística: cajas, palets, consumibles y protección.</p>
        </div>

        <!-- Si NO hay productos -->
        <c:if test="${empty productos}">
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <h3>No hay productos disponibles</h3>
                <p>No tenemos productos activos en el catálogo ahora mismo.</p>
            </div>
        </c:if>

        <!-- Si SÍ hay productos -->
        <c:if test="${not empty productos}">
            <div class="products-grid">

                <c:forEach var="p" items="${productos}">
                    <c:set var="catLower" value="${fn:toLowerCase(p.categoria)}"/>

                    <div class="product-card">

                        <!-- IMAGEN -->
                        <c:choose>
                            <c:when test="${fn:contains(catLower, 'palet')}">
                                <img src="<%= request.getContextPath() %>/img/paleteuropeo.png"
                                     alt="${p.nombre}" class="product-img">
                            </c:when>
                            <c:otherwise>
                                <img src="<%= request.getContextPath() %>/img/cajakarton.png"
                                     alt="${p.nombre}" class="product-img">
                            </c:otherwise>
                        </c:choose>

                        <div class="product-info">
                            <div class="product-category">${p.categoria}</div>

                            <h3 class="product-title">${p.nombre}</h3>

                            <p class="product-description">
                                <c:out value="${p.descripcion}"/>
                            </p>

                            <div class="product-meta">
                                <div class="product-price">${p.precio} €</div>

                                <c:choose>
                                    <c:when test="${p.stock <= 0}">
                                        <span class="badge badge-danger">Sin stock</span>
                                    </c:when>
                                    <c:when test="${p.stock <= p.stock_min}">
                                        <span class="badge badge-warn">Bajo stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-ok">En stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="product-stock">
                                <span>Stock: <b>${p.stock}</b> (mín: ${p.stock_min})</span>
                            </div>

                            <!-- AÑADIR AL CARRITO (SERVIDOR) -->
                            <c:choose>
                                <c:when test="${p.stock <= 0}">
                                    <button class="add-to-cart" type="button" disabled style="opacity:.6; cursor:not-allowed;">
                                        <i class="fas fa-ban"></i> No disponible
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <form method="post" action="<%= request.getContextPath() %>/carrito" style="margin:0;">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <input type="hidden" name="nombre" value="${p.nombre}">
                                        <input type="hidden" name="categoria" value="${p.categoria}">
                                        <input type="hidden" name="precio" value="${p.precio}">
                                        <input type="hidden" name="imagen"
                                               value="/img/${fn:contains(catLower, 'palet') ? 'paleteuropeo.png' : 'cajakarton.png'}">

                                        <button class="add-to-cart" type="submit">
                                            <i class="fas fa-cart-plus"></i> Añadir al carrito
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>

                </c:forEach>

            </div>
        </c:if>

    </div>
</section>

<!-- CONTACTO -->
<section class="contact-section" id="contact">
    <div class="container">
        <div class="section-title">
            <h2>Contacto</h2>
            <p class="section-subtitle">¿Necesitas asesoramiento o presupuesto?</p>
        </div>

        <div class="contact-container">

            <div class="contact-info">
                <div class="contact-item">
                    <div class="contact-icon"><i class="fas fa-map-marker-alt"></i></div>
                    <div>
                        <h3>Dirección</h3>
                        <p>Zaragoza (España)</p>
                    </div>
                </div>

                <div class="contact-item">
                    <div class="contact-icon"><i class="fas fa-phone"></i></div>
                    <div>
                        <h3>Teléfono</h3>
                        <p>+34 600 000 000</p>
                    </div>
                </div>

                <div class="contact-item">
                    <div class="contact-icon"><i class="fas fa-envelope"></i></div>
                    <div>
                        <h3>Email</h3>
                        <p>soporte@ecommercelogistica.com</p>
                    </div>
                </div>
            </div>

            <div class="contact-form">
                <!-- Formulario solo visual (si quieres, luego lo mandamos a un servlet) -->
                <form>
                    <div class="form-group">
                        <input type="text" placeholder="Tu Nombre" required>
                    </div>
                    <div class="form-group">
                        <input type="email" placeholder="Tu Correo Electrónico" required>
                    </div>
                    <div class="form-group">
                        <textarea placeholder="Tu Mensaje" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Enviar Mensaje</button>
                </form>
            </div>

        </div>
    </div>
</section>

<!-- FOOTER -->
<footer id="footer">
    <div class="container">
        <div class="copyright">
            <p>&copy; 2026 Ecommerce Logística - Proyecto DAM</p>
        </div>
    </div>
</footer>

</body>
</html>
