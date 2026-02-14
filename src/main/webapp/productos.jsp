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

    <!-- CSS local -->
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
            <div class="products-grid" id="productsGrid">

                <c:forEach var="p" items="${productos}">
                    <c:set var="catLower" value="${fn:toLowerCase(p.categoria)}"/>

                    <div class="product-card"
                         data-name="${fn:toLowerCase(p.nombre)}"
                         data-cat="${fn:toLowerCase(p.categoria)}">

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

                            <!-- BOTÓN -->
                            <button class="add-to-cart"
                                    data-id="${p.id}"
                                    data-name="${p.nombre}"
                                    data-price="${p.precio}"
                                    data-image="<%= request.getContextPath() %>/img/${fn:contains(catLower, 'palet') ? 'paleteuropeo.png' : 'cajakarton.png'}">
                                <i class="fas fa-cart-plus"></i> Añadir al carrito
                            </button>

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
                <form id="contactForm">
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

<!-- CARRITO LATERAL -->
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

<!-- ========================= -->
<!-- JS DEL CARRITO + BUSCADOR -->
<!-- ========================= -->
<script>
    // DOM
    const cartIcon = document.getElementById('cart-icon');
    const cartSidebar = document.getElementById('cart-sidebar');
    const closeCart = document.getElementById('close-cart');
    const overlay = document.getElementById('overlay');
    const cartItemsContainer = document.getElementById('cart-items');
    const cartTotalElement = document.getElementById('cart-total');
    const cartCountElement = document.getElementById('cartCount');
    const addToCartButtons = document.querySelectorAll('.add-to-cart');

    const hamburger = document.getElementById('hamburger');
    const navMenu = document.getElementById('nav-menu');

    const searchInput = document.getElementById('searchInput');
    const productsGrid = document.getElementById('productsGrid');

    // Carrito
    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    // Inicializar
    updateCartDisplay();

    // Abrir carrito
    cartIcon.addEventListener('click', () => {
        cartSidebar.classList.add('active');
        overlay.classList.add('active');
    });

    // Cerrar carrito
    closeCart.addEventListener('click', closeAll);

    overlay.addEventListener('click', closeAll);

    function closeAll() {
        cartSidebar.classList.remove('active');
        overlay.classList.remove('active');
        navMenu.classList.remove('active');
    }

    // Menú hamburguesa
    hamburger.addEventListener('click', () => {
        navMenu.classList.toggle('active');
        overlay.classList.toggle('active');
    });

    // Añadir al carrito
    addToCartButtons.forEach(button => {
        button.addEventListener('click', () => {

            const id = button.getAttribute('data-id');
            const name = button.getAttribute('data-name');
            const price = parseFloat(button.getAttribute('data-price'));
            const image = button.getAttribute('data-image');

            const existingItem = cart.find(item => item.id === id);

            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({id, name, price, image, quantity: 1});
            }

            localStorage.setItem('cart', JSON.stringify(cart));
            updateCartDisplay();

            // efecto
            button.innerHTML = '<i class="fas fa-check"></i> Añadido';
            button.style.background = '#4CAF50';

            setTimeout(() => {
                button.innerHTML = '<i class="fas fa-cart-plus"></i> Añadir al carrito';
                button.style.background = '';
            }, 1000);
        });
    });

    // Buscador
    if (searchInput) {
        searchInput.addEventListener('input', () => {
            const q = searchInput.value.toLowerCase().trim();

            const cards = document.querySelectorAll('.product-card');
            cards.forEach(card => {
                const name = card.getAttribute('data-name');
                const cat = card.getAttribute('data-cat');

                if (name.includes(q) || cat.includes(q)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    }

    // Pintar carrito
    function updateCartDisplay() {

        const totalCount = cart.reduce((total, item) => total + item.quantity, 0);
        cartCountElement.textContent = totalCount;

        const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        cartTotalElement.textContent = total.toFixed(2) + " €";

        cartItemsContainer.innerHTML = "";

        if (cart.length === 0) {
            cartItemsContainer.innerHTML = `
                <div class="cart-empty">
                    <i class="fas fa-shopping-cart"></i>
                    <p>Tu carrito está vacío</p>
                    <p>Agrega productos para verlos aquí</p>
                </div>
            `;
            return;
        }

        cart.forEach(item => {
            const div = document.createElement("div");
            div.className = "cart-item";

            div.innerHTML = `
                <img src="${item.image}" alt="${item.name}" class="cart-item-img">

                <div class="cart-item-info">
                    <div class="cart-item-title">${item.name}</div>
                    <div class="cart-item-price">${item.price.toFixed(2)} €</div>

                    <div class="cart-item-quantity">
                        <button class="quantity-btn decrease" data-id="${item.id}">-</button>
                        <span>${item.quantity}</span>
                        <button class="quantity-btn increase" data-id="${item.id}">+</button>
                    </div>

                    <button class="remove-item" data-id="${item.id}">Eliminar</button>
                </div>
            `;

            cartItemsContainer.appendChild(div);
        });

        // botones -
        document.querySelectorAll(".decrease").forEach(btn => {
            btn.addEventListener("click", () => {
                const id = btn.getAttribute("data-id");
                const item = cart.find(i => i.id === id);

                if (!item) return;

                if (item.quantity > 1) {
                    item.quantity -= 1;
                } else {
                    cart = cart.filter(i => i.id !== id);
                }

                localStorage.setItem("cart", JSON.stringify(cart));
                updateCartDisplay();
            });
        });

        // botones +
        document.querySelectorAll(".increase").forEach(btn => {
            btn.addEventListener("click", () => {
                const id = btn.getAttribute("data-id");
                const item = cart.find(i => i.id === id);

                if (!item) return;

                item.quantity += 1;

                localStorage.setItem("cart", JSON.stringify(cart));
                updateCartDisplay();
            });
        });

        // eliminar
        document.querySelectorAll(".remove-item").forEach(btn => {
            btn.addEventListener("click", () => {
                const id = btn.getAttribute("data-id");
                cart = cart.filter(i => i.id !== id);

                localStorage.setItem("cart", JSON.stringify(cart));
                updateCartDisplay();
            });
        });
    }
</script>

</body>
</html>
