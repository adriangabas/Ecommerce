-- ecommerce.formulario_contacto definition

CREATE TABLE `formulario_contacto` (
                                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                       `nombre` varchar(50) NOT NULL,
                                       `email` varchar(100) DEFAULT NULL,
                                       `asunto` varchar(100) DEFAULT NULL,
                                       `mensaje` varchar(500) DEFAULT NULL,
                                       `fecha` datetime NOT NULL DEFAULT current_timestamp(),
                                       `leido` tinyint(1) NOT NULL DEFAULT 0,
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ecommerce.productos definition

CREATE TABLE `productos` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `nombre` varchar(50) NOT NULL,
                             `descripcion` varchar(500) DEFAULT NULL,
                             `categoria` varchar(50) DEFAULT NULL,
                             `precio` decimal(10,2) NOT NULL DEFAULT 0.00,
                             `stock` int(10) unsigned NOT NULL DEFAULT 0,
                             `stock_min` int(10) unsigned NOT NULL DEFAULT 0,
                             `email_aviso` varchar(100) DEFAULT NULL,
                             `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
                             `activo` tinyint(1) NOT NULL DEFAULT 1,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ecommerce.usuarios definition

CREATE TABLE `usuarios` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `nombre` varchar(50) NOT NULL,
                            `apellidos` varchar(50) DEFAULT NULL,
                            `email` varchar(100) NOT NULL,
                            `password` varchar(255) NOT NULL,
                            `rol` enum('admin','client') NOT NULL DEFAULT 'client',
                            `telefono` varchar(20) DEFAULT NULL,
                            `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
                            `activo` tinyint(1) NOT NULL DEFAULT 1,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ecommerce.movimientos_stock definition

CREATE TABLE `movimientos_stock` (
                                     `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                     `tipo` enum('entrada','salida') NOT NULL,
                                     `cantidad` int(10) unsigned NOT NULL DEFAULT 1,
                                     `motivo` enum('pedido','ajuste','reposicion') NOT NULL,
                                     `fecha` datetime NOT NULL DEFAULT current_timestamp(),
                                     `referencia` varchar(50) NOT NULL,
                                     `id_producto` int(10) unsigned NOT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `id_producto` (`id_producto`),
                                     CONSTRAINT `movimientos_stock_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ecommerce.pedidos definition

CREATE TABLE `pedidos` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `fecha_pedido` datetime NOT NULL DEFAULT current_timestamp(),
                           `estado` enum('pendiente','en_proceso','finalizado','cancelado') NOT NULL DEFAULT 'pendiente',
                           `total` decimal(10,2) NOT NULL DEFAULT 0.00,
                           `direccion_envio` varchar(100) DEFAULT NULL,
                           `id_usuario` int(10) unsigned NOT NULL,
                           PRIMARY KEY (`id`),
                           KEY `id_usuario` (`id_usuario`),
                           CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ecommerce.lineas_pedido definition

CREATE TABLE `lineas_pedido` (
                                 `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                 `cantidad` int(10) unsigned NOT NULL DEFAULT 1,
                                 `precio_unitario` decimal(10,2) NOT NULL DEFAULT 0.00,
                                 `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
                                 `id_producto` int(10) unsigned NOT NULL,
                                 `id_pedido` int(10) unsigned NOT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `id_pedido` (`id_pedido`,`id_producto`),
                                 KEY `id_producto` (`id_producto`),
                                 CONSTRAINT `lineas_pedido_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
                                 CONSTRAINT `lineas_pedido_ibfk_2` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;