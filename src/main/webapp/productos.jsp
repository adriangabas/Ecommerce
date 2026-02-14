<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>E-commerce | Catálogo</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>

<body>

<!-- Header -->
<header>
    <div class="container header-container">
        <a class="logo" href="<%= request.getContextPath() %>/">
            <i class="fas fa-box"></i>
            E-commerce<span>Logística</span>
        </a>

        <button class="hamburger" id="hamburger" aria-label="Abrir menú">
            <i class="fas fa-bars"></i>
        </button>

        <nav>
            <ul id="nav-menu">
                <li><a href="<%= request.getContextPath() %>/" >Inicio</a></li>
                <li><a href="<%= request.getContextPath() %>/productos" class="active">Productos</a></li>
                <li><a href="#contact">Contacto</a></li>
                <li><a href="#footer">Empresa</a></li>
            </ul>
        </nav>

        <div class="header-actions">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input id="searchInput" type="text" placeholder="Buscar cajas, palets, bandejas...">
            </div>

            <div class="cart-icon" id="cart-icon" title="Ver carrito">
                <i class="fas fa-shopping-cart"></i>
                <span class="cart-count" id="cartCount">0</span>
            </div>
        </div>
    </div>
</header>

<!-- Product Section -->
<section class="products-section" id="products">
    <div class="container">
        <div class="section-title">
            <h2>Catálogo de productos</h2>
            <p class="section-subtitle">Embalaje y logística: cajas, palets, consumibles y protección.</p>
        </div>

        <c:if test="${empty productos}">
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <h3>No hay productos disponibles</h3>
                <p>Ahora mismo no tenemos productos activos en el catálogo.</p>
                <a class="btn-secondary" href="<%= request.getContextPath() %>/">Volver al inicio</a>
            </div>
        </c:if>

        <c:if test="${not empty productos}">
            <div class="products-grid" id="productsGrid">

                <c:forEach var="p" items="${productos}">
                    <c:set var="catLower" value="${fn:toLowerCase(p.categoria)}"/>

                    <div class="product-card"
                         data-name="${fn:toLowerCase(p.nombre)}"
                         data-cat="${fn:toLowerCase(p.categoria)}">

                        <c:choose>
                            <c:when test="${fn:contains(catLower, 'palet')}">
                                <img src="<%= request.getContextPath() %>/img/palet.png" alt="${p.nombre}" class="product-img">
                            </c:when>
                            <c:otherwise>
                                <img src="<%= request.getContextPath() %>/img/caja.png" alt="${p.nombre}" class="product-img">
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

                            <button class="add-to-cart"
                                    data-id="${p.id}"
                                    data-name="${p.nombre}"
                                    data-price="${p.precio}"
                                    data-category="${p.categoria}">
                                <i class="fas fa-cart-plus"></i> Añadir al carrito
                            </button>
                        </div>

                    </div>
                </c:forEach>

            </div>
        </c:if>

    </div>
</section>

<!-- Contact Section -->
<section class="contact-section" id="contact">
    <div class="container">
        <div class="section-title">
            <h2>Contacto</h2>
            <p class="section-subtitle">¿Necesitas asesoramiento de embalaje o un presupuesto?</p>
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
                        <p>Lunes a Viernes: 9:00 - 18:00</p>
                    </div>
                </div>

                <div class="contact-item">
                    <div class="contact-icon"><i class="fas fa-envelope"></i></div>
                    <div>
                        <h3>Correo</h3>
                        <p>soporte@ecommercelogistica.com</p>
                    </div>
                </div>

                <div class="contact-item">
                    <div class="contact-icon"><i class="fas fa-truck"></i></div>
                    <div>
                        <h3>Envíos</h3>
                        <p>Entrega 24/48h en Península (según zona y producto)</p>
                    </div>
                </div>
            </div>

            <div class="contact-form">
                <form id="contactForm">
                    <div class="form-group">
                        <input type="text" placeholder="Tu Nombre" required>
                    </div>
                    <div class="form-group">
                        <input type="email" placeholder="Tu Correo Electrónico" required>
                    </div>
                    <div class="form-group">
                        <input type="tel" placeholder="Tu Teléfono">
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

<!-- Footer -->
<footer id="footer">
    <div class="container">
        <div class="footer-container">
            <div class="footer-col">
                <h3>E-commerce Logística</h3>
                <p>Catálogo de embalaje y suministros: cajas, palets, bandejas, protección y consumibles.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-whatsapp"></i></a>
                </div>
            </div>

            <div class="footer-col">
                <h3>Enlaces</h3>
                <ul>
                    <li><a href="<%= request.getContextPath() %>/">Inicio</a></li>
                    <li><a href="<%= request.getContextPath() %>/productos">Productos</a></li>
                    <li><a href="#contact">Contacto</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Categorías</h3>
                <ul>
                    <li><a href="#" class="cat-filter" data-cat="cajas">Cajas</a></li>
                    <li><a href="#" class="cat-filter" data-cat="palets">Palets</a></li>
                    <li><a href="#" class="cat-filter" data-cat="bandeja">Bandejas</a></li>
                    <li><a href="#" class="cat-filter" data-cat="consumibles">Consumibles</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Boletín</h3>
                <p>Ofertas y avisos de stock bajo (sin spam).</p>
                <div class="form-group">
                    <input type="email" placeholder="Tu correo electrónico" class="newsletter-input">
                </div>
                <button class="submit-btn newsletter-btn">Suscribirse</button>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2026 E-commerce Logística. Todos los derechos reservados.</p>
        </div>
    </div>
</footer>

<!-- Cart Sidebar -->
<div class="cart-sidebar" id="cart-sidebar">
    <div class="cart-header">
        <h3 class="cart-title">Tu Carrito</h3>
        <button class="close-cart" id="close-cart" aria-label="Cerrar carrito">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="cart-items" id="cart-items">
        <div class="cart-empty">
            <i class="fas fa-shopping-cart"></i>
            <p>Tu carrito está vacío</p>
            <p>Agrega productos para verlos aquí</p>
        </div>
    </div>

    <div class="cart-total">
        <span>Total:</span>
        <span id="cart-total">0.00 €</span>
    </div>

    <button class="checkout-btn" id="checkoutBtn">
        <i class="fas fa-credit-card"></i> Tramitar pedido
    </button>
</div>

<div class="overlay" id="overlay"></div>
</body>
</html>
