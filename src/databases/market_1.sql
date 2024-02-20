-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 15-02-2024 a las 01:35:12
-- Versión del servidor: 8.0.36-0ubuntu0.22.04.1
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

START TRANSACTION;

SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;

--
-- Base de datos: `market`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carritos`
--

CREATE DATABASE market;

USE market;

CREATE TABLE `carritos` (
    `id` int UNSIGNED NOT NULL, `cantidad` decimal(9, 3) NOT NULL, `id_producto` int UNSIGNED NOT NULL, `id_tienda` smallint UNSIGNED NOT NULL, `id_user` mediumint UNSIGNED NOT NULL COMMENT 'Cliente Comprador', `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los Productos agregados al Carrito de Compras de un Cliente';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
    `id` mediumint UNSIGNED NOT NULL, `instrucciones` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `entrega_fecha` date NOT NULL COMMENT 'El cliente cuando desea que su pedido sea entregado', `valor_productos` decimal(12, 3) UNSIGNED NOT NULL, `valor_envio` decimal(10, 3) UNSIGNED NOT NULL, `valor_descuento` decimal(12, 3) UNSIGNED NOT NULL COMMENT 'Valor producto - Valor promo', `valor_cupon` decimal(11, 3) UNSIGNED NOT NULL DEFAULT '0.000' COMMENT 'Valor descuento por cupón aplicado (tomado del pedido hijo)', `impuestos` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0=No 1=Si', `valor_impuestos` decimal(11, 3) NOT NULL DEFAULT '0.000' COMMENT 'Valor de impuestos de todos los productos -- No tiene en cuenta el valor final', `valor_final` decimal(12, 3) UNSIGNED NOT NULL, `calificacion` decimal(3, 2) DEFAULT NULL COMMENT 'Calculado con todas las Calificaciones y sus pesos', `id_tienda` smallint UNSIGNED NOT NULL, `direccion` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Guardar el String de la dirección del cliente en ese momento. En manual es digitada', `valor_comision` decimal(11, 3) NOT NULL DEFAULT '0.000' COMMENT 'Es el valor de la comisión calculado segun la utilidad', `id_user` mediumint UNSIGNED DEFAULT NULL COMMENT 'Cliente', `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los Pedidos hechos por el Cliente, con la información Resumen y directa';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_estados`
--

CREATE TABLE `pedidos_estados` (
    `id` int UNSIGNED NOT NULL, `estado` tinyint UNSIGNED NOT NULL COMMENT '	1=Creado 2=Confirmado 3=Enviado 4=Finalizado 25=Rechazado 26=Cancelado Tienda 27=Cancelado Cliente 31=Reclamo 32=Reclamo Finalizado 33=Soporte 34=Soporte Finalizado', `id_pedido` mediumint UNSIGNED NOT NULL, `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Es el Historial de los Estados de un Pedido';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_productos`
--

CREATE TABLE `pedidos_productos` (
    `id` mediumint UNSIGNED NOT NULL, `cantidad` decimal(9, 3) NOT NULL, `valor_unitario` decimal(11, 3) UNSIGNED NOT NULL COMMENT 'Valor en _productos_', `valor_unitario_promocion` decimal(11, 3) UNSIGNED NOT NULL COMMENT 'Valor en _productos_ si tiene promo _valor_promo_ si no tiene _valor_', `total_teorico` decimal(12, 3) UNSIGNED NOT NULL, `total_final` decimal(12, 3) UNSIGNED NOT NULL COMMENT 'Se usa siempre, y es por motivo de si llega a haber promoción', `id_promocion` mediumint UNSIGNED DEFAULT NULL COMMENT 'La promoción de como se vendió', `id_producto` int UNSIGNED DEFAULT NULL COMMENT 'Null = Se borró el producto después', `id_pedido` mediumint UNSIGNED NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los Productos asociados a un Pedido';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
    `id` int UNSIGNED NOT NULL, `estado` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0=Inactivo 1=Activo.', `kit` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0=No 1=Si... Para evaluar disponibilidad, descuentos y otros en productos_kits', `barcode` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Código de barras', `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `presentacion` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `descripcion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `foto` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Max 200', `peso` decimal(6, 2) NOT NULL DEFAULT '0.00' COMMENT 'En Kilogramos'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los Productos en general de todo el Proyecto';

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO
    `productos` (
        `id`, `estado`, `kit`, `barcode`, `nombre`, `presentacion`, `descripcion`, `foto`, `peso`
    )
VALUES (
        1, 1, 0, '-', 'Cobertura Chocolate Negro Nacional De Chocolate', '1000 gr', 'Cobertura Chocolate Negro Nacional De Chocolate  - 1000gr', NULL, 0.00
    ),
    (
        2, 1, 0, '0', 'Bebida Achocolatada Chocolisto Cookies & Cream', '180 gr', 'Bebida Achocolatada Chocolisto Cookies & Cream - 180 gr', NULL, 0.00
    ),
    (
        3, 1, 0, '0100010000048', 'Pulpa de fruta Manzana Concentrado', 'Tambor 238 kilos', NULL, NULL, 0.00
    ),
    (
        4, 1, 0, '0100010000063', 'Pulpa de fruta Pera Concentrado', 'Tambor x 238 kilos', NULL, NULL, 0.00
    ),
    (
        5, 1, 0, '0110645667271171', 'Desechable Darnel C1', 'Pq x 500 Unid', 'Desechable Darnel C1 - Pq x 500 Unid', NULL, 0.00
    ),
    (
        6, 1, 0, '011111124127', 'Jabon Liquido Corporal Dove', '354ml', 'Jabon Liquido Corporal Dove - 354 ml', NULL, 0.00
    ),
    (
        7, 1, 0, '0117702458001157', 'Blonda Icopor Circular No.17 Darnel', 'Pq x 200 Unid', 'Blonda Icopor Circular No.17 Darnel Blanca Pq x 200 Unid', NULL, 0.00
    ),
    (
        8, 1, 0, '0117702458083610', 'Vinipel', '1500 Mts', 'Vinipel x 1500 Mts', NULL, 0.00
    ),
    (
        9, 1, 0, '0117702458223696', 'Desechable Darnel P1', 'Pq x 200 Unid', 'Desechable Darnel P1 -Paquete x 200 Unidades', NULL, 0.00
    ),
    (
        10, 1, 0, '0117702458227922', 'Desechable Darnel J1', 'Pq x 200 Unid', 'Desechable Darnel J1 - Pq x 200 Unid', NULL, 0.00
    ),
    (
        11, 1, 0, '0117702458227946', 'Desechable J2 Darnel', 'Bulto - 200 Und', 'Desechable J2 Darnel x Bulto (200)', NULL, 0.00
    ),
    (
        12, 1, 0, '021000026326', 'Salsa Mayonesa Kraft', '887 ml', 'Salsa Mayonesa Kraft x 887 ml', NULL, 0.00
    ),
    (
        13, 1, 0, '021200510069', 'Guantes Scotch Brite', 'Unidad', 'Guantes Scotch Brite x Unidad', NULL, 0.00
    ),
    (
        14, 1, 0, '03436602', 'Caramelo Sirup Hersheys', '623 gr', 'Caramelo Sirup Hersheys - 623 gr', NULL, 0.00
    ),
    (
        15, 1, 0, '046500716935', 'Ambientador En Cono Hawaian Glade', '170 gr', 'Ambientador Cono Hawaian Glade x 170 gr', NULL, 0.00
    ),
    (
        16, 1, 0, '053800026619', 'Aceituna En Lata Lindsay Medium', '170 gr', 'Aceituna Lindsay Medium x 170 gr', NULL, 0.00
    ),
    (
        17, 1, 0, '0606110226431', 'Aceite La Viuda', '450 ml', 'Aceite La Viuda x 450 ml', NULL, 0.00
    ),
    (
        18, 1, 0, '0781159010668', 'Arequipe Manjar Blanco MilHoja Premium', '5 kg', 'Arequipe Manjar Blanco MilHoja Premium - 5 kg', NULL, 0.00
    ),
    (
        19, 1, 0, '099176480310', 'Crema Dental Total 12 Clean Mint Colgate', '75 ml', 'Crema Dental Total 12 Clean Mint Colgate x 75 ml', NULL, 0.00
    ),
    (
        20, 1, 0, '1', 'Repollo Morado', '500 gr', 'Repollo Morado - 500 gr', NULL, 0.00
    ),
    (
        21, 1, 0, '100', 'Brevas', '1000 gr', 'Brevas - 1000 gr', NULL, 0.00
    ),
    (
        22, 1, 0, '10000', 'Acelga (Fruver)', '250 gr', 'Acelga x 250 gr', NULL, 0.00
    ),
    (
        23, 1, 0, '1000000000160', 'Piña Perolera', 'Unidad', 'Piña Perolera - Unidad', NULL, 0.00
    ),
    (
        24, 1, 0, '1000000000405', 'Cilantro', 'Unidad', 'Cilantro - Unidad', NULL, 0.00
    ),
    (
        25, 1, 0, '1000000000443', 'Revuelto Verde', 'Unidad', 'Revuelto Verde - Unidad', NULL, 0.00
    ),
    (
        26, 1, 0, '1000000000849', 'Piña Gold', 'Unidad', 'Piña Gold - Unidad', NULL, 0.00
    ),
    (
        27, 1, 0, '1000000000870', 'Uchuva', 'Unidad', 'Uchuva  - Unidad', NULL, 0.00
    ),
    (
        28, 1, 0, '1000000000887', 'Guisantes', 'Bandeja', 'Guisantes -  Bandeja', NULL, 0.00
    ),
    (
        29, 1, 0, '1000000001105', 'Cebolla En Rama', 'Unidad', 'Cebolla En Rama - Unidad', NULL, 0.00
    ),
    (
        30, 1, 0, '1000000001112', 'Picado', 'Unidad', 'Picado x Unidad', NULL, 0.00
    ),
    (
        31, 1, 0, '1000000001129', 'Semilla De Ahuyama', 'Unidad', 'Semilla De Ahuyama - Unidad', NULL, 0.00
    ),
    (
        32, 1, 0, '1000000001198', 'Uva Isabella', 'Bandeja', 'Uva Isabella - Bandeja', NULL, 0.00
    ),
    (
        33, 1, 0, '1000000001280', 'Uva Surtida', 'Bandeja', 'Uva Surtida - Bandeja', NULL, 0.00
    ),
    (
        34, 1, 0, '1000000001679', 'Tomate Rose', '500 gr', 'Tomate Rose  - 500 gr', NULL, 0.00
    ),
    (
        35, 1, 0, '1000000001686', 'Albaricoque', '120 gr', 'Albaricoque - 120 gr', NULL, 0.00
    ),
    (
        36, 1, 0, '1000000001716', 'Perejil Crespo', '100 gr', 'Perejil Crespo - 100 gr', NULL, 0.00
    ),
    (
        37, 1, 0, '1000000001839', 'Manzana', 'Bandeja - 6 Und', 'Manzana Bandeja -   Bandeja - 6 Und', NULL, 0.00
    ),
    (
        38, 1, 0, '1000000001884', 'Papa Limpia Rapimercado', '2500 gr', 'Papa Limpia Rapimercado  - 2500 gr', NULL, 0.00
    ),
    (
        39, 1, 0, '1000000002287', 'Espinaca Congelada', '1000 gr', 'Espinaca Congelada - 1000 gr', NULL, 0.00
    ),
    (
        40, 1, 0, '1000000002874', 'Zumo De Uva', '250 ml', 'Zumo De Uva - 250 ml', NULL, 0.00
    ),
    (
        41, 1, 0, '1000000003086', 'Habichuela', 'Unidad', 'Habichuela - Unidad', NULL, 0.00
    ),
    (
        42, 1, 0, '1000000003154', 'Cerezas Frescas', '1000 gr', 'Cerezas Frescas - 1000 gr', NULL, 0.00
    ),
    (
        43, 1, 0, '1000000003185', 'Col Hoja', 'Unidad', 'Col Hoja  - Unidad', NULL, 0.00
    ),
    (
        44, 1, 0, '1000000003253', 'Hoja De Bijao', 'Unidad', 'Hoja De Bijao - Unidad', NULL, 0.00
    ),
    (
        45, 1, 0, '1000000003680', 'Tomate Snack', '200 gr', 'Tomate Snack - Bandeja  -  200 gr', NULL, 0.00
    ),
    (
        46, 1, 0, '1000000004052', 'Zanahoria Mini', 'Bandeja', 'Zanahoria Mini- Bandeja', NULL, 0.00
    ),
    (
        47, 1, 0, '1000000004410', 'Rabano Rojo Baby', 'Unidad', 'Rabano Rojo Baby - Unidad', NULL, 0.00
    ),
    (
        48, 1, 0, '1000000004731', 'Perejil Crespo Organico', 'Bandeja - 50 gr', 'Perejil Crespo Organico - Bandeja x 50 gr', NULL, 0.00
    ),
    (
        49, 1, 0, '1000000004762', 'Germinado De Repollo', 'Unidad', 'Germinado De Repollo - Unidad', NULL, 0.00
    ),
    (
        50, 1, 0, '1000000004823', 'Espinaca Baby', '200 gr', 'Espinaca Baby - 200 gr', NULL, 0.00
    ),
    (
        51, 1, 0, '1000000004854', 'Germinado De Rabano', 'Unidad', 'Germinado De Rabano - Unidad', NULL, 0.00
    ),
    (
        52, 1, 0, '1000000005011', 'Estropajo', 'und', 'Estropajo - und', NULL, 0.00
    ),
    (
        53, 1, 0, '1000000005097', 'Esparrago', '500 gr', 'Esparrago - 500 gr', NULL, 0.00
    ),
    (
        54, 1, 0, '1000000005134', 'Wok China', '1000 gr', 'Wok China - 1000 gr', NULL, 0.00
    ),
    (
        55, 1, 0, '1000000005196', 'Fresa', 'Bandeja - 250 gr', 'Fresa  - Bandeja - 250 gr', NULL, 0.00
    ),
    (
        56, 1, 0, '1000000005202', 'Fresa', 'Bandeja - 500 gr', 'Fresa - Bandeja  - 500 gr', NULL, 0.00
    ),
    (
        57, 1, 0, '1000000005493', 'Zanahoria  De Colores Baja', '240 gr', 'Zanahoria  De Colores Baja - 240 gr', NULL, 0.00
    ),
    (
        58, 1, 0, '1000000005554', 'Galletas Saltin Semillas Y Cereales', 'Pq x 9 Und', 'Galletas Saltin Semillas Y Cereales - Pq x 9 Und', NULL, 0.00
    ),
    (
        59, 1, 0, '1000000006124', 'Culantro Mazo', 'Unidad', 'Culantro Mazo - Unidad', NULL, 0.00
    ),
    (
        60, 1, 0, '1000000006414', 'Tomate De Sol', 'Bandeja - 500 gr', 'Tomate De Sol -  Bandeja - 500 gr', NULL, 0.00
    ),
    (
        61, 1, 0, '1000000006445', 'Alfalfa', 'Bandeja', 'Alfalfa - Bandeja', NULL, 0.00
    ),
    (
        62, 1, 0, '1000000006919', 'Papa Natural', '12500 gr', 'Papa Natural - 12500 gr', NULL, 0.00
    ),
    (
        63, 1, 0, '1000000007053', 'Perejil Crespo', 'Bandeja', 'Perejil Crespo - Bandeja', NULL, 0.00
    ),
    (
        64, 1, 0, '1000000007152', 'Peras', 'Bandeja', 'Peras - Bandeja', NULL, 0.00
    ),
    (
        65, 1, 0, '1000000007466', 'Arandanos Importado', 'Bandeja', 'Arandanos  Importado -  Bandeja', NULL, 0.00
    ),
    (
        66, 1, 0, '1000000125405', 'Naranja Valencia', '10 Kg', 'Naranja Valencia -10 Kg', NULL, 0.00
    ),
    (
        67, 1, 0, '1000000254839', 'Sopa Bandeja', '200 gr', 'Sopa Bandeja - 200 gr', NULL, 0.00
    ),
    (
        68, 1, 0, '1000000479072', 'Calendula Fresca Kiska', 'Unidad', 'Calendula Fresca Kiska - Unidad', NULL, 0.00
    ),
    (
        69, 1, 0, '1000000479089', 'Laurel Fresco Kiska', 'Unidad', 'Laurel Fresco Kiska - Unidad', NULL, 0.00
    ),
    (
        70, 1, 0, '1000000479096', 'Manzanilla Fresca Kiska', '10 gr', 'Manzanilla Fresca Kiska - 10 gr', NULL, 0.00
    ),
    (
        71, 1, 0, '1000000479133', 'Ruda Freska Kiska', '50 gr', 'Ruda Freska Kiska - 50 gr', NULL, 0.00
    ),
    (
        72, 1, 0, '1000000479157', 'Toronjil Fresco Kiska', '50 gr', 'Toronjil Fresco Kiska - 50 gr', NULL, 0.00
    ),
    (
        73, 1, 0, '1000000479171', 'Guascas Frescas Kiska', '10 gr', 'Guascas Frescas Kiska - 10 gr', NULL, 0.00
    ),
    (
        74, 1, 0, '1000000479423', 'Yerbabuena Fresca Kiska', '1 unid', 'Yerbabuena Fresca Kiska - 1 unid', NULL, 0.00
    ),
    (
        75, 1, 0, '1000000481167', 'Poleo Fresco', '10 gr', 'Poleo Fresco - 10 gr', NULL, 0.00
    ),
    (
        76, 1, 0, '1000000530186', 'Berros Mazo', 'Unidad', 'Berros Mazo - Unidad', NULL, 0.00
    ),
    (
        77, 1, 0, '1000000603644', 'Fresa Economica', 'Bandeja - 350 gr', 'Fresa Economica - Bandeja - 350 gr', NULL, 0.00
    ),
    (
        78, 0, 0, '100000154444', 'Miel Delcasino', 'Pq x 100 Unid - 7 gr', 'Miel Delicaso - Pq x 100 Unid - 7 gr', NULL, 0.00
    ),
    (
        79, 1, 0, '1000004700004', 'Salvia Fesca Kiska', '50 gr', 'Salvia Fesca Kiska - 50 gr', NULL, 0.00
    ),
    (
        80, 1, 0, '1000004700011', 'Hoja Sabila Kiska', 'Unidad', 'Hoja Sabila Kiska -  Unidad', NULL, 0.00
    ),
    (
        81, 1, 0, '1000004700288', 'Espinaca Tierna', '200 gr', 'Espinaca Tierna - 200 gr', NULL, 0.00
    ),
    (
        82, 1, 0, '1000004700301', 'Zaragosa Roja', '400 gr', 'Zaragosa Roja - 400 gr', NULL, 0.00
    ),
    (
        83, 1, 0, '1000004700318', 'Arvejas Castillo', '400 gr', 'Arvejas Castillo - 400 gr', NULL, 0.00
    ),
    (
        84, 1, 0, '1000004700608', 'Frijol Cabeza negra Castillo', '400 gr', 'Frijol Cabeza negra Castillo - 400 gr', NULL, 0.00
    ),
    (
        85, 1, 0, '1000004700622', 'Guandul Verde Castillo', '320 gr', 'Guandul Verde Castillo - 320 gr', NULL, 0.00
    ),
    (
        86, 1, 0, '1000004700646', 'Arvejas Combinadas Castillo', '400 gr', 'Arvejas Combinadas Castillo - 400 gr', NULL, 0.00
    ),
    (
        87, 1, 0, '1000004700653', 'Palomitos Castillo', '300 gr', 'Palomitos Castillo - 300 gr', NULL, 0.00
    ),
    (
        88, 1, 0, '1000004700660', 'Zaragosa Blanca Castillo', '320 gr', 'Zaragosa Blanca Castillo - 320 gr', NULL, 0.00
    ),
    (
        89, 1, 0, '1000004701612', 'Pulpa Pasteurizada Sin Azucar Canoa Guayaba', '230 gr', 'Pulpa Pasteurizada Sin Azucar Canoa Guayaba - 230 Gr', NULL, 0.00
    ),
    (
        90, 1, 0, '1000004701629', 'Pulpa Pasteurizada Canoa Mora Sin Azucar', '230 gr', 'Pulpa Pasteurizada Canoa Mora Sin Azucar - 230 Gr', NULL, 0.00
    ),
    (
        91, 1, 0, '100001878', 'Refresco Sprite', 'ml', NULL, NULL, 0.00
    ),
    (
        92, 1, 0, '1000022005', 'Alfajor Santelmo', '85 gr', 'Alfajor Santelmo x 85 gr', NULL, 0.00
    ),
    (
        93, 1, 0, '100002791', 'Limpiador En Polvo Bicloro Ajax', '388 gr', 'Limpiador En Polvo Bicloro Ajax - 388 gr', NULL, 0.00
    ),
    (
        94, 1, 0, '100002891', 'Desodorante En Barra Lady Speed Wild Fressi', '45 gr', 'Desodorante En Barra Lady Speed Wild Fressi  x 45 gr', NULL, 0.00
    ),
    (
        95, 1, 0, '100006708', 'Crema humectante Dermatopic 250 gr', 'unidad', NULL, NULL, 0.00
    ),
    (
        96, 1, 0, '10001', 'Agraz (Fruver)', '500 gr', 'Agraz x lb', NULL, 0.00
    ),
    (
        97, 0, 0, '100010', 'Cerveza Barrilito', '355 ml Sixpack', NULL, NULL, 0.00
    ),
    (
        98, 0, 0, '100017', 'Chicharos con zanahoria Herdez', '220 g', NULL, NULL, 0.00
    ),
    (
        99, 0, 0, '100018', 'Chipotles en adobo La Costeña', '105 g', NULL, NULL, 0.00
    ),
    (
        100, 1, 0, '10002', 'Agraz Bandeja (Fruver)', 'Bandeja', 'Agraz x Bandeja', NULL, 0.00
    ),
    (
        101, 0, 0, '100024', 'Cerveza clara Corona extra', '355 ml Sixpack', NULL, NULL, 0.00
    ),
    (
        102, 0, 0, '100029', 'Doritos Nacho', '340 gr', 'Doritos Nacho x 340 gr', NULL, 0.00
    ),
    (
        103, 1, 0, '100029687', 'Cajeta YOPI 250 gr', 'gr', NULL, NULL, 0.00
    ),
    (
        104, 1, 0, '10003', 'Aguacate (Fruver)', 'Unidad', 'Aguacate x unidad', NULL, 0.00
    ),
    (
        105, 0, 0, '100030', 'Doritos pizzerolas', '340 gr', NULL, NULL, 0.00
    ),
    (
        106, 0, 0, '100033', 'Fabuloso frescura activa', '1000 ml', NULL, NULL, 0.00
    ),
    (
        107, 0, 0, '100035', 'Fresca', '600 ml', NULL, NULL, 0.00
    ),
    (
        108, 1, 0, '1000350115255', 'Albahaca Fresca Kiska', 'Unidad', 'Albahaca Fresca Kiska - Unidad', NULL, 0.00
    ),
    (
        109, 1, 0, '1000350115415', 'Menta Fresca Kiska', 'Unidad', 'Menta Fresca Kiska - Unidad', NULL, 0.00
    ),
    (
        110, 1, 0, '1000350115422', 'Oregano Fresco Kiska', 'Unid', 'Oregano Fresco Kiska - Unid', NULL, 0.00
    ),
    (
        111, 1, 0, '1000350115439', 'Romero Fresco Kiska', '50 gr', 'Romero Fresco Kiska - 50 gr', NULL, 0.00
    ),
    (
        112, 1, 0, '1000350122246', 'Fruta Surtida', 'Bandeja', 'Fruta Surtida - Bandeja', NULL, 0.00
    ),
    (
        113, 1, 0, '10003501279510', 'Estragon Mazo', 'Und', 'Estragon Mazo  - und', NULL, 0.00
    ),
    (
        114, 1, 0, '1000350139442', 'Pepino Dulce', '250 gr', 'Pepino Dulce -250 gr', NULL, 0.00
    ),
    (
        115, 1, 0, '1000350144439', 'Limonaria Freska Kiska', '50 gr', 'Limonaria Freska Kiska - 50 gr', NULL, 0.00
    ),
    (
        116, 1, 0, '1000350164505', 'Garbanzo Castillo', '320 gr', 'Garbanzo Castillo - 320 gr', NULL, 0.00
    ),
    (
        117, 1, 0, '100035022909', 'Ajedrez Madera Mediano', 'Mediano', 'Ajedrez Madera Mediano', NULL, 0.00
    ),
    (
        118, 1, 0, '1000350237292', 'Perejil Liso Organico', 'Bandeja - 100 gr', 'Perejil Liso Organico - Bandeja - 100 gr', NULL, 0.00
    ),
    (
        119, 1, 0, '1000350249219', 'Zumo De Uva Light', '500 ml', 'Zumo De Uva Light - 500 ml', NULL, 0.00
    ),
    (
        120, 1, 0, '1000350260269', 'Zumo De Uva Light', '1000 ml', 'Zumo De Uva Light - 1000 ml', NULL, 0.00
    ),
    (
        121, 1, 0, '1000350269699', 'Habichuela', 'Bandeja', 'Habichuela -  Bandeja', NULL, 0.00
    ),
    (
        122, 1, 0, '1000350270428', 'Torombolo', '500 gr', 'Torombolo - 500 gr', NULL, 0.00
    ),
    (
        123, 1, 0, '1000350270466', 'Flor Jamaica', 'Bandeja', 'Flor Jamaica - Bandeja', NULL, 0.00
    ),
    (
        124, 1, 0, '1000350273689', 'Pimentones Mini Dulce', '1000 gr', 'Pimentones Mini Dulce - 1000 gr', NULL, 0.00
    ),
    (
        125, 1, 0, '1000350274006', 'Tomate Uvalina', '1000 gr', 'Tomate Uvalina - 1000 gr', NULL, 0.00
    ),
    (
        126, 1, 0, '1000350320741', 'Papa Rajada', '1500 gr', 'Papa Rajada- 1500 gr', NULL, 0.00
    ),
    (
        127, 1, 0, '1000350328204', 'Arandanos', '113 gr', 'Arandanos - 113 gr', NULL, 0.00
    ),
    (
        128, 1, 0, '1000350343511', 'Pera Bolsa', '5 Und', 'Pera Bolsa -5 Und', NULL, 0.00
    ),
    (
        129, 1, 0, '1000350370814', 'Nopal', 'Unidad', 'Nopal - Unidad', NULL, 0.00
    ),
    (
        130, 1, 0, '1000350372351', 'Platano Verde', 'Unidad', 'Platano Verde - Unidad', NULL, 0.00
    ),
    (
        131, 1, 0, '1000350373822', 'Yerbabuena Fresca Kiska', '500 gr', 'Yerbabuena Fresca Kiska - 500 gr', NULL, 0.00
    ),
    (
        132, 1, 0, '1000350373839', 'Albahaca Fresca Kiska', '50 gr', 'Albahaca Fresca Kiska- Pq x und', NULL, 0.00
    ),
    (
        133, 1, 0, '1000350400221', 'Mazorca', 'Bandeja - 3 Und', 'Mazorca -Bandeja - 3 Und', NULL, 0.00
    ),
    (
        134, 1, 0, '1000350454859', 'Aguacate Hass', 'Pq x  6 Und', 'Aguacate Hass - Paq x 6 und', NULL, 0.00
    ),
    (
        135, 1, 0, '10004', 'Ahuyama (Fruver)', '500 gr', 'Ahuyama x Libra', NULL, 0.00
    ),
    (
        136, 1, 0, '1000462', 'Jalapeños Rebanados Taconacho', '250 gr', 'Jalapeños Rebanados Taconacho x 250 gr', NULL, 0.00
    ),
    (
        137, 1, 0, '10004620', 'Jalapeños Rebanados Taconacho', '500 gr', 'Jalapeños Rebanados Taconacho x 500 gr', NULL, 0.00
    ),
    (
        138, 1, 0, '10005', 'Ahuyamin Criollo (Fruver)', '1000 gr', 'Ahuyamín Criollo x Kilo', NULL, 0.00
    ),
    (
        139, 1, 0, '10006', 'Ajo (Fruver)', '3 Cabezas', 'Ajo x 3 Cabezas', NULL, 0.00
    ),
    (
        140, 1, 0, '100063', 'Sprite', '600 ml', NULL, NULL, 0.00
    ),
    (
        141, 0, 0, '100067', 'Cerveza oscura Victoria', '355 ml Sixpack', NULL, NULL, 0.00
    ),
    (
        142, 1, 0, '10007', 'Ajo Morado (Fruver)', 'Paquete', 'Ajo Morado x Paquete', NULL, 0.00
    ),
    (
        143, 1, 0, '10008', 'Apio Arracacha (Fruver)', '250 gr', 'Apio Arracacha x 250 gr', NULL, 0.00
    ),
    (
        144, 1, 0, '10009', 'Arveja Desgranda (Fruver)', '500 gr', 'Arveja Desgranda x Libra', NULL, 0.00
    ),
    (
        145, 1, 0, '10010', 'Arveja Verde En Cascara (Fruver)', '500 gr', 'Arveja Verde En Cascara x Libra', NULL, 0.00
    ),
    (
        146, 1, 0, '1001001009503', 'Blanqueador Desinfectante Brilla King', '2000 ml', 'Blanqueador Desinfectante Brilla King x 2000 ml', NULL, 0.00
    ),
    (
        147, 1, 0, '1001003014604', 'Detergente Floral Bonaropa', '1000 gr', 'Detergente Floral Bonaropa x 1000 gr', NULL, 0.00
    ),
    (
        148, 1, 0, '1001003017520', 'Detergente  Bicarbonato Bonaropa', '2800 gr', 'Detergente Bicarbonato Bonaropa x 2800 gr', NULL, 0.00
    ),
    (
        149, 1, 0, '1001003021077', 'Detergente Liquido Coco Bonaropa', '1000 ml', 'Detergente Liquido Coco para Prendas Delicadas Bonaropa x 1000 ml', NULL, 0.00
    ),
    (
        150, 1, 0, '1001003030659', 'Detergente Liquido Prendas Oscuras Bonaropa', '1000 ml', 'Detergente Prendas Oscuras Bonaropa x 1000 ml', NULL, 0.00
    ),
    (
        151, 1, 0, '1001004016089', 'Gel Antibacterial Aloe Vera Natural Feeling', '300 ml', 'Gel Antibacterial Aloe Vera Natural Feeling x 300 ml', NULL, 0.00
    ),
    (
        152, 1, 0, '1001005021020', 'Jabon Barra Brilla King', '300 gr', 'Jabon Barra Brilla King x 300 gr', NULL, 0.00
    ),
    (
        153, 1, 0, '1001007012088', 'Polvo Abrasivo Limon Brilla King', '500 gr', 'Polvo Abrasivo Brilla King x 500 gr', NULL, 0.00
    ),
    (
        154, 1, 0, '1001007015812', 'Limpiavidrios Antiempañante Brilla King', '500 ml', 'Limpiavidrios Brilla King - 500 ml', NULL, 0.00
    ),
    (
        155, 1, 0, '1001007016055', 'Desinfectante Para Baño Anti-Hongos Brilla King', '500 ml', 'Desinfectante Para Baño Anti-Hongos Brilla King x 500 ml', NULL, 0.00
    ),
    (
        156, 1, 0, '1001007022971', 'Limpiador De Juntas Brilla King', '500 ml', 'Limpiador De Juntas Brilla King', NULL, 0.00
    ),
    (
        157, 1, 0, '1001007025484', 'Limpiador Citronela Brilla King', '1000 ml', 'Limpiador Citronela Brilla King x 1000 ml', NULL, 0.00
    ),
    (
        158, 1, 0, '1001007033731', 'Varsol Emulsionado Brilla King', '800 ml', 'Varsol Emulsionado Brilla King x 800 ml', NULL, 0.00
    ),
    (
        159, 1, 0, '1001007038880', 'Limpiador De Textiles Brilla King', '500 ml', 'Limpiador De Textiles Brilla King 500 ml', NULL, 0.00
    ),
    (
        160, 1, 0, '1001007038903', 'Desinfectante Multiusos Todo En Uno Brilla King', '500 ml', 'Desinfectante Multiusos Todo En Uno Brilla King - 500 gr', NULL, 0.00
    ),
    (
        161, 1, 0, '1001007038927', 'Desinfectante De Aire Y Superficies Brilla King', '250 ml', 'Desinfectante De Aire Y Superficies Brilla King x 250 ml', NULL, 0.00
    ),
    (
        162, 1, 0, '1001007038934', 'Limpiador En Gel Multisuperficies Brilla King', '1000 ml', 'Limpiador En Gel Multisuperficies Brilla King 1000 ml', NULL, 0.00
    ),
    (
        163, 1, 0, '1001008024233', 'Suavizante Aroma Floral Bonaropa', '1000 ml', 'Suavizante Aroma Floral Bonaropa x 1000 ml', NULL, 0.00
    ),
    (
        164, 1, 0, '1001008024240', 'Suavizante Bonaropa Manzana', '1000 ml', 'Suavizante Bonaropa Manzana x 1000 ml', NULL, 0.00
    ),
    (
        165, 1, 0, '1001009015483', 'Paños Multiusos Tidy House', 'Paquete x 4 Und', 'Paños Multiusos Tidy House-  Paquete x 4 Und', NULL, 0.00
    ),
    (
        166, 1, 0, '1001010012037', 'Quitamanchas Líquido Ropa Color Bonaropa', '1000 ml', 'Quitamanchas Líquido Bonaropa x 1000 ml', NULL, 0.00
    ),
    (
        167, 1, 0, '1001010012044', 'Blanqueador Ropa Color Bonaropa', '1000 ml', 'Blanqueador Ropa Color Bonaropa - 1000 ml', NULL, 0.00
    ),
    (
        168, 1, 0, '1001012026094', 'Quitamanchas Para Ropa Blanca Liquido Bonaropa', '1000 ml', 'Quitamanchas Líquido Bonaropa x  1000 ml', NULL, 0.00
    ),
    (
        169, 1, 0, '1001012038875', 'Suavizante Antibacterial Bonaropa', '1000 ml', 'Suavizante Bonaropa Antibacerial - 1000 ml', NULL, 0.00
    ),
    (
        170, 1, 0, '1001012039230', 'Suavizante Aroma Floral Bonaropa', '3000 ml', 'Suavizante Aroma Floral Bonaropa x 3000 ml', NULL, 0.00
    ),
    (
        171, 1, 0, '1001013030410', 'Cera Autobrillante Brilla Kig', '1000 ml', 'Cera Autobrillante Brilla Kig x 1000 ml', NULL, 0.00
    ),
    (
        172, 1, 0, '1001013033947', 'Limpiador Brilla King Manzana y Canela', '1000 ml', 'Limpiador Brilla king Manzana y Canela x 1000 ml', NULL, 0.00
    ),
    (
        173, 1, 0, '1001016038949', 'Toalla Desinfectante Brilla King', 'Pq x 10 Unid', 'Toalla Desinfectante Lima Limón Brilla King - Paquete x 10 Unidades', NULL, 0.00
    ),
    (
        174, 1, 0, '100105', 'Nutella', '350gr', 'Nutella \n350gr', NULL, 0.00
    ),
    (
        175, 1, 0, '10011', 'Banano (Fruver)', '500 gr', 'Banano  x Libra', NULL, 0.00
    ),
    (
        176, 0, 0, '10012', 'Banano Grande (Fruver)', '250 gr', 'Banano Grande x 250 gr', NULL, 0.00
    ),
    (
        177, 1, 0, '10013', 'Bandeja De Arandanos (Fruver)', 'Bandeja', 'Bandeja De Arandanos x Bandeja', NULL, 0.00
    ),
    (
        178, 1, 0, '10014', 'Bandeja De Uva (Fruver)', 'Bandeja', 'Bandeja De Uva x Bandeja', NULL, 0.00
    ),
    (
        179, 1, 0, '10015', 'Berenjena Blanca (Fruver)', '500 gr', 'Berenjena Blanca x Libra', NULL, 0.00
    ),
    (
        180, 1, 0, '10016', 'Berenjena Morada (Fruver)', '500 gr', 'Berenjena Morada x libra', NULL, 0.00
    ),
    (
        181, 1, 0, '10017', 'Bolsa De Carbon Grande', 'Unidad', 'Bolsa De Carbon Grande x Unidad', NULL, 0.00
    ),
    (
        182, 1, 0, '10018', 'Bolsa De Carbon Pequeña', 'Unidad', 'Bolsa De Carbon Pequeña x Unidad', NULL, 0.00
    ),
    (
        183, 1, 0, '10019', 'Borojo (Fruver)', 'Unidad', 'Borojo x Unid', NULL, 0.00
    ),
    (
        184, 0, 0, '10020', 'Brocoli', '250 gr', 'Brocoli x 250 gr', NULL, 0.00
    ),
    (
        185, 1, 0, '1002001014702', 'Enjuague Bucal Meta Fresca Bucarine', '500 ml', 'Enjuague Bucal Meta Fresca- sin alcohol Bucarine x 500 ml', NULL, 0.00
    ),
    (
        186, 1, 0, '1002001015426', 'Seda Dental Bucarine Menta Fresca', '50 mts', 'Seda Dental Bucarine Menta Fresca x 50 Mts', NULL, 0.00
    ),
    (
        187, 1, 0, '1002001016942', 'Crema Dental Kids Sin Fluor Bucarine', '75 gr', 'Crema Dental Kids Sin Fluor Bucarine x 75 gr', NULL, 0.00
    ),
    (
        188, 1, 0, '1002001029218', 'Crema Dental Con Fluor Gel Bucarine', '150 ml', 'Crema Dental Gel Con Fluor Bucarine x 150 ml', NULL, 0.00
    ),
    (
        189, 1, 0, '1002001035189', 'Crema Dental Triple Accion Bucarine', '150 ml', 'Crema Dental Triple Accion Bucarine x 150 ml', NULL, 0.00
    ),
    (
        190, 1, 0, '1002001038692', 'Crema Dental Junior Bucarine', '100 ml', 'Crema Dental Junior Con Fluor Bucarine x 100 ml', NULL, 0.00
    ),
    (
        191, 1, 0, '1002003038072', 'Desodorante Roll-On Sensitive Natural Feeling', '75 ml', 'Desodorante Roll-On Sensitive Natural Feeling - 75 ml', NULL, 0.00
    ),
    (
        192, 1, 0, '1002003038089', 'Desodorante Roll-On Invisible Natural Feeling', '75 ml', 'Desodorante Roll-On Invisible Natural Feeling x 75 ml', NULL, 0.00
    ),
    (
        193, 1, 0, '1002004015522', 'Jabon De Tocador Natural Feeling', 'Pq x 4 Surtido-125 g', 'Jabon De Tocador Natural Feeling- Pq x 4 Surtido-125 g', NULL, 0.00
    ),
    (
        194, 1, 0, '1002004015539', 'Jabon De Tocador Avena Natural Feeling', 'Pq x 3 Und - 375 gr', 'Jabon De Tocador Avena Natural Feeling -   Pq x 3 Und - 375 gr', NULL, 0.00
    ),
    (
        195, 1, 0, '1002004038972', 'Jabon Espumoso Antibacterial Milefiore', '270 ml', 'Jabon Espumoso Antibacterial Milefiore x 270 ml', NULL, 0.00
    ),
    (
        196, 1, 0, '1002007031352', 'Espuma Para Afeitar Xen', '300 ml', 'Espuma Para Afeitar XEN x 300 ml', NULL, 0.00
    ),
    (
        197, 1, 0, '1002008034338', 'Tampones Digitales Super Fresh & Free', 'Pq x 10 Unid', 'Tampones Digitales Super Fresh & Free - Pq x 10 Unidades', NULL, 0.00
    ),
    (
        198, 1, 0, '1002008035458', 'Tampones Digitales Medio Fresh & Free', 'Pq x 10 Unid', 'Tampones Digitales Medio Fresh & Free - Paquete x 10 Unidades', NULL, 0.00
    ),
    (
        199, 1, 0, '1002009034344', 'Shampoo Hidratante Hidratante Natural Feeling', '400ml', 'Shampoo Hidratante Hidratante Natural Feeling x 400 ml', NULL, 0.00
    ),
    (
        200, 1, 0, '1002009034351', 'Shampoo Hidratante Regenerador Natural Feeling', '400 ml', 'Shampoo Hidratante Regenerador  Natural Feeling x 400 ml', NULL, 0.00
    ),
    (
        201, 1, 0, '1002010016032', 'Talco De Pies Antibacterial Xen', '150 gr', 'Talco De Pies Antibacterial Xen - 150 gr', NULL, 0.00
    ),
    (
        202, 1, 0, '1002010035743', 'Gel De Baño Nutritivo Natural Feeling', '750 ml', 'Gel De Baño Nutritivo Natural Feeling x 750 ml', NULL, 0.00
    ),
    (
        203, 1, 0, '1002010035750', 'Gel De Baño Flor De Cerezo Natural Feeling', '750 ml', 'Gel De Baño Hidratante Flor de Cerezo Natural Feeling x 750 ml', NULL, 0.00
    ),
    (
        204, 1, 0, '1002017030505', 'Removedor de uñas Natural Feeling', '250 gr', 'Removedor de uñas Natural Feeling x 250 gr', NULL, 0.00
    ),
    (
        205, 1, 0, '1002018033987', 'Repelente Natural Feeling', '120 ml', 'Repelente Natural Feeling x 120 ml', NULL, 0.00
    ),
    (
        206, 1, 0, '10021', 'Brocoli (Fruver)', '500 gr', 'Brocoli x 500 gr', NULL, 0.00
    ),
    (
        207, 1, 0, '10022', 'Calabacin Verde (Fruver)', '500 gr', 'Calabacin Verde x Libra', NULL, 0.00
    ),
    (
        208, 1, 0, '10023', 'Calabaza (Fruver)', '500 gr', 'Calabaza x 500 gr', NULL, 0.00
    ),
    (
        209, 1, 0, '10024', 'Cebolla Cabezona (Fruver)', '500 gr', 'Cebolla Cabezona x Libra', NULL, 0.00
    ),
    (
        210, 1, 0, '10025', 'Cebolla Cabezona Roja (Fruver)', '500 gr', 'Cebolla Cabezona Roja x Libra', NULL, 0.00
    ),
    (
        211, 1, 0, '10026', 'Cebolla Larga (Fruver)', '500 gr', 'Cebolla Larga x libra', NULL, 0.00
    ),
    (
        212, 1, 0, '10027', 'Cebolla Puerro (Fruver)', '500 gr', 'Cebolla Puerro x libra', NULL, 0.00
    ),
    (
        213, 1, 0, '10029', 'Champiñon En Bandeja Tajado', 'Bandeja', 'Champiñon En Bandeja Tajado', NULL, 0.00
    ),
    (
        214, 1, 0, '10030', 'Champiñones Enteros (Fruver)', '500 gr', 'Champiñones Enteros x libra', NULL, 0.00
    ),
    (
        215, 1, 0, '1003003019559', 'Jugo De Naranja Fresco Tree Fruts', '1000 ml', 'Jugo De Naranja Fresco Tree Fruts x 1000 ml', NULL, 0.00
    ),
    (
        216, 1, 0, '1003003020999', 'Refresco Naranja Tree Fruits', '1700 ml', 'Refresco Naranja Tree Fruits x  1700 ml', NULL, 0.00
    ),
    (
        217, 1, 0, '1003003021408', 'Jugo Mandarina Tree Fruts', '1000 ml', 'Jugo Mandarina Tree Fruts x 1000 ml', NULL, 0.00
    ),
    (
        218, 1, 0, '1003003026175', 'Nectar Jugo Surtido Tree Fruts', 'Pq x 6 Und-  200 ml', 'Nectar jugo surtido Pera, Manzana, Mango -  Pq x 6 Unid - 200 ml c/u', NULL, 0.00
    ),
    (
        219, 1, 0, '1003006029623', 'Agua Omi Limonada', '600 ml', 'Agua Omi Limonada x 600 ml', NULL, 0.00
    ),
    (
        220, 1, 0, '1003012035298', 'Jugo De Limon Tree Fruts', '250 ml', 'Jugo De Limon Tree Fruts x 250 ml', NULL, 0.00
    ),
    (
        221, 1, 0, '10031', 'Cilantro (Fruver)', '100 gr', 'Cilantro x 100 gr', NULL, 0.00
    ),
    (
        222, 1, 0, '10032', 'Ciruelas (Fruver)', 'Bandeja', 'Ciruelas x bandeja', NULL, 0.00
    ),
    (
        223, 1, 0, '10033', 'Ciruelas Grandes (Fruver)', '500 gr', 'Ciruelas Grandes x libra', NULL, 0.00
    ),
    (
        224, 1, 0, '10034', 'Coco (Fruver)', 'Unidad', 'Coco x Unidad', NULL, 0.00
    ),
    (
        225, 0, 0, '10035', 'Coliflor (Fruver)', '100 gr', 'Coliflor x 100 gr', NULL, 0.00
    ),
    (
        226, 1, 0, '10036', 'Coliflor (Fruver)', '500 gr', 'Coliflor x Libra', NULL, 0.00
    ),
    (
        227, 1, 0, '10037', 'Curuba (Fruver)', '500 gr', 'Curuba x Libra', NULL, 0.00
    ),
    (
        228, 1, 0, '10038', 'Durazno (Fruver)', '500 gr', 'Durazno x Libra', NULL, 0.00
    ),
    (
        229, 0, 0, '10039', 'Durazno Chileno (Fruver)', '500 gr', 'Durazno Chileno x Libra', NULL, 0.00
    ),
    (
        230, 0, 0, '10040', 'Espinaca (Fruver)', '250 gr', 'Espinaca x 250', NULL, 0.00
    ),
    (
        231, 1, 0, '1004002018086', 'Cafe Tostado Tipo Suave Viejo Molino', '500 gr', 'Cafe Tostado Tipo Suave Viejo Molino x 500 gr', NULL, 0.00
    ),
    (
        232, 1, 0, '1004002022212', 'Cafe Instantaneo Descafeinado Viejo Molino', '85 gr', 'Café Instantáneo Descafeinado Viejo Molino - 85 gr', NULL, 0.00
    ),
    (
        233, 1, 0, '1004003025021', 'Chocolate Tradicional de La Taza', '500 gr', 'Chocolate Tradicional de La Taza x 500 gr', NULL, 0.00
    ),
    (
        234, 1, 0, '1004003025045', 'Chocolate Clavos y Canela De La Taza', '500 gr', 'Chocolate Clavos y Canela De La Taza x 500 gr', NULL, 0.00
    ),
    (
        235, 1, 0, '1004003027261', 'Cacao En Polvo Lihgt Clavos y Canela Casa Real', '120 gr', 'Cacao En Polvo Lihgt Clavos y Canela Casa Real x 120 gr', NULL, 0.00
    ),
    (
        236, 1, 0, '1004003031725', 'Chocolate Vainilla De La Taza', '500 gr', 'Chocolate Vainilla De La Taza x 500 gr', NULL, 0.00
    ),
    (
        237, 1, 0, '1004006024731', 'Aromatica Frutos Rojos Kanpur', 'Caja x 10 Und- 10 gr', 'Aromatica Frutos Rojos Kanpur  - Caja x 10 Und- 10 gr', NULL, 0.00
    ),
    (
        238, 1, 0, '1004009016191', 'Gelatina Sin Sabor Kedeli', 'Pq x 4 Und- 30 gr', 'Gelatina Sin Sabor Kedeli - Pq x 4 Und- 30 gr', NULL, 0.00
    ),
    (
        239, 1, 0, '10042', 'Feijoa (Fruver)', 'Bandeja', 'Feijoa x Bandeja', NULL, 0.00
    ),
    (
        240, 1, 0, '10043', 'Fresa (Fruver)', '500 gr', 'Fresa Grande x Libra', NULL, 0.00
    ),
    (
        241, 0, 0, '10044', 'Fresa Pequeña (Fruver)', 'Libra', 'Fresa Pequeña x Libra', NULL, 0.00
    ),
    (
        242, 1, 0, '10045', 'Frijol Desgranado (Fruver)', '500 gr', 'Frijol Desgranado x Libra', NULL, 0.00
    ),
    (
        243, 1, 0, '10046', 'Frijol En Cascara (Fruver)', '250 gr', 'Frijol En Cascara  x 250 gr', NULL, 0.00
    ),
    (
        244, 1, 0, '10047', 'Frijol En Cascara (Fruver)', 'Libra', 'Frijol En Cascara  x Libra', NULL, 0.00
    ),
    (
        245, 1, 0, '10048', 'Granadilla (Fruver)', 'Unidad', 'Granadilla  x Unidad', NULL, 0.00
    ),
    (
        246, 0, 0, '10049', 'Granadilla Pequeña (Fruver)', 'Unidad', 'Granadilla Pequeña x Unidad', NULL, 0.00
    ),
    (
        247, 1, 0, '10050', 'Guanabana (Fruver)', '500 gr', 'Guanabana x Libra', NULL, 0.00
    ),
    (
        248, 1, 0, '1005001009082', 'Salchicha Tipo Parrilla Viande', 'Pq x 16 - 500 gr', 'Salchicha Tipo Parrilla Viande - Pq x 16 - 500 gr', NULL, 0.00
    ),
    (
        249, 1, 0, '1005001009105', 'Salchicha Tradicional Viande', '450 gr', 'Salchicha Tradicional Viande x 450 gr', NULL, 0.00
    ),
    (
        250, 1, 0, '1005001032455', 'Salchicha Viande Minimanguera', 'Pq x 8 Und- 480 gr', 'Salchicha Viande Minimanguera - Pq x 8 Und- 480 gr', NULL, 0.00
    ),
    (
        251, 1, 0, '1005003009042', 'Jamon De Cerdo Viande', 'Pq x 20 - 400 gr', 'Jamon De Cerdo Viande - Pq x 20 - 400 gr', NULL, 0.00
    ),
    (
        252, 1, 0, '1005003017955', 'Mortadela De Pollo Premium Brakel', 'Pq x 14 Unid- 250 gr', 'Mortadela De Pollo Premium Brakel -Pq x 14 Unid- 250 gr', NULL, 0.00
    ),
    (
        253, 1, 0, '1005003018914', 'Jamon De Pollo Premium Brakel', 'Pq x 14 Und- 250 gr', 'Jamon De Pollo Premium Brakel x Paquete de 14 unidades -250 gr', NULL, 0.00
    ),
    (
        254, 1, 0, '1005003024786', 'Jamon De Pavo White Holland', '250 gr', 'Jamon De Pavo White Holland x 250 gr', NULL, 0.00
    ),
    (
        255, 1, 0, '1005004017190', 'Chorizo Santarrosano Viande', 'Pq x 5 Und- 225 gr', 'Chorizo Santarrosano Viande - Pq x 5 Und- 225 gr', NULL, 0.00
    ),
    (
        256, 1, 0, '1005005011180', 'Morcilla De Cerdo  Viande', 'Pq x 8 Und- 500 gr', 'Morcilla De Cerdo  Viande - Pq x 8 Und- 500 gr', NULL, 0.00
    ),
    (
        257, 1, 0, '1005005037494', 'Butifarra Viande', 'Pq x 16 Und - 500 gr', 'Butifarra Viande - Paquete x 16 Unid - 500 gr', NULL, 0.00
    ),
    (
        258, 1, 0, '1005007009062', 'Mortadela Fina Viande', 'Pq x 12 Und- 225 gr', 'Mortadela Fina Viande - Pq x 12 Und- 225 gr', NULL, 0.00
    ),
    (
        259, 1, 0, '1005008024538', 'Salchichon Cervecero De Cerdo Viande', '500 gr', 'Salchichon Cervecero De Cerdo Viande x 500 gr', NULL, 0.00
    ),
    (
        260, 1, 0, '1005009009053', 'Tocineta Ahumada Viande', 'Pq x 10 T- 150 gr', 'Tocineta Ahumada Viande - 10 Tajadas x 150 gr', NULL, 0.00
    ),
    (
        261, 1, 0, '10051', 'Guasca (Fruver)', 'Paquete', 'Guascas x Paquete', NULL, 0.00
    ),
    (
        262, 1, 0, '10052', 'Guascas  (Fruver)', '500 gr', 'Guascas  (Fruver) - 500 gr', NULL, 0.00
    ),
    (
        263, 0, 0, '10053', 'Guayaba (Fruver)', '250 gr', 'Guayaba x 250 gr', NULL, 0.00
    ),
    (
        264, 1, 0, '10054', 'Guayaba (Fruver)', '500 gr', 'Guayaba x Libra', NULL, 0.00
    ),
    (
        265, 1, 0, '10055', 'Guineo (Fruver)', 'Unidad', 'Guineo x Unidad', NULL, 0.00
    ),
    (
        266, 1, 0, '10056', 'Habichuela (Fruver)', '500 gr', 'Habichuela x Libra', NULL, 0.00
    ),
    (
        267, 1, 0, '10057', 'Jengibre (Fruver)', '500 gr', 'Jengibre x Libra', NULL, 0.00
    ),
    (
        268, 1, 0, '10058', 'Kiwi (Fruver)', '500 gr', 'Kiwi x Libra', NULL, 0.00
    ),
    (
        269, 1, 0, '10059', 'Lechuga Batavia (Fruver)', '500 gr', 'Lechuga Batavia x 500 gr', NULL, 0.00
    ),
    (
        270, 1, 0, '10060', 'Lechuga Crespa (Fruver)', 'Unidad', 'Lechuga Crespa x Unidad', NULL, 0.00
    ),
    (
        271, 1, 0, '1006004024713', 'Pasta Fusilli Mixto Deliziare', '500 gr', 'Pasta Fusilli Mixto Deliziare x 500 gr', NULL, 0.00
    ),
    (
        272, 1, 0, '1006008031441', 'Crema De Pollo con Champiñones Velsup', '70 gr', 'Crema de Pollo con Champiñones Velsup-  Unidad - 70 gr', NULL, 0.00
    ),
    (
        273, 1, 0, '1006008031465', 'Crema De Choclo Velsup', '70 gr', 'Crema de Choclo  Velsup - Unidad x 70 gr', NULL, 0.00
    ),
    (
        274, 1, 0, '1006010019987', 'Arroz Achocolatado Fiocco', '320 gr', 'Arroz Achocolatado Fiocco x 320 gr', NULL, 0.00
    ),
    (
        275, 1, 0, '1006014016920', 'Pasta Penne Deliziare', '500 gr', 'Pasta Penne Deliziare x 500 gr', NULL, 0.00
    ),
    (
        276, 1, 0, '1006015016912', 'Pasta Deliziare Spaghetti', '500 gr', 'Pasta Deliziare Spaghetti x 500 gr', NULL, 0.00
    ),
    (
        277, 1, 0, '10061', 'Lechuga Romana Cuisine (Fruver)', '200 gr', 'Lechuga Romana Cuisine x 200 gr', NULL, 0.00
    ),
    (
        278, 0, 0, '10062', 'Limón Criollo (Fruver)', '250 gr', 'Limón criollo x 250 gr', NULL, 0.00
    ),
    (
        279, 1, 0, '10063', 'Limon Criollo (Fruver)', '500 gr', 'Limón criollo x Libra', NULL, 0.00
    ),
    (
        280, 1, 0, '10064', 'Limon Mandarino (Fruver)', '500 gr', 'Limón Mandarino x Libra', NULL, 0.00
    ),
    (
        281, 0, 0, '10065', 'Limón Tahiti (Fruver)', '250 gr', 'Limón Tahití x 250 gr', NULL, 0.00
    ),
    (
        282, 1, 0, '10066', 'Limon Tahiti (Fruver)', '500 gr', 'Limon tahiti x Libra', NULL, 0.00
    ),
    (
        283, 0, 0, '10067', 'Lulo (Fruver)', '250 gr', 'Lulo x 250 gr', NULL, 0.00
    ),
    (
        284, 1, 0, '10068', 'Lulo (Fruver)', '500 gr', 'Lulo x Libra', NULL, 0.00
    ),
    (
        285, 1, 0, '10069', 'Maiz De Mute (Fruver)', '500 gr', 'Maiz De Mute (Fruver) - 500 gr', NULL, 0.00
    ),
    (
        286, 1, 0, '10070', 'Mandarina Criolla (Fruver)', '500 gr', 'Mandarina Criolla x Libra', NULL, 0.00
    ),
    (
        287, 1, 0, '1007001036648', 'Albahaca Especiaria P&I', '20 gr', 'Albahaca Especiaria P&I x 20 gr', NULL, 0.00
    ),
    (
        288, 1, 0, '1007001036655', 'Comino Molido Speciaria', '28 gr', 'Comino Molido Speciaria x 28 gr', NULL, 0.00
    ),
    (
        289, 1, 0, '1007001036709', 'Tomillo Speciaria', '20 gr', 'Tomillo Speciaria x 20 gr', NULL, 0.00
    ),
    (
        290, 1, 0, '1007001038246', 'Canela Molida Speciaria', '28 gr', 'Canela Molida Speciaria x 28 gr', NULL, 0.00
    ),
    (
        291, 1, 0, '1007001039106', 'Canela En Astillas Speciaria', '20 gr', 'Canela En Astillas Speciaria x 20 gr', NULL, 0.00
    ),
    (
        292, 1, 0, '1007002029656', 'Caldo De Gallina Speciaria', 'Pq x 8 Cubos-84 gr', 'Caldo De Gallina Speciaria - Pq x 8 Cubos-84 gr', NULL, 0.00
    ),
    (
        293, 1, 0, '1007002032021', 'Caldo De Costilla Speciaria', 'Pq x 8 Und - 80 gr', 'Caldo De Costilla Speciaria  - Pq x 8 Und - 80 gr', NULL, 0.00
    ),
    (
        294, 1, 0, '1007005039119', 'Coco Rayado Speciaria', '100 gr', 'Coco Rayado Speciaria x 100 gr', NULL, 0.00
    ),
    (
        295, 1, 0, '10071', 'Mango De Azucar (Fruver)', '500 gr', 'Mango De Azucar x Libra', NULL, 0.00
    ),
    (
        296, 1, 0, '10072', 'Mango Tommy (Fruver)', '500 gr', 'Mango Tommy x Libra', NULL, 0.00
    ),
    (
        297, 1, 0, '10073', 'Manzana Roja (Fruver)', 'Unidad', 'Manzana Roja x Unidad', NULL, 0.00
    ),
    (
        298, 1, 0, '10074', 'Manzana Rosada (Fruver)', 'Unidad', 'Manzana Rosada x Unidad', NULL, 0.00
    ),
    (
        299, 1, 0, '10075', 'Manzana Verde (Fruver)', 'Unidad', 'Manzana Verde x Unidad', NULL, 0.00
    ),
    (
        300, 0, 0, '10076', 'Maracuya (Fruver)', '250 gr', 'Maracuyá x 250 gr', NULL, 0.00
    ),
    (
        301, 1, 0, '10077', 'Maracuya (Fruver)', '500 gr', 'Maracuyá x Libra', NULL, 0.00
    ),
    (
        302, 1, 0, '10078', 'Mazorca (Fruver)', 'Unidad', 'Mazorca x Unidad', NULL, 0.00
    ),
    (
        303, 1, 0, '10079', 'Mazorca Bogotana (Fruver)', 'Unidad', 'Mazorca  Bogotana x Unidad', NULL, 0.00
    ),
    (
        304, 1, 0, '10080', 'Mazorca Desgranada (Fruver)', '500 gr', 'Mazorca Desgranada x Libra', NULL, 0.00
    ),
    (
        305, 1, 0, '1008001014810', 'Bandeja Muslos de Pollo Marinados Brasset', '700 gr', 'Bandeja Muslos de Pollo Marinados Brasset x 700 gr', NULL, 0.00
    ),
    (
        306, 1, 0, '1008001022716', 'Alitas De Pollo BBQ Brasset', '900 gr', 'Alitas De Pollo BBQ Brasset x 900 gr', NULL, 0.00
    ),
    (
        307, 1, 0, '1008001025946', 'Muslos de Pollo Brasset', '800 gr', 'Bolsa  Muslos de Pollo x 800 gr', NULL, 0.00
    ),
    (
        308, 1, 0, '1008001034368', 'Menudencia Fina De Pollo Brasset', 'Bandeja  x 500 gr', 'Menudencia Fina De Pollo Brasset - Bandeja x  500 gr', NULL, 0.00
    ),
    (
        309, 1, 0, '1008002026614', 'Helado Chocolate Külfi', '1000 ml', 'Helado Chocolate Külfi x 1000 ml', NULL, 0.00
    ),
    (
        310, 1, 0, '1008003025302', 'Posta De Bagre Capitan Bay (Frutos del Mar)', '400 gr', 'Posta De Bagre Capitan Bay  x  400 gr', NULL, 0.00
    ),
    (
        311, 1, 0, '1008003029225', 'Camaron Precocido Captain Bay (Frutos del Mar)', '400 gr', 'Camaron Precocido Captain Bay - 400 gr', NULL, 0.00
    ),
    (
        312, 1, 0, '1008004022072', 'Croquetas De Yuca Toastatas', '500 gr', 'Croquetas De Yuca Toastatas - 500 gr', NULL, 0.00
    ),
    (
        313, 1, 0, '1008006031485', 'Carne De Res Para Asar Red Cut', '500 gr', 'Carne De Res Para Asar Red Cut x 500 gr', NULL, 0.00
    ),
    (
        314, 1, 0, '1008006032314', 'Tocino Carnudo Red Cut', '500 gr', 'Tocino De Cerdo Red Cut  x 500gr', NULL, 0.00
    ),
    (
        315, 1, 0, '10081', 'Melon (Fruver)', '500 gr', 'Melon x Libra', NULL, 0.00
    ),
    (
        316, 1, 0, '10082', 'Mora (Fruver)', '250 gr', 'Mora x 250 gr', NULL, 0.00
    ),
    (
        317, 1, 0, '10083', 'Mora (Fruver)', '500 gr', 'Mora x Libra', NULL, 0.00
    ),
    (
        318, 1, 0, '10084', 'Naranja Criolla (Fruver)', 'Unidad', 'Naranja Criolla x Unidad', NULL, 0.00
    ),
    (
        319, 1, 0, '10085', 'Naranja Tangelo (Fruver)', '500 gr', 'Naranja Tangelo x Libra', NULL, 0.00
    ),
    (
        320, 1, 0, '10086', 'Naranja Valenciana (Fruver)', '500 gr', 'Naranja Valenciana- 500 gr', NULL, 0.00
    ),
    (
        321, 1, 0, '10087', 'Papa Criolla (Fruver)', '500 gr', 'Papa Criolla x Libra', NULL, 0.00
    ),
    (
        322, 1, 0, '10088', 'Papa Pastusa (Fruver)', '500 gr', 'Papa Pastusa x Libra', NULL, 0.00
    ),
    (
        323, 1, 0, '10089', 'Papaya (Fruver)', '500 gr', 'Papaya x Libra', NULL, 0.00
    ),
    (
        324, 1, 0, '10090', 'Patilla (Fruver)', '500 gr', 'Patilla x 500 gr', NULL, 0.00
    ),
    (
        325, 1, 0, '1009004017655', 'Salchicha Viena Viande', 'Lata x 7 Und- 150 gr', 'Salchicha De Pollo Enlatada Viena Viande - Lata x 7 Und- 150 gr', NULL, 0.00
    ),
    (
        326, 1, 0, '1009004018720', 'Frijoles Antioqueños Con Tocino Cooltivo', '320 gr', 'Frijoles Antioqueños Con Tocino Cooltivo x 320 gr', NULL, 0.00
    ),
    (
        327, 1, 0, '1009005029121', 'Tomates Secos Ainoa', '180 gr', 'Tomates Secos en Aceite con Hierbas Ainoa x 180 gr', NULL, 0.00
    ),
    (
        328, 1, 0, '1009006014836', 'Maíz Tierno Cooltivo', '340 gr', 'Maíz Tierno Cooltivo x 340 gr', NULL, 0.00
    ),
    (
        329, 1, 0, '10090060377120', 'Aceituna Rellena Pimiento Ainoa', '180 gr', 'Aceituna Rellena Pimiento Ainoa  - 180 gr', NULL, 0.00
    ),
    (
        330, 1, 0, '10091', 'Patilla Baby (Fruver)', '1500 gr', 'Patilla Baby x 1500 gr', NULL, 0.00
    ),
    (
        331, 1, 0, '10092', 'Pepino Cohombro (Fruver)', '500 gr', 'Pepino Cohombro x Libra', NULL, 0.00
    ),
    (
        332, 1, 0, '10093', 'Pepino Para Rellenar (Fruver)', '500 gr', 'Pepino Para Rellenar x 500 gr', NULL, 0.00
    ),
    (
        333, 1, 0, '10094', 'Pera Criolla (Fruver)', 'Unidad', 'Pera Criolla - Unidad', NULL, 0.00
    ),
    (
        334, 1, 0, '10095', 'Pera Verde (Fruver)', 'Unidad', 'Pera Verde x Unidad', NULL, 0.00
    ),
    (
        335, 1, 0, '10096', 'Perejil (Fruver)', '150 gr', 'Perejil  x 150 gr', NULL, 0.00
    ),
    (
        336, 1, 0, '10097', 'Picado De Verdura (Fruver)', '220 gr', 'Picado De Verdura x 220 gr', NULL, 0.00
    ),
    (
        337, 1, 0, '10098', 'Pimenton Rojo (Fruver)', '500 gr', 'Pimentón Rojo x Libra', NULL, 0.00
    ),
    (
        338, 1, 0, '10099', 'Pimenton Verde (Fruver)', '500 gr', 'Pimentón Verde x Libra', NULL, 0.00
    ),
    (
        339, 1, 0, '101', 'Calabacin', '1000 gr', 'Calabacin - 1000 gr', NULL, 0.00
    ),
    (
        340, 1, 0, '10100', 'Piña Criolla (Fruver)', 'Unidad', 'Piña Criolla x Unidad', NULL, 0.00
    ),
    (
        341, 1, 0, '1010012033896', 'Difusor De Olores Varitas Hosh', '40 ml', 'Difusor De Olores Varitas Hosh x 40 ml', NULL, 0.00
    ),
    (
        342, 1, 0, '1010012033933', 'Ambientador De Lencería  Hosh', '150 ml', 'Ambientador De Lencería  Hosh x 150 ml', NULL, 0.00
    ),
    (
        343, 1, 0, '1010012038846', 'Ambientador En Aerosol Lavanda Hosh', '360 ml', 'Ambientador En Aerosol Lavanda Hosh x 360 ml', NULL, 0.00
    ),
    (
        344, 1, 0, '1010012038853', 'Ambientador En Aerosol Manzana Y Canela Hosh', '360 ml', 'Ambientador En Aerosol Manzana Y Canela Hosh x 360 ml', NULL, 0.00
    ),
    (
        345, 1, 0, '1010015033381', 'Insecticida 2 En 1 Done', '250 ml', 'Insecticida 2 En 1 Done x 250 ml', NULL, 0.00
    ),
    (
        346, 1, 0, '10101', 'Piña Oro Miel (Fruver)', 'Unidad', 'Piña Oro Miel - Unidad', NULL, 0.00
    ),
    (
        347, 1, 0, '10102', 'Pitaya (Fruver)', '500 gr', 'Pitaya x Libra', NULL, 0.00
    ),
    (
        348, 1, 0, '10103', 'Platano Maduro (Fruver)', '500 gr', 'Plátano Maduro x Libra', NULL, 0.00
    ),
    (
        349, 1, 0, '10104', 'Platano Verde (Fruver)', '500 gr', 'Plátano Verde x Libra', NULL, 0.00
    ),
    (
        350, 1, 0, '10105', 'Pulpa De Curuba (Fruver)', '500 gr', 'Pulpa de Curuba x Libra', NULL, 0.00
    ),
    (
        351, 1, 0, '10106', 'Pulpa De Fresa (Fruver)', '500 gr', 'Pulpa de Fresa x Libra', NULL, 0.00
    ),
    (
        352, 1, 0, '10107', 'Pulpa De Guanabana (Fruver)', '500 gr', 'Pulpa de Guanábana x 500 gr', NULL, 0.00
    ),
    (
        353, 1, 0, '10108', 'Pulpa De Guayaba (Fruver)', '500 gr', 'Pulpa de Guayaba x Libra', NULL, 0.00
    ),
    (
        354, 1, 0, '10109', 'Pulpa De Lulo (Fruver)', '500 gr', 'Pulpa de Lulo x Libra', NULL, 0.00
    ),
    (
        355, 1, 0, '10110', 'Pulpa De Mango (Fruver)', '500 gr', 'Pulpa de Mango x Libra', NULL, 0.00
    ),
    (
        356, 1, 0, '1011003016904', 'Crema De Avellanas Nuzart', '350 gr', 'Crema de Avellanas Nuzart x 350 gr', NULL, 0.00
    ),
    (
        357, 1, 0, '1011003018816', 'Crema De Avellanas Duo Nuzart', '350 gr', 'Crema De Avellanas Duo Nuzart - 350 gr', NULL, 0.00
    ),
    (
        358, 1, 0, '1011003027825', 'Chocolatina Keo', 'Pq x 12 Unid', 'Chocolatina Keo - Pq x 12 Unid', NULL, 0.00
    ),
    (
        359, 1, 0, '1011005018685', 'Galleta Mantequilla Saltisima', '4 Tacos- 324 gr', 'Galleta Mantequilla Saltisima Paquete - 4 tacos - 324 gr', NULL, 0.00
    ),
    (
        360, 1, 0, '1011011031524', 'Barquillo Nuzart', '150 gr', 'Barquillo Nuzart  x 150 gr', NULL, 0.00
    ),
    (
        361, 1, 0, '10111', 'Pulpa De Maracuya (Fruver)', '500 gr', 'Pulpa de Maracuyá x Libra', NULL, 0.00
    ),
    (
        362, 1, 0, '10112', 'Pulpa De Mora (Fruver)', '500 gr', 'Pulpa de Mora x Libra', NULL, 0.00
    ),
    (
        363, 1, 0, '10113', 'Pulpa De Piña (Fruver)', '500 gr', 'Pulpa De Piña x Libra', NULL, 0.00
    ),
    (
        364, 1, 0, '10114', 'Pulpa De Uva Isabella (Fruver)', '500 gr', 'Pulpa de uva Isabella x Libra', NULL, 0.00
    ),
    (
        365, 1, 0, '10115', 'Pulpa Tomate De Arbol (Fruver)', '500 gr', 'Pulpa Tomate de Arbol x Libra', NULL, 0.00
    ),
    (
        366, 1, 0, '10116', 'Pulpa Tropical (Fruver)', '500 gr', 'Pulpa de Fruta Tropical x Libra', NULL, 0.00
    ),
    (
        367, 1, 0, '10117', 'Rabano (Fruver)', '500 gr', 'Rabano (Fruver) - 500 gr', NULL, 0.00
    ),
    (
        368, 1, 0, '10118', 'Rama De Apio (Fruver)', '3 Tallos', 'Rama De Apio x 3 Tallos', NULL, 0.00
    ),
    (
        369, 1, 0, '10119', 'Remolacha (Fruver)', '500 gr', 'Remolacha x Libra', NULL, 0.00
    ),
    (
        370, 1, 0, '10120', 'Repollo (Fruver)', '500 gr', 'Repollo x Libra', NULL, 0.00
    ),
    (
        371, 1, 0, '10121', 'Repollo Morado (Fruver)', '500 gr', 'Repollo Morado x Libra', NULL, 0.00
    ),
    (
        372, 1, 0, '10122', 'Sandia (Fruver)', '500 gr', 'Sandia x Libra', NULL, 0.00
    ),
    (
        373, 1, 0, '10123', 'Tamarindo (Fruver)', 'Unidad', 'Tamarindo  x Unidad', NULL, 0.00
    ),
    (
        374, 0, 0, '10124', 'Tamarindo Mediano (Fruver)', 'Unidad', 'Tamarindo Mediano x Unidad', NULL, 0.00
    ),
    (
        375, 0, 0, '10125', 'Tamarindo Pequeño (Fruver)', 'Unidad', 'Tamarindo Pequeño x Unidad', NULL, 0.00
    ),
    (
        376, 1, 0, '10126', 'Tomate (Fruver)', '500 gr', 'Tomate x Libra', NULL, 0.00
    ),
    (
        377, 1, 0, '10127', 'Tomate Cherry Makand', '500 gr', 'Tomate Cherry Makand x 500 gr', NULL, 0.00
    ),
    (
        378, 0, 0, '10128', 'Tomate De Arbol (Fruver)', '250 gr', 'Tomate De Arbol x 250 gr', NULL, 0.00
    ),
    (
        379, 1, 0, '10129', 'Tomate De Arbol (Fruver)', '500 gr', 'Tomate De Arbol x Libra', NULL, 0.00
    ),
    (
        380, 1, 0, '10130', 'Tomate Verde (Fruver)', '500 gr', 'Tomate Verde x Libra', NULL, 0.00
    ),
    (
        381, 1, 0, '1013002020166', 'Jabon Cremoso Little Angels', 'Pq x 3 Unid - 375 gr', 'Jabon Cremoso Little Angels x Paquete de 3 Unid - 375 gr', NULL, 0.00
    ),
    (
        382, 1, 0, '1013002025833', 'Crema Dermoprotectora Little Angels', '150 gr', 'Crema Dermoprotectora Little Angels x 150 gr', NULL, 0.00
    ),
    (
        383, 1, 0, '1013002034378', 'Shampoo Bebe Little Angels', '360 ml', 'Shampoo Niños Little Angels  x  360ml', NULL, 0.00
    ),
    (
        384, 1, 0, '101300501555', 'Jabon De Tocador Con Aloe Vera Natural Feeling', 'Pq x 3 Und - 375 gr', 'Jabon De Tocador Con Aloe Vera Natural Feeling -   Pq x 3 Und - 375 gr', NULL, 0.00
    ),
    (
        385, 1, 0, '1013005015558', 'Jabon De Tocador Natural Feeling Limpieza Delicada', 'Pq x 3 Und- 375 gr', 'Jabon De Tocador Natural Feeling Limpieza Delicada - Pq x 3 Und- 375 gr', NULL, 0.00
    ),
    (
        386, 1, 0, '10131', 'Toronja', 'Unidad', 'Toronja x Unidad', NULL, 0.00
    ),
    (
        387, 1, 0, '10132', 'Uchuva Concha (Fruver)', '500 gr', 'Uchuva Concha x Libra', NULL, 0.00
    ),
    (
        388, 1, 0, '10133', 'Uchuva Desgranada (Fruver)', '500 gr', 'Uchuva Desgranada x 500 gr', NULL, 0.00
    ),
    (
        389, 1, 0, '10134', 'Uchuva En Canasta (Fruver)', 'Canasta', 'Uchuva en Canasta x Unidad - Canasta', NULL, 0.00
    ),
    (
        390, 1, 0, '10135', 'Uva Importada (Fruver)', '500 gr', 'Uva Importada x Libra', NULL, 0.00
    ),
    (
        391, 1, 0, '10136', 'Yota (Fruver)', '500 gr', 'Yota x Libra', NULL, 0.00
    ),
    (
        392, 1, 0, '10137', 'Yuca (Fruver)', '500 gr', 'Yuca x Libra', NULL, 0.00
    ),
    (
        393, 1, 0, '10138', 'Zanahoria (Fruver)', '500 gr', 'Zanahoria x Libra', NULL, 0.00
    ),
    (
        394, 0, 0, '10139', 'Zapote (Fruver)', 'Unidad', 'Zapote x Unidad', NULL, 0.00
    ),
    (
        395, 1, 0, '10140', 'Zukini Amarillo (Fruver)', '500 gr', 'Zukini x Libra', NULL, 0.00
    ),
    (
        396, 1, 0, '1014002014520', 'Queso Sabanero En Tajadas Latti', '250gr x 10 Unid', 'Queso Sabanero En Tajadas Latti 10 Unid x 250gr', NULL, 0.00
    ),
    (
        397, 1, 0, '1014003022180', 'Yogurt En Botella Fresa  Latti', '1000 ml', 'Yogurt En Botella Fresa  Latti x 1000 ml', NULL, 0.00
    ),
    (
        398, 1, 0, '1014003023262', 'Yogurt En Botella Melocoton Latti', '1000 ml', 'Yogurt En Botella Melocoton Latti X 1000 ml', NULL, 0.00
    ),
    (
        399, 1, 0, '1014005016682', 'Leche En Polvo  Descremada Latti', '400 gr', 'Leche en Polvo  Descremada Latti x 400 gr', NULL, 0.00
    ),
    (
        400, 1, 0, '1014006023429', 'Leche Entera Tetra Pak Latti', '900 ml', 'Leche Entera Tetra Pak Latti x 900 ml', NULL, 0.00
    ),
    (
        401, 1, 0, '1014012029880', 'Crema De Leche Latti', '200 gr', 'Crema De Leche Latti x 200 gr', NULL, 0.00
    ),
    (
        402, 1, 0, '1014012034853', 'Crema Vegetal Batida En Spray Külfi', '250 gr', 'Crema Vegetal Batida En Spray Külfi x 250 gr', NULL, 0.00
    ),
    (
        403, 1, 0, '1014013016452', 'Arequipe Latti', '250 gr', 'Arequipe Latti x 250 gr', NULL, 0.00
    ),
    (
        404, 1, 0, '1014013018753', 'Arequipe Latti', 'Pq x 6 Und- 300 gr', 'Arequipe Latti - Pq x 6 Und- 300 gr', NULL, 0.00
    ),
    (
        405, 1, 0, '1014013028608', 'Leche Condensada Semidescremada Latti', '300 gr', 'Leche Condensada Azucarada-Semidescremada Latti X 300 GR', NULL, 0.00
    ),
    (
        406, 1, 0, '1014013029902', 'Arequipe Sin Azucar Natri', '250 gr', 'Arequipe Sin Azucar Natri X 250 gr', NULL, 0.00
    ),
    (
        407, 1, 0, '1014014018196', 'Queso Crema Latti', '200 gr', 'Queso Crema Latti - 200 gr', NULL, 0.00
    ),
    (
        408, 1, 0, '1014015032849', 'Yogurt Griego Mora Latti', '160 gr', 'Yogurt Griego Mora Latti x 160 gr', NULL, 0.00
    ),
    (
        409, 1, 0, '1014015040639', 'Yogurt Griego Natural Latti', '330 gr', 'Yogurt Griego Nautal Sin Azucar Latti x 330 gr', NULL, 0.00
    ),
    (
        410, 1, 0, '1014018033690', 'Leche Deslactosada Descremada 0% Latti', '900 ml', 'Leche Deslactosada Descremada 0% Latti x 900 ml en tetra pak', NULL, 0.00
    ),
    (
        411, 1, 0, '1014021038354', 'Queso Tajado Reducido en Grasa Vita Latti', 'Pq x 15 T - 249 gr', 'Queso Tajado Reducido en Grasa Vita Latti - Pq x 15 T - 249 gr', NULL, 0.00
    ),
    (
        412, 1, 0, '1014023033296', 'Leche Saborizada Fresa Larga Vida Tetra Pak Latti', 'Pq x 3 unid', 'Leche Saborizada Sabor a Fresa Paquete x 3 unidades - 600 ml', NULL, 0.00
    ),
    (
        413, 1, 0, '1014023033302', 'Leche Saborizada Chocolate Larga Vida Tetra Pak Latti', 'Pq x 3 unid', 'Leche Saborizada Chocolate Paquete x 3 unidades - 600 ml', NULL, 0.00
    ),
    (
        414, 1, 0, '1014023037867', 'Leche Entera Tetra Pak Latti', '200 ml', 'Leche Entera Tetra Pak Latti x 200 ml', NULL, 0.00
    ),
    (
        415, 1, 0, '1015001029300', 'Magic Friends Premium', '2000 gr', 'Alimento Premium Para Perro Magic Friends x 2000 gr', NULL, 0.00
    ),
    (
        416, 1, 0, '1015002023727', 'Arena Para Gatos Magic Friends', '4500 gr', 'Arena Para Gatos Magic Friends x 4500 gr', NULL, 0.00
    ),
    (
        417, 1, 0, '1015009039714', 'Magic Friends Paños Humedos', '50 Unid', 'Magic Friends Paños Humedos Para Mascotas x 50 Uind', NULL, 0.00
    ),
    (
        418, 1, 0, '1016001015256', 'Palitroques Horneaditos', '100 gr', 'Palitroques Horneaditos  - 100 gr', NULL, 0.00
    ),
    (
        419, 1, 0, '1016002008677', 'Brownie De Arequipe Horneaditos', '80 gr', 'Brownie De Arequipe Horneaditos x 80 gr', NULL, 0.00
    ),
    (
        420, 1, 0, '1016002014623', 'Mini Choco Horneaditos', 'Pq x 6 Und- 180 gr', 'Mini Choco Horneaditos -Pq x 6 Und- 180 gr', NULL, 0.00
    ),
    (
        421, 1, 0, '1016002018782', 'Galleta Cucas Horneaditos', 'Pq x 12 Unid - 340 g', 'Galleta Cucas Horneaditos - Pq x 12 Unid - 340 gr', NULL, 0.00
    ),
    (
        422, 1, 0, '1016003015285', 'Tostadas Mantequilla Horneaditos', '100 gr', 'Tostadas Mantequilla Horneaditos x 100 gr', NULL, 0.00
    ),
    (
        423, 1, 0, '1016003018545', 'Pan De Leche Horneaditos', '440 gr', 'Pan De Leche Horneaditos x 440 gr', NULL, 0.00
    ),
    (
        424, 1, 0, '1016003018569', 'Pan Tajado Horneaditos', '450 gr', 'Pan Tajado Horneaditos x 450gr', NULL, 0.00
    ),
    (
        425, 1, 0, '1016003018576', 'Pan Tajado Integral Horneaditos', '350gr', 'Pan Tajado Integral Horneaditos x 350 gr', NULL, 0.00
    ),
    (
        426, 1, 0, '1016003117200', 'Tostadas Frutos Rojos Horneaditos', '100 gr', 'Tostadas Frutos Rojos Horneaditos x 100 gr', NULL, 0.00
    ),
    (
        427, 1, 0, '1016004021810', 'Galleta Quesudito Horneaditos', '250 gr', 'Galleta Quesudito Horneaditos x 250 gr', NULL, 0.00
    ),
    (
        428, 1, 0, '1016008020642', 'Mini Brownie con Arequipe Horneaditos', 'Pq x 15 Und- 350 gr', 'Brownie con Arequipe Horneaditos - Pq x 15 Und - 350 gr', NULL, 0.00
    ),
    (
        429, 0, 0, '1016008037152', 'Mini Mantecada Tradicion', '195gr x 6 Und', 'Mini Mantecada Tradicion 195gr x 6 Und', NULL, 0.00
    ),
    (
        430, 1, 0, '1016015017444', 'Pan Integral Miel y Pasas Horneaditos', '340 gr', 'Pan Integral Miel y Pasas Horneaditos x 340 gr', NULL, 0.00
    ),
    (
        431, 1, 0, '1018004015585', 'Tortilla De Harina Crachos', 'Pq 12 Unid x 360 gr', 'Tortilla De Harina Crachos - Pq x 12 unidades de 360 gr', NULL, 0.00
    ),
    (
        432, 1, 0, '1018004015592', 'Tortilla De Harina Crachos', 'Pq x 8 Unid', 'Tortilla De Harina Crachos  Pq x 8 Unidades  - 580 gr', NULL, 0.00
    ),
    (
        433, 1, 0, '1018007017807', 'Mani Salado Nuthos', '200 gr', 'Mani Salado Nuthos x 200 gr', NULL, 0.00
    ),
    (
        434, 1, 0, '1018007032688', 'Uvas Pasas Nuthos', '200 gr', 'Uvas Pasas Nuthos x 200 gr', NULL, 0.00
    ),
    (
        435, 1, 0, '1018007038727', 'Mani Crocante Nuthos', '180 gr', 'Mani Crocante Nuthos - 180 gr', NULL, 0.00
    ),
    (
        436, 1, 0, '1018015031048', 'Tortillas Integrales Natri', 'Pq x 8 Und- 250 gr', 'Tortillas Integrales Natri - Pq x 8 Und- 250 gr', NULL, 0.00
    ),
    (
        437, 1, 0, '10190', 'Garbanzo La Q', '500 gr', 'Garbanzo La Q x 500 gr', NULL, 0.00
    ),
    (
        438, 1, 0, '1019001016636', 'Salsa De Tomate Zev', '500 gr', 'Salsa De Tomate Zev x 500 gr', NULL, 0.00
    ),
    (
        439, 1, 0, '1019001017374', 'Salsa Mayonesa Baja En Grasa Zev', '500 gr', 'Salsa Mayonesa Baja En Grasa Zev x 500 gr', NULL, 0.00
    ),
    (
        440, 1, 0, '1019001027373', 'Salsa Rosada Zev', '200 gr', 'Salsa Rosada Zev x 200 gr', NULL, 0.00
    ),
    (
        441, 1, 0, '1019001039482', 'Salsa Tartara Zev', '200 gr', 'Salsa Tartara Zev x 200 gr', NULL, 0.00
    ),
    (
        442, 1, 0, '1019002021332', 'Salsa De Soya Frasco Zev', '190 gr', 'Salsa De Soya Frasco Zev x 190 gr', NULL, 0.00
    ),
    (
        443, 1, 0, '1019002021349', 'Salsa Negra Frasco Zev', '190 gr', 'Salsa Negra Frasco Zev x 190 gr', NULL, 0.00
    ),
    (
        444, 1, 0, '1019002022650', 'Salsa BBQ Mash', '550 ml', 'Salsa BBQ Mash x 550 ml', NULL, 0.00
    ),
    (
        445, 1, 0, '1019002023473', 'Vinagreta Ranch Zev', '240 ml', 'Vinagreta Ranch Zev x 240 ml', NULL, 0.00
    ),
    (
        446, 1, 0, '1019002023633', 'Vinagreta Light Zev', '265 ml', 'Vinagreta Light Zev x 265 ml', NULL, 0.00
    ),
    (
        447, 1, 0, '1019003031477', 'Mermelada De Mora Zev', '200 gr', 'Mermelada De Mora Zev x 200 gr', NULL, 0.00
    ),
    (
        448, 1, 0, '1019008034480', 'Salsa Boloñesa Deliziare', '400 gr', NULL, NULL, 0.00
    ),
    (
        449, 1, 0, '1019008034497', 'Salsa Napolitana', '400 gr', 'Salsa Napolitana x 400 gr', NULL, 0.00
    ),
    (
        450, 1, 0, '1019015020698', 'Vinagre Blanco Zev', '500 ml', 'Vinagre Blanco Zev x 500 ml', NULL, 0.00
    ),
    (
        451, 1, 0, '1022001016759', 'Carton De Huevos Tipo AA', '12  Unidades', 'Carton De Huevos Tipo AA - 12 Unidades', NULL, 0.00
    ),
    (
        452, 1, 0, '1024002018107', 'Margarina Vegetal Don Olio', '500 gr', 'Margarina Vegetal Don Olio x 500 gr', NULL, 0.00
    ),
    (
        453, 1, 0, '1024002022029', 'Margarina Don Olio', '125 gr', 'Margarina Don Olio x 125 gr', NULL, 0.00
    );

INSERT INTO
    `productos` (
        `id`, `estado`, `kit`, `barcode`, `nombre`, `presentacion`, `descripcion`, `foto`, `peso`
    )
VALUES (
        454, 1, 0, '1024002022661', 'Margarina De Canola Don Olio', '250 gr', 'Margarina De Canola Don Olio x 250 gr', NULL, 0.00
    ),
    (
        455, 1, 0, '1024002030468', 'Margarina Esparcible Don Olio Light', '250 gr', 'Margarina Don Olio', NULL, 0.00
    ),
    (
        456, 1, 0, '1024004031500', 'Aceite Canola Spray Don Olio', '180 gr', 'Aceite Spray Don Olio x 180 gr', NULL, 0.00
    ),
    (
        457, 1, 0, '1024004035409', 'Aceite De Coco Virgen Natri', '231ml', 'Aceite De Coco Virgen Natri x 231 ml', NULL, 0.00
    ),
    (
        458, 1, 0, '1025003030242', 'Arepa Santandereana Masmai', 'Pq x  6 Und - 450 gr', 'Arepa Santandereana Masmai- Pq x 6 Und- 450 gr', NULL, 0.00
    ),
    (
        459, 1, 0, '1027003032035', 'Torta Helada Frutos Rojos Kulfi', '450 gr', 'Torta Helada Frutos Rojos Kulfi  x  450 gr', NULL, 0.00
    ),
    (
        460, 1, 0, '1027003032042', 'Torta Helada Choco Arequipe Kulfi', '450 gr', 'Torta Helada Choco Arequipe Kulfi x 450gr', NULL, 0.00
    ),
    (
        461, 1, 0, '1027003040160', 'Helado Chocolate Kulfi', '65 gr', 'Helado De Chocolate Kulfi x 65 gr', NULL, 0.00
    ),
    (
        462, 1, 0, '1027004032997', 'Nuggest De Pollo Apanado Brasset', '300 gr', 'Nuggest De Pollo Apanado Brasset x 300 gr', NULL, 0.00
    ),
    (
        463, 1, 0, '1027004034465', 'Cazuela De Mariscos Capitan Bay (Frutos del Mar)', '400 gr', 'Cazuela De Mariscos Capitan Bay x  400 gr', NULL, 0.00
    ),
    (
        464, 1, 0, '1027006037631', 'Helado Yogurt Con Salsa De Mora Kulfi', '1000 ml', 'Helado Yogurt Con Salsa De Mora Kulfi x 1000 ml', NULL, 0.00
    ),
    (
        465, 1, 0, '1028001037824', 'Galleta Happy Cream Limon', 'Pq x 6 Unid', 'Galleta Happy Cream Limon - Pq x 6 Unid', NULL, 0.00
    ),
    (
        466, 1, 0, '1028002037458', 'Galletas Semidulces Saltísimas', '3 Tacos x 315 gr', 'Galletas Semidulces Saltísimas x 315 gr', NULL, 0.00
    ),
    (
        467, 1, 0, '1028002037465', 'Galletas Semidulces Saltísimas', '5 Tacos x 455 gr', 'Galletas Semidulces Saltísimas -  5 Tacos x 455 gr', NULL, 0.00
    ),
    (
        468, 1, 0, '1028004030532', 'Galleta Happy Cream Vainilla', 'Pq x 6 Unid', 'Galleta Happy Cream Vainilla - Pq x 6 Unid', NULL, 0.00
    ),
    (
        469, 1, 0, '1028004036022', 'Galleta Happy Cream Vainilla', 'Pq x 12 Unid', 'Galleta Happy Cream Vainilla - Pq x 12 Unid', NULL, 0.00
    ),
    (
        470, 1, 0, '1028006032565', 'Galleta Cubierta Yogur Natri', '180 gr', 'Galleta Cubierta Yogur Natri x 180 gr', NULL, 0.00
    ),
    (
        471, 1, 0, '1028008033720', 'Galletas Wafer Vainilla Happy Wafer', 'Pq x 6 Und- 174 gr', 'Galletas Wafer Vainilla Happy Wafer Paquete x 6 Und - 174 gr', NULL, 0.00
    ),
    (
        472, 1, 0, '103', 'Cidra', '1000 gr', 'Cidra - 1000 gr', NULL, 0.00
    ),
    (
        473, 0, 0, '10332832', 'Chicle En Polvo Oka Loka', '12g', 'Chicle En Polvo Oka Loka', NULL, 0.00
    ),
    (
        474, 1, 0, '1036516', 'ARROZ', '500gr', 'Arroz de marca', NULL, 0.00
    ),
    (
        475, 1, 0, '104', 'Manzana De Agua', '1000 gr', 'Manzana De Agua - 1000 gr', NULL, 0.00
    ),
    (
        476, 1, 0, '1041430070040', 'Curry Speciaria', '28 gr', 'Curry Speciaria x 28gr', NULL, 0.00
    ),
    (
        477, 1, 0, '1041440070047', 'Jengibre En Polvo Speciaria', '28 gr', 'Jengibre En Polvo Speciaria x 28 gr', NULL, 0.00
    ),
    (
        478, 1, 0, '1041460070041', 'Paprika Speciaria', '28 gr', 'Paprika Speciaria - 28 gr', NULL, 0.00
    ),
    (
        479, 1, 0, '1041470070048', 'Clavo Entero Speciaria', '20 gr', 'Clavo Entero Speciaria x 20 gr', NULL, 0.00
    ),
    (
        480, 1, 0, '1041500080061', 'Carne Molida Red Cut', '500  gr', 'Carne Molida Red Cut x 500 gr', NULL, 0.00
    ),
    (
        481, 1, 0, '1041590140157', 'Yogurt Griego Frutos Del Bosque + Granola  Latti', '160 gr', 'Yogurt Griego Frutos Del Bosque + Granola  Latti - 160 gr', NULL, 0.00
    ),
    (
        482, 1, 0, '1041600140153', 'Yogurt Griego Fresa + Granola  Latti', '160 gr', 'Yogurt Griego Fresa + Granola  Latti - 160 gr', NULL, 0.00
    ),
    (
        483, 1, 0, '1041610140150', 'Yogurt Griego Kiwi + Granola  Latti', '160 gr', 'Yogurt Griego Kiwi + Granola  Latti - 160 gr', NULL, 0.00
    ),
    (
        484, 1, 0, '105', 'Guanabana', '1000 gr', 'Guanaban - 1000 gr', NULL, 0.00
    ),
    (
        485, 1, 0, '106', 'Badea', '1000 gr', 'Badea - 1000 gr', NULL, 0.00
    ),
    (
        486, 1, 0, '107', 'Calabacita', '1000 gr', 'Calabacita - 1000 gr', NULL, 0.00
    ),
    (
        487, 1, 0, '108', 'Batata', '1000 gr', 'Batata - 1000 gr', NULL, 0.00
    ),
    (
        488, 1, 0, '109', 'Malanga', '1000 gr', 'Malanga - 1000 gr', NULL, 0.00
    ),
    (
        489, 1, 0, '11', 'Guayaba', '1000 gr', 'Guayaba - 1000 gr', NULL, 0.00
    ),
    (
        490, 1, 0, '11000001', 'Arepa De Chocolo', 'Unidad', 'Arepa De Chocolo - Unidad', NULL, 0.00
    ),
    (
        491, 1, 0, '11000002', 'Madurito Con Queso', 'Unidad', 'Madurito Con Queso - Unidad', NULL, 0.00
    ),
    (
        492, 1, 0, '11000003', 'Mazorca Asada', 'Unidad', 'Mazorca Asada - Unidad', NULL, 0.00
    ),
    (
        493, 1, 0, '11000004', 'Chorizo', 'Unidad', 'Chorizo - Unidad', NULL, 0.00
    ),
    (
        494, 1, 0, '11000005', 'Rellena Asada', 'Unidad', 'Rellena Asada - Unidad', NULL, 0.00
    ),
    (
        495, 1, 0, '11000006', 'Rellena + Papa', 'Combo', 'Rellena (1)+Papita - Combo', NULL, 0.00
    ),
    (
        496, 1, 0, '11000007', 'Chorizo + Papa', 'Combo', 'Chorizo (2)+Papita - Combo', NULL, 0.00
    ),
    (
        497, 1, 0, '11000008', 'Rellena + Chorizo + Papa', 'Combo', 'Rellena (1)+Chorizo (1)+Papita - Combo', NULL, 0.00
    ),
    (
        498, 1, 0, '11000009', 'Arepa De Chocolo + Chorizo', 'Combo', 'Arepa de Chocolo+Chorizo - Combo', NULL, 0.00
    ),
    (
        499, 1, 0, '11000010', 'Parrillada Tipica', 'Combo Para 2', 'Lomito de Res             \r\nChuleta de Cerdo\r\nPechuga\r\nRellena\r\nChorizo\r\nMadurito\r\nChicharrón\r\nArepa de Chocolo\r\n\r\nPara dos (2) Personas', NULL, 0.00
    ),
    (
        500, 1, 0, '11000011', 'Parrillada Tipica', 'Combo Para 3', 'Lomito de Res             \r\nChuleta de Cerdo\r\nPechuga\r\nRellena\r\nChorizo\r\nMadurito\r\nChicharrón\r\nArepa de Chocolo\r\n\r\nPara Tres (3) Personas', NULL, 0.00
    ),
    (
        501, 1, 0, '11000012', 'Parrillada Tipica', 'Combo Para 4', 'Lomito de Res             \r\nChuleta de Cerdo\r\nPechuga\r\nRellena\r\nChorizo\r\nMadurito\r\nChicharrón\r\nArepa de Chocolo\r\n\r\nPara Cuatro (4) Personas', NULL, 0.00
    ),
    (
        502, 1, 0, '11000013', 'Parrillada Tipica', 'Combo Para 6', 'Lomito de Res             \r\nChuleta de Cerdo\r\nPechuga\r\nRellena\r\nChorizo\r\nMadurito\r\nChicharrón\r\nArepa de Chocolo\r\n\r\nPara Seis (6) Personas', NULL, 0.00
    ),
    (
        503, 1, 0, '11000014', 'Parrillada Tipica', 'Combo Para 8', 'Lomito de Res             \r\nChuleta de Cerdo\r\nPechuga\r\nRellena\r\nChorizo\r\nMadurito\r\nChicharrón\r\nArepa de Chocolo\r\n\r\nPara Ocho (8)  Personas', NULL, 0.00
    ),
    (
        504, 1, 0, '11000015', 'Sopa De Mute', 'Unidad', 'Sopa De Mute Santandereano - Unidad', NULL, 0.00
    ),
    (
        505, 1, 0, '11000016', 'Sancocho de Gallina Criolla', 'Combo', 'Sancocho de Gallina Criolla Con 1/4 de Gallina - Combo', NULL, 0.00
    ),
    (
        506, 1, 0, '11000017', 'Cabro Con Pepitoria', 'Combo', 'Cabro Con Pepitoria - Combo', NULL, 0.00
    ),
    (
        507, 1, 0, '11000019', 'Pollo a la Broaster Completo', 'Unidad', 'Pollo a la Broaster Completo - Unidad', NULL, 0.00
    ),
    (
        508, 1, 0, '11000020', 'Pollo Asado Completo', 'Unidad', 'Pollo Asado Completo - Unidad', NULL, 0.00
    ),
    (
        509, 1, 0, '1111111008140', 'Salchica Manguera A Granel', '178 gr', 'Salchica Manguera A Granel - 178 gr', NULL, 0.00
    ),
    (
        510, 1, 0, '1111111112427', 'Papa R-12', '10000 gr', 'Papa R-12 - 10000 gr', NULL, 0.00
    ),
    (
        511, 1, 0, '1111111112434', 'Papa R-12', '3000 gr', 'Papa R-12 - 3000 gr', NULL, 0.00
    ),
    (
        512, 1, 0, '1111111112441', 'Papa Pastusa', '2500 gr', 'Papa Pastusa - 2500 gr', NULL, 0.00
    ),
    (
        513, 1, 0, '1111111112458', 'Papa Pastusa', '3000 gr', 'Papa Pastusa - 3000 gr', NULL, 0.00
    ),
    (
        514, 1, 0, '1111111113561', 'Bolsa de Carbon', 'Und', 'Bolsa de Carbon   - Und', NULL, 0.00
    ),
    (
        515, 1, 0, '1111111115992', 'Papa R-12', '5000 gr', 'Papa R-12 - 5000 gr', NULL, 0.00
    ),
    (
        516, 1, 0, '1111111129463', 'Panela Rapimercar', '1000 gr', 'Panela Rapimercar - 1000 gr', NULL, 0.00
    ),
    (
        517, 1, 0, '1111111132845', 'Huevo Gallina Rojo Rapi Tipo A', '12 Und', 'Huevo Gallina Rojo Rapi Tipo A - 12 Und', NULL, 0.00
    ),
    (
        518, 1, 0, '1111111132852', 'Panela Rapimercar', '500 gr', 'Panela Rapimercar -  500 gr', NULL, 0.00
    ),
    (
        519, 1, 0, '1111111151341', 'Panela Cuadrada', '250 gr', 'Panela Cuadrada - 250 gr', NULL, 0.00
    ),
    (
        520, 1, 0, '1111111257005', 'Panela Rapimercar', '1900 gr', 'Panela Rapimercar  - 1900 gr', NULL, 0.00
    ),
    (
        521, 1, 0, '1111111265970', 'Frijol Balin Rapimercar', '500 gr', 'Frijol Balin Rapimercar - 500 gr', NULL, 0.00
    ),
    (
        522, 1, 0, '1111111328729', 'Huevo Gallina Rapi Tipo A', '15 Und', 'Huevo Gallina Rapi Tipo A - 15 Und', NULL, 0.00
    ),
    (
        523, 1, 0, '1111111408117', 'Frijol Rojo Rapimercar', '250 gr', 'Frijol Rojo Rapimercar - 250 gr', NULL, 0.00
    ),
    (
        524, 1, 0, '1111111408155', 'Frijol Cabecita Negra', '250 gr', 'Frijol Cabecita Negra - 250 gr', NULL, 0.00
    ),
    (
        525, 1, 0, '1111111408179', 'Frijol Blanco Palomo BJ', '250 gr', 'Frijol Blanco Palomo BJ  - 250 gr', NULL, 0.00
    ),
    (
        526, 1, 0, '1111111408186', 'Frijol Palomo Rapimercar', '500 gr', 'Frijol Palomo Rapimercar - 500 gr', NULL, 0.00
    ),
    (
        527, 1, 0, '1111111408193', 'Arveja Rapimercar', '250 gr', 'Arveja Rapi Mercar - 250 gr', NULL, 0.00
    ),
    (
        528, 1, 0, '1111111408278', 'Arroz Rapi Mercar', '500 gr', 'Arroz Rapi Mercar - 500gr', NULL, 0.00
    ),
    (
        529, 1, 0, '1111111408292', 'Frijol Cargamanto Rapimercar', '250 gr', 'Frijol Cargamanto Rapi Mercar - 250 gr', NULL, 0.00
    ),
    (
        530, 1, 0, '1111111408308', 'Frijol Cargamanto Blanco', '500 gr', 'Frijol Cargamanto Blanco - 500 gr', NULL, 0.00
    ),
    (
        531, 1, 0, '11111114145900', 'Garbanzo Rapimercar', '250 gr', 'Garbanzo Rapimercar - 250 gr', NULL, 0.00
    ),
    (
        532, 1, 0, '1111111474082', 'Pasta Macaroni Queso Kraft', '206 gr', 'Pasta Macaroni Queso Kraft - 206 gr', NULL, 0.00
    ),
    (
        533, 1, 0, '1111111600863', 'Pan Morrocota Rapi', 'Und', 'Pan Morrocota Rapi  - Und', NULL, 0.00
    ),
    (
        534, 1, 0, '1111111601051', 'Pan Mantequilla', '75 gr', 'Pan Mantequilla - 75 gr', NULL, 0.00
    ),
    (
        535, 1, 0, '1111111601082', 'Pan Frances Grande Rapi', 'Und', 'Pan Frances Grande Rapi - Und', NULL, 0.00
    ),
    (
        536, 1, 0, '1111111601099', 'Pan Chileno Rapi', '425 gr', 'Pan Chileno Rapi - 425 gr', NULL, 0.00
    ),
    (
        537, 1, 0, '1111111601136', 'Pan Perro rapi', 'Pq x 6 und', 'Pan Perro rapi  - Pq x 6 und', NULL, 0.00
    ),
    (
        538, 1, 0, '1111111601181', 'Pan Molde Grande Rapi', 'Und', 'Pan Molde Grande Rapi - Und', NULL, 0.00
    ),
    (
        539, 1, 0, '1111111601198', 'Pan Molde Integral', '625 gr', 'Pan Molde Integral - 625 gr', NULL, 0.00
    ),
    (
        540, 1, 0, '1111111602386', 'Pan De Leche Rapi Grande', 'und', 'Pan De Leche Rapi Grande - Und', NULL, 0.00
    ),
    (
        541, 1, 0, '1111111604731', 'Pan Mini Perro Rapi', 'Pq x 10 und', 'Pan Mini Perro Rapi  - Pq x 10 und', NULL, 0.00
    ),
    (
        542, 1, 0, '1111111604748', 'Pan Mini Hamburguesa Rapi', 'Pq x 10 und', 'Pan Mini Hamburguesa Rapi  - Pq x 10 und', NULL, 0.00
    ),
    (
        543, 1, 0, '1111111620014', 'Galetas Rapimercar', 'Pq x 5 Und', 'Galetas Rapimercar - Pq x 5 Und', NULL, 0.00
    ),
    (
        544, 1, 0, '1111111869116', 'Huevo Rapi Tipo B', '30 Und', 'Huevo Rapi Tipo B - 30 Und', NULL, 0.00
    ),
    (
        545, 1, 0, '1111111876114', 'Huevo Gallina Rapi Tipo A', '30 Und', 'Huevo Gallina Rapi Tipo A - 30 Und', NULL, 0.00
    ),
    (
        546, 1, 0, '1111111881644', 'Huevo De Codorniz La Milagrosa', '24 Und', 'Huevo De Codorniz La Milagrosa - 24 Und', NULL, 0.00
    ),
    (
        547, 1, 0, '1113', 'Pechuga De Pollo Fresca', '1000 gr', 'Pechuga De Pollo Fresca - 1000 gr', NULL, 0.00
    ),
    (
        548, 1, 0, '11152066301', 'Arroz Sushi Nishiki Jfc', '1000 gr', 'Arroz Sushi Nishiki Jfc - 1000 gr', NULL, 0.00
    ),
    (
        549, 1, 0, '11210000018', 'Salsa de pimienta Tabasco Picante', '60 ml', 'Salsa de pimienta Tabasco Picante - 60 ml', NULL, 0.00
    ),
    (
        550, 1, 0, '114', 'Rabano Blanco', '500 gr', 'Rabano Blanco - 500 gr', NULL, 0.00
    ),
    (
        551, 1, 0, '12000000', 'Arepa Trifasica', 'Unidad', 'Carne, huevo, pollo y salchicha', NULL, 0.00
    ),
    (
        552, 1, 0, '12000001', 'Arepas Rellenas', 'Unidad', NULL, NULL, 0.00
    ),
    (
        553, 1, 0, '12000002', 'Buñuelo', 'Unidad', 'Buñuelo - Unidad', NULL, 0.00
    ),
    (
        554, 1, 0, '12000003', 'Cafe', 'Unidad', NULL, NULL, 0.00
    ),
    (
        555, 1, 0, '12000004', 'Chocolate', 'Unidad', NULL, NULL, 0.00
    ),
    (
        556, 1, 0, '12000005', 'Empanada de Trigo Pollo Queso', 'Unidad', 'Empanada Pollo Queso', NULL, 0.00
    ),
    (
        557, 1, 0, '12000006', 'Empanada de Yuca Mixta', 'Unidad', 'Empanada de Yuca Mixta con Arroz, Carne y Huevo - Unidad', NULL, 0.00
    ),
    (
        558, 1, 0, '12000007', 'Empanada Hawaiana', 'Unidad', 'Empanada Hawaiana', NULL, 0.00
    ),
    (
        559, 1, 0, '12000008', 'Empanada Ranchera', 'Unidad', 'Empanada Ranchera', NULL, 0.00
    ),
    (
        560, 1, 0, '12000009', 'Empanada Solo Pollo', 'Unidad', 'Empanada Solo Pollo - Unidad', NULL, 0.00
    ),
    (
        561, 1, 0, '12000010', 'Empanada Trigo Mixta', 'Unidad', 'Empanada Trigo Mixta - Unidad', NULL, 0.00
    ),
    (
        562, 1, 0, '12000011', 'Huevo Frito', 'Unidad', 'Huevo Frito Acopañado de Arepa Blanca', NULL, 0.00
    ),
    (
        563, 1, 0, '12000012', 'Huevos Pericos', 'Unidad', 'Huevos Pericos acompañado de Pan o Arepa Blanca', NULL, 0.00
    ),
    (
        564, 1, 0, '12000013', 'Huevos Ranchero', 'Unidad', 'Huevos Ranchero acompañado de Pan o Arepa Blanca', NULL, 0.00
    ),
    (
        565, 1, 0, '12000014', 'Jugo de Naranja', 'Unidad', NULL, NULL, 0.00
    ),
    (
        566, 1, 0, '12000015', 'Papa Rellena Mixta', 'Unidad', 'Arroz, huevo y carne', NULL, 0.00
    ),
    (
        567, 1, 0, '12000016', 'Salpicon', 'Unidad', NULL, NULL, 0.00
    ),
    (
        568, 1, 0, '12000017', 'Sandwich', 'Unidad', NULL, NULL, 0.00
    ),
    (
        569, 1, 0, '122', 'Ciruela Nacional', '1000 gr', 'Ciruela Nacional - 1000 gr', NULL, 0.00
    ),
    (
        570, 1, 0, '123', 'Aji Chivato', '1000 gr', 'Aji Chivato - 1000 gr', NULL, 0.00
    ),
    (
        571, 1, 0, '123123', 'Carton  De Huevos Tipo A', '30 Unidades', 'Cartón  De Huevos Tipo Tipo A x 30 Unidades', NULL, 0.00
    ),
    (
        572, 0, 0, '123132', 'Aceite De Palma (Galilea, Ideal, Salomon)', '3000 ml', 'Aceite De Palma (Galilea, Ideal, Salomon) - 3000 ml', NULL, 0.00
    ),
    (
        573, 1, 0, '12345670124520', 'Colita Fashion', 'Pq x 4 Und', 'Colita Fashion  - Pq x 4 Und', NULL, 0.00
    ),
    (
        574, 0, 1, '123556', 'Ancheta Nochebuena', 'Ancheta Nochebuena', 'Ancheta Nochebuena', NULL, 0.00
    ),
    (
        575, 1, 0, '124', 'Pimenton Rojo', '1000 gr', 'Pimenton Rojo - 1000 gr', NULL, 0.00
    ),
    (
        576, 1, 0, '1241', 'Producto prueba', '3234', 'gasdgf', NULL, 0.00
    ),
    (
        577, 1, 0, '126', 'Guayaba Agria', '1000 gr', 'Guayaba Agria - 1000 gr', NULL, 0.00
    ),
    (
        578, 1, 0, '127', 'Zapote Cachaco', '500 gr', 'Zapote Cachaco - 500 gr', NULL, 0.00
    ),
    (
        579, 1, 0, '13', 'Mandarina Comun', '500 gr', 'Mandarina Comun  - 500 gr', NULL, 0.00
    ),
    (
        580, 1, 0, '13000000', 'Lunes Carne Asada 1', 'Unidad', '- Sopa Fideos\r\n- Arroz \r\n- Maduro \r\n- Ensalada rusa\r\n- Carne Asada', NULL, 0.00
    ),
    (
        581, 1, 0, '13000001', 'Lunes Pechuga Asada 1', 'Unidad', '- Sopa Fideos\r\n- Arroz \r\n- Maduro \r\n- Ensalada rusa\r\n- Pechuga Asada', NULL, 0.00
    ),
    (
        582, 1, 0, '13000002', 'Lunes Especial 1', 'Unidad', '- Chatas\r\n- Papas a la francesa \r\n- Ensalada', NULL, 0.00
    ),
    (
        583, 1, 0, '13000003', 'Martes Carne Desmechada 1', 'Unidad', '- Sopa Patacón\r\n- Arroz \r\n- Frijol blanco\r\n- Ensalada \r\n- Carne desmechada', NULL, 0.00
    ),
    (
        584, 1, 0, '13000004', 'Martes Pechuga Asada 1', 'Unidad', '- Sopa Patacón\r\n- Arroz \r\n- Frijol blanco\r\n- Ensalada \r\n- Pechuga Asada', NULL, 0.00
    ),
    (
        585, 1, 0, '13000005', 'Martes Especial 1', 'Unidad', '- Costillitas de cerdo\r\n- Papas a la francesa\r\n- Ensalada', NULL, 0.00
    ),
    (
        586, 1, 0, '13000006', 'Miercoles Carne en Bistec 1', 'Unidad', '- Sopa Avena\r\n- Arroz \r\n- Alverjas\r\n- Patacón \r\n- Ensalada \r\n- Carne en Bistec', NULL, 0.00
    ),
    (
        587, 1, 0, '13000007', 'Miercoles Pollo Sudado 1', 'Unidad', '- Sopa Avena\r\n- Arroz \r\n- Alverjas\r\n- Patacón \r\n- Ensalada \r\n- Pollo Sudado', NULL, 0.00
    ),
    (
        588, 1, 0, '13000008', 'Miercoles Especial 1', 'Unidad', '- Picada ( Carne, pollo, chorizo, maduro, papa, y rellena)', NULL, 0.00
    ),
    (
        589, 1, 0, '13000009', 'Jueves Carne Sudada 1', 'Unidad', '- Crema de Apio\r\n- Arroz\r\n- Papa criolla\r\n- Lenteja \r\n- Ensalada \r\n- Carne sudada', NULL, 0.00
    ),
    (
        590, 1, 0, '13000010', 'Jueves Lomo de Cerdo 1', 'Unidad', '- Crema de Apio\r\n- Arroz\r\n- Papa criolla\r\n- Lenteja \r\n- Ensalada \r\n- Lomo de Cerdo', NULL, 0.00
    ),
    (
        591, 1, 0, '13000011', 'Jueves Especial 1', 'Unidad', '- Hamburguesa Sencilla: (Carne + Verduras)  con papa a la francesa', NULL, 0.00
    ),
    (
        592, 1, 0, '13000012', 'Viernes Carne Molida 1', 'Unidad', '- Sopa de verduras\r\n- Arroz\r\n- Frijol rojo\r\n- Yuca\r\n- Ensalada\r\n- Carne Molida', NULL, 0.00
    ),
    (
        593, 1, 0, '13000013', 'Viernes Higado en Bistec 1', 'Unidad', '- Sopa de verduras\r\n- Arroz\r\n- Frijol rojo\r\n- Yuca\r\n- Ensalada\r\n- Higado en Bistec', NULL, 0.00
    ),
    (
        594, 1, 0, '13000014', 'Viernes Especial 1', 'Unidad', '- Lasagna con tostadas de pan', NULL, 0.00
    ),
    (
        595, 1, 0, '13000015', 'Lunes Carne Asada 2', 'Unidad', '- Sopa de Pastas \r\n- Arroz \r\n- Tajadas \r\n- Ensalada de papa \r\n- Carne Asada', NULL, 0.00
    ),
    (
        596, 1, 0, '13000016', 'Lunes Pechuga Asada 2', 'Unidad', '- Sopa de Pastas \r\n- Arroz \r\n- Tajadas \r\n- Ensalada de papa \r\n- Pechuga Asada', NULL, 0.00
    ),
    (
        597, 1, 0, '13000017', 'Lunes Especial 2', 'Unidad', '- Pastas a la boloñesa \r\n- Papas a la francesa', NULL, 0.00
    ),
    (
        598, 1, 0, '13000018', 'Martes Carne Molida 2', 'Unidad', '- Sopa de verduras \r\n- Arroz \r\n- Frijol blanco\r\n- Ensalada \r\n- Moneditas de plátano\r\n- Carne desmechada', NULL, 0.00
    ),
    (
        599, 1, 0, '13000019', 'Martes Especial 2', 'Unidad', '- Chatas\r\n- Papas a la francesa \r\n- Ensalada', NULL, 0.00
    ),
    (
        600, 1, 0, '13000020', 'Miercoles Pollo Frito  2', 'Unidad', '- Sopa de apio\r\n- Arroz \r\n- Guiso de ahuyama \r\n- Fritas de trigo\r\n- Pollo frito', NULL, 0.00
    ),
    (
        601, 1, 0, '13000021', 'Miercoles Especial 2', 'Unidad', '- Pechuga en salsa de ciruela \r\n- Ensalada agridulce\r\n- Puré de papa', NULL, 0.00
    ),
    (
        602, 1, 0, '13000022', 'Jueves Pechuga Asada 2', 'Unidad', '- Sopa de avena\r\n- Espaguetis\r\n- Ensalada\r\n- Patacones \r\n- Pechuga Asada', NULL, 0.00
    ),
    (
        603, 1, 0, '13000023', 'Jueves Especial 2', 'Unidad', '- Sobrebarriga \r\n- Ensalada de aguacate \r\n- Patacones', NULL, 0.00
    ),
    (
        604, 1, 0, '13000024', 'Viernes Pollo Sudado 2', 'Unidad', '- Sopa de fideos\r\n- Arroz\r\n- Frijol blanco\r\n- Papa\r\n- Ensalada\r\n- Pollo sudado', NULL, 0.00
    ),
    (
        605, 1, 0, '13000025', 'Viernes Especial 2', 'Unidad', '- Arroz con pollo\r\n- Papa a la francesa', NULL, 0.00
    ),
    (
        606, 1, 0, '13000026', 'Lunes Lomo de Cerdo 3', 'Unidad', '- Crema de auyama \r\n- Arroz\r\n- Ensalada \r\n- Lenteja \r\n- Tajadas\r\n- Lomo de Cerdo', NULL, 0.00
    ),
    (
        607, 1, 0, '13000027', 'Lunes Pechuga Asada 3', 'Unidad', '- Crema de auyama \r\n- Arroz\r\n- Ensalada \r\n- Lenteja \r\n- Tajadas\r\n- Pechuga Asada', NULL, 0.00
    ),
    (
        608, 1, 0, '13000028', 'Lunes Especial 3', 'Unidad', '- Pechuga rellena\r\n- Ensalada de yogurt \r\n- Pure de papa', NULL, 0.00
    ),
    (
        609, 1, 0, '13000029', 'Martes Pollo Frito  3', 'Unidad', '- Sopa de patacon\r\n- Arroz \r\n- Guiso de yota \r\n- Papa amarilla al vapor\r\n- Pollo frito', NULL, 0.00
    ),
    (
        610, 1, 0, '13000030', 'Martes Especial 3', 'Unidad', '- Alitas de pollo en salsa picante\r\n- Ensalada \r\n- Papa a la francesa', NULL, 0.00
    ),
    (
        611, 1, 0, '13000031', 'Miercoles Higado en Bistec 3', 'Unidad', '- Sopa de cebada\r\n- Arroz\r\n- Frijol rojo\r\n- Patacones\r\n- Higado en Bistec', NULL, 0.00
    ),
    (
        612, 1, 0, '13000032', 'Miercoles Especial 3', 'Unidad', '- Bandeja paisa', NULL, 0.00
    ),
    (
        613, 1, 0, '13000033', 'Jueves Albondigas 3', 'Unidad', '- Sopa de fideos \r\n- Arroz\r\n- Ensalada de remolacha\r\n- Arvejas\r\n- Maduro cocido \r\n- Albondigas', NULL, 0.00
    ),
    (
        614, 1, 0, '13000034', 'Jueves Especial 3', 'Unidad', '- Pechuga gratinada \r\n- Papas a la francesa', NULL, 0.00
    ),
    (
        615, 1, 0, '13000035', 'Viernes Carne Asada 3', 'Unidad', '- Sopa de arracacha \r\n- Macarrones\r\n- Arroz \r\n- Ensalada\r\n- Yuca \r\n- Carne Asada', NULL, 0.00
    ),
    (
        616, 1, 0, '13000036', 'Viernes Pechuga Asada 3', 'Unidad', '- Arroz\r\n- Ensalada \r\n- Yuca \r\n- Pechuga Asada', NULL, 0.00
    ),
    (
        617, 1, 0, '13000037', 'Viernes Especial 3', 'Unidad', '- Mute\r\n- Yuca\r\n- Ensalada', NULL, 0.00
    ),
    (
        618, 1, 0, '13027', 'Tomatillo', 'Bandeja - 500 gr', 'Tomatillo - Bandeja - 500 gr', NULL, 0.00
    ),
    (
        619, 1, 0, '132', 'Aguacate Lorena', '1000 gr', 'Aguacate Lorena - 1000 gr', NULL, 0.00
    ),
    (
        620, 1, 0, '136', 'Lulo Injerto', '1000 gr', 'Lulo Injerto - 1000 gr', NULL, 0.00
    ),
    (
        621, 1, 0, '137', 'Zukinni Amarillo', '500 gr', 'Zukinni Amarillo - 500 gr', NULL, 0.00
    ),
    (
        622, 1, 0, '138', 'Zukinni Verde', '500 gr', 'Zukinni Verde - 500 gr', NULL, 0.00
    ),
    (
        623, 1, 0, '13959', 'Tomate Cherry White', '500 gr', 'Tomate Cherry White  -  500 gr', NULL, 0.00
    ),
    (
        624, 1, 0, '14', 'Maracuya', '1000 gr', 'Maracuya - 1000 gr', NULL, 0.00
    ),
    (
        625, 1, 0, '140', 'Pimento Amarillo', '1000 gr', 'Pimento Amarillo - 1000 gr', NULL, 0.00
    ),
    (
        626, 1, 0, '15', 'Pepino Cohombro', '1000 gr', 'Pepino Cohombro - 1000 gr', NULL, 0.00
    ),
    (
        627, 1, 0, '150', 'Contramuslo Pollo Hucana', '1000 gr', 'Contramuslo Pollo Hucana - 1000 gr', NULL, 0.00
    ),
    (
        628, 1, 0, '15235', 'Queso parmesano Colanta Rallado', '100 gr', 'Queso parmesano Colanta Rallado - 100 gr', NULL, 0.00
    ),
    (
        629, 1, 0, '15245', 'Aceite de soya (Galilea, Ideal, Salomón)', '110 ml', 'Aceite Vegetal de Palma. Ideal para freír, hornear, guisar y preparar alimentos.', NULL, 0.00
    ),
    (
        630, 1, 0, '153', 'Alas Hucanas', '1000 gr', 'Alas Hucanas - 1000 gr', NULL, 0.00
    ),
    (
        631, 1, 0, '157', 'Aji Topito', '1000 gr', 'Aji Topito - 1000 gr', NULL, 0.00
    ),
    (
        632, 1, 0, '162', 'Papa Sin Lavar', '1000 gr', 'Papa Sin Lavar - 1000 gr', NULL, 0.00
    ),
    (
        633, 1, 0, '165911', 'Alas De Pollo', '1000 gr', 'Alas De Pollo - 1000 gr', NULL, 0.00
    ),
    (
        634, 1, 0, '16596', 'Pechuga De Pollo Relajada', '1000 gr', 'Pechuga De Pollo Relajada - 1000 gr', NULL, 0.00
    ),
    (
        635, 1, 0, '17', 'Papa Criolla', '1000 gr', 'Papa Criolla - 1000 gr', NULL, 0.00
    ),
    (
        636, 1, 0, '170', 'Aji Jalapeño', '1000 gr', 'Aji Jalapeño - 1000 gr', NULL, 0.00
    ),
    (
        637, 1, 0, '17500081200', 'Niagras Starch Original', '567 gr', 'Niagras Starch Original - 567 gr', NULL, 0.00
    ),
    (
        638, 1, 0, '17500081255', 'Niagras Starch Lavanda', '567 gr', 'Niagras Starch Lavanda - 567 gr', NULL, 0.00
    ),
    (
        639, 1, 0, '17705546500020', 'Margarina Industrail Dany Hojaldren', 'Caja x 30 Und-500 gr', 'Margarina Industrail Dany Hojaldren - Caja x 30 Und-500 gr', NULL, 0.00
    ),
    (
        640, 1, 0, '17707142301018', 'Margarina Cinco Estrellas', '15 Kg', 'Margarina Cinco Estrellas x 15 Kg', NULL, 0.00
    ),
    (
        641, 1, 0, '17707142302107', 'Margarina Ducrema', '15 Kg', 'Margarina Ducrema x 15 Kg', NULL, 0.00
    ),
    (
        642, 1, 0, '17800142731', 'Purina Dog  Chow Pavo y Pollo', '374 gr', 'Purina Dog  Chow Pavo y Pollo - 374 gr', NULL, 0.00
    ),
    (
        643, 1, 0, '18', 'Tomate Liso', '1000 gr', 'Tomate Liso - 1000 gr', NULL, 0.00
    ),
    (
        644, 1, 0, '180', 'Papa Sabanera', '1000 gr', 'Papa Sabanera - 1000 gr', NULL, 0.00
    ),
    (
        645, 1, 0, '182771', 'Leche Entera La Esmeralda', '900 ml', 'Leche Entera La Esmeralda - 900 ml', NULL, 0.00
    ),
    (
        646, 1, 0, '184', 'Yacon', '1000 gr', 'Yacon - 1000 gr', NULL, 0.00
    ),
    (
        647, 1, 0, '19', 'Arracacha', '1000 gr', 'Arracacha - 1000 gr', NULL, 0.00
    ),
    (
        648, 1, 0, '19161004147', 'Guasca Deshidratada Kiska', '10 gr', 'Guasca Deshidratada Kiska - 10 gr', NULL, 0.00
    ),
    (
        649, 1, 0, '19161004161', 'Hinojo Fresca Kiska', 'Unidad', 'Hinojo Fresca Kiska - Unidad', NULL, 0.00
    ),
    (
        650, 1, 0, '19161004192', 'Manzanilla Deshidratada Kiska', '10 gr', 'Manzanilla Deshidratada Kiska - 10 gr', NULL, 0.00
    ),
    (
        651, 1, 0, '19161004598', 'Curry Deshidratado Kiska', '40 gr', 'Curry Deshidratado Kiska - 40 gr', NULL, 0.00
    ),
    (
        652, 1, 0, '19161004635', 'Paprika Pura Kiska', 'Pq x 30 gr', 'Paprika Pura Kiska - pq x 30 gr', NULL, 0.00
    ),
    (
        653, 1, 0, '192', 'Frijol Balin Bola Roja Granel', '500 gr', 'Frijol Balin Bola Roja Granel - 500 gr', NULL, 0.00
    ),
    (
        654, 1, 0, '193', 'Papaya Moradol', '1000 gr', 'Papaya Moradol - 1000 gr', NULL, 0.00
    ),
    (
        655, 1, 0, '19972', 'Pasta de Tomate Fruco', '200  gr', 'Pasta de Tomate Fruco - 200  gr', NULL, 0.00
    ),
    (
        656, 1, 0, '20', 'Tomate De Arbol Comun', '1000 gr', 'Tomate De Arbol Comun - 1000 gr', NULL, 0.00
    ),
    (
        657, 1, 0, '200', 'Frijlol Rojo a Granel', '1000 gr', 'Frijlol Rojo a Granel - 1000 gr', NULL, 0.00
    ),
    (
        658, 1, 0, '20000', 'Alas De Pollo', 'Lb', 'Alas De Pollo x Libra', NULL, 0.00
    ),
    (
        659, 1, 0, '20001', 'Aleta De Res', '500 gr', 'Carne Aleta De Res x Libra', NULL, 0.00
    ),
    (
        660, 1, 0, '20002', 'Alitas Adobadas BBQ Mac Pollo', 'Bolsa x 900 gr', 'Alitas Adobadas BBQ Mac Pollo - Bolsa x 900 gr', NULL, 0.00
    ),
    (
        661, 0, 0, '20003', 'Alitas de Pollo Bbq', '8 unid', 'Alitas de Pollo Bbq Crudas X 8 unid', NULL, 0.00
    ),
    (
        662, 1, 0, '20004', 'Anillos de Calamar Pesquera Del Mar', '250 gr', 'Anillos de Calamar Pesquera Del Mar - 250 gr', NULL, 0.00
    ),
    (
        663, 0, 0, '20005', 'Asadura', '500 gr', 'Carne Asadura x libra', NULL, 0.00
    ),
    (
        664, 1, 0, '20006', 'Bagre (Frutos Del Mar)', '500 gr', 'Bagre x Libra', NULL, 0.00
    ),
    (
        665, 1, 0, '20007', 'Bandeja De Corazones Pollo', 'Bandeja', 'Bandeja De Corazones Pollo - Bandeja', NULL, 0.00
    ),
    (
        666, 1, 0, '20008', 'Bandeja De Higado Pollo', '500 gr', 'Bandeja De Higado Pollo x 500 gr', NULL, 0.00
    ),
    (
        667, 1, 0, '20009', 'Bandeja De Mollejas Pollo', 'Bandeja', 'Bandeja De Mollejas Pollo', NULL, 0.00
    ),
    (
        668, 1, 0, '20010', 'Basa Especial (Frutos del Mar)', '500 gr', 'Basa Especial x libra', NULL, 0.00
    ),
    (
        669, 1, 0, '20011', 'Bife De Chorizo De Res', '500 gr', 'Bife De Chorizo De Res x Libra', NULL, 0.00
    ),
    (
        670, 1, 0, '20012', 'Bocapecho De Res', '500 gr', 'Bocapecho De Res x libra', NULL, 0.00
    ),
    (
        671, 1, 0, '20013', 'Bofe De Res', '500 gr', 'Bofe De Res x Libra', NULL, 0.00
    ),
    (
        672, 1, 0, '20015', 'Bolsa De Menudencias Pollo', 'Bandeja / Und', 'Bandeja De Menudencias Pollo - Bandeja', NULL, 0.00
    ),
    (
        673, 1, 0, '20016', 'Bondiola De Cerdo', '500 gr', 'Bondiola De Cerdo x 500 gr', NULL, 0.00
    ),
    (
        674, 1, 0, '20017', 'Cabro', '500 gr', 'Cabro x libra', NULL, 0.00
    ),
    (
        675, 1, 0, '20018', 'Cabro Revuelto', '500 gr', 'Cabro Revuelto x libra', NULL, 0.00
    ),
    (
        676, 1, 0, '20019', 'Cachama (Frutos del Mar)', '500 gr', 'Cachama x libra', NULL, 0.00
    ),
    (
        677, 1, 0, '20020', 'Cachetes De Res', '500 gr', 'Cachetes de Res x 500 gr', NULL, 0.00
    ),
    (
        678, 1, 0, '20021', 'Cadera De Res', '500 gr', 'Cadera De Res  - 500 gr', NULL, 0.00
    ),
    (
        679, 1, 0, '20022', 'Callo De Res', '500 gr', 'Callo De Res x 500 gr', NULL, 0.00
    ),
    (
        680, 1, 0, '20023', 'Camaron Precocido Vitamar (Frutos del Mar)', '400 gr', 'Camaron Precocido Vitamar x 400 gr', NULL, 0.00
    ),
    (
        681, 1, 0, '20024', 'Capon Abierto', '500 gr', 'Capon Abierto x Libra', NULL, 0.00
    ),
    (
        682, 1, 0, '20025', 'Capon De Res', '500 gr', 'Capón de Res x Libra', NULL, 0.00
    ),
    (
        683, 1, 0, '20026', 'Capon De Res Molida', '500 gr', 'Capón De Res Molida x Libra', NULL, 0.00
    ),
    (
        684, 1, 0, '20027', 'Carne De Res De Primera En Trozos', '500 gr', 'Carne De Res De primera En Trozos', NULL, 0.00
    ),
    (
        685, 1, 0, '20029', 'Carne Hamburguesa', 'Pq x 5 Unidades', 'Carne Hamburguesa -  Pq x 5 Unidades', NULL, 0.00
    ),
    (
        686, 1, 0, '20030', 'Carne Molida', '500 gr', 'Carne Molida x Libra', NULL, 0.00
    ),
    (
        687, 1, 0, '20031', 'Cazuela De Mariscos (Frutos del Mar)', '1000 gr', 'Cazuela De Mariscos x 1000 gr', NULL, 0.00
    ),
    (
        688, 1, 0, '20032', 'Cazuela De Mariscos (Frutos del Mar)', '750 gr', 'Cazuela De Mariscos x 750 gr', NULL, 0.00
    ),
    (
        689, 1, 0, '20033', 'Cecina De Res', '500 gr', 'Cecina De Res x libra', NULL, 0.00
    ),
    (
        690, 1, 0, '20034', 'Cecina De Res Al Vacio', '500 gr', 'Cecina De Res Empacada Al Vacío x Libra', NULL, 0.00
    ),
    (
        691, 0, 0, '20035', 'Centro/Cogote al Vacio', '500 gr', 'Centro/Cogote al Vacío x Libra', NULL, 0.00
    ),
    (
        692, 1, 0, '20036', 'Chata Con Hueso', '500 gr', 'Chata Con Hueso x Libra', NULL, 0.00
    ),
    (
        693, 1, 0, '200367', 'Bolsa Basura Oriplast Negra 23 x 34', '10 Und', 'Bolsa Basura Oriplast Negra 23 x 34 - 10 und', NULL, 0.00
    ),
    (
        694, 1, 0, '20037', 'Chata De Res En Filete', '500 gr', 'Chata De Res En Filete x Libra', NULL, 0.00
    ),
    (
        695, 1, 0, '20038', 'Chata De Res Sin Hueso', '500 gr', 'Chata sin Hueso x libra', NULL, 0.00
    ),
    (
        696, 1, 0, '20039', 'Chatas De Res Al Vacio', '500 gr', 'Chatas De Res Al Vacio x Libra', NULL, 0.00
    ),
    (
        697, 1, 0, '20041', 'Chocozuelas De Res', '500 gr', 'Chocozuelas De Res x Libra', NULL, 0.00
    ),
    (
        698, 1, 0, '20042', 'Chorizo De Cerdo', 'Unidad', 'Chorizo De Cerdo x Unid', NULL, 0.00
    ),
    (
        699, 0, 0, '20043', 'Chorizo Jalapeño', 'Unidad', 'Chorizo Jalapeño x Unidad', NULL, 0.00
    ),
    (
        700, 1, 0, '20044', 'Chuleta Ahumada', '500 gr', 'Chuleta Ahumada x Libra', NULL, 0.00
    ),
    (
        701, 1, 0, '20045', 'Chuleta De Cerdo', '500 gr', 'Chuleta De Cerdo x 500 gr', NULL, 0.00
    ),
    (
        702, 1, 0, '20046', 'Cogote De Res', '500 gr', 'Carne De Cogote x Libra', NULL, 0.00
    ),
    (
        703, 1, 0, '20047', 'Cogote De Res Molido', '500 gr', 'Cogote De Res Molido x Libra', NULL, 0.00
    ),
    (
        704, 1, 0, '20048', 'Cola De Res Nudos', '500 gr', 'Cola Re Res Nudos x Libra', NULL, 0.00
    ),
    (
        705, 1, 0, '20049', 'Cola Solo Nudos Res', '500 gr', 'Cola Solo Nudos Res x 500 gr', NULL, 0.00
    ),
    (
        706, 1, 0, '20050', 'Colombinas De Pollo', '500gr', 'Colombinas De Pollo x Libra', NULL, 0.00
    ),
    (
        707, 1, 0, '20051', 'Contra Muslos De Pollo', '500 gr', 'Contra Muslos De Pollo x Libra', NULL, 0.00
    ),
    (
        708, 1, 0, '20052', 'Costilla De Cerdo Ahumada La Fazenda', '500 gr', 'Costilla De Cerdo Ahumada x 500 gr', NULL, 0.00
    ),
    (
        709, 1, 0, '20053', 'Costilla De Res', '500 gr', 'Carne Costilla De Res x Libra', NULL, 0.00
    ),
    (
        710, 1, 0, '20054', 'Costillas De Cerdo', '500 gr', 'Costillas De Cerdo x Libra', NULL, 0.00
    ),
    (
        711, 1, 0, '20055', 'Costillas De Cerdo La Fazenda', '500 gr', 'Costillas De Cerdo La Fazenda x Libra', NULL, 0.00
    ),
    (
        712, 1, 0, '20056', 'Espinazo De Cerdo', '500 gr', 'Espinazo De Cerdo x Libra', NULL, 0.00
    ),
    (
        713, 0, 0, '20057', 'Falda Costilla De Res Al Vacio', '500 gr', 'Falda Costilla Res Al Vacío x Libra', NULL, 0.00
    ),
    (
        714, 1, 0, '20058', 'Falda De Costilla', '500 gr', 'Falda De Costilla x Libra', NULL, 0.00
    ),
    (
        715, 1, 0, '20059', 'Filete Basa (Frutos del Mar)', '500 gr', 'Filete Basa x Libra', NULL, 0.00
    ),
    (
        716, 1, 0, '20060', 'Filete De Robalo (Frutos del Mar)', '400 gr', 'Filete De Robalo x 400gr', NULL, 0.00
    ),
    (
        717, 1, 0, '20061', 'Filete De Robalo Antillana (Frutos del Mar)', '450 gr', 'Filete De Robalo Antillana  x 450 gr', NULL, 0.00
    ),
    (
        718, 1, 0, '20062', 'Filete De Tilapia (Frutos del Mar)', '500 gr', 'Filete De Tilapia Libra x Libra', NULL, 0.00
    ),
    (
        719, 0, 0, '20063', 'Filete Entero De Salmon Super Salmon (Frutos del Mar)', '500 gr', 'Filete Entero De Salmon Super Salmo x 500 gr', NULL, 0.00
    ),
    (
        720, 1, 0, '20064', 'Filete Pechuga De Pollo Pimpollo', 'Bandeja', 'Filete De Pechuga Pimpollo x Bandeja', NULL, 0.00
    ),
    (
        721, 1, 0, '20065', 'Filete Pierna De Cerdo', '500 gr', 'Filete Pierna de Cerdo x Libra', NULL, 0.00
    ),
    (
        722, 1, 0, '20066', 'Gallina', 'Unidad', 'Gallina x Unidad', NULL, 0.00
    ),
    (
        723, 1, 0, '20067', 'Goulash De Cerdo', '500 gr', 'Goulash De Cerdo x Libra', NULL, 0.00
    ),
    (
        724, 1, 0, '20068', 'Higado De Res', '500  gr', 'Higado De Res x Libra', NULL, 0.00
    ),
    (
        725, 1, 0, '20069', 'Hueso Aguja  De Res', '500 gr', 'Hueso Aguja Res X Libra', NULL, 0.00
    ),
    (
        726, 1, 0, '20070', 'Hueso Carnudo  De Res', '500 gr', 'Hueso Carnudo Res x Libra', NULL, 0.00
    ),
    (
        727, 1, 0, '20071', 'Hueso Cogote  De Res', '500 gr', 'Hueso de cogote x Libra', NULL, 0.00
    ),
    (
        728, 1, 0, '20072', 'Lengua De Res', '500 gr', 'Lengua x Libra', NULL, 0.00
    ),
    (
        729, 1, 0, '20073', 'Lomito De Mojarra', 'Unidad', 'Lomito De Mojarra x Unidad', NULL, 0.00
    ),
    (
        730, 1, 0, '20074', 'Lomito Fino Cañon De Res', '500 gr', 'Lomito Fino Cañon De Res x Libra', NULL, 0.00
    ),
    (
        731, 1, 0, '20075', 'Lomo Ancho  De Res', '500 gr', 'Lomo Ancho Res x Libra', NULL, 0.00
    ),
    (
        732, 0, 0, '20076', 'Lomo Ancho De Res Al Vacío', '500 gr', 'Lomo Ancho De Res Al Vacío - 500 gr', NULL, 0.00
    ),
    (
        733, 1, 0, '20077', 'Lomo De Cerdo', '500 gr', 'Lomo De Cerdo x Libra', NULL, 0.00
    ),
    (
        734, 0, 0, '20078', 'Lomo fino de Res al vacío Deleta', 'Unidad', 'Lomo fino de Res al vacío Jumbo', NULL, 0.00
    ),
    (
        735, 1, 0, '20079', 'Mano De Res', '500 gr', 'Mano De Res x Libra', NULL, 0.00
    ),
    (
        736, 1, 0, '20080', 'Menudencia De Pollo En Bolsa', '500 gr', 'Menudencia En Bolsa x Libra', NULL, 0.00
    ),
    (
        737, 1, 0, '20081', 'Milanesa De Cerdo', '500 gr', 'Milanesa De Cerdo x Libra', NULL, 0.00
    ),
    (
        738, 1, 0, '20082', 'Milanesa De Res', '500 gr', 'Milanesa De Res X Libra', NULL, 0.00
    ),
    (
        739, 1, 0, '20083', 'Mojarra Grande (Frutos del Mar)', '500 gr', 'Mojarra Grande x Libra', NULL, 0.00
    ),
    (
        740, 1, 0, '20084', 'Mojarra Pequeña', '500 gr', 'Mojarra Pequeña x Libra', NULL, 0.00
    ),
    (
        741, 1, 0, '20085', 'Molida De Cerdo', '500 gr', 'Molida De Cerdo x Libra', NULL, 0.00
    ),
    (
        742, 1, 0, '20086', 'Mollejas De Res', '500 gr', 'Mollejas de Res x Libra', NULL, 0.00
    ),
    (
        743, 1, 0, '20087', 'Morro De Res', '500 gr', 'Morro De Res x Libra', NULL, 0.00
    ),
    (
        744, 1, 0, '20088', 'Murillo De Res', '500 gr', 'Carne de Murillo de Res x Libra', NULL, 0.00
    ),
    (
        745, 1, 0, '20089', 'Nervio De Res', '500 gr', 'Nervio De Res x Libra', NULL, 0.00
    ),
    (
        746, 1, 0, '20090', 'Osobuco De Res', '500 gr', 'Osobuco De Res x Libra', NULL, 0.00
    ),
    (
        747, 1, 0, '20091', 'Pajarilla De Res', '500 gr', 'Pajarilla De Res x Libra', NULL, 0.00
    ),
    (
        748, 1, 0, '20092', 'Paletero De Res', '500 gr', 'Paletero De Res x Libra', NULL, 0.00
    ),
    (
        749, 1, 0, '20093', 'Patas De Pollo', '500 gr', 'Patas De Pollo x Libra', NULL, 0.00
    ),
    (
        750, 1, 0, '20094', 'Pechuga De Pollo Arreglada', '1000 gr', 'Pechuga De Pollo Arreglada x 1000 gr', NULL, 0.00
    ),
    (
        751, 1, 0, '20095', 'Pechuga De Pollo Con Piel', '1000 gr', 'Pechuga De Pollo Con Piel x 1000 gr', NULL, 0.00
    ),
    (
        752, 1, 0, '20096', 'Pechuga De Pollo En Trozos', '500 gr', 'Pechuga De Pollo En Trozos x Libra', NULL, 0.00
    ),
    (
        753, 1, 0, '20097', 'Pechuga De Pollo  Fileteada', '1000 gr', 'Pechuga De Pollo  Fileteada x 1000 gr', NULL, 0.00
    ),
    (
        754, 1, 0, '20098', 'Peines Costilla Especial De Res', '500 gr', 'Peines Costilla Especial De Res x Libra', NULL, 0.00
    ),
    (
        755, 0, 0, '20099', 'Pernil Ahumado San Nicolas', '1 Kg', 'Pernil Ahumado San Nicolas - 1 Kg', NULL, 0.00
    ),
    (
        756, 1, 0, '201', 'Frijol Palomo Blanquillo A Granel', '1000 gr', 'Frijol Palomo Blanquillo A Granel - 1000 gr', NULL, 0.00
    ),
    (
        757, 1, 0, '20100', 'Pernil De Pollo Mixto', 'Unidad', 'Pernil De Pollo Mixto  X Unidad', NULL, 0.00
    ),
    (
        758, 1, 0, '20101', 'Pescado Basa Tajada (Frutos del Mar)', '500 gr', 'Basa Tajada x libra', NULL, 0.00
    ),
    (
        759, 1, 0, '20102', 'Pescueso De Pollo', '500 gr', 'Pescuezo De Pollo x Libra', NULL, 0.00
    ),
    (
        760, 1, 0, '20103', 'Pezuña De Cerdo', '500 gr', 'Pezuña De Cerdo x Libra', NULL, 0.00
    ),
    (
        761, 1, 0, '20104', 'Pierna De Cabro', '500 gr', 'Pierna De Cabro x Libra', NULL, 0.00
    ),
    (
        762, 1, 0, '20105', 'Pollo Entero', 'Unidad', 'Pollo Entrero x Unidad', NULL, 0.00
    ),
    (
        763, 1, 0, '20106', 'Pollo Semicriollo', '500gr', 'Pollo Semicriollo x Unidad', NULL, 0.00
    ),
    (
        764, 1, 0, '20107', 'Posta De Res', '500 gr', 'Posta De Res x Libra', NULL, 0.00
    ),
    (
        765, 1, 0, '20108', 'Posta Pierna De Res', '500 gr', 'Posta De Pierna x 500 gr', NULL, 0.00
    ),
    (
        766, 1, 0, '20109', 'Punta De Alas De Pollo', '500 gr', 'Punta De Alas x Libra', NULL, 0.00
    ),
    (
        767, 1, 0, '20110', 'Punta De Anca', '500 gr', 'Carne Punta De Anca x 500 gr', NULL, 0.00
    ),
    (
        768, 1, 0, '20111', 'Punta De Anca Premium', '500 gr', 'Punta De Anca Premium x Libra', NULL, 0.00
    ),
    (
        769, 1, 0, '20112', 'Rellena', 'Unidad', 'Rellena X Unidad', NULL, 0.00
    ),
    (
        770, 1, 0, '20113', 'Salmon (Frutos del Mar)', '500 gr', 'Salmon x 500 gr', NULL, 0.00
    ),
    (
        771, 1, 0, '20114', 'Sobrebarriga De Res Delgada', '500 gr', 'Sobrebarriga De Res Delgada x 500 gr', NULL, 0.00
    ),
    (
        772, 1, 0, '20115', 'Tapadera Res', '500 gr', 'Tapadera Res x 500 gr', NULL, 0.00
    ),
    (
        773, 1, 0, '20116', 'T-Bone Steak Premium', '500 gr', 'T-Bone Steak Premium x libra', NULL, 0.00
    ),
    (
        774, 1, 0, '20117', 'Tira De Asado Costilla De Res', '500 gr', 'Tira De Asado Costilla De Res x 500 gr', NULL, 0.00
    ),
    (
        775, 1, 0, '20118', 'Tocino Carnudo De Cerdo', '500 gr', 'Tocino Carnudo De Cerdo x 500 gr', NULL, 0.00
    ),
    (
        776, 1, 0, '20119', 'Toma Hawk Res', '500 gr', 'Toma Hawk Res x 500 gr', NULL, 0.00
    ),
    (
        777, 1, 0, '20120', 'Trucha (Frutos del Mar)', '500 gr', 'Trucha x 500 gr', NULL, 0.00
    ),
    (
        778, 1, 0, '20121', 'Visceras De Res', 'Bandeja', 'Visceras De Res x Bandeja', NULL, 0.00
    ),
    (
        779, 1, 0, '202', 'Frijol Cabeza Negra A Granel', '1000 gr', 'Frijol Cabeza Negra A Granel - 1000 gr', NULL, 0.00
    ),
    (
        780, 1, 0, '20222021', 'PRODUCTO PARA CATEGORIAS', 'SFASFASF', 'ASFASFAS', NULL, 0.00
    ),
    (
        781, 1, 0, '203', 'Arveja A Granel', '1000 gr', 'Arveja A Granel - 1000 gr', NULL, 0.00
    ),
    (
        782, 1, 0, '204', 'Lenteja A Granel', '1000 gr', 'Lenteja A Granel - 1000 gr', NULL, 0.00
    ),
    (
        783, 1, 0, '2040', 'Jabon En Barra Azul Desenveulto', '200 gr', 'Jabon En Barra Azul Desenveulto  - 200 gr', NULL, 0.00
    ),
    (
        784, 1, 0, '20521', 'Carne De Primera Al Vacío', '500 gr', 'Carne De Primera Al Vacío x Libra', NULL, 0.00
    ),
    (
        785, 1, 0, '20523', 'Carne De Res Especial En Trozos', '500 gr', 'Carne De Res Especial En Trozos', NULL, 0.00
    ),
    (
        786, 1, 0, '20524', 'Carne  De Res Molida Magra', '500 gr', 'Carne Molida Magra', NULL, 0.00
    ),
    (
        787, 1, 0, '20527', 'Carne Oreada', '500 gr', 'Carne Oreada x libra', NULL, 0.00
    ),
    (
        788, 1, 0, '20528', 'Carne Paletero De Res Al Vacio', 'Libra', 'Carne Paletero De Res Al Vacio x Libra', NULL, 0.00
    ),
    (
        789, 1, 0, '20536', 'Chicharron Carnudo De Cerdo', '500 gr', 'Chicharron Carnudo De Cerdo x 500 gr', NULL, 0.00
    ),
    (
        790, 1, 0, '20540', 'Chorizo Mixto', 'Unidad', 'Chorizo Mixto x Unidad', NULL, 0.00
    ),
    (
        791, 0, 0, '20560', 'Higado De Res Al Vacio', '500 gr', 'Higado De Res Al Vacio x Libra', NULL, 0.00
    ),
    (
        792, 0, 0, '20561', 'Higado y Corazones De Pollo', '500 gr', 'Higado y Corazones De Pollo x Libra', NULL, 0.00
    ),
    (
        793, 1, 0, '20564', 'Hueso Cogote Carnudo  De Res', '500 gr', 'Hueso de cogote Carnudo x Libra', NULL, 0.00
    ),
    (
        794, 0, 0, '20571', 'Lomo De Cerdo Al Vacio', '500 gr', 'Lomo De Cerdo Al Vacío x Libra', NULL, 0.00
    ),
    (
        795, 1, 0, '20572', 'Lomo Fino De Res Semi-Limpio', '500 gr', 'Lomo Fino De Res Semi-Limpio - 500 gr', NULL, 0.00
    ),
    (
        796, 0, 0, '20576', 'Milanesa De Res Al Vacío', '500 gr', 'Milanesa Al Vacío x Libra', NULL, 0.00
    ),
    (
        797, 0, 0, '20583', 'Murillo De Res Al Vacio', '500 gr', 'Murillo De Res Al Vacio x Libra', NULL, 0.00
    ),
    (
        798, 1, 0, '206', 'Maiz Amarillo a Granel', '1000 gr', 'Maiz Amarillo a Granel - 1000 gr', NULL, 0.00
    ),
    (
        799, 0, 0, '20600', 'Pierna De Cerdo Al Vacio', '500 gr', 'Pierna De Cerdo Al Vacío x Libra', NULL, 0.00
    ),
    (
        800, 0, 0, '20604', 'Posta De Res Al Vacio', '500 gr', 'Posta Al Vacío x Libra', NULL, 0.00
    ),
    (
        801, 1, 0, '20609', 'Red Cut Milanesa De Cerdo', '500 gr', 'Red Cut Milanesa De Cerdo X 500 gr', NULL, 0.00
    ),
    (
        802, 0, 0, '20613', 'Sobrebarriga De Res Gruesa', '500 gr', 'Sobrebarriga Gruesa x 500 gr', NULL, 0.00
    ),
    (
        803, 0, 0, '20614', 'Sobrebarriga De Res Gruesa Al Vacio', '500 gr', 'Sobrebarriga De Res Gruesa Al Vacio x 500 gr', NULL, 0.00
    ),
    (
        804, 0, 0, '20621', 'Trucha Al Vacío (Frutos del Mar)', '500 gr', 'Trucha Al Vacío x 500 gr', NULL, 0.00
    ),
    (
        805, 0, 0, '20625', 'Callo de Res al vacio', '500 gr', 'Callo de Res al vacio x 500 gr', NULL, 0.00
    ),
    (
        806, 0, 0, '20629', 'Filete Pechuga De Pollo Al Vacio', '500 gr', 'Filete Pechuga De Pollo Al Vacio x Libra', NULL, 0.00
    ),
    (
        807, 1, 0, '20630', 'Lomo De Cerdo Red Cut', '500 gr', 'Lomo De Cerdo Red Cut x 500 gr', NULL, 0.00
    ),
    (
        808, 1, 0, '20636', 'Carne Molida De Res Al Vacio', 'Libra', 'Carne Molida De Res Al Vacio x Libra', NULL, 0.00
    ),
    (
        809, 1, 0, '20637', 'Aleta De Res Al Vacio', 'Libra', 'Aleta De Res Al Vacio - Libra', NULL, 0.00
    ),
    (
        810, 1, 0, '207', 'Avena Entera A Granel', '500 gr', 'Avena Entera A Granel - 500 gr', NULL, 0.00
    ),
    (
        811, 1, 0, '20876', 'Carne Molida Adobada Rapi', '1000 gr', 'Carne Molida Adobada Rapi  - 1000 gr', NULL, 0.00
    ),
    (
        812, 1, 0, '209', 'Mezcla Lactea de Polvo A Granel', '1000 gr', 'Mezcla Lactea de Polvo A Granel - 1000 gr', NULL, 0.00
    ),
    (
        813, 1, 0, '21', 'Curuba', '500 gr', 'Curuba - 500 gr', NULL, 0.00
    ),
    (
        814, 1, 0, '210', 'Azucar A Granel', '1000 gr', 'Azucar A Granel - 1000 gr', NULL, 0.00
    ),
    (
        815, 1, 0, '2100', 'Zanahoria', '500 gr', 'Zanahoria  -  500 gr', NULL, 0.00
    ),
    (
        816, 1, 0, '213', 'Berengena Criolla', '1000 gr', 'Berengena Criolla - 1000 gr', NULL, 0.00
    ),
    (
        817, 1, 0, '215', 'Aji picante Tabasco', '1000 gr', 'Aji picante Tabasco - 1000 gr', NULL, 0.00
    ),
    (
        818, 1, 0, '216', 'Arroz a Granel', '1000 gr', 'Arroz a Granel - 1000 gr', NULL, 0.00
    ),
    (
        819, 1, 0, '2160', 'Pescado Mojarra Tilapia', '1000 gr', 'Pescado Mojarra Tilapia - 1000 gr', NULL, 0.00
    ),
    (
        820, 1, 0, '21668685', 'Syrup Hersheys Caramelo', '623 gr', 'Syrup Hershey`S Caramelo - 623 gr', NULL, 0.00
    ),
    (
        821, 1, 0, '220', 'Gordana Oferta Rapi', '100 gr', 'Gordana Oferta Rapi - 100 gr', NULL, 0.00
    ),
    (
        822, 1, 0, '221', 'Corozo', '1000 gr', 'Corozo - 1000 gr', NULL, 0.00
    ),
    (
        823, 1, 0, '222', 'Anon Chirimolla', '1000 gr', 'Anon Chirimolla - 1000 gr', NULL, 0.00
    ),
    (
        824, 1, 0, '23', 'Habichuela', '1000 gr', 'Habichuela - 1000 gr', NULL, 0.00
    ),
    (
        825, 0, 0, '23423', 'Borrar prueba', '500 gr', NULL, NULL, 0.00
    ),
    (
        826, 1, 0, '24', 'Mazorca Criolla', '1000 gr', 'Mazorca Criolla - 1000 gr', NULL, 0.00
    ),
    (
        827, 1, 0, '2435981520229', 'Granola La Hojuela Dorada', '500 gr', 'Granola La Hojuela Dorada x 500 gr', NULL, 0.00
    ),
    (
        828, 1, 0, '2435981520991', 'Granola La Hojuela Dorada', '250 gr', 'Granola La Hojuela Dorada x 250 gr', NULL, 0.00
    ),
    (
        829, 1, 0, '25', 'Apio', '1000 gr', 'Apio - 1000 gr', NULL, 0.00
    ),
    (
        830, 1, 0, '254771', 'Rambutan', '500 gr', 'Rambutan - 500 gr', NULL, 0.00
    ),
    (
        831, 1, 0, '26', 'Papa Natural Limpia', '1000 gr', 'Papa Natural Limpia - 1000 gr', NULL, 0.00
    ),
    (
        832, 1, 0, '261', 'Uva Verde Sin Semilla', '1000 gr', 'Uva Verde Sin Semilla - 1000 gr', NULL, 0.00
    ),
    (
        833, 1, 0, '27', 'Lechuga Batavia', '1000  gr', 'Lechuga Batavia - 1000 gr', NULL, 0.00
    ),
    (
        834, 1, 0, '270', 'Manzana Royal Importada', '1000 gr', 'Manzana Royal Importada - 1000 gr', NULL, 0.00
    ),
    (
        835, 1, 0, '27000380109', 'Tomates Enteros Pelados Hunts', '411 gr', 'Tomates Enteros Pelados Hunts - 411 gr', NULL, 0.00
    ),
    (
        836, 1, 0, '27000500064', 'Salsa Hunts Tradicional', '680 gr', 'Salsa Hunts Tradicional - 680 gr', NULL, 0.00
    ),
    (
        837, 1, 0, '27000500101', 'Salsa Pasta Hunt 4 Queso', '680 gr', 'Salsa Pasta Hunt 4 Queso - 680 gr', NULL, 0.00
    ),
    (
        838, 1, 0, '271', 'Kiwi', '1000 gr', 'Kiwi - 1000 gr', NULL, 0.00
    ),
    (
        839, 1, 0, '272', 'Higo', '500 gr', 'Higo - 500 gr', NULL, 0.00
    ),
    (
        840, 1, 0, '27702028000365', 'Margarina En Barra Sabrina', 'Caja x 24 - 50 gr', 'Margarina En Barra Sabrina x Caja x 24 Und / 50 gr', NULL, 0.00
    ),
    (
        841, 1, 0, '27702028021735', 'Margarina Gustosita', '24 Und x 50 gr', 'Margarina En Barra Gustosita - 24 Unidades x 50 gr', NULL, 0.00
    ),
    (
        842, 1, 0, '27885', 'Cafe Molido Granel Kilo', '1000 gr', 'Café Molido Granel - 1000 gr', NULL, 0.00
    ),
    (
        843, 1, 0, '28', 'Yuca', '1000 gr', 'Yuca - 1000 gr', NULL, 0.00
    ),
    (
        844, 1, 0, '28056', 'Papel Higienico Scott Trio', '4 unid', 'Papel Higienico Scott Trio x 4 unid', NULL, 0.00
    ),
    (
        845, 1, 0, '281', 'Frijol Caraota Granel', '1000 gr', 'Frijol Caraota Granel - 1000 gr', NULL, 0.00
    ),
    (
        846, 1, 0, '29', 'Coco', '1000 gr', 'Coco  - 1000 gr', NULL, 0.00
    ),
    (
        847, 1, 0, '29588310000040', 'Colita De Cuadril Res Ranchera', '1000 gr', 'Colita De Cuadril Res Ranchera  - 1000 gr', NULL, 0.00
    ),
    (
        848, 1, 0, '29588320000030', 'Bife De Lomo Ranchera', '1000 gr', 'Bife De Lomo Ranchera - 1000 gr', NULL, 0.00
    ),
    (
        849, 1, 0, '2958833000002', 'Costilla San Louis Ranchera Bbq', '1000 gr', 'Costilla San Louis Ranchera Bbq - 1000 gr', NULL, 0.00
    ),
    (
        850, 1, 0, '2965640000002', 'Bife De Chata Ranchera', '1000 gr', 'Bife De Chata Ranchera - 1000 gr', NULL, 0.00
    ),
    (
        851, 1, 0, '297100', 'Vaso 3 Onz', 'Und', 'Vaso 3 Onz - und', NULL, 0.00
    ),
    (
        852, 1, 0, '297161', 'Naranja Valencia', '25 Und', 'Naranja Valencia -  25 Und', NULL, 0.00
    ),
    (
        853, 1, 0, '3', 'Repollo Blanco', '500 gr', 'Repollo Blanco - 500 gr', NULL, 0.00
    ),
    (
        854, 1, 0, '30', 'Platano Verde', '1000 gr', 'Platano Verde - 1000 gr', NULL, 0.00
    ),
    (
        855, 1, 0, '30000', 'Ajonjoli Los Almendros', '250 gr', 'Ajonjoli x 250 gr', NULL, 0.00
    ),
    (
        856, 1, 0, '30000065525', 'Cereal Quaker Life Maple', '370 gr', 'Cereal Quaker Life Maple  - 370 gr', NULL, 0.00
    ),
    (
        857, 1, 0, '30001', 'Albaricoque Los Almendros', '125 gr', 'Albaricoque Los Almendros - 125 gr', NULL, 0.00
    ),
    (
        858, 1, 0, '30002', 'Almendras Los Almendros', '125 gr', 'Almendras x 125 gr', NULL, 0.00
    ),
    (
        859, 1, 0, '30003', 'Amaranto Los Almendros', '125 gr', 'Amaranto Los Almendros  - 125 gr', NULL, 0.00
    ),
    (
        860, 1, 0, '30004', 'Arandanos Deshidratados Los Almendros', '125 gr', 'Arandanos Deshidratados x 125 gr', NULL, 0.00
    ),
    (
        861, 1, 0, '30005', 'Chia', '250 gr', 'Chia x 250 gr', NULL, 0.00
    ),
    (
        862, 0, 0, '30006', 'Chia', '500 gr', 'Chia x 500 gr', NULL, 0.00
    ),
    (
        863, 1, 0, '30007', 'Ciruelas Pasas', '200 gr', 'Ciruelas Pasas x 200 gr', NULL, 0.00
    ),
    (
        864, 1, 0, '30009', 'Ciruelas Pasas Los Almendros', '125 gr', 'Ciruelas Pasas Los Almendros x 125 gr', NULL, 0.00
    ),
    (
        865, 1, 0, '30010', 'Coco Laminado Los Almendros', '250 gr', 'Coco Laminado Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        866, 0, 0, '30011', 'Damascos', '500 gr', 'Damascos x 500 gr', NULL, 0.00
    ),
    (
        867, 0, 0, '30012', 'Datiles', '500 gr', 'Datiles x 500 gr', NULL, 0.00
    ),
    (
        868, 1, 0, '30013', 'Datiles Los Almendros', '125 gr', 'Datiles Los Almendros x 125 gr', NULL, 0.00
    ),
    (
        869, 1, 0, '30014', 'Fruta Confitada', '500 gr', 'Fruta Confitada x 500 gr', NULL, 0.00
    ),
    (
        870, 1, 0, '30015', 'Grageas', '125 gr', 'Grageas x 125 gr', NULL, 0.00
    ),
    (
        871, 1, 0, '30016', 'Granola Ligth', '500 gr', 'Granola Ligth x 500 gr', NULL, 0.00
    ),
    (
        872, 1, 0, '30017', 'Granola Los Almendros', '500 gr', 'Granola Los Almendros   - 500 gr', NULL, 0.00
    ),
    (
        873, 1, 0, '30018', 'Granola Viva Mejor', '250 gr', 'Granola Viva Mejor x 250 gr', NULL, 0.00
    ),
    (
        874, 1, 0, '30019', 'Habas De Queso Los Almendros', '250 gr', 'Abad De Queso Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        875, 1, 0, '30020', 'Habas Tostadas Los Almendros', '250 gr', 'Abad Tostadas Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        876, 1, 0, '30021', 'Harina De Almendra', '125 gr', 'Harina De Almendra x 125  gr', NULL, 0.00
    ),
    (
        877, 0, 0, '30022', 'Harina De Almendra', '500 gr', 'Harina De Almendra x 500 gr', NULL, 0.00
    ),
    (
        878, 1, 0, '30023', 'Linaza Canadience  En Polvo', '250 gr', 'Linaza Canadience  En Polvo x 250 gr', NULL, 0.00
    ),
    (
        879, 0, 0, '30024', 'Linaza  Canadience  En Polvo', '500 gr', 'Linaza  Canadience  En Polvo x 500 gr', NULL, 0.00
    ),
    (
        880, 1, 0, '30025', 'Linaza  Canadience  Entera', '250 gr', 'Linaza  Canadience  Entera x 250 gr', NULL, 0.00
    ),
    (
        881, 0, 0, '30026', 'Linaza  Canadience  Entera', '500 gr', 'Linaza  Canadience  Entera x 500 gr', NULL, 0.00
    ),
    (
        882, 1, 0, '30027', 'Macadamia Los Almendros', '125 gr', 'Nuez De Macadamia x 125 gr', NULL, 0.00
    ),
    (
        883, 1, 0, '30028', 'Maiz De Queso Los Almendros', '250 gr', 'Maiz De Queso Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        884, 1, 0, '30029', 'Maiz Picante', '125 gr', 'Maiz Picante x 125 gr', NULL, 0.00
    ),
    (
        885, 0, 0, '30030', 'Maiz Picante', '500 gr', 'Maiz Picante x 500 gr', NULL, 0.00
    ),
    (
        886, 1, 0, '30031', 'Maiz Tostado Los Almendros', '125 gr', 'Maiz Tostado Los Almendros x 125 gr', NULL, 0.00
    ),
    (
        887, 1, 0, '30032', 'Mani De Soya Los Almendros', '250 gr', 'Mani De Soya Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        888, 1, 0, '30033', 'Mani Dulce Los Almendros', '500 gr', 'Mani Dulce Los Almendros  x 500 gr', NULL, 0.00
    ),
    (
        889, 1, 0, '30034', 'Mani Horneado Los Almendros', '125 gr', 'Mani Horneado x 125 gr', NULL, 0.00
    ),
    (
        890, 1, 0, '30035', 'Mani Japones Los Almendros', '250 gr', 'Mani Japones x 250gr', NULL, 0.00
    ),
    (
        891, 1, 0, '30036', 'Mani Salado Los Almendros', '125 gr', 'Mani Salado Los Almendros x 125 gr', NULL, 0.00
    ),
    (
        892, 1, 0, '30037', 'Mani Triturado Los Almendros', '250 gr', 'Mani Triturado Los Almendros - 250 gr', NULL, 0.00
    ),
    (
        893, 1, 0, '30038', 'Mani Uva Los Almendros', '250 gr', 'Mani Uva Los Almendros x 250gr', NULL, 0.00
    ),
    (
        894, 1, 0, '30039', 'Marañon importado', '125 gr', 'Marañon Importado x 125 gr', NULL, 0.00
    ),
    (
        895, 1, 0, '30040', 'Mix De Pasas, Nueces y Almendras', '100 gr', 'Mix De Pasas, Nueces y Almendras x 100 gr', NULL, 0.00
    ),
    (
        896, 1, 0, '30041', 'Mix Especial Frutos Secos Los Almendros', '125 gr', 'Mix Espefcial Frutos Secos Los Almendros x 125 gr', NULL, 0.00
    ),
    (
        897, 1, 0, '30042', 'Mix Fiesta Frutos Secos Los Almendros', '250 gr', 'Mix Fiesta Frutos Secos Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        898, 1, 0, '30043', 'Mix Frutos Secos Especial Sin Dulce Los Almendros', '125 gr', 'Mix Frutos Secos Especial Sin Dulce x 125 gr', NULL, 0.00
    ),
    (
        899, 1, 0, '30044', 'Mix Sencillo Frutos Secos Los Almendros', '125 gr', 'Mix Sencillo Frutos Secos Los Almendros x 125 gr', NULL, 0.00
    ),
    (
        900, 1, 0, '30045', 'Nueces Enteras', '125 gr', 'Nueces Enteras x 125 gr', NULL, 0.00
    ),
    (
        901, 1, 0, '30046', 'Nueces Enteras', '500 gr', 'Nueces Enteras x 500 gr', NULL, 0.00
    ),
    (
        902, 1, 0, '30047', 'Nuez de Nogal Los Almendros', '125 gr', 'Nuez de Nogal Los Almendros  - 125 gr', NULL, 0.00
    ),
    (
        903, 1, 0, '30048', 'Nuez Del Brasil Los Almendros', '125 gr', 'Nuez Del Brasil Los Almendros  - 125 gr', NULL, 0.00
    ),
    (
        904, 1, 0, '30049', 'Pistachos Los Almendros', '125 gr', 'Pistachos x 125 gr', NULL, 0.00
    ),
    (
        905, 1, 0, '30050', 'Quinua', '250 gr', 'Quinua x 250 gr', NULL, 0.00
    ),
    (
        906, 0, 0, '30051', 'Quinua', '500 gr', 'Quinua x 500 gr', NULL, 0.00
    ),
    (
        907, 1, 0, '30052', 'Salvado De Trigo', '500 gr', 'Salvado De Trigo -  500 gr', NULL, 0.00
    ),
    (
        908, 1, 0, '30053', 'Semillas De Calabaza Los Almendros', '125 gr', 'Semillas De Calabaza Los Almendros x 125gr', NULL, 0.00
    ),
    (
        909, 1, 0, '30054', 'Uvas Pasas El Chino', '200 gr', 'Uvas Pasas El Chino - 200 gr', NULL, 0.00
    ),
    (
        910, 1, 0, '30055', 'Uvas Pasas Loa Almendros', '500 gr', 'Uvas Pasas Loa Almendros  x 500 gr', NULL, 0.00
    ),
    (
        911, 1, 0, '30056', 'Uvas Pasas Los Almendros', '250 gr', 'Uvas Pasas Los Almendros x 250 gr', NULL, 0.00
    ),
    (
        912, 1, 0, '3008', 'Queso Salado', '125 gr', 'Queso Salado x 125 gr', NULL, 0.00
    ),
    (
        913, 1, 0, '3014260014445', 'Cepillo Oral B Complete 5 Acciones', 'Und', 'Cepillo Oral B complete 5 acciones  - Unidad', NULL, 0.00
    ),
    (
        914, 1, 0, '3014260019723', 'Cepillo Dental Oral B Kids Mickey', 'Und', 'Cepillo Dental Oral B Kids Mickey - Unid', NULL, 0.00
    ),
    (
        915, 1, 0, '30142602789390', 'Cepillo Dental Oral B Stages Etapa 1', 'Unidad', 'Cepillo Dental Oral B Stages Etapa 1 - Unidad', NULL, 0.00
    ),
    (
        916, 1, 0, '3014260328597', 'Prestobarba Gillette Excel Mujer', 'Und', 'Prestobarba Gillette Excel Mujer - Und', NULL, 0.00
    ),
    (
        917, 1, 0, '3014260802189', 'Cepillo Dental Complete Limpieza Profunda Oral-B', 'Und', 'Cepillo Dental Complete Limpieza Profunda Oral-B  - Unidad', NULL, 0.00
    ),
    (
        918, 1, 0, '30142608022190', 'Cepillo Oral B Complete 40 Suave', 'Unidad', 'Cepillo Oral B Complete 40 Suave  - Unidad', NULL, 0.00
    ),
    (
        919, 1, 0, '3014260833176', 'Cepillo Dental Oral B 1.2.3', 'Und', 'Cepillo Dental Oral B 1.2.3  - Unidad', NULL, 0.00
    ),
    (
        920, 1, 0, '30142608467250', 'Cepillo Dental Pro Compact Ondulado', 'Unidad', 'Cepillo Dental Pro Compact Ondulado  - Unidad', NULL, 0.00
    ),
    (
        921, 1, 0, '3014260846800', 'Cepillo Dental Oral B Complete', 'Pq x 3 Und', 'Cepillo Dental Oral B Complete  - Pq x 3 und', NULL, 0.00
    );

INSERT INTO
    `productos` (
        `id`, `estado`, `kit`, `barcode`, `nombre`, `presentacion`, `descripcion`, `foto`, `peso`
    )
VALUES (
        922, 1, 0, '3016', 'Extintor', 'Unidad', 'Extintor  x Unidad', NULL, 0.00
    ),
    (
        923, 1, 0, '3019', 'Riñonera Platica', 'Unidad', 'Riñonera Platica  x Unidad', NULL, 0.00
    ),
    (
        924, 1, 0, '305', 'Arveja Verde Desgranada', '1000 gr', 'Arveja Verde Desgranada - 1000 gr', NULL, 0.00
    ),
    (
        925, 1, 0, '30640', 'Arveja y Zanahoria', 'Bandeja', 'Arveja y Zanahoria -  Bandeja', NULL, 0.00
    ),
    (
        926, 1, 0, '306421', 'Naranja Valencia', '12 Und', 'Naranja Valencia -   12 Und', NULL, 0.00
    ),
    (
        927, 1, 0, '307', 'Mango Tommy', '1000 gr', 'Mango Tommy  - 1000 gr', NULL, 0.00
    ),
    (
        928, 1, 0, '31', 'Platano Amarillo', '1000 gr', 'Platano Amarillo - 1000 gr', NULL, 0.00
    ),
    (
        929, 1, 0, '310', 'Uva Roja Importada', '1000 gr', 'Uva Roja Importada - 1000 gr', NULL, 0.00
    ),
    (
        930, 1, 0, '319', 'Tocino Corriente', '500 gr', 'Tocino Corriente - 500 gr', NULL, 0.00
    ),
    (
        931, 1, 0, '319261', 'Naranja Valencia', '50 Und', 'Naranja Valencia - 50 Und', NULL, 0.00
    ),
    (
        932, 1, 0, '32', 'Zapote Costeño', '500 gr', 'Zapote Costeño - 500 gr', NULL, 0.00
    ),
    (
        933, 1, 0, '321316113030', 'Aceite De Canola Don Olio', '2000 ml', 'Aceite De Canola Don Olio - 2000 ml', NULL, 0.00
    ),
    (
        934, 1, 0, '32151', 'PRODUCTO PARA CATEGORIAS 512612', 'No Tiene', 'safas', NULL, 0.00
    ),
    (
        935, 1, 0, '32151979', 'PRODUCTO PARA CATEGORIAS 512612', 'ASFASFAS', 'safas', NULL, 0.00
    ),
    (
        936, 1, 0, '322', 'Carne Salada Corriente Rapi', '1000 gr', 'Carne Salada Corriente Rapi - 1000 gr', NULL, 0.00
    ),
    (
        937, 1, 0, '327', 'Frijol Verde Desgranado', '1000 gr', 'Frijol Verde Desgranado - 1000 gr', NULL, 0.00
    ),
    (
        938, 1, 0, '33', 'Manzana Roja Importada', '1000 gr', 'Manzana Roja Importada - 1000 gr', NULL, 0.00
    ),
    (
        939, 1, 0, '330', 'Melon Cantaloupe', '1000 gr', 'Melon Cantaloupe - 1000 gr', NULL, 0.00
    ),
    (
        940, 1, 0, '33844000059', 'Ajo En Polvo Badia', '85 gr', 'Ajo En Polvo Badia - 85 gr', NULL, 0.00
    ),
    (
        941, 1, 0, '33844000219', 'Oregano Entero Badia', '14 gr', 'Oregano Entero Badia - 14 gr', NULL, 0.00
    ),
    (
        942, 1, 0, '33844000240', 'Pimienta Negra Molida Badia', '14 gr', 'Pimienta Negra Molida Badia - 14 gr', NULL, 0.00
    ),
    (
        943, 1, 0, '33844000264', 'Pimienta Blanca Molida Badia', '35 gr', 'Pimienta Blanca Molida Badia - 35 gr', NULL, 0.00
    ),
    (
        944, 1, 0, '33844000301', 'Canela Polvo Badia', '14 gr', 'Canela Polvo Badia - 14 gr', NULL, 0.00
    ),
    (
        945, 1, 0, '33844000394', 'Pimienta Roja Crushed Badia', '14 gr', 'Pimienta Roja Crushed Badia - 14 gr', NULL, 0.00
    ),
    (
        946, 1, 0, '33844000615', 'Cilantro Badia', '7.1 gr', 'Cilantro Badia - 7.1 gr', NULL, 0.00
    ),
    (
        947, 1, 0, '33844000707', 'Ajo Polvo Badia', '28 gr', 'Ajo Polvo Badia - 28 gr', NULL, 0.00
    ),
    (
        948, 1, 0, '33844000745', 'Curry Polvo Badia', '28 gr', 'Curry Polvo Badia - 28 gr', NULL, 0.00
    ),
    (
        949, 1, 0, '33844000752', 'Jengibre Molido Badia', '21 gr', 'Jengibre Molido Badia - 21 gr', NULL, 0.00
    ),
    (
        950, 1, 0, '33844000769', 'Ajo y Perejil Badia', '42.5 gr', 'Ajo y Perejil Badia - 42.5 gr', NULL, 0.00
    ),
    (
        951, 1, 0, '33844000998', 'Sazon Completa Badia', '49 gr', 'Sazon Completa Badia - 49 gr', NULL, 0.00
    ),
    (
        952, 1, 0, '33844002107', 'Te Badia de Manzanilla', 'pq x 10 unid', 'Te Badia de Manzanilla - pq x 10 unid', NULL, 0.00
    ),
    (
        953, 1, 0, '33844002152', 'Albahaca Badia', '21 gr', 'Albahaca Badia - 21 gr', NULL, 0.00
    ),
    (
        954, 1, 0, '33844002619', 'Leche de Coco Badia', '400 gr', 'Leche de Coco Badia - 400 gr', NULL, 0.00
    ),
    (
        955, 1, 0, '34', 'Manzana Verde Importada', '1000 gr', 'Manzana Verde Importada - 1000 gr', NULL, 0.00
    ),
    (
        956, 1, 0, '34159', 'Pernil De Pollo', '1000 gr', 'Pernil De Pollo - 1000 gr', NULL, 0.00
    ),
    (
        957, 1, 0, '350', 'Chuguas', '1000 gr', 'Chuguas - 1000 gr', NULL, 0.00
    ),
    (
        958, 1, 0, '3500610000560', 'Vinos Espumoso Baron Rothber Seco', '750 ml', 'Vinos Espumoso Baron Rothber Seco - 750 ML', NULL, 0.00
    ),
    (
        959, 1, 0, '35006100059920', 'Vino Espumoso Baron De Rothberg Brut Botella', '750 ml', 'Vino Espumoso Baron De Rothberg Brut Botella - 750 ml', NULL, 0.00
    ),
    (
        960, 1, 0, '3500610093708', 'Champaña Rose JP Chenet', '750 ml', 'Champaña Rose JP Chenet  x 750 ml', NULL, 0.00
    ),
    (
        961, 1, 0, '3500610133534', 'Champaña Brut Frizzantino', '750 ml', 'Champaña Brut Frizzantino x 750 ml', NULL, 0.00
    ),
    (
        962, 1, 0, '350128471', 'Cebolla Blanca Sin Pelar', '1000 gr', 'Cebolla Blanca Sin Pelar - 1000 gr', NULL, 0.00
    ),
    (
        963, 1, 0, '35016607', 'Desinfectante Sanpic Manzana - Canela', '450 ml', 'Desinfectante Sanpic Manzana - Canela - 450 ml', NULL, 0.00
    ),
    (
        964, 1, 0, '350169581', 'Pescado Lebranche', '1000 gr', 'Pescado Lebranche - 1000 gr', NULL, 0.00
    ),
    (
        965, 1, 0, '350170481', 'Filete De Tilapia', '1000 gr', 'Filete De Tilapia - 1000 gr', NULL, 0.00
    ),
    (
        966, 1, 0, '35017638', 'Huevo Sannap Tipo A', '30 Und', 'Huevo Sannap Tipo A - 3 Und', NULL, 0.00
    ),
    (
        967, 1, 0, '350176991', 'Crema de Leche Parmalat', '200 ml', 'Crema de Leche Parmalat - 200 ml', NULL, 0.00
    ),
    (
        968, 1, 0, '350197431', 'Pechuga De Pollo Campesina Fresco', '1000 gr', 'Pechuga De Pollo Campesina Fresco - 1000 gr', NULL, 0.00
    ),
    (
        969, 1, 0, '350237281', 'Aguacate Santa Ana', '1000 gr', 'Aguacate Santa Ana - 1000 gr', NULL, 0.00
    ),
    (
        970, 1, 0, '35024759', 'Chatas Angus Porcionada', '1000 gr', 'Chatas Angus Porcionada  - 1000 gr', NULL, 0.00
    ),
    (
        971, 1, 0, '350247601', 'Papada Cerdo', '1000 gr', 'Papada Cerdo - 1000 gr', NULL, 0.00
    ),
    (
        972, 1, 0, '350320581', 'T-Bone Stick Nacional', '1000 gr', 'T-Bone Stick Nacional - 1000 gr', NULL, 0.00
    ),
    (
        973, 1, 0, '35036478', 'Cerveza Miller Lite Lata', '330 ml', 'Cerveza Miller Lite Lata - 330 ml', NULL, 0.00
    ),
    (
        974, 1, 0, '350368381', 'Muslo Campesino Fresco', '1000 gr', 'Muslo Campesino Fresco - 1000 gr', NULL, 0.00
    ),
    (
        975, 1, 0, '350454251', 'Batata Morro', '1000 gr', 'Batata Morro - 1000 gr', NULL, 0.00
    ),
    (
        976, 1, 0, '350454261', 'Bola De Pierna', '500 gr', 'Bola De Pierna - 500 gr', NULL, 0.00
    ),
    (
        977, 1, 0, '350454271', 'Capon Camaguey Rapi', '1000 gr', 'Capon Camaguey Rapi  - 1000 gr', NULL, 0.00
    ),
    (
        978, 1, 0, '35045428', 'Carne Adobada Camaguey Rapi', '1000 gr', 'Carne Adobada Camaguey Rapi - 1000 gr', NULL, 0.00
    ),
    (
        979, 1, 0, '350454301', 'Carne Molida Especial Camaguey', '1000 gr', 'Carne Molida Especial Camaguey - 1000 gr', NULL, 0.00
    ),
    (
        980, 1, 0, '35045433', 'Mico', '1000 gr', 'Mico - 1000 gr', NULL, 0.00
    ),
    (
        981, 1, 0, '350454341', 'Lomo Ancho Rapi', '500 gr', 'Lomo Ancho Rapi - 500 gr', NULL, 0.00
    ),
    (
        982, 1, 0, '350454351', 'Lomo Fino Entero', '1000 gr', 'Lomo Fino Entero - 1000 gr', NULL, 0.00
    ),
    (
        983, 1, 0, '35045440', 'Carne Molida Corriente Camaguey Rapi', '1000 gr', 'Carne Molida Corriente Camaguey Rapi  - 1000 gr', NULL, 0.00
    ),
    (
        984, 1, 0, '35045441', 'Carne Salada Corriente Camaguey Rapi', '1000 gr', 'Carne Salada Corriente Camaguey Rapi - 1000 gr', NULL, 0.00
    ),
    (
        985, 1, 0, '350454421', 'Carne Salada Especial Camaguey Rapi', '1000 gr', 'Carne Salada Especial Camaguey Rapi - 1000 gr', NULL, 0.00
    ),
    (
        986, 1, 0, '35045443', 'Pecho Espaldilla', '1000 gr', 'Pecho Espaldilla - 1000 gr', NULL, 0.00
    ),
    (
        987, 1, 0, '35045447', 'Chocozuela Camaguey Rapi', '1000 gr', 'Chocozuela Camaguey Rapi - 1000 gr', NULL, 0.00
    ),
    (
        988, 1, 0, '35045448', 'Costiasar Camaguey Rapi', '1000 gr', 'Costiasar Camaguey Rapi - 1000 gr', NULL, 0.00
    ),
    (
        989, 1, 0, '350455351', 'Posta De Bagre Congelado', '500 gr', 'Posta De Bagre Congelado - 500 gr', NULL, 0.00
    ),
    (
        990, 1, 0, '350456491', 'Pescado Mojarra Roja', 'Unidad', 'Pescado Mojarra Roja - Unidad', NULL, 0.00
    ),
    (
        991, 1, 0, '3560', 'Pila Varta Alkalina AAA', 'Pq x 2 unid', 'Pila Varta Alkalina AAA - Pila Varta Alkalina AAA', NULL, 0.00
    ),
    (
        992, 1, 0, '3574661049076', 'Tampon Ob Aplicador Plast.Super', 'Pq x 8 Und', 'Tampon Ob Aplicador Plast.Super  - Pq x 8 Und', NULL, 0.00
    ),
    (
        993, 1, 0, '36', 'Guineo Verde', '1000 gr', 'Guineo Verde - 1000 gr', NULL, 0.00
    ),
    (
        994, 1, 0, '360', 'Pera Asiatica', '1000 gr', 'Pera Asiatica -1000 gr', NULL, 0.00
    ),
    (
        995, 1, 0, '3600900010696', 'Cereal Quinoa Tipiak Gourmand', '400 gr', 'Cereal Quinoa Tipiak Gourmand  - 400 gr', NULL, 0.00
    ),
    (
        996, 1, 0, '3600900020978', 'Cereal Tipiak Cuscus Original', '500 gr', 'Cereal Tipiak Cuscus Original  - 500 gr', NULL, 0.00
    ),
    (
        997, 1, 0, '362', 'Guineo Manzano', '1000 gr', 'Guineo Manzano - 1000 gr', NULL, 0.00
    ),
    (
        998, 1, 0, '36600813719', 'Protector Labial Chapstick Cereza', 'unid', 'Protector Labial Chapstick Cereza  - unid', NULL, 0.00
    ),
    (
        999, 1, 0, '366008140130', 'Protector labial Chapstick de Fresa', 'unid', 'Protector labial Chapstick de Fresa  - unid', NULL, 0.00
    ),
    (
        1000, 1, 0, '37', 'Guineo Maduro', '1000 gr', 'Guineo Maduro - 1000 gr', NULL, 0.00
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

CREATE TABLE `promociones` (
    `id` mediumint UNSIGNED NOT NULL, `estado` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0=Inactivo 1=Activo', `nombre` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `imagen` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Max 900', `porcentaje` tinyint UNSIGNED DEFAULT NULL, `dias_semana` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[0,0,0,0,0,0,0]' COMMENT '0=No 1=Si... Lunes=Día_1 Domingo=Día_7... Aplica para Full_categoría'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son las Promociones con sus datos básicos de configuración';

--
-- Volcado de datos para la tabla `promociones`
--

INSERT INTO
    `promociones` (
        `id`, `estado`, `nombre`, `imagen`, `porcentaje`, `dias_semana`
    )
VALUES (
        1, 1, 'La Huerta de los descuentos', NULL, 25, '[0,0,0,0,0,0,0]'
    ),
    (
        2, 1, 'Imperdibles', NULL, 35, '[0,0,0,0,0,0,0]'
    ),
    (
        3, 0, 'Carnes Empacadas Al Vacío', NULL, 29, '[0,0,0,0,0,0,0]'
    ),
    (
        4, 1, 'Promocion Dia de la Amistad', NULL, 24, '[0,0,0,0,0,0,0]'
    ),
    (
        5, 1, 'Huevo Santo se va!!', NULL, 10, '[0,0,0,0,0,0,0]'
    ),
    (
        6, 1, 'Nutri L Promo!!', NULL, 20, '[0,0,0,0,0,0,0]'
    ),
    (
        7, 1, '¡Super Oferta!', NULL, 25, '[0,0,0,0,0,0,0]'
    ),
    (
        8, 1, 'Promoción Patria', NULL, 50, '[0,0,0,0,0,0,0]'
    ),
    (
        9, 1, 'Aseo Hogar Multinsa', NULL, 5, '[0,0,0,0,0,0,0]'
    ),
    (
        10, 1, 'Amor & Amistad', NULL, 50, '[0,0,0,0,0,0,0]'
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendas`
--

CREATE TABLE `tiendas` (
    `id` smallint UNSIGNED NOT NULL, `estado` tinyint UNSIGNED NOT NULL COMMENT '0=Inactivo 1=Activo', `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `descripcion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `direccion` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `direccion_anexo` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `direccion_barrio` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `calificacion` decimal(3, 2) NOT NULL DEFAULT '0.00', `calificacion_cantidad` mediumint UNSIGNED NOT NULL DEFAULT '0', `impuestos` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0=No 1=Si +Impto 2=Si Impto incluido 3=Si Impto incluido sin etiqueta.. Los pedidos se liquidan con Impuestos, aplica para Pedidos y Admin_Pedidos', `dias_trabajados` varchar(21) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[1,1,1,1,1,1,0]' COMMENT 'Arreglo de los días en trabaja el Cedis.. 0=No trabaja 1=Si trabaja... Lunes=Día_1 Domingo=Día_7'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Es un Centro de Distribución principal, para distribuir a las Tiendas';

--
-- Volcado de datos para la tabla `tiendas`
--

INSERT INTO
    `tiendas` (
        `id`, `estado`, `nombre`, `descripcion`, `telefono`, `direccion`, `direccion_anexo`, `direccion_barrio`, `calificacion`, `calificacion_cantidad`, `impuestos`, `dias_trabajados`
    )
VALUES (
        1, 1, 'Mas x menos', 'Sede Provicia de Soto 2', '3104234325', 'Cl 73 41 W-250 Bodega 27 - Provincia de Soto II', NULL, NULL, 0.00, 0, 0, '[1,1,1,1,1,1,0]'
    ),
    (
        2, 1, 'D1', 'Pendiente definir los datos del cedis Aguachica', '3104234325', 'Por ajustar definir', NULL, NULL, 0.00, 0, 0, '[1,1,1,1,1,1,0]'
    ),
    (
        3, 1, 'Mercantil', 'pendiente una descripción.', '5562105984', 'Antiguo Camino a Los Reyes 11 Amp Ricardo Flores Magón Iztapalapa 09828 Ciudad de México, CDMX', NULL, NULL, 0.00, 0, 0, '[1,1,1,1,1,1,0]'
    ),
    (
        4, 0, 'Justo y bueno', 'Barrancabermeja', '3104234325', 'Barrio Colombia, calle 51 # 16-67', NULL, NULL, 0.00, 0, 0, '[1,1,1,1,1,1,0]'
    ),
    (
        5, 1, 'Exito', 'Pedidos de Horeca', '3104234325', 'barrio', NULL, NULL, 0.00, 0, 0, '[1,1,1,1,1,1,0]'
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendas_distancias`
--

CREATE TABLE `tiendas_distancias` (
    `id` mediumint UNSIGNED NOT NULL, `id_tienda` smallint UNSIGNED NOT NULL, `valor` smallint UNSIGNED NOT NULL, `desde` smallint UNSIGNED DEFAULT NULL, `hasta` smallint UNSIGNED DEFAULT NULL COMMENT 'Null= +nn mt. Se usa para dar valor cuando la distancia sobre pasa la distancia mayor'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los valores de Domicilio o Envío de una Tienda, respecto a la distancia con el Cliente';

--
-- Volcado de datos para la tabla `tiendas_distancias`
--

INSERT INTO
    `tiendas_distancias` (
        `id`, `id_tienda`, `valor`, `desde`, `hasta`
    )
VALUES (10, 1, 2000, 0, 100),
    (159, 1, 2500, 101, 200),
    (160, 1, 3500, 201, 400),
    (161, 1, 5000, 401, NULL),
    (162, 2, 2000, 0, 100),
    (163, 2, 2500, 101, 200),
    (164, 2, 3500, 201, 400),
    (165, 2, 5000, 401, NULL),
    (166, 3, 2000, 0, 100),
    (167, 3, 2500, 101, 200),
    (168, 3, 3500, 201, 400),
    (169, 3, 5000, 401, NULL),
    (170, 4, 2000, 0, 100),
    (171, 4, 2500, 101, 200),
    (172, 4, 3500, 201, 400),
    (173, 4, 5000, 401, NULL),
    (174, 5, 2000, 0, 100),
    (175, 5, 2500, 101, 200),
    (176, 5, 3500, 201, 400),
    (177, 5, 5000, 401, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendas_productos`
--

CREATE TABLE `tiendas_productos` (
    `id` int UNSIGNED NOT NULL, `compra_maxima` decimal(3, 1) NOT NULL DEFAULT '1.0', `valor` decimal(11, 3) NOT NULL COMMENT 'Valor de venta más actual', `id_promocion` mediumint UNSIGNED DEFAULT NULL, `id_tienda` smallint UNSIGNED NOT NULL, `id_producto` int UNSIGNED NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los Productos que están disponibles para un Cedis';

--
-- Volcado de datos para la tabla `tiendas_productos`
--

INSERT INTO
    `tiendas_productos` (
        `id`, `compra_maxima`, `valor`, `id_promocion`, `id_tienda`, `id_producto`
    )
VALUES (
        76904, 3.0, 6209.000, 2, 5, 215
    ),
    (
        76920, 2.0, 27020.000, 9, 2, 256
    ),
    (
        76929, 4.0, 10794.000, 1, 2, 374
    ),
    (
        76931, 2.0, 3592.000, 9, 2, 11
    ),
    (
        76932, 4.0, 5959.000, 10, 2, 338
    ),
    (
        76943, 5.0, 1542.000, 4, 3, 864
    ),
    (
        76972, 2.0, 1455.000, 7, 2, 899
    ),
    (
        76987, 2.0, 29817.000, 3, 4, 801
    ),
    (
        76998, 1.0, 2444.000, 3, 5, 50
    ),
    (
        77000, 1.0, 3728.000, 3, 3, 390
    ),
    (
        77011, 5.0, 21151.000, 5, 2, 706
    ),
    (
        77028, 2.0, 157.000, 3, 5, 205
    ),
    (
        77041, 5.0, 28385.000, 6, 1, 649
    ),
    (
        77061, 2.0, 26375.000, 9, 5, 287
    ),
    (
        77067, 3.0, 9493.000, 6, 5, 23
    ),
    (
        77071, 3.0, 22715.000, 8, 1, 636
    ),
    (
        77083, 3.0, 307.000, 3, 5, 247
    ),
    (
        77088, 3.0, 29046.000, 2, 1, 819
    ),
    (
        77089, 5.0, 16594.000, 5, 5, 80
    ),
    (
        77090, 4.0, 8427.000, 2, 5, 542
    ),
    (
        77091, 4.0, 32506.000, 7, 2, 558
    ),
    (
        77093, 1.0, 21307.000, 8, 5, 579
    ),
    (
        77107, 3.0, 33496.000, 8, 5, 273
    ),
    (
        77110, 2.0, 13738.000, 5, 1, 725
    ),
    (
        77136, 4.0, 13077.000, 7, 1, 596
    ),
    (
        77141, 4.0, 19507.000, 4, 1, 392
    ),
    (
        77145, 5.0, 4334.000, 7, 1, 504
    ),
    (
        77149, 1.0, 21043.000, 8, 5, 223
    ),
    (
        77152, 3.0, 26592.000, 2, 1, 279
    ),
    (
        77183, 1.0, 20132.000, 8, 5, 419
    ),
    (
        77184, 2.0, 9481.000, 5, 3, 245
    ),
    (
        77185, 3.0, 12743.000, 1, 5, 584
    ),
    (
        77191, 1.0, 15535.000, 1, 5, 322
    ),
    (
        77203, 4.0, 28941.000, 1, 4, 37
    ),
    (
        77222, 2.0, 3580.000, 8, 3, 470
    ),
    (
        77238, 5.0, 21266.000, 2, 4, 623
    ),
    (
        77243, 1.0, 14336.000, 2, 1, 984
    ),
    (
        77247, 2.0, 23107.000, 5, 1, 973
    ),
    (
        77256, 2.0, 33311.000, 8, 5, 417
    ),
    (
        77257, 2.0, 31215.000, 9, 4, 794
    ),
    (
        77278, 2.0, 12738.000, 9, 2, 650
    ),
    (
        77287, 5.0, 24637.000, 10, 3, 975
    ),
    (
        77297, 5.0, 7854.000, 4, 1, 302
    ),
    (
        77320, 2.0, 32352.000, 3, 1, 579
    ),
    (
        77321, 4.0, 14489.000, 7, 5, 527
    ),
    (
        77338, 1.0, 17887.000, 6, 1, 574
    ),
    (
        77341, 5.0, 2727.000, 7, 5, 30
    ),
    (
        77356, 5.0, 5066.000, 9, 5, 229
    ),
    (
        77369, 1.0, 13464.000, 8, 5, 989
    ),
    (
        77370, 2.0, 15576.000, 5, 4, 703
    ),
    (
        77377, 1.0, 20448.000, 8, 1, 246
    ),
    (
        77378, 4.0, 20260.000, 4, 1, 430
    ),
    (
        77399, 3.0, 12665.000, 4, 4, 626
    ),
    (
        77401, 4.0, 8659.000, 7, 4, 558
    ),
    (
        77407, 2.0, 8361.000, 3, 2, 397
    ),
    (
        77418, 1.0, 7412.000, 1, 3, 196
    ),
    (
        77438, 5.0, 18130.000, 10, 2, 358
    ),
    (
        77447, 4.0, 15641.000, 9, 5, 253
    ),
    (
        77459, 5.0, 4189.000, 9, 1, 912
    ),
    (
        77463, 4.0, 18443.000, 6, 1, 741
    ),
    (
        77466, 3.0, 33183.000, 1, 1, 590
    ),
    (
        77472, 3.0, 33490.000, 6, 1, 362
    ),
    (
        77478, 5.0, 32653.000, 10, 5, 955
    ),
    (
        77487, 5.0, 13679.000, 3, 1, 732
    ),
    (
        77497, 2.0, 22408.000, 8, 4, 810
    ),
    (
        77506, 3.0, 16072.000, 6, 3, 481
    ),
    (
        77520, 4.0, 24471.000, 3, 1, 817
    ),
    (
        77529, 3.0, 8963.000, 2, 5, 189
    ),
    (
        77530, 2.0, 10002.000, 10, 5, 600
    ),
    (
        77535, 4.0, 15194.000, 9, 2, 653
    ),
    (
        77539, 4.0, 32448.000, 4, 3, 905
    ),
    (
        77544, 2.0, 33736.000, 3, 2, 446
    ),
    (
        77573, 4.0, 15181.000, 7, 2, 959
    ),
    (
        77576, 2.0, 7585.000, 6, 3, 54
    ),
    (
        77582, 4.0, 17685.000, 3, 2, 945
    ),
    (
        77590, 1.0, 29373.000, 2, 5, 619
    ),
    (
        77601, 4.0, 16034.000, 5, 5, 89
    ),
    (
        77612, 3.0, 11190.000, 9, 3, 854
    ),
    (
        77617, 3.0, 18475.000, 6, 5, 196
    ),
    (
        77628, 5.0, 14341.000, 5, 1, 119
    ),
    (
        77629, 2.0, 33280.000, 2, 3, 372
    ),
    (
        77657, 5.0, 2734.000, 7, 2, 742
    ),
    (
        77669, 5.0, 764.000, 3, 5, 928
    ),
    (
        77692, 4.0, 24116.000, 3, 5, 35
    ),
    (
        77702, 2.0, 11491.000, 3, 1, 933
    ),
    (
        77715, 2.0, 2315.000, 3, 5, 952
    ),
    (
        77725, 4.0, 12793.000, 3, 2, 142
    ),
    (
        77732, 2.0, 22163.000, 9, 2, 215
    ),
    (
        77733, 5.0, 9994.000, 6, 4, 775
    ),
    (
        77752, 3.0, 8958.000, 2, 1, 573
    ),
    (
        77759, 2.0, 11626.000, 3, 2, 709
    ),
    (
        77772, 2.0, 23243.000, 8, 5, 565
    ),
    (
        77774, 4.0, 17233.000, 6, 1, 906
    ),
    (
        77777, 3.0, 31730.000, 8, 2, 134
    ),
    (
        77778, 4.0, 3879.000, 5, 5, 455
    ),
    (
        77779, 2.0, 16316.000, 4, 1, 248
    ),
    (
        77787, 2.0, 27510.000, 3, 3, 420
    ),
    (
        77793, 3.0, 18958.000, 4, 5, 605
    ),
    (
        77798, 3.0, 7773.000, 3, 4, 481
    ),
    (
        77801, 5.0, 15467.000, 5, 5, 497
    ),
    (
        77810, 3.0, 5495.000, 5, 5, 166
    ),
    (
        77840, 2.0, 10775.000, 2, 2, 540
    ),
    (
        77841, 4.0, 24655.000, 7, 5, 742
    ),
    (
        77842, 5.0, 17863.000, 8, 2, 193
    ),
    (
        77844, 4.0, 24579.000, 2, 2, 101
    ),
    (
        77859, 4.0, 30766.000, 2, 1, 857
    ),
    (
        77861, 3.0, 11487.000, 3, 2, 832
    ),
    (
        77864, 3.0, 24858.000, 5, 2, 547
    ),
    (
        77893, 5.0, 12194.000, 10, 4, 191
    ),
    (
        77921, 3.0, 31798.000, 4, 4, 905
    ),
    (
        77922, 2.0, 12125.000, 2, 4, 735
    ),
    (
        77923, 4.0, 23555.000, 2, 3, 385
    ),
    (
        77926, 2.0, 9986.000, 5, 3, 698
    ),
    (
        77928, 2.0, 31370.000, 8, 1, 904
    ),
    (
        77945, 1.0, 18310.000, 6, 5, 2
    ),
    (
        77949, 3.0, 29667.000, 1, 3, 205
    ),
    (
        77961, 4.0, 29108.000, 10, 3, 150
    ),
    (
        77972, 1.0, 23723.000, 4, 4, 45
    ),
    (
        77981, 4.0, 3509.000, 1, 5, 333
    ),
    (
        77986, 1.0, 27632.000, 8, 3, 541
    ),
    (
        77989, 4.0, 9433.000, 4, 1, 245
    ),
    (
        77998, 5.0, 6541.000, 3, 3, 70
    ),
    (
        78004, 4.0, 19571.000, 7, 3, 778
    ),
    (
        78007, 4.0, 23957.000, 1, 5, 676
    ),
    (
        78009, 5.0, 25291.000, 9, 1, 593
    ),
    (
        78014, 2.0, 29920.000, 9, 5, 117
    ),
    (
        78028, 4.0, 16583.000, 4, 2, 512
    ),
    (
        78033, 1.0, 18023.000, 7, 4, 245
    ),
    (
        78035, 2.0, 14200.000, 5, 1, 867
    ),
    (
        78037, 4.0, 23131.000, 1, 5, 797
    ),
    (
        78042, 4.0, 10191.000, 3, 1, 828
    ),
    (
        78049, 5.0, 3617.000, 8, 4, 265
    ),
    (
        78051, 3.0, 15391.000, 10, 3, 341
    ),
    (
        78057, 4.0, 33754.000, 6, 4, 438
    ),
    (
        78058, 4.0, 9323.000, 3, 2, 693
    ),
    (
        78062, 5.0, 2967.000, 7, 1, 522
    ),
    (
        78070, 3.0, 1766.000, 5, 1, 212
    ),
    (
        78075, 5.0, 18785.000, 1, 3, 572
    ),
    (
        78095, 4.0, 14299.000, 2, 3, 116
    ),
    (
        78097, 2.0, 33945.000, 5, 1, 329
    ),
    (
        78105, 2.0, 13960.000, 1, 1, 985
    ),
    (
        78110, 1.0, 7066.000, 7, 4, 791
    ),
    (
        78122, 4.0, 14018.000, 7, 2, 278
    ),
    (
        78132, 4.0, 29337.000, 2, 1, 25
    ),
    (
        78138, 2.0, 22776.000, 5, 1, 109
    ),
    (
        78139, 2.0, 10522.000, 6, 5, 830
    ),
    (
        78144, 2.0, 6191.000, 4, 2, 703
    ),
    (
        78148, 2.0, 3536.000, 2, 1, 276
    ),
    (
        78157, 3.0, 28532.000, 9, 1, 349
    ),
    (
        78159, 3.0, 8152.000, 6, 5, 180
    ),
    (
        78163, 4.0, 12413.000, 8, 5, 446
    ),
    (
        78165, 2.0, 22809.000, 10, 4, 353
    ),
    (
        78166, 2.0, 31559.000, 1, 3, 186
    ),
    (
        78169, 1.0, 20708.000, 10, 1, 509
    ),
    (
        78172, 3.0, 26987.000, 7, 1, 284
    ),
    (
        78187, 2.0, 29386.000, 9, 5, 820
    ),
    (
        78193, 3.0, 11033.000, 10, 5, 806
    ),
    (
        78196, 2.0, 8636.000, 5, 4, 809
    ),
    (
        78203, 1.0, 29573.000, 2, 1, 854
    ),
    (
        78206, 1.0, 27064.000, 9, 5, 968
    ),
    (
        78211, 4.0, 28447.000, 2, 5, 569
    ),
    (
        78212, 5.0, 31548.000, 9, 3, 1
    ),
    (
        78213, 3.0, 9004.000, 10, 1, 252
    ),
    (
        78258, 4.0, 29752.000, 2, 1, 894
    ),
    (
        78306, 3.0, 15146.000, 9, 2, 916
    ),
    (
        78319, 2.0, 2790.000, 9, 1, 771
    ),
    (
        78340, 3.0, 23572.000, 1, 5, 694
    ),
    (
        78346, 5.0, 28332.000, 5, 3, 59
    ),
    (
        78348, 5.0, 3900.000, 9, 1, 570
    ),
    (
        78352, 3.0, 23087.000, 2, 4, 344
    ),
    (
        78357, 2.0, 1980.000, 7, 5, 799
    ),
    (
        78370, 1.0, 24969.000, 4, 4, 538
    ),
    (
        78373, 5.0, 1776.000, 6, 4, 828
    ),
    (
        78374, 1.0, 19054.000, 8, 2, 678
    ),
    (
        78377, 2.0, 28561.000, 6, 2, 407
    ),
    (
        78379, 3.0, 29947.000, 9, 3, 297
    ),
    (
        78391, 3.0, 16637.000, 9, 5, 164
    ),
    (
        78400, 2.0, 2792.000, 8, 3, 233
    ),
    (
        78407, 2.0, 2901.000, 5, 1, 192
    ),
    (
        78409, 4.0, 19102.000, 4, 2, 867
    ),
    (
        78411, 3.0, 9254.000, 3, 2, 163
    ),
    (
        78412, 2.0, 11716.000, 7, 1, 565
    ),
    (
        78415, 3.0, 892.000, 4, 4, 309
    ),
    (
        78419, 1.0, 3798.000, 3, 4, 680
    ),
    (
        78422, 2.0, 11006.000, 8, 1, 726
    ),
    (
        78427, 4.0, 5269.000, 6, 2, 533
    ),
    (
        78428, 5.0, 8982.000, 5, 2, 927
    ),
    (
        78433, 3.0, 24028.000, 9, 2, 148
    ),
    (
        78435, 4.0, 28000.000, 6, 3, 450
    ),
    (
        78439, 4.0, 22873.000, 3, 5, 1000
    ),
    (
        78443, 3.0, 10209.000, 9, 3, 325
    ),
    (
        78458, 1.0, 20905.000, 7, 4, 565
    ),
    (
        78459, 3.0, 9208.000, 6, 1, 591
    ),
    (
        78467, 4.0, 4565.000, 5, 4, 365
    ),
    (
        78473, 5.0, 21885.000, 5, 3, 555
    ),
    (
        78477, 3.0, 31609.000, 3, 3, 878
    ),
    (
        78481, 2.0, 13885.000, 5, 1, 777
    ),
    (
        78483, 2.0, 32321.000, 2, 4, 930
    ),
    (
        78489, 2.0, 836.000, 6, 3, 370
    ),
    (
        78502, 4.0, 32619.000, 5, 2, 560
    ),
    (
        78542, 2.0, 28397.000, 2, 1, 195
    ),
    (
        78543, 4.0, 19413.000, 10, 1, 625
    ),
    (
        78547, 2.0, 15749.000, 9, 5, 203
    ),
    (
        78577, 1.0, 12678.000, 7, 5, 32
    ),
    (
        78578, 2.0, 537.000, 5, 1, 862
    ),
    (
        78586, 1.0, 24218.000, 5, 5, 639
    ),
    (
        78598, 2.0, 27579.000, 4, 3, 357
    ),
    (
        78599, 2.0, 9566.000, 6, 2, 907
    ),
    (
        78603, 4.0, 14727.000, 3, 5, 120
    ),
    (
        78620, 5.0, 13750.000, 3, 5, 729
    ),
    (
        78624, 2.0, 16480.000, 7, 1, 27
    ),
    (
        78631, 2.0, 6375.000, 2, 5, 208
    ),
    (
        78639, 3.0, 10728.000, 3, 5, 261
    ),
    (
        78649, 2.0, 14574.000, 5, 4, 225
    ),
    (
        78656, 4.0, 30291.000, 9, 4, 580
    ),
    (
        78665, 3.0, 15586.000, 2, 5, 414
    ),
    (
        78673, 1.0, 18176.000, 5, 3, 706
    ),
    (
        78695, 1.0, 3242.000, 3, 5, 184
    ),
    (
        78697, 3.0, 22947.000, 8, 5, 368
    ),
    (
        78700, 2.0, 19006.000, 3, 2, 595
    ),
    (
        78701, 2.0, 22836.000, 5, 3, 587
    ),
    (
        78710, 1.0, 20962.000, 7, 4, 380
    ),
    (
        78713, 3.0, 31100.000, 9, 4, 681
    ),
    (
        78723, 2.0, 29678.000, 6, 2, 691
    ),
    (
        78725, 4.0, 7280.000, 9, 1, 530
    ),
    (
        78726, 3.0, 19359.000, 6, 1, 618
    ),
    (
        78735, 4.0, 11743.000, 4, 4, 145
    ),
    (
        78736, 2.0, 11132.000, 3, 5, 86
    ),
    (
        78746, 2.0, 19689.000, 4, 5, 668
    ),
    (
        78748, 3.0, 30400.000, 2, 4, 66
    ),
    (
        78759, 1.0, 11028.000, 6, 5, 211
    ),
    (
        78760, 1.0, 22023.000, 2, 3, 853
    ),
    (
        78772, 3.0, 17108.000, 9, 5, 243
    ),
    (
        78780, 4.0, 24108.000, 7, 1, 403
    ),
    (
        78782, 2.0, 3479.000, 1, 5, 570
    ),
    (
        78794, 1.0, 6494.000, 8, 2, 814
    ),
    (
        78798, 1.0, 9481.000, 3, 1, 703
    ),
    (
        78804, 4.0, 26252.000, 6, 2, 795
    ),
    (
        78805, 2.0, 15433.000, 8, 3, 41
    ),
    (
        78815, 5.0, 7962.000, 4, 5, 601
    ),
    (
        78819, 4.0, 14046.000, 8, 5, 25
    ),
    (
        78828, 4.0, 12996.000, 4, 3, 898
    ),
    (
        78829, 4.0, 32200.000, 6, 5, 892
    ),
    (
        78841, 2.0, 11102.000, 3, 2, 149
    ),
    (
        78846, 4.0, 27737.000, 2, 1, 917
    ),
    (
        78859, 2.0, 32122.000, 10, 1, 453
    ),
    (
        78861, 2.0, 26815.000, 4, 1, 514
    ),
    (
        78874, 3.0, 12087.000, 5, 5, 412
    ),
    (
        78876, 1.0, 20844.000, 8, 5, 306
    ),
    (
        78883, 2.0, 26307.000, 2, 3, 703
    ),
    (
        78886, 4.0, 15807.000, 9, 1, 447
    ),
    (
        78887, 2.0, 18081.000, 2, 1, 33
    ),
    (
        78900, 3.0, 7867.000, 9, 5, 675
    ),
    (
        78907, 2.0, 27694.000, 10, 3, 101
    ),
    (
        78912, 3.0, 13632.000, 6, 2, 998
    ),
    (
        78914, 2.0, 4756.000, 7, 5, 687
    ),
    (
        78925, 2.0, 33028.000, 5, 1, 297
    ),
    (
        78932, 4.0, 15946.000, 4, 1, 588
    ),
    (
        78941, 1.0, 13220.000, 9, 2, 14
    ),
    (
        78944, 4.0, 28417.000, 3, 4, 149
    ),
    (
        78949, 3.0, 9027.000, 2, 5, 245
    ),
    (
        78950, 3.0, 10976.000, 4, 5, 529
    ),
    (
        78969, 3.0, 5818.000, 2, 1, 802
    ),
    (
        78970, 5.0, 8820.000, 5, 4, 81
    ),
    (
        78971, 2.0, 860.000, 4, 4, 713
    ),
    (
        78974, 3.0, 30989.000, 9, 3, 802
    ),
    (
        78977, 4.0, 4628.000, 6, 3, 757
    ),
    (
        78979, 5.0, 14911.000, 3, 4, 65
    ),
    (
        79003, 4.0, 5937.000, 7, 4, 832
    ),
    (
        79010, 2.0, 24876.000, 8, 5, 21
    ),
    (
        79013, 2.0, 18962.000, 9, 4, 998
    ),
    (
        79015, 2.0, 15326.000, 5, 4, 343
    ),
    (
        79018, 2.0, 31787.000, 8, 5, 448
    ),
    (
        79023, 3.0, 9080.000, 3, 1, 677
    ),
    (
        79029, 2.0, 12559.000, 8, 5, 191
    ),
    (
        79031, 1.0, 7569.000, 10, 1, 639
    ),
    (
        79035, 5.0, 964.000, 5, 5, 451
    ),
    (
        79053, 2.0, 6315.000, 9, 1, 759
    ),
    (
        79060, 1.0, 3346.000, 3, 4, 575
    ),
    (
        79063, 4.0, 29497.000, 3, 3, 918
    ),
    (
        79064, 1.0, 14659.000, 1, 5, 500
    ),
    (
        79075, 1.0, 29008.000, 2, 5, 478
    ),
    (
        79085, 3.0, 11234.000, 10, 5, 943
    ),
    (
        79088, 3.0, 31367.000, 10, 1, 661
    ),
    (
        79090, 2.0, 32003.000, 8, 5, 290
    ),
    (
        79096, 4.0, 22314.000, 3, 1, 458
    ),
    (
        79105, 5.0, 2511.000, 6, 3, 582
    ),
    (
        79109, 2.0, 32667.000, 10, 5, 611
    ),
    (
        79128, 2.0, 472.000, 3, 5, 137
    ),
    (
        79150, 2.0, 2488.000, 3, 1, 402
    ),
    (
        79153, 1.0, 13538.000, 8, 5, 293
    ),
    (
        79154, 3.0, 2621.000, 7, 4, 339
    ),
    (
        79155, 2.0, 30599.000, 10, 1, 434
    ),
    (
        79166, 4.0, 15745.000, 2, 1, 193
    ),
    (
        79177, 4.0, 26243.000, 8, 3, 46
    ),
    (
        79180, 3.0, 16722.000, 3, 3, 31
    ),
    (
        79188, 4.0, 8372.000, 4, 4, 564
    ),
    (
        79195, 5.0, 21138.000, 3, 1, 511
    ),
    (
        79196, 3.0, 4746.000, 2, 1, 981
    ),
    (
        79210, 4.0, 14255.000, 10, 3, 550
    ),
    (
        79215, 4.0, 32826.000, 4, 1, 962
    ),
    (
        79216, 4.0, 28296.000, 9, 2, 962
    ),
    (
        79234, 4.0, 5123.000, 4, 1, 539
    ),
    (
        79262, 2.0, 20879.000, 2, 4, 932
    ),
    (
        79264, 2.0, 5896.000, 3, 4, 863
    ),
    (
        79266, 2.0, 6626.000, 5, 4, 694
    ),
    (
        79268, 2.0, 20111.000, 2, 3, 448
    ),
    (
        79269, 4.0, 32511.000, 8, 2, 308
    ),
    (
        79280, 2.0, 12673.000, 2, 3, 461
    ),
    (
        79284, 4.0, 5448.000, 7, 4, 607
    ),
    (
        79295, 4.0, 21160.000, 8, 2, 240
    ),
    (
        79299, 3.0, 15306.000, 6, 2, 760
    ),
    (
        79300, 1.0, 24566.000, 7, 5, 622
    ),
    (
        79306, 2.0, 30883.000, 6, 2, 143
    ),
    (
        79327, 3.0, 25579.000, 2, 3, 852
    ),
    (
        79335, 4.0, 20693.000, 1, 3, 856
    ),
    (
        79343, 3.0, 33347.000, 6, 5, 698
    ),
    (
        79351, 5.0, 18993.000, 1, 3, 976
    ),
    (
        79363, 1.0, 23419.000, 3, 5, 69
    ),
    (
        79365, 5.0, 1786.000, 4, 3, 336
    ),
    (
        79366, 2.0, 15730.000, 5, 4, 552
    ),
    (
        79372, 5.0, 3298.000, 7, 2, 847
    ),
    (
        79377, 2.0, 8645.000, 8, 1, 838
    ),
    (
        79387, 5.0, 21900.000, 4, 3, 629
    ),
    (
        79393, 3.0, 21505.000, 8, 1, 89
    ),
    (
        79399, 4.0, 23202.000, 3, 5, 839
    ),
    (
        79406, 3.0, 30868.000, 4, 5, 488
    ),
    (
        79414, 3.0, 10247.000, 4, 3, 152
    ),
    (
        79435, 2.0, 26204.000, 5, 1, 830
    ),
    (
        79440, 4.0, 31656.000, 5, 3, 954
    ),
    (
        79444, 2.0, 9411.000, 4, 5, 840
    ),
    (
        79449, 2.0, 28668.000, 4, 1, 121
    ),
    (
        79463, 3.0, 24546.000, 8, 5, 260
    ),
    (
        79466, 1.0, 3865.000, 5, 1, 82
    ),
    (
        79470, 1.0, 30623.000, 4, 1, 217
    ),
    (
        79481, 2.0, 7288.000, 2, 1, 868
    ),
    (
        79485, 2.0, 14720.000, 6, 3, 66
    ),
    (
        79486, 4.0, 3265.000, 6, 2, 683
    ),
    (
        79490, 2.0, 1655.000, 3, 1, 495
    ),
    (
        79496, 2.0, 23688.000, 2, 2, 235
    ),
    (
        79499, 2.0, 9607.000, 4, 5, 823
    ),
    (
        79500, 2.0, 11565.000, 3, 1, 630
    ),
    (
        79502, 4.0, 21890.000, 4, 3, 473
    ),
    (
        79520, 3.0, 25575.000, 1, 5, 410
    ),
    (
        79523, 1.0, 20074.000, 8, 1, 39
    ),
    (
        79536, 4.0, 30615.000, 4, 1, 19
    ),
    (
        79548, 3.0, 27677.000, 4, 5, 99
    ),
    (
        79560, 4.0, 22677.000, 5, 5, 614
    ),
    (
        79575, 3.0, 13690.000, 9, 1, 855
    ),
    (
        79589, 5.0, 5548.000, 2, 1, 165
    ),
    (
        79592, 4.0, 4635.000, 6, 2, 532
    ),
    (
        79602, 2.0, 9317.000, 7, 4, 521
    ),
    (
        79609, 1.0, 5594.000, 6, 3, 600
    ),
    (
        79611, 1.0, 22865.000, 2, 3, 284
    ),
    (
        79616, 1.0, 18279.000, 6, 1, 801
    ),
    (
        79646, 2.0, 31835.000, 1, 2, 668
    ),
    (
        79647, 2.0, 13300.000, 2, 3, 763
    ),
    (
        79648, 3.0, 14148.000, 5, 1, 832
    ),
    (
        79650, 5.0, 31926.000, 9, 4, 683
    ),
    (
        79657, 4.0, 22158.000, 10, 1, 206
    ),
    (
        79660, 4.0, 11569.000, 6, 5, 907
    ),
    (
        79674, 4.0, 14860.000, 9, 3, 195
    ),
    (
        79683, 3.0, 30201.000, 1, 3, 399
    ),
    (
        79690, 3.0, 10686.000, 9, 4, 864
    ),
    (
        79694, 1.0, 1958.000, 1, 5, 894
    ),
    (
        79697, 4.0, 24036.000, 7, 2, 836
    ),
    (
        79705, 4.0, 25518.000, 9, 1, 840
    ),
    (
        79708, 5.0, 13437.000, 2, 1, 325
    ),
    (
        79710, 2.0, 8978.000, 8, 2, 284
    ),
    (
        79721, 5.0, 2192.000, 4, 3, 680
    ),
    (
        79722, 4.0, 26925.000, 7, 5, 648
    ),
    (
        79731, 2.0, 2019.000, 6, 4, 554
    ),
    (
        79748, 2.0, 17415.000, 10, 3, 19
    ),
    (
        79750, 2.0, 27577.000, 6, 3, 908
    ),
    (
        79751, 5.0, 30918.000, 8, 1, 214
    ),
    (
        79759, 1.0, 3343.000, 4, 2, 753
    ),
    (
        79760, 4.0, 12016.000, 6, 5, 882
    ),
    (
        79762, 2.0, 22364.000, 3, 5, 38
    ),
    (
        79783, 2.0, 9750.000, 4, 1, 939
    ),
    (
        79786, 1.0, 3408.000, 3, 5, 997
    ),
    (
        79790, 3.0, 11046.000, 1, 1, 385
    ),
    (
        79805, 3.0, 5555.000, 2, 2, 796
    ),
    (
        79808, 2.0, 8052.000, 5, 4, 304
    ),
    (
        79817, 5.0, 33395.000, 3, 2, 987
    ),
    (
        79833, 2.0, 24132.000, 1, 1, 135
    ),
    (
        79834, 3.0, 7575.000, 6, 1, 526
    ),
    (
        79839, 4.0, 14452.000, 7, 2, 72
    ),
    (
        79849, 2.0, 3532.000, 5, 5, 250
    ),
    (
        79856, 1.0, 6043.000, 7, 5, 821
    ),
    (
        79860, 1.0, 26069.000, 6, 3, 927
    ),
    (
        79863, 3.0, 11282.000, 10, 5, 741
    ),
    (
        79864, 5.0, 6159.000, 3, 4, 101
    ),
    (
        79869, 1.0, 20251.000, 9, 5, 652
    ),
    (
        79883, 3.0, 24992.000, 3, 4, 969
    ),
    (
        79886, 4.0, 20967.000, 6, 1, 481
    ),
    (
        79888, 4.0, 21308.000, 2, 5, 43
    ),
    (
        79924, 1.0, 7852.000, 9, 1, 239
    ),
    (
        79925, 2.0, 1953.000, 8, 5, 263
    ),
    (
        79934, 3.0, 20680.000, 9, 4, 624
    ),
    (
        79939, 2.0, 20375.000, 3, 3, 998
    ),
    (
        79952, 3.0, 19927.000, 8, 5, 588
    ),
    (
        79953, 1.0, 15546.000, 2, 3, 546
    ),
    (
        79958, 4.0, 14261.000, 7, 2, 408
    ),
    (
        79977, 3.0, 18865.000, 4, 1, 232
    ),
    (
        79987, 4.0, 5602.000, 6, 2, 883
    ),
    (
        80000, 4.0, 22383.000, 5, 1, 62
    ),
    (
        80001, 2.0, 16990.000, 2, 5, 466
    ),
    (
        80009, 3.0, 24517.000, 4, 3, 566
    ),
    (
        80017, 3.0, 4881.000, 4, 1, 167
    ),
    (
        80022, 2.0, 26869.000, 1, 5, 242
    ),
    (
        80025, 5.0, 5547.000, 10, 3, 517
    ),
    (
        80035, 2.0, 1406.000, 8, 5, 355
    ),
    (
        80036, 5.0, 12752.000, 3, 5, 55
    ),
    (
        80039, 2.0, 11276.000, 7, 1, 488
    ),
    (
        80044, 4.0, 4640.000, 8, 3, 505
    ),
    (
        80056, 4.0, 23336.000, 5, 2, 824
    ),
    (
        80057, 3.0, 17630.000, 5, 3, 979
    ),
    (
        80063, 3.0, 25388.000, 9, 3, 558
    ),
    (
        80065, 4.0, 20800.000, 10, 5, 898
    ),
    (
        80075, 2.0, 10449.000, 8, 4, 709
    ),
    (
        80093, 5.0, 32478.000, 9, 2, 241
    ),
    (
        80103, 1.0, 29666.000, 4, 4, 290
    ),
    (
        80110, 2.0, 19946.000, 9, 4, 375
    ),
    (
        80112, 3.0, 5609.000, 10, 3, 201
    ),
    (
        80127, 5.0, 28800.000, 4, 5, 660
    ),
    (
        80129, 5.0, 922.000, 5, 1, 953
    ),
    (
        80131, 3.0, 7710.000, 8, 1, 810
    ),
    (
        80135, 3.0, 25159.000, 2, 1, 324
    ),
    (
        80148, 3.0, 2367.000, 6, 3, 292
    ),
    (
        80153, 2.0, 14965.000, 7, 1, 545
    ),
    (
        80154, 2.0, 5165.000, 7, 5, 856
    ),
    (
        80156, 2.0, 10662.000, 7, 4, 159
    ),
    (
        80165, 2.0, 33906.000, 4, 3, 798
    ),
    (
        80177, 3.0, 13640.000, 6, 3, 705
    ),
    (
        80193, 4.0, 1867.000, 4, 2, 675
    ),
    (
        80197, 1.0, 33456.000, 7, 2, 122
    ),
    (
        80215, 3.0, 15844.000, 7, 5, 575
    ),
    (
        80218, 3.0, 11352.000, 8, 1, 1000
    ),
    (
        80223, 3.0, 30563.000, 1, 3, 361
    ),
    (
        80225, 2.0, 22260.000, 8, 1, 848
    ),
    (
        80226, 1.0, 29990.000, 2, 2, 175
    ),
    (
        80235, 2.0, 10717.000, 1, 1, 283
    ),
    (
        80238, 1.0, 3749.000, 6, 2, 229
    ),
    (
        80239, 1.0, 16362.000, 4, 1, 513
    ),
    (
        80251, 5.0, 29691.000, 5, 3, 569
    ),
    (
        80253, 2.0, 9022.000, 8, 5, 479
    ),
    (
        80257, 3.0, 26124.000, 10, 3, 876
    ),
    (
        80262, 4.0, 33284.000, 6, 1, 638
    ),
    (
        80280, 4.0, 29217.000, 9, 1, 257
    ),
    (
        80282, 2.0, 25211.000, 3, 1, 635
    ),
    (
        80284, 4.0, 4104.000, 5, 5, 87
    ),
    (
        80288, 4.0, 6823.000, 9, 1, 683
    ),
    (
        80291, 1.0, 8252.000, 9, 5, 730
    ),
    (
        80297, 1.0, 11006.000, 6, 5, 686
    ),
    (
        80304, 4.0, 20003.000, 8, 1, 129
    ),
    (
        80305, 3.0, 16864.000, 4, 2, 304
    ),
    (
        80321, 4.0, 27695.000, 8, 3, 869
    ),
    (
        80340, 5.0, 13899.000, 2, 3, 565
    ),
    (
        80359, 3.0, 28052.000, 7, 1, 928
    ),
    (
        80374, 3.0, 23637.000, 7, 2, 428
    ),
    (
        80382, 1.0, 14864.000, 9, 5, 880
    ),
    (
        80387, 1.0, 233.000, 10, 4, 170
    ),
    (
        80403, 5.0, 14548.000, 5, 1, 806
    ),
    (
        80407, 2.0, 15583.000, 3, 5, 970
    ),
    (
        80411, 2.0, 10752.000, 8, 5, 310
    ),
    (
        80430, 4.0, 3844.000, 7, 5, 550
    ),
    (
        80436, 1.0, 24445.000, 5, 5, 313
    ),
    (
        80445, 5.0, 2435.000, 6, 4, 280
    ),
    (
        80464, 5.0, 33410.000, 10, 1, 204
    ),
    (
        80472, 1.0, 6922.000, 7, 5, 679
    ),
    (
        80473, 3.0, 15596.000, 8, 3, 644
    ),
    (
        80481, 3.0, 24831.000, 1, 5, 847
    ),
    (
        80485, 3.0, 10968.000, 8, 5, 324
    ),
    (
        80489, 4.0, 20903.000, 1, 2, 575
    ),
    (
        80522, 3.0, 8107.000, 9, 5, 906
    ),
    (
        80525, 1.0, 13836.000, 7, 2, 812
    ),
    (
        80532, 2.0, 14060.000, 7, 5, 818
    ),
    (
        80540, 4.0, 9575.000, 10, 1, 172
    ),
    (
        80544, 4.0, 9256.000, 10, 1, 568
    ),
    (
        80561, 1.0, 17315.000, 3, 3, 295
    ),
    (
        80588, 4.0, 33115.000, 3, 3, 384
    ),
    (
        80591, 4.0, 32444.000, 5, 2, 705
    ),
    (
        80607, 2.0, 3510.000, 5, 1, 893
    ),
    (
        80612, 2.0, 8114.000, 2, 1, 619
    ),
    (
        80620, 2.0, 3946.000, 6, 2, 484
    ),
    (
        80621, 4.0, 20128.000, 6, 5, 883
    ),
    (
        80623, 3.0, 15097.000, 9, 2, 411
    ),
    (
        80628, 1.0, 5446.000, 5, 5, 403
    ),
    (
        80632, 3.0, 21532.000, 6, 5, 230
    ),
    (
        80637, 5.0, 10939.000, 8, 1, 815
    ),
    (
        80638, 5.0, 8847.000, 5, 3, 626
    ),
    (
        80639, 2.0, 19652.000, 1, 2, 707
    ),
    (
        80653, 2.0, 11310.000, 10, 5, 490
    ),
    (
        80654, 4.0, 17715.000, 3, 3, 818
    ),
    (
        80671, 1.0, 13129.000, 8, 5, 139
    ),
    (
        80675, 4.0, 15495.000, 3, 4, 674
    ),
    (
        80690, 4.0, 22104.000, 3, 1, 766
    ),
    (
        80695, 4.0, 19040.000, 8, 1, 826
    ),
    (
        80696, 1.0, 2040.000, 10, 4, 588
    ),
    (
        80707, 4.0, 25545.000, 4, 2, 961
    ),
    (
        80709, 5.0, 29045.000, 5, 4, 590
    ),
    (
        80719, 5.0, 20213.000, 3, 3, 882
    ),
    (
        80721, 4.0, 3094.000, 9, 1, 863
    ),
    (
        80734, 3.0, 24931.000, 5, 1, 53
    ),
    (
        80745, 5.0, 3530.000, 7, 5, 718
    ),
    (
        80751, 4.0, 23732.000, 3, 5, 325
    ),
    (
        80754, 1.0, 29720.000, 3, 2, 185
    ),
    (
        80770, 3.0, 8670.000, 7, 2, 859
    ),
    (
        80774, 4.0, 29246.000, 4, 1, 331
    ),
    (
        80775, 3.0, 10878.000, 3, 1, 882
    ),
    (
        80777, 2.0, 22179.000, 5, 2, 432
    ),
    (
        80782, 5.0, 4138.000, 7, 1, 24
    ),
    (
        80789, 3.0, 5184.000, 2, 5, 370
    ),
    (
        80790, 1.0, 11380.000, 5, 1, 963
    ),
    (
        80791, 4.0, 20941.000, 10, 1, 258
    ),
    (
        80795, 1.0, 27301.000, 1, 3, 997
    ),
    (
        80799, 1.0, 29966.000, 5, 2, 640
    ),
    (
        80816, 1.0, 27516.000, 7, 5, 913
    ),
    (
        80832, 5.0, 8375.000, 4, 4, 374
    ),
    (
        80834, 4.0, 31983.000, 4, 5, 671
    ),
    (
        80851, 2.0, 18659.000, 2, 1, 655
    ),
    (
        80852, 2.0, 8770.000, 6, 1, 373
    ),
    (
        80853, 4.0, 2346.000, 8, 5, 292
    ),
    (
        80864, 3.0, 15413.000, 9, 1, 688
    ),
    (
        80872, 1.0, 22061.000, 3, 5, 404
    ),
    (
        80874, 3.0, 10924.000, 3, 1, 646
    ),
    (
        80883, 1.0, 27088.000, 7, 2, 641
    ),
    (
        80890, 1.0, 2403.000, 1, 4, 276
    ),
    (
        80892, 1.0, 23020.000, 4, 3, 184
    ),
    (
        80901, 2.0, 19841.000, 4, 1, 364
    ),
    (
        80903, 4.0, 15812.000, 2, 3, 570
    ),
    (
        80917, 1.0, 22787.000, 3, 5, 385
    ),
    (
        80922, 1.0, 14829.000, 1, 5, 365
    ),
    (
        80925, 4.0, 22485.000, 3, 5, 192
    ),
    (
        80934, 5.0, 29925.000, 7, 4, 560
    ),
    (
        80958, 2.0, 17676.000, 5, 5, 199
    ),
    (
        80960, 3.0, 27916.000, 5, 5, 132
    ),
    (
        80965, 1.0, 19770.000, 8, 1, 148
    ),
    (
        80970, 4.0, 26077.000, 9, 5, 148
    ),
    (
        80986, 2.0, 26907.000, 4, 3, 945
    ),
    (
        80997, 4.0, 31869.000, 4, 1, 149
    ),
    (
        81019, 3.0, 27731.000, 8, 3, 721
    ),
    (
        81021, 3.0, 31011.000, 3, 3, 521
    ),
    (
        81035, 5.0, 21898.000, 6, 5, 179
    ),
    (
        81045, 4.0, 1350.000, 7, 1, 397
    ),
    (
        81048, 4.0, 23624.000, 5, 2, 359
    ),
    (
        81066, 4.0, 2335.000, 5, 1, 220
    ),
    (
        81086, 4.0, 17985.000, 2, 1, 833
    ),
    (
        81150, 2.0, 33033.000, 5, 1, 218
    ),
    (
        81151, 4.0, 18316.000, 3, 2, 846
    ),
    (
        81155, 3.0, 12830.000, 1, 5, 636
    ),
    (
        81163, 3.0, 11213.000, 3, 5, 264
    ),
    (
        81173, 1.0, 15022.000, 2, 1, 43
    ),
    (
        81185, 4.0, 19761.000, 7, 4, 656
    ),
    (
        81187, 1.0, 28259.000, 10, 2, 944
    ),
    (
        81198, 2.0, 3528.000, 9, 1, 547
    ),
    (
        81205, 4.0, 10049.000, 5, 1, 363
    ),
    (
        81213, 2.0, 14011.000, 2, 1, 50
    ),
    (
        81219, 2.0, 4466.000, 7, 5, 844
    ),
    (
        81223, 1.0, 487.000, 10, 5, 649
    ),
    (
        81227, 3.0, 3664.000, 3, 1, 290
    ),
    (
        81236, 3.0, 14643.000, 6, 3, 716
    ),
    (
        81242, 2.0, 25403.000, 1, 1, 907
    ),
    (
        81264, 4.0, 33037.000, 5, 3, 193
    ),
    (
        81265, 2.0, 8338.000, 2, 5, 252
    ),
    (
        81277, 4.0, 19250.000, 9, 4, 275
    ),
    (
        81286, 3.0, 8793.000, 8, 5, 210
    ),
    (
        81290, 3.0, 13699.000, 3, 5, 903
    ),
    (
        81300, 3.0, 10141.000, 2, 4, 251
    ),
    (
        81302, 3.0, 28194.000, 7, 5, 364
    ),
    (
        81308, 2.0, 33205.000, 5, 1, 190
    ),
    (
        81318, 3.0, 24063.000, 3, 5, 168
    ),
    (
        81323, 4.0, 32318.000, 4, 5, 447
    ),
    (
        81325, 2.0, 19165.000, 8, 3, 622
    ),
    (
        81338, 2.0, 3200.000, 1, 5, 745
    ),
    (
        81348, 2.0, 29843.000, 9, 5, 204
    ),
    (
        81349, 1.0, 17976.000, 6, 2, 398
    ),
    (
        81359, 3.0, 2951.000, 6, 4, 47
    ),
    (
        81367, 2.0, 13457.000, 1, 5, 755
    ),
    (
        81374, 3.0, 18217.000, 1, 3, 146
    ),
    (81379, 2.0, 431.000, 5, 1, 68),
    (
        81381, 2.0, 20687.000, 3, 2, 674
    ),
    (
        81388, 4.0, 12346.000, 8, 4, 924
    ),
    (
        81395, 2.0, 33666.000, 5, 3, 1000
    ),
    (
        81403, 2.0, 10862.000, 8, 4, 885
    ),
    (
        81414, 4.0, 22565.000, 3, 2, 94
    ),
    (
        81418, 5.0, 19445.000, 1, 3, 347
    ),
    (
        81440, 4.0, 26205.000, 4, 1, 645
    ),
    (
        81441, 5.0, 24413.000, 8, 4, 787
    ),
    (
        81447, 3.0, 16620.000, 9, 4, 230
    ),
    (
        81449, 1.0, 5570.000, 8, 2, 901
    ),
    (
        81450, 4.0, 14235.000, 7, 4, 385
    ),
    (
        81454, 1.0, 11573.000, 5, 1, 175
    ),
    (
        81462, 4.0, 32191.000, 8, 2, 688
    ),
    (
        81466, 3.0, 28458.000, 10, 2, 525
    ),
    (
        81473, 2.0, 8253.000, 3, 1, 113
    ),
    (
        81475, 4.0, 22105.000, 1, 2, 339
    ),
    (
        81479, 2.0, 12813.000, 1, 1, 208
    ),
    (
        81481, 5.0, 18408.000, 9, 4, 441
    ),
    (
        81487, 4.0, 21516.000, 8, 1, 52
    ),
    (
        81489, 3.0, 9488.000, 7, 2, 739
    ),
    (
        81494, 4.0, 21880.000, 1, 1, 563
    ),
    (
        81496, 3.0, 13305.000, 3, 5, 905
    ),
    (
        81498, 4.0, 2380.000, 1, 4, 317
    ),
    (
        81501, 1.0, 5176.000, 6, 2, 394
    ),
    (
        81518, 2.0, 3458.000, 8, 4, 562
    ),
    (
        81519, 3.0, 8954.000, 2, 5, 318
    ),
    (
        81525, 3.0, 2692.000, 1, 5, 852
    ),
    (
        81534, 5.0, 8343.000, 4, 4, 108
    ),
    (
        81544, 3.0, 21421.000, 8, 5, 398
    ),
    (
        81549, 4.0, 4407.000, 4, 3, 114
    ),
    (
        81552, 2.0, 4987.000, 7, 5, 654
    ),
    (
        81559, 2.0, 26548.000, 3, 4, 222
    ),
    (
        81561, 3.0, 13727.000, 4, 3, 127
    ),
    (
        81563, 3.0, 16639.000, 7, 5, 468
    ),
    (
        81574, 1.0, 5516.000, 8, 3, 45
    ),
    (
        81581, 3.0, 22552.000, 7, 1, 652
    ),
    (
        81586, 2.0, 12666.000, 5, 1, 932
    ),
    (
        81587, 3.0, 27496.000, 5, 5, 453
    ),
    (
        81594, 1.0, 23482.000, 5, 5, 719
    ),
    (
        81625, 2.0, 16996.000, 9, 5, 884
    ),
    (
        81632, 4.0, 21634.000, 1, 2, 973
    ),
    (
        81633, 2.0, 9455.000, 7, 3, 609
    ),
    (
        81640, 3.0, 14357.000, 8, 2, 636
    ),
    (
        81652, 5.0, 20072.000, 3, 2, 572
    ),
    (
        81669, 5.0, 15518.000, 5, 1, 117
    ),
    (
        81674, 2.0, 23832.000, 8, 5, 326
    ),
    (
        81675, 4.0, 30052.000, 2, 4, 15
    ),
    (
        81679, 4.0, 29130.000, 1, 3, 847
    ),
    (
        81681, 4.0, 33976.000, 9, 2, 897
    ),
    (
        81683, 4.0, 415.000, 7, 3, 916
    ),
    (
        81691, 4.0, 12270.000, 3, 2, 19
    ),
    (
        81698, 3.0, 22819.000, 5, 3, 912
    ),
    (
        81702, 1.0, 2243.000, 2, 2, 670
    ),
    (
        81709, 5.0, 21487.000, 4, 3, 896
    ),
    (
        81711, 4.0, 32561.000, 8, 2, 281
    ),
    (
        81734, 2.0, 23720.000, 6, 5, 792
    ),
    (
        81739, 5.0, 2129.000, 4, 3, 836
    ),
    (
        81758, 4.0, 12926.000, 4, 2, 589
    ),
    (
        81776, 2.0, 25891.000, 9, 5, 338
    ),
    (
        81777, 4.0, 25299.000, 5, 1, 87
    ),
    (
        81782, 2.0, 19935.000, 4, 1, 196
    ),
    (
        81805, 2.0, 32710.000, 5, 1, 150
    ),
    (
        81824, 4.0, 21955.000, 7, 3, 783
    ),
    (
        81833, 5.0, 22098.000, 5, 3, 709
    ),
    (
        81845, 4.0, 23378.000, 4, 3, 234
    ),
    (
        81850, 2.0, 18789.000, 10, 1, 605
    ),
    (
        81874, 3.0, 17105.000, 8, 2, 204
    ),
    (
        81888, 3.0, 13777.000, 9, 2, 637
    ),
    (
        81891, 3.0, 17609.000, 4, 5, 544
    ),
    (
        85090, 2.0, 9752.000, 4, 5, 402
    ),
    (
        85092, 4.0, 9411.000, 3, 1, 836
    ),
    (
        85094, 2.0, 30835.000, 8, 3, 630
    ),
    (
        85098, 3.0, 19961.000, 2, 5, 236
    ),
    (
        85102, 4.0, 6431.000, 9, 1, 693
    ),
    (
        85103, 2.0, 25989.000, 4, 2, 491
    ),
    (
        85106, 1.0, 25103.000, 7, 5, 916
    ),
    (
        85114, 4.0, 20183.000, 7, 3, 677
    ),
    (
        85116, 3.0, 8436.000, 9, 3, 415
    ),
    (
        85118, 2.0, 11727.000, 2, 3, 419
    ),
    (
        85121, 2.0, 29289.000, 6, 3, 318
    ),
    (
        85123, 4.0, 30853.000, 10, 2, 820
    ),
    (
        85124, 4.0, 27520.000, 2, 5, 743
    ),
    (
        85129, 4.0, 8753.000, 2, 3, 616
    ),
    (
        85133, 3.0, 6487.000, 8, 1, 131
    ),
    (
        85135, 5.0, 5584.000, 9, 4, 384
    ),
    (
        85143, 4.0, 24495.000, 7, 1, 542
    ),
    (
        85145, 5.0, 8442.000, 4, 1, 404
    ),
    (
        85161, 2.0, 30696.000, 9, 3, 890
    ),
    (
        85164, 1.0, 6886.000, 8, 1, 300
    ),
    (
        85172, 4.0, 18921.000, 6, 5, 193
    ),
    (
        85173, 1.0, 31799.000, 4, 1, 84
    ),
    (
        85176, 4.0, 19636.000, 4, 5, 709
    ),
    (
        85189, 3.0, 22721.000, 1, 2, 770
    ),
    (
        85207, 4.0, 27305.000, 7, 1, 144
    ),
    (
        85220, 4.0, 15567.000, 3, 5, 859
    ),
    (
        85222, 3.0, 25039.000, 3, 1, 782
    ),
    (
        85228, 1.0, 3358.000, 5, 4, 882
    ),
    (
        85230, 4.0, 8786.000, 3, 3, 529
    ),
    (
        85238, 3.0, 7725.000, 4, 2, 695
    ),
    (
        85239, 5.0, 29963.000, 5, 3, 182
    ),
    (
        85243, 5.0, 4454.000, 7, 1, 339
    ),
    (
        85247, 5.0, 22030.000, 5, 3, 822
    ),
    (
        85254, 4.0, 5141.000, 8, 2, 627
    ),
    (
        85268, 3.0, 19181.000, 5, 3, 166
    ),
    (
        85271, 3.0, 16440.000, 7, 2, 490
    ),
    (
        85274, 5.0, 14365.000, 5, 5, 345
    ),
    (
        85282, 4.0, 31566.000, 3, 2, 504
    ),
    (
        85285, 2.0, 8960.000, 9, 3, 418
    ),
    (
        85286, 5.0, 14087.000, 3, 1, 763
    ),
    (
        85287, 3.0, 1582.000, 8, 1, 601
    ),
    (
        85288, 5.0, 31576.000, 8, 2, 777
    ),
    (
        85292, 5.0, 6154.000, 2, 2, 302
    ),
    (
        85294, 4.0, 33038.000, 3, 2, 791
    ),
    (
        85300, 3.0, 3876.000, 10, 3, 511
    ),
    (
        85304, 2.0, 4845.000, 7, 4, 707
    ),
    (
        85307, 1.0, 27389.000, 10, 3, 668
    ),
    (
        85310, 2.0, 2507.000, 8, 4, 822
    ),
    (
        85315, 4.0, 9187.000, 5, 2, 910
    ),
    (
        85317, 4.0, 5823.000, 9, 4, 260
    ),
    (
        85320, 3.0, 12421.000, 7, 1, 419
    ),
    (
        85324, 4.0, 24063.000, 5, 2, 505
    ),
    (
        85325, 5.0, 15412.000, 4, 1, 484
    ),
    (
        85326, 2.0, 20788.000, 5, 2, 77
    ),
    (
        85327, 3.0, 22369.000, 6, 4, 413
    ),
    (
        85334, 2.0, 11931.000, 3, 1, 474
    ),
    (
        85336, 5.0, 11139.000, 7, 2, 168
    ),
    (
        85365, 2.0, 20686.000, 7, 2, 494
    ),
    (
        85370, 5.0, 14388.000, 3, 1, 556
    ),
    (
        85371, 3.0, 4771.000, 1, 4, 278
    ),
    (
        85379, 4.0, 1006.000, 10, 5, 492
    ),
    (
        85383, 1.0, 19925.000, 7, 3, 220
    ),
    (
        85389, 3.0, 23277.000, 8, 3, 865
    ),
    (
        85390, 3.0, 28084.000, 7, 5, 530
    ),
    (
        85395, 2.0, 4750.000, 3, 3, 199
    ),
    (
        85398, 4.0, 2534.000, 2, 1, 267
    ),
    (
        85400, 3.0, 14336.000, 8, 3, 777
    ),
    (
        85401, 4.0, 6158.000, 8, 3, 834
    ),
    (
        85406, 2.0, 31443.000, 6, 1, 844
    ),
    (
        85409, 5.0, 12013.000, 10, 4, 246
    ),
    (
        85420, 4.0, 10785.000, 7, 2, 26
    ),
    (
        85426, 3.0, 7811.000, 7, 3, 655
    ),
    (
        85427, 4.0, 22942.000, 3, 5, 61
    ),
    (
        85434, 5.0, 10677.000, 9, 4, 520
    ),
    (
        85441, 2.0, 19873.000, 4, 4, 879
    ),
    (
        85449, 3.0, 29769.000, 6, 1, 950
    ),
    (
        85450, 3.0, 3544.000, 4, 3, 110
    ),
    (
        85452, 2.0, 4434.000, 3, 4, 220
    ),
    (
        85453, 4.0, 1726.000, 1, 5, 863
    ),
    (
        85457, 3.0, 5089.000, 6, 1, 991
    ),
    (
        85460, 5.0, 12516.000, 3, 5, 42
    ),
    (
        85469, 4.0, 4007.000, 4, 2, 869
    ),
    (
        85474, 3.0, 22370.000, 5, 2, 682
    ),
    (
        85480, 1.0, 7881.000, 1, 3, 578
    ),
    (
        85481, 2.0, 18529.000, 10, 2, 900
    ),
    (
        85483, 3.0, 2190.000, 7, 3, 835
    ),
    (
        85489, 4.0, 32966.000, 7, 2, 354
    ),
    (
        85491, 4.0, 11028.000, 4, 5, 531
    ),
    (
        85493, 2.0, 577.000, 5, 1, 162
    ),
    (
        85496, 4.0, 19263.000, 6, 1, 497
    ),
    (
        85501, 5.0, 13914.000, 4, 2, 102
    ),
    (
        85508, 1.0, 10922.000, 3, 3, 293
    ),
    (
        85510, 4.0, 205.000, 8, 5, 295
    ),
    (
        85519, 2.0, 30626.000, 6, 5, 234
    ),
    (
        85520, 2.0, 21555.000, 4, 5, 607
    ),
    (
        85522, 2.0, 20108.000, 2, 1, 796
    ),
    (
        85524, 4.0, 33610.000, 6, 3, 365
    ),
    (
        85528, 4.0, 19148.000, 8, 1, 124
    ),
    (
        85537, 4.0, 22800.000, 8, 4, 473
    ),
    (
        85538, 2.0, 7149.000, 7, 4, 697
    ),
    (
        85542, 1.0, 1107.000, 1, 5, 670
    ),
    (
        85545, 2.0, 24016.000, 2, 3, 253
    ),
    (
        85548, 3.0, 8012.000, 9, 5, 810
    ),
    (
        85557, 3.0, 14175.000, 3, 4, 541
    ),
    (
        85561, 3.0, 19787.000, 4, 4, 160
    ),
    (
        85562, 2.0, 6972.000, 1, 3, 271
    ),
    (
        85563, 5.0, 33782.000, 2, 3, 971
    ),
    (
        85565, 3.0, 7106.000, 6, 5, 178
    ),
    (
        85568, 1.0, 20004.000, 9, 3, 4
    ),
    (
        85576, 2.0, 28270.000, 8, 2, 810
    ),
    (
        85577, 3.0, 24494.000, 4, 3, 72
    ),
    (
        85588, 1.0, 2146.000, 1, 1, 120
    ),
    (
        85589, 3.0, 28436.000, 9, 4, 476
    ),
    (
        85590, 5.0, 8345.000, 5, 3, 663
    ),
    (
        85593, 5.0, 26469.000, 1, 4, 705
    ),
    (
        85601, 2.0, 31517.000, 8, 2, 964
    ),
    (
        85605, 4.0, 10556.000, 3, 3, 387
    ),
    (
        85610, 4.0, 9495.000, 4, 5, 357
    ),
    (
        85612, 5.0, 24546.000, 9, 1, 869
    ),
    (
        85613, 1.0, 29075.000, 10, 3, 151
    ),
    (
        85614, 3.0, 29168.000, 9, 5, 36
    ),
    (
        85617, 2.0, 29554.000, 7, 5, 665
    ),
    (
        85618, 3.0, 7083.000, 7, 5, 710
    ),
    (
        85620, 4.0, 19255.000, 3, 3, 155
    ),
    (
        85621, 1.0, 20896.000, 1, 2, 375
    ),
    (
        85624, 5.0, 19698.000, 3, 2, 262
    ),
    (
        85628, 4.0, 32757.000, 7, 3, 467
    ),
    (
        85629, 4.0, 25615.000, 3, 1, 768
    ),
    (
        85636, 4.0, 7771.000, 2, 5, 311
    ),
    (
        85642, 4.0, 24757.000, 6, 3, 64
    ),
    (
        85643, 4.0, 10044.000, 4, 1, 65
    ),
    (
        85653, 4.0, 27189.000, 6, 2, 78
    ),
    (
        85658, 2.0, 32449.000, 8, 1, 684
    ),
    (
        85661, 4.0, 3966.000, 2, 1, 884
    ),
    (
        85662, 2.0, 4481.000, 6, 3, 963
    ),
    (
        85669, 1.0, 19721.000, 6, 1, 597
    ),
    (
        85671, 5.0, 31793.000, 1, 3, 992
    ),
    (
        85673, 2.0, 24124.000, 9, 2, 585
    ),
    (
        85682, 4.0, 8247.000, 2, 4, 963
    ),
    (
        85689, 1.0, 33873.000, 9, 3, 608
    ),
    (
        85692, 4.0, 23392.000, 6, 3, 430
    ),
    (
        85695, 1.0, 28092.000, 9, 1, 580
    ),
    (
        85697, 3.0, 21862.000, 7, 2, 892
    ),
    (
        85699, 3.0, 31606.000, 9, 3, 403
    ),
    (
        85701, 3.0, 8440.000, 4, 1, 374
    ),
    (
        85703, 3.0, 22282.000, 6, 1, 408
    ),
    (
        85705, 3.0, 17588.000, 8, 2, 453
    ),
    (
        85708, 3.0, 23904.000, 8, 5, 47
    ),
    (
        85722, 1.0, 29001.000, 2, 5, 612
    ),
    (
        85732, 3.0, 8605.000, 5, 3, 664
    ),
    (
        85737, 3.0, 3907.000, 1, 4, 953
    ),
    (
        85749, 3.0, 1637.000, 6, 3, 733
    ),
    (
        85752, 2.0, 25788.000, 9, 5, 22
    ),
    (
        85753, 3.0, 29384.000, 2, 2, 679
    ),
    (
        85762, 5.0, 13176.000, 10, 3, 149
    ),
    (
        85763, 5.0, 7924.000, 4, 1, 412
    ),
    (
        85764, 4.0, 19480.000, 6, 2, 192
    ),
    (
        85768, 3.0, 24353.000, 1, 1, 342
    ),
    (
        85773, 2.0, 13775.000, 3, 4, 569
    ),
    (
        85775, 4.0, 7092.000, 8, 5, 776
    ),
    (
        85785, 4.0, 30959.000, 3, 2, 536
    ),
    (
        85790, 5.0, 3855.000, 6, 4, 401
    ),
    (
        85791, 1.0, 8433.000, 10, 1, 631
    ),
    (
        85794, 2.0, 33049.000, 3, 2, 352
    ),
    (
        85799, 4.0, 18220.000, 2, 5, 115
    ),
    (
        85800, 5.0, 9563.000, 7, 2, 701
    ),
    (
        85801, 3.0, 20796.000, 5, 2, 300
    ),
    (
        85810, 5.0, 6771.000, 4, 2, 835
    ),
    (
        85824, 2.0, 14563.000, 3, 5, 752
    ),
    (
        85834, 5.0, 23612.000, 8, 1, 587
    ),
    (
        85835, 5.0, 26707.000, 3, 4, 612
    ),
    (
        85836, 2.0, 28217.000, 8, 2, 50
    ),
    (
        85840, 5.0, 19627.000, 10, 1, 261
    ),
    (
        85843, 2.0, 1794.000, 9, 2, 583
    ),
    (
        85850, 4.0, 25065.000, 8, 4, 60
    ),
    (
        85854, 2.0, 8204.000, 6, 4, 505
    ),
    (
        85856, 2.0, 33689.000, 3, 5, 975
    ),
    (
        85858, 4.0, 33075.000, 9, 2, 856
    ),
    (
        85859, 3.0, 24341.000, 3, 5, 865
    ),
    (
        85860, 4.0, 18642.000, 9, 4, 603
    ),
    (
        85861, 1.0, 25461.000, 5, 4, 788
    ),
    (85862, 3.0, 9222.000, 8, 1, 4),
    (
        85864, 5.0, 3976.000, 9, 2, 138
    ),
    (
        85868, 3.0, 27225.000, 3, 4, 956
    ),
    (
        85871, 2.0, 10906.000, 3, 5, 119
    ),
    (
        85875, 3.0, 20848.000, 3, 2, 261
    ),
    (
        85880, 1.0, 9071.000, 10, 1, 153
    ),
    (
        85887, 5.0, 724.000, 4, 3, 761
    ),
    (
        85889, 2.0, 1556.000, 3, 4, 619
    ),
    (85890, 3.0, 47.000, 4, 3, 396),
    (
        85901, 4.0, 8788.000, 8, 5, 470
    ),
    (
        85906, 4.0, 28514.000, 1, 3, 35
    ),
    (
        85907, 2.0, 13477.000, 2, 2, 872
    ),
    (
        85910, 1.0, 16010.000, 2, 1, 797
    ),
    (
        85912, 2.0, 16526.000, 7, 4, 837
    ),
    (
        85923, 1.0, 13917.000, 9, 1, 858
    ),
    (
        85924, 1.0, 18181.000, 6, 3, 354
    ),
    (
        85927, 5.0, 1305.000, 4, 4, 528
    ),
    (
        85934, 3.0, 19443.000, 2, 1, 3
    ),
    (
        85938, 2.0, 15128.000, 2, 2, 271
    ),
    (
        85939, 2.0, 31491.000, 6, 2, 69
    ),
    (
        85945, 4.0, 11119.000, 5, 2, 638
    ),
    (
        85946, 4.0, 7483.000, 3, 3, 533
    ),
    (
        85951, 2.0, 17456.000, 10, 2, 787
    ),
    (
        85955, 4.0, 19872.000, 4, 1, 480
    ),
    (
        85958, 2.0, 9777.000, 8, 2, 17
    ),
    (
        85976, 4.0, 29217.000, 4, 1, 372
    ),
    (
        85978, 3.0, 10227.000, 2, 4, 730
    ),
    (
        85982, 2.0, 2955.000, 5, 2, 657
    ),
    (
        85986, 2.0, 2849.000, 4, 2, 242
    ),
    (
        85993, 2.0, 20620.000, 1, 2, 21
    ),
    (
        85994, 3.0, 11168.000, 3, 1, 682
    ),
    (
        85995, 2.0, 2307.000, 7, 2, 752
    ),
    (
        86000, 1.0, 6881.000, 9, 5, 756
    ),
    (
        86003, 4.0, 30199.000, 9, 5, 9
    ),
    (
        86016, 5.0, 9936.000, 8, 5, 582
    ),
    (
        86021, 2.0, 30336.000, 6, 2, 518
    ),
    (
        86024, 3.0, 2409.000, 2, 2, 598
    ),
    (
        86026, 2.0, 5785.000, 10, 3, 275
    ),
    (
        86035, 4.0, 33996.000, 7, 3, 74
    ),
    (
        86038, 1.0, 4313.000, 6, 2, 298
    ),
    (
        86058, 1.0, 12609.000, 6, 3, 308
    ),
    (
        86060, 2.0, 12467.000, 10, 4, 525
    ),
    (
        86067, 2.0, 592.000, 5, 1, 107
    ),
    (
        86074, 4.0, 608.000, 1, 5, 891
    ),
    (
        86075, 3.0, 29106.000, 8, 2, 956
    ),
    (
        86076, 1.0, 10184.000, 5, 1, 229
    ),
    (
        86078, 2.0, 33019.000, 8, 4, 529
    ),
    (
        86079, 3.0, 15535.000, 2, 5, 445
    ),
    (
        86086, 3.0, 18880.000, 6, 5, 363
    ),
    (
        86087, 4.0, 3539.000, 1, 4, 559
    ),
    (
        86089, 4.0, 8400.000, 7, 3, 932
    ),
    (
        86092, 2.0, 17342.000, 5, 3, 805
    ),
    (
        86093, 2.0, 14485.000, 7, 4, 372
    ),
    (
        86095, 2.0, 30781.000, 6, 2, 794
    ),
    (
        86098, 4.0, 12394.000, 9, 2, 226
    ),
    (
        86100, 3.0, 15242.000, 9, 4, 704
    ),
    (
        86108, 4.0, 33018.000, 5, 2, 325
    ),
    (
        86111, 3.0, 6161.000, 5, 4, 749
    ),
    (
        86115, 5.0, 13641.000, 4, 2, 117
    ),
    (
        86116, 1.0, 23469.000, 5, 1, 78
    ),
    (
        86119, 2.0, 23770.000, 10, 5, 498
    ),
    (
        86125, 3.0, 30571.000, 2, 5, 187
    ),
    (
        86130, 5.0, 5311.000, 10, 3, 592
    ),
    (
        86135, 2.0, 149.000, 10, 4, 719
    ),
    (
        86137, 5.0, 11196.000, 10, 5, 597
    ),
    (
        86143, 2.0, 6518.000, 4, 2, 96
    ),
    (
        86144, 4.0, 18737.000, 5, 3, 701
    ),
    (
        86145, 4.0, 8112.000, 3, 2, 561
    ),
    (
        86147, 4.0, 5254.000, 5, 5, 71
    ),
    (
        86153, 2.0, 27362.000, 5, 5, 76
    ),
    (
        86162, 4.0, 13625.000, 9, 2, 994
    ),
    (
        86165, 4.0, 29067.000, 4, 1, 74
    ),
    (
        86169, 1.0, 20766.000, 8, 2, 805
    ),
    (
        86172, 4.0, 25409.000, 3, 5, 65
    ),
    (
        86176, 3.0, 27982.000, 4, 3, 888
    ),
    (
        86180, 4.0, 289.000, 1, 1, 163
    ),
    (
        86181, 4.0, 32634.000, 8, 4, 696
    ),
    (
        86183, 3.0, 33192.000, 6, 5, 946
    ),
    (
        86190, 3.0, 30366.000, 3, 2, 353
    ),
    (
        86191, 2.0, 5782.000, 2, 1, 937
    ),
    (
        86195, 3.0, 32666.000, 10, 1, 476
    ),
    (
        86199, 3.0, 4205.000, 1, 4, 483
    ),
    (
        86208, 4.0, 30887.000, 6, 1, 835
    ),
    (
        86211, 2.0, 17070.000, 8, 3, 548
    ),
    (
        86213, 5.0, 14292.000, 4, 4, 35
    ),
    (
        86217, 3.0, 11666.000, 6, 4, 646
    ),
    (
        86233, 3.0, 8756.000, 8, 1, 911
    ),
    (
        86234, 3.0, 15221.000, 9, 2, 740
    ),
    (
        86239, 3.0, 33718.000, 4, 5, 426
    ),
    (
        86247, 4.0, 17404.000, 4, 1, 502
    ),
    (
        86252, 2.0, 25865.000, 8, 4, 366
    ),
    (
        86259, 3.0, 12660.000, 5, 2, 702
    ),
    (
        86263, 2.0, 19169.000, 4, 5, 454
    ),
    (
        86267, 2.0, 16434.000, 10, 3, 561
    ),
    (
        86278, 5.0, 24309.000, 6, 5, 711
    ),
    (
        86280, 3.0, 18423.000, 9, 5, 860
    ),
    (
        86284, 4.0, 14217.000, 3, 4, 7
    ),
    (
        86290, 5.0, 27174.000, 3, 3, 920
    ),
    (
        86293, 2.0, 17495.000, 8, 2, 448
    ),
    (
        86294, 4.0, 29921.000, 9, 4, 884
    ),
    (
        86295, 2.0, 33234.000, 9, 3, 373
    ),
    (
        86302, 3.0, 10343.000, 7, 3, 815
    ),
    (
        86303, 2.0, 6668.000, 10, 3, 961
    ),
    (
        86305, 5.0, 30351.000, 8, 2, 663
    ),
    (
        86309, 5.0, 20191.000, 2, 4, 67
    ),
    (
        86312, 4.0, 16440.000, 1, 3, 842
    ),
    (
        86314, 1.0, 19533.000, 8, 3, 427
    ),
    (
        86316, 4.0, 27980.000, 6, 3, 12
    ),
    (
        86321, 1.0, 19283.000, 5, 4, 351
    ),
    (
        86322, 3.0, 7283.000, 7, 5, 449
    ),
    (
        86329, 3.0, 7583.000, 8, 2, 652
    ),
    (
        86344, 4.0, 32375.000, 3, 3, 708
    ),
    (86345, 1.0, 21.000, 9, 4, 414),
    (
        86348, 3.0, 19332.000, 6, 1, 604
    ),
    (
        86354, 5.0, 4094.000, 6, 4, 620
    ),
    (
        86367, 2.0, 23175.000, 10, 4, 723
    ),
    (
        86368, 3.0, 5488.000, 5, 3, 584
    ),
    (
        86369, 2.0, 13508.000, 4, 2, 602
    ),
    (
        86379, 3.0, 31651.000, 2, 4, 874
    ),
    (
        86385, 3.0, 14101.000, 5, 4, 881
    ),
    (
        86399, 5.0, 2191.000, 7, 5, 726
    ),
    (
        86402, 1.0, 23208.000, 2, 4, 122
    ),
    (
        86405, 3.0, 32277.000, 6, 1, 614
    ),
    (
        86406, 4.0, 13514.000, 5, 1, 818
    ),
    (
        86408, 1.0, 27333.000, 7, 5, 733
    ),
    (
        86417, 2.0, 22438.000, 3, 5, 330
    ),
    (
        86418, 4.0, 17655.000, 5, 5, 51
    ),
    (
        86423, 4.0, 4375.000, 6, 2, 162
    ),
    (
        86425, 4.0, 2995.000, 3, 1, 585
    ),
    (
        86429, 1.0, 15842.000, 2, 1, 994
    ),
    (
        86433, 5.0, 32516.000, 9, 4, 82
    ),
    (
        86437, 4.0, 1422.000, 2, 2, 804
    ),
    (
        86438, 3.0, 23440.000, 3, 4, 757
    ),
    (
        86442, 3.0, 5802.000, 4, 3, 748
    ),
    (
        86446, 2.0, 8457.000, 7, 3, 200
    ),
    (
        86448, 2.0, 33721.000, 10, 5, 835
    ),
    (
        86457, 2.0, 9275.000, 6, 1, 721
    ),
    (
        86458, 2.0, 15117.000, 3, 5, 45
    ),
    (
        86464, 2.0, 24678.000, 6, 3, 923
    ),
    (
        86465, 1.0, 23742.000, 3, 5, 185
    ),
    (
        86468, 2.0, 33086.000, 4, 3, 121
    ),
    (
        86469, 4.0, 18248.000, 4, 1, 540
    ),
    (
        86476, 3.0, 24027.000, 1, 5, 591
    ),
    (
        86478, 4.0, 18756.000, 7, 5, 418
    ),
    (
        86485, 5.0, 10527.000, 8, 1, 946
    ),
    (
        86502, 2.0, 21233.000, 7, 3, 902
    ),
    (
        86521, 1.0, 9985.000, 5, 1, 357
    ),
    (
        86526, 2.0, 29269.000, 6, 3, 241
    ),
    (
        86544, 2.0, 17464.000, 7, 5, 360
    ),
    (
        86547, 3.0, 3489.000, 7, 2, 588
    ),
    (
        86548, 3.0, 32991.000, 3, 2, 116
    ),
    (
        86549, 1.0, 9178.000, 10, 1, 535
    ),
    (
        86550, 3.0, 11296.000, 5, 3, 994
    ),
    (
        86554, 2.0, 29437.000, 9, 5, 704
    ),
    (
        86555, 5.0, 11006.000, 10, 4, 193
    ),
    (
        86557, 3.0, 13986.000, 6, 3, 304
    ),
    (
        86565, 2.0, 12704.000, 2, 2, 317
    ),
    (
        86566, 4.0, 7443.000, 3, 2, 990
    ),
    (
        86567, 1.0, 2283.000, 4, 2, 876
    ),
    (
        86568, 2.0, 28090.000, 3, 4, 294
    ),
    (
        86569, 1.0, 8435.000, 2, 1, 873
    ),
    (
        86575, 5.0, 30758.000, 8, 5, 731
    ),
    (
        86583, 5.0, 17419.000, 6, 3, 400
    ),
    (
        86597, 2.0, 1497.000, 5, 2, 628
    ),
    (
        86610, 4.0, 31202.000, 7, 3, 744
    ),
    (
        86614, 5.0, 15337.000, 4, 3, 989
    ),
    (
        86615, 4.0, 20782.000, 9, 4, 849
    ),
    (
        86617, 4.0, 29963.000, 2, 4, 945
    ),
    (
        86622, 3.0, 5165.000, 4, 2, 355
    ),
    (
        86624, 4.0, 31165.000, 1, 3, 459
    ),
    (
        86627, 5.0, 26576.000, 3, 5, 78
    ),
    (
        86634, 4.0, 25095.000, 6, 3, 801
    ),
    (
        86636, 4.0, 5156.000, 4, 1, 537
    ),
    (86650, 5.0, 2143.000, 7, 5, 8),
    (
        86653, 1.0, 5902.000, 7, 4, 799
    ),
    (
        86655, 3.0, 9432.000, 1, 3, 47
    ),
    (
        86663, 1.0, 22522.000, 3, 1, 633
    ),
    (
        86668, 3.0, 2535.000, 2, 3, 675
    ),
    (
        86674, 2.0, 28086.000, 4, 1, 598
    ),
    (
        86675, 4.0, 17160.000, 6, 2, 400
    ),
    (
        86677, 4.0, 9451.000, 1, 3, 949
    ),
    (
        86683, 4.0, 28521.000, 8, 1, 352
    ),
    (
        86685, 2.0, 31469.000, 1, 2, 219
    ),
    (
        86686, 2.0, 3642.000, 5, 1, 913
    ),
    (
        86688, 1.0, 11884.000, 8, 3, 771
    ),
    (
        86691, 3.0, 24799.000, 2, 2, 463
    ),
    (
        86692, 2.0, 27312.000, 4, 1, 595
    ),
    (
        86695, 2.0, 32018.000, 9, 5, 561
    ),
    (
        86703, 3.0, 10941.000, 10, 5, 794
    ),
    (
        86704, 2.0, 8354.000, 9, 3, 44
    ),
    (
        86727, 1.0, 17741.000, 4, 5, 706
    ),
    (
        86729, 4.0, 29395.000, 5, 3, 722
    ),
    (
        86730, 3.0, 5268.000, 4, 3, 98
    ),
    (
        86732, 2.0, 29540.000, 5, 3, 724
    ),
    (
        86740, 2.0, 18616.000, 10, 2, 156
    ),
    (
        86742, 3.0, 26473.000, 2, 1, 940
    ),
    (
        86743, 3.0, 6852.000, 3, 2, 252
    ),
    (
        86756, 4.0, 6476.000, 8, 2, 323
    ),
    (
        86763, 2.0, 7305.000, 6, 5, 877
    ),
    (
        86766, 2.0, 21557.000, 7, 2, 716
    ),
    (
        86767, 3.0, 26303.000, 2, 2, 948
    ),
    (
        86770, 4.0, 2672.000, 5, 5, 425
    ),
    (
        86772, 4.0, 25747.000, 7, 4, 240
    ),
    (
        86777, 2.0, 7833.000, 3, 2, 421
    ),
    (
        86779, 4.0, 17905.000, 2, 1, 820
    ),
    (
        86782, 5.0, 30156.000, 6, 1, 714
    ),
    (
        86784, 1.0, 2352.000, 1, 5, 371
    ),
    (
        86785, 2.0, 29790.000, 8, 2, 190
    ),
    (
        86787, 4.0, 24671.000, 3, 1, 775
    ),
    (
        86800, 2.0, 21649.000, 6, 4, 506
    ),
    (
        86801, 1.0, 22953.000, 3, 2, 596
    ),
    (
        86803, 4.0, 27873.000, 8, 3, 538
    ),
    (
        86809, 2.0, 28303.000, 7, 4, 121
    ),
    (
        86811, 4.0, 31915.000, 2, 5, 320
    ),
    (
        86812, 4.0, 22836.000, 3, 5, 904
    ),
    (
        86813, 4.0, 18883.000, 3, 3, 416
    ),
    (
        86817, 5.0, 20650.000, 4, 5, 557
    ),
    (
        86822, 3.0, 26980.000, 5, 3, 775
    ),
    (
        86828, 5.0, 15466.000, 5, 5, 237
    ),
    (
        86831, 3.0, 12359.000, 3, 1, 491
    ),
    (
        86832, 2.0, 10185.000, 5, 2, 74
    ),
    (
        86836, 2.0, 17656.000, 7, 5, 420
    ),
    (
        86840, 1.0, 2478.000, 4, 3, 917
    ),
    (
        86843, 1.0, 26939.000, 9, 1, 920
    ),
    (
        86844, 2.0, 12510.000, 2, 4, 86
    ),
    (
        86851, 5.0, 30042.000, 5, 3, 714
    ),
    (
        86859, 1.0, 31996.000, 6, 5, 807
    ),
    (
        86862, 1.0, 6870.000, 8, 3, 261
    ),
    (
        86865, 3.0, 12927.000, 5, 1, 26
    ),
    (
        86866, 5.0, 16635.000, 7, 1, 244
    ),
    (
        86867, 5.0, 8158.000, 3, 2, 210
    ),
    (
        86875, 4.0, 4863.000, 5, 4, 776
    ),
    (
        86889, 2.0, 18887.000, 4, 4, 158
    ),
    (
        86891, 3.0, 18177.000, 8, 3, 102
    ),
    (
        86895, 4.0, 15638.000, 9, 1, 740
    ),
    (
        86899, 2.0, 20437.000, 1, 3, 103
    ),
    (
        86902, 5.0, 3928.000, 7, 2, 909
    ),
    (
        86910, 3.0, 14903.000, 7, 1, 343
    ),
    (
        86921, 3.0, 29322.000, 2, 1, 879
    ),
    (
        86922, 2.0, 18812.000, 1, 3, 840
    ),
    (
        86931, 3.0, 15548.000, 7, 1, 264
    ),
    (
        86932, 1.0, 27495.000, 7, 5, 936
    ),
    (
        86941, 4.0, 1058.000, 2, 4, 58
    ),
    (
        86945, 2.0, 4101.000, 7, 1, 235
    ),
    (
        86948, 1.0, 31882.000, 6, 1, 620
    ),
    (
        86952, 2.0, 32434.000, 8, 5, 434
    ),
    (
        86961, 3.0, 30824.000, 9, 4, 334
    ),
    (
        86963, 2.0, 4939.000, 7, 1, 307
    ),
    (
        86964, 2.0, 16325.000, 6, 2, 157
    ),
    (
        86969, 4.0, 30437.000, 9, 1, 250
    ),
    (
        86970, 2.0, 9174.000, 8, 5, 216
    ),
    (
        86972, 2.0, 31045.000, 7, 4, 221
    ),
    (
        86979, 3.0, 16545.000, 2, 1, 824
    ),
    (
        86986, 4.0, 19036.000, 4, 4, 234
    ),
    (
        86989, 5.0, 18214.000, 8, 3, 773
    ),
    (
        86990, 3.0, 13753.000, 4, 4, 470
    ),
    (
        86994, 1.0, 5814.000, 6, 2, 273
    ),
    (
        86995, 4.0, 11004.000, 2, 4, 105
    ),
    (
        86998, 3.0, 20978.000, 8, 5, 473
    ),
    (
        87004, 5.0, 14870.000, 4, 3, 968
    ),
    (
        87009, 4.0, 31591.000, 6, 1, 691
    ),
    (
        87013, 3.0, 18101.000, 2, 5, 126
    ),
    (
        87023, 5.0, 11949.000, 10, 5, 608
    ),
    (
        87024, 2.0, 20020.000, 2, 4, 313
    ),
    (
        87028, 4.0, 18902.000, 6, 2, 176
    ),
    (
        87029, 2.0, 7034.000, 10, 2, 789
    ),
    (
        87035, 4.0, 17779.000, 4, 4, 502
    ),
    (
        87038, 2.0, 2761.000, 4, 2, 61
    ),
    (
        87040, 3.0, 4340.000, 4, 2, 914
    ),
    (
        87042, 3.0, 12180.000, 1, 1, 462
    ),
    (
        87043, 5.0, 14288.000, 3, 4, 512
    ),
    (
        87044, 1.0, 25517.000, 6, 4, 530
    ),
    (
        87045, 4.0, 27935.000, 2, 4, 56
    ),
    (
        87050, 4.0, 19045.000, 9, 4, 716
    ),
    (
        87053, 3.0, 33066.000, 4, 4, 567
    ),
    (
        87072, 2.0, 22834.000, 7, 2, 662
    ),
    (
        87078, 2.0, 33170.000, 4, 4, 627
    ),
    (
        87079, 5.0, 31628.000, 8, 1, 890
    ),
    (
        87080, 2.0, 410.000, 1, 2, 957
    ),
    (
        87084, 4.0, 7158.000, 7, 4, 840
    ),
    (
        87087, 3.0, 32573.000, 5, 2, 923
    ),
    (
        87091, 3.0, 5877.000, 8, 2, 586
    ),
    (
        87106, 5.0, 23181.000, 6, 5, 663
    ),
    (
        87107, 4.0, 10605.000, 6, 5, 85
    ),
    (
        87108, 3.0, 12532.000, 3, 2, 435
    ),
    (
        87131, 3.0, 12837.000, 6, 3, 892
    ),
    (
        87135, 4.0, 22337.000, 9, 4, 897
    ),
    (
        87154, 2.0, 21689.000, 8, 5, 133
    ),
    (
        87157, 4.0, 26324.000, 3, 1, 346
    ),
    (
        87159, 4.0, 9605.000, 2, 3, 86
    ),
    (
        87166, 4.0, 6872.000, 6, 1, 640
    ),
    (
        87170, 2.0, 16771.000, 7, 4, 94
    ),
    (
        87181, 2.0, 11599.000, 9, 2, 671
    ),
    (
        87182, 3.0, 1949.000, 5, 1, 926
    ),
    (
        87183, 3.0, 20349.000, 6, 1, 470
    ),
    (
        87186, 3.0, 33285.000, 5, 3, 900
    ),
    (
        87190, 5.0, 17322.000, 6, 3, 715
    ),
    (
        87192, 3.0, 11283.000, 1, 1, 354
    ),
    (
        87193, 3.0, 19577.000, 4, 4, 911
    ),
    (
        87195, 1.0, 5234.000, 5, 4, 857
    ),
    (
        87201, 4.0, 22450.000, 8, 5, 281
    ),
    (
        87215, 4.0, 26750.000, 10, 3, 75
    ),
    (
        87226, 3.0, 21138.000, 9, 3, 273
    ),
    (
        87231, 1.0, 17578.000, 4, 2, 410
    ),
    (
        87233, 3.0, 7544.000, 6, 2, 970
    ),
    (
        87241, 2.0, 5841.000, 9, 4, 834
    ),
    (
        87249, 2.0, 22805.000, 7, 1, 459
    ),
    (
        87261, 4.0, 31854.000, 4, 4, 349
    ),
    (
        87262, 2.0, 20005.000, 6, 1, 538
    ),
    (
        87263, 3.0, 5234.000, 2, 1, 108
    ),
    (
        87267, 2.0, 21595.000, 8, 1, 823
    ),
    (
        87268, 1.0, 18168.000, 7, 4, 728
    ),
    (
        87271, 2.0, 27263.000, 3, 5, 849
    ),
    (
        87283, 3.0, 31978.000, 2, 5, 134
    ),
    (
        87285, 3.0, 23066.000, 2, 2, 475
    ),
    (
        87288, 1.0, 32170.000, 5, 3, 623
    ),
    (
        87293, 2.0, 33887.000, 3, 1, 943
    ),
    (
        87297, 3.0, 17416.000, 2, 1, 888
    ),
    (
        87298, 2.0, 27785.000, 3, 3, 87
    ),
    (
        87303, 5.0, 6758.000, 2, 5, 105
    ),
    (
        87306, 4.0, 33068.000, 7, 3, 475
    ),
    (
        87310, 1.0, 1181.000, 1, 2, 516
    ),
    (
        87311, 2.0, 12330.000, 3, 2, 465
    ),
    (
        87316, 4.0, 24923.000, 2, 2, 989
    ),
    (
        87320, 1.0, 28279.000, 8, 3, 794
    ),
    (
        87323, 3.0, 19316.000, 5, 3, 188
    ),
    (
        87331, 5.0, 25173.000, 8, 4, 213
    ),
    (
        87336, 1.0, 12677.000, 7, 5, 59
    ),
    (
        87339, 2.0, 29476.000, 8, 2, 857
    ),
    (
        87349, 2.0, 31591.000, 6, 4, 615
    ),
    (
        87357, 1.0, 14921.000, 9, 5, 978
    ),
    (
        87358, 2.0, 33487.000, 4, 5, 444
    ),
    (
        87361, 4.0, 27975.000, 7, 4, 142
    ),
    (
        87363, 3.0, 30720.000, 7, 3, 810
    ),
    (
        87367, 4.0, 26073.000, 6, 2, 131
    ),
    (
        87369, 3.0, 32748.000, 4, 4, 311
    ),
    (
        87370, 3.0, 4680.000, 9, 4, 557
    ),
    (
        87372, 1.0, 2314.000, 10, 4, 496
    ),
    (
        87373, 3.0, 20603.000, 8, 1, 959
    ),
    (
        87375, 3.0, 551.000, 6, 5, 918
    ),
    (
        87380, 2.0, 21540.000, 3, 1, 967
    ),
    (
        87388, 2.0, 30451.000, 5, 4, 948
    ),
    (
        87391, 5.0, 13432.000, 4, 3, 381
    ),
    (
        87396, 5.0, 6164.000, 1, 3, 666
    ),
    (
        87398, 5.0, 12249.000, 3, 4, 336
    ),
    (
        87402, 2.0, 32354.000, 8, 2, 292
    ),
    (
        87403, 1.0, 11728.000, 6, 5, 887
    ),
    (
        87406, 4.0, 13452.000, 5, 5, 460
    ),
    (
        87420, 2.0, 6776.000, 6, 1, 790
    ),
    (
        87427, 2.0, 15138.000, 8, 3, 881
    ),
    (
        87435, 3.0, 7299.000, 9, 4, 641
    ),
    (
        87436, 3.0, 1435.000, 5, 1, 891
    ),
    (
        87438, 3.0, 23539.000, 8, 5, 540
    ),
    (
        87444, 4.0, 26307.000, 7, 1, 410
    ),
    (
        87448, 1.0, 16162.000, 4, 1, 277
    ),
    (
        87452, 5.0, 5774.000, 9, 5, 103
    ),
    (
        87466, 2.0, 28699.000, 5, 3, 601
    ),
    (
        87470, 4.0, 13199.000, 8, 5, 996
    ),
    (
        87471, 2.0, 21407.000, 3, 1, 471
    ),
    (
        87472, 2.0, 11505.000, 7, 2, 46
    ),
    (
        87474, 1.0, 16391.000, 4, 3, 209
    ),
    (
        87490, 3.0, 23013.000, 2, 2, 551
    ),
    (
        87503, 4.0, 12247.000, 9, 2, 264
    ),
    (
        87505, 3.0, 4749.000, 2, 1, 791
    ),
    (
        87514, 4.0, 29097.000, 2, 2, 684
    ),
    (
        87515, 4.0, 18486.000, 6, 2, 214
    ),
    (
        87519, 4.0, 20667.000, 1, 2, 207
    ),
    (
        87522, 2.0, 28423.000, 6, 2, 356
    ),
    (
        87528, 2.0, 16067.000, 8, 3, 943
    ),
    (
        87539, 2.0, 3087.000, 1, 4, 986
    ),
    (
        87543, 5.0, 8236.000, 4, 4, 935
    ),
    (
        87544, 3.0, 2582.000, 3, 1, 390
    ),
    (
        87550, 4.0, 16299.000, 9, 2, 306
    ),
    (
        87554, 1.0, 25122.000, 7, 1, 313
    ),
    (
        87560, 1.0, 3806.000, 4, 2, 800
    ),
    (
        87566, 2.0, 17593.000, 2, 4, 921
    ),
    (
        87567, 1.0, 27785.000, 8, 2, 960
    ),
    (
        87568, 1.0, 20349.000, 7, 4, 553
    ),
    (
        87570, 3.0, 19603.000, 6, 5, 246
    ),
    (
        87582, 3.0, 30651.000, 8, 2, 834
    ),
    (
        87583, 3.0, 25147.000, 4, 3, 686
    ),
    (87586, 2.0, 7130.000, 4, 2, 7),
    (
        87590, 2.0, 14073.000, 4, 2, 738
    ),
    (
        87596, 4.0, 28475.000, 4, 1, 269
    ),
    (
        87597, 2.0, 10293.000, 9, 2, 139
    ),
    (
        87599, 3.0, 737.000, 7, 2, 438
    ),
    (
        87602, 1.0, 7664.000, 9, 4, 515
    ),
    (
        87603, 1.0, 21894.000, 2, 3, 682
    ),
    (
        87605, 3.0, 4374.000, 9, 5, 163
    ),
    (
        87608, 1.0, 11681.000, 6, 1, 270
    ),
    (
        87609, 2.0, 21009.000, 3, 2, 896
    ),
    (
        87615, 3.0, 13675.000, 6, 4, 49
    ),
    (
        87620, 3.0, 24097.000, 3, 4, 573
    ),
    (
        87625, 2.0, 5782.000, 2, 1, 941
    ),
    (
        87630, 3.0, 21494.000, 8, 5, 523
    ),
    (
        87637, 2.0, 28838.000, 4, 3, 769
    ),
    (
        87638, 4.0, 4769.000, 7, 4, 812
    ),
    (
        87643, 3.0, 13074.000, 4, 3, 519
    ),
    (
        87651, 4.0, 3949.000, 3, 5, 944
    ),
    (
        87658, 2.0, 3305.000, 6, 4, 752
    ),
    (
        87661, 3.0, 16489.000, 7, 2, 592
    ),
    (
        87665, 4.0, 22104.000, 8, 4, 761
    ),
    (
        87675, 4.0, 14859.000, 4, 2, 940
    ),
    (
        87678, 4.0, 6623.000, 8, 2, 621
    ),
    (
        87682, 1.0, 6080.000, 7, 5, 618
    ),
    (
        87684, 4.0, 7439.000, 7, 3, 950
    ),
    (
        87690, 2.0, 12908.000, 2, 2, 769
    ),
    (
        87692, 3.0, 18123.000, 2, 1, 658
    ),
    (
        87694, 5.0, 23262.000, 8, 5, 106
    ),
    (
        87697, 2.0, 19235.000, 8, 3, 766
    ),
    (
        87700, 5.0, 19055.000, 8, 2, 320
    ),
    (
        87704, 5.0, 27786.000, 2, 2, 288
    ),
    (
        87719, 4.0, 30069.000, 10, 1, 734
    ),
    (
        87720, 2.0, 12103.000, 9, 2, 249
    ),
    (
        87721, 4.0, 4012.000, 3, 1, 210
    ),
    (
        87722, 1.0, 17810.000, 6, 1, 772
    ),
    (
        87723, 4.0, 31025.000, 7, 3, 67
    ),
    (
        87727, 5.0, 11742.000, 9, 2, 882
    ),
    (
        87734, 3.0, 21976.000, 1, 1, 435
    ),
    (
        87741, 3.0, 3364.000, 3, 5, 722
    ),
    (
        87751, 1.0, 10198.000, 3, 3, 315
    ),
    (
        87757, 1.0, 5142.000, 5, 4, 893
    ),
    (
        87776, 4.0, 20018.000, 7, 2, 913
    ),
    (
        87783, 4.0, 874.000, 8, 4, 678
    ),
    (
        87785, 1.0, 12770.000, 8, 3, 750
    ),
    (
        87789, 4.0, 1371.000, 2, 2, 566
    ),
    (
        87796, 4.0, 17198.000, 4, 2, 626
    ),
    (
        87798, 4.0, 6534.000, 6, 2, 733
    ),
    (
        87817, 4.0, 7146.000, 7, 3, 688
    ),
    (
        87821, 5.0, 33676.000, 2, 3, 955
    ),
    (
        87825, 2.0, 33188.000, 1, 1, 456
    ),
    (
        87828, 5.0, 33295.000, 1, 2, 685
    ),
    (
        87833, 4.0, 14113.000, 3, 4, 667
    ),
    (
        87834, 3.0, 2258.000, 2, 2, 47
    ),
    (
        87846, 1.0, 11879.000, 6, 5, 689
    ),
    (
        87850, 4.0, 18570.000, 5, 3, 235
    ),
    (
        87853, 5.0, 8416.000, 4, 4, 689
    ),
    (
        87856, 3.0, 21189.000, 4, 4, 970
    ),
    (
        87858, 3.0, 13965.000, 7, 5, 626
    ),
    (
        87859, 3.0, 8355.000, 10, 1, 328
    ),
    (
        87879, 2.0, 733.000, 6, 5, 986
    ),
    (
        87882, 5.0, 3341.000, 7, 4, 269
    ),
    (
        87887, 3.0, 17210.000, 1, 4, 255
    ),
    (
        87899, 3.0, 31292.000, 3, 1, 22
    ),
    (
        87900, 4.0, 28319.000, 8, 4, 700
    ),
    (
        87904, 4.0, 21647.000, 9, 4, 630
    ),
    (
        87911, 4.0, 16481.000, 9, 1, 487
    ),
    (
        87917, 4.0, 1639.000, 8, 4, 904
    ),
    (
        87936, 4.0, 1638.000, 2, 3, 305
    ),
    (
        87947, 2.0, 8435.000, 2, 1, 851
    ),
    (
        87965, 3.0, 22859.000, 7, 2, 327
    ),
    (
        87971, 4.0, 14071.000, 3, 3, 589
    ),
    (
        87974, 2.0, 14883.000, 3, 1, 498
    ),
    (
        87975, 2.0, 32810.000, 10, 4, 450
    ),
    (
        87978, 2.0, 13044.000, 9, 2, 67
    ),
    (
        87979, 2.0, 5017.000, 9, 2, 251
    ),
    (
        87982, 4.0, 15882.000, 10, 3, 340
    ),
    (
        87984, 4.0, 24527.000, 5, 1, 812
    ),
    (
        87986, 4.0, 32169.000, 6, 1, 505
    ),
    (
        87988, 4.0, 32232.000, 3, 2, 526
    ),
    (
        87990, 3.0, 5092.000, 10, 2, 600
    ),
    (
        87993, 2.0, 24208.000, 1, 1, 944
    ),
    (
        88000, 2.0, 27479.000, 2, 5, 515
    ),
    (
        88008, 2.0, 27312.000, 9, 2, 429
    ),
    (
        88010, 5.0, 26435.000, 3, 3, 24
    ),
    (
        88016, 2.0, 26981.000, 9, 2, 209
    ),
    (
        88017, 3.0, 24741.000, 3, 5, 79
    ),
    (
        88020, 4.0, 1001.000, 3, 1, 780
    ),
    (
        88023, 3.0, 10979.000, 10, 5, 728
    ),
    (
        88029, 2.0, 29682.000, 9, 4, 912
    ),
    (
        88032, 3.0, 27230.000, 2, 3, 504
    ),
    (
        88034, 1.0, 2747.000, 2, 2, 492
    ),
    (
        88037, 4.0, 6462.000, 8, 3, 401
    ),
    (
        88039, 2.0, 23010.000, 10, 4, 141
    ),
    (
        88040, 2.0, 32345.000, 9, 4, 270
    ),
    (
        88046, 2.0, 27970.000, 2, 1, 18
    ),
    (
        88047, 5.0, 12121.000, 2, 3, 693
    ),
    (
        88048, 3.0, 30962.000, 8, 1, 73
    ),
    (
        88049, 2.0, 18136.000, 3, 3, 758
    ),
    (
        88056, 3.0, 24748.000, 3, 5, 935
    ),
    (
        88060, 3.0, 23266.000, 6, 4, 228
    ),
    (
        88061, 4.0, 6962.000, 7, 4, 156
    ),
    (
        88069, 2.0, 18998.000, 5, 3, 713
    ),
    (
        88072, 4.0, 8798.000, 7, 4, 490
    ),
    (
        88077, 5.0, 17262.000, 7, 4, 197
    ),
    (
        88079, 3.0, 28890.000, 8, 2, 632
    ),
    (
        88099, 4.0, 15236.000, 2, 5, 543
    ),
    (
        88102, 5.0, 9087.000, 4, 5, 688
    ),
    (
        88106, 4.0, 28209.000, 2, 2, 502
    ),
    (
        88107, 5.0, 11082.000, 8, 4, 195
    ),
    (
        88112, 4.0, 2010.000, 8, 3, 808
    ),
    (
        88113, 2.0, 17395.000, 10, 3, 276
    ),
    (
        88119, 3.0, 20513.000, 4, 4, 555
    ),
    (
        88131, 2.0, 24869.000, 8, 5, 114
    ),
    (
        88134, 3.0, 15538.000, 1, 4, 169
    ),
    (
        88137, 4.0, 17817.000, 4, 2, 851
    ),
    (
        88142, 5.0, 22663.000, 7, 2, 120
    ),
    (
        88145, 1.0, 12598.000, 7, 3, 240
    ),
    (
        88150, 4.0, 17948.000, 2, 4, 387
    ),
    (
        88153, 3.0, 5876.000, 6, 2, 772
    ),
    (
        88155, 4.0, 32658.000, 8, 2, 488
    ),
    (
        88156, 5.0, 32212.000, 2, 3, 780
    ),
    (
        88159, 2.0, 7877.000, 4, 2, 750
    ),
    (
        88164, 5.0, 12707.000, 10, 4, 488
    ),
    (
        88166, 2.0, 27880.000, 1, 4, 392
    ),
    (
        88170, 2.0, 4795.000, 7, 1, 316
    ),
    (
        88172, 1.0, 29963.000, 4, 1, 523
    ),
    (
        88173, 2.0, 26025.000, 1, 4, 110
    ),
    (
        88174, 1.0, 28043.000, 1, 4, 361
    ),
    (
        88176, 4.0, 16843.000, 6, 2, 534
    ),
    (
        88178, 2.0, 28954.000, 6, 2, 591
    ),
    (
        88180, 2.0, 12745.000, 4, 2, 613
    ),
    (
        88185, 4.0, 4898.000, 6, 2, 470
    ),
    (
        88190, 3.0, 11664.000, 4, 4, 184
    ),
    (
        88205, 3.0, 3713.000, 9, 2, 717
    ),
    (
        88207, 4.0, 5529.000, 6, 1, 663
    ),
    (
        88212, 3.0, 8730.000, 10, 5, 128
    ),
    (
        88226, 3.0, 32620.000, 4, 4, 288
    ),
    (88231, 3.0, 780.000, 8, 5, 48),
    (
        88234, 5.0, 15074.000, 6, 3, 277
    ),
    (
        88240, 5.0, 16899.000, 5, 5, 381
    ),
    (
        88243, 4.0, 27916.000, 8, 2, 552
    ),
    (
        88244, 4.0, 19828.000, 10, 1, 653
    ),
    (
        88248, 1.0, 16432.000, 4, 2, 612
    ),
    (
        88259, 5.0, 8643.000, 5, 3, 380
    ),
    (
        88263, 1.0, 5403.000, 5, 4, 925
    ),
    (
        88265, 1.0, 29743.000, 2, 1, 892
    ),
    (
        88273, 4.0, 24323.000, 5, 1, 720
    ),
    (
        88274, 3.0, 27805.000, 4, 1, 375
    ),
    (
        88275, 4.0, 13193.000, 9, 1, 531
    ),
    (
        88276, 4.0, 19387.000, 10, 1, 438
    ),
    (
        88279, 4.0, 24632.000, 1, 5, 644
    ),
    (
        88280, 3.0, 557.000, 9, 3, 859
    ),
    (
        88284, 3.0, 4218.000, 1, 4, 946
    ),
    (
        88287, 3.0, 18647.000, 2, 4, 171
    ),
    (
        88289, 5.0, 15400.000, 4, 2, 889
    ),
    (
        88294, 1.0, 27846.000, 8, 3, 828
    ),
    (
        88295, 4.0, 24997.000, 2, 3, 140
    ),
    (
        88302, 5.0, 25192.000, 9, 2, 877
    ),
    (
        88309, 2.0, 32305.000, 9, 2, 188
    ),
    (
        88311, 1.0, 129.000, 9, 2, 486
    ),
    (
        88314, 4.0, 22414.000, 8, 1, 694
    ),
    (
        88318, 5.0, 14536.000, 3, 4, 609
    ),
    (
        88321, 5.0, 25435.000, 9, 2, 57
    ),
    (
        88324, 1.0, 23249.000, 3, 4, 518
    ),
    (
        88325, 2.0, 9926.000, 10, 5, 578
    ),
    (
        88326, 2.0, 13478.000, 4, 2, 763
    ),
    (
        88335, 4.0, 15516.000, 2, 2, 15
    ),
    (
        88337, 2.0, 5573.000, 7, 1, 394
    ),
    (
        88341, 4.0, 14091.000, 10, 3, 712
    ),
    (
        88342, 1.0, 32950.000, 8, 1, 671
    ),
    (
        88347, 5.0, 14703.000, 4, 2, 253
    ),
    (
        88349, 3.0, 25465.000, 2, 2, 191
    ),
    (
        88352, 5.0, 23237.000, 7, 2, 844
    ),
    (
        88356, 2.0, 16023.000, 9, 1, 439
    ),
    (
        88364, 5.0, 24124.000, 8, 3, 694
    ),
    (
        88368, 4.0, 10131.000, 2, 5, 999
    ),
    (
        88370, 4.0, 14259.000, 3, 3, 431
    ),
    (
        88373, 4.0, 31186.000, 6, 2, 450
    ),
    (
        88376, 3.0, 31509.000, 4, 1, 451
    ),
    (
        88380, 2.0, 6035.000, 9, 1, 706
    ),
    (
        88383, 4.0, 7589.000, 2, 5, 535
    ),
    (
        88385, 3.0, 12745.000, 5, 1, 784
    ),
    (
        88389, 3.0, 2855.000, 9, 2, 952
    ),
    (
        88390, 4.0, 27932.000, 9, 1, 496
    ),
    (
        88396, 2.0, 17465.000, 9, 5, 781
    ),
    (
        88399, 2.0, 28363.000, 8, 2, 183
    ),
    (
        88402, 2.0, 24216.000, 6, 4, 237
    ),
    (
        88404, 1.0, 7176.000, 9, 5, 789
    ),
    (
        88418, 4.0, 24014.000, 3, 4, 204
    ),
    (
        88419, 4.0, 10228.000, 2, 5, 973
    ),
    (
        88428, 2.0, 26170.000, 5, 5, 107
    ),
    (
        88430, 1.0, 20177.000, 9, 4, 572
    ),
    (
        88433, 4.0, 8038.000, 8, 1, 278
    ),
    (
        88436, 1.0, 15165.000, 9, 5, 382
    ),
    (
        88439, 3.0, 1478.000, 7, 5, 985
    ),
    (
        88446, 4.0, 4700.000, 4, 3, 20
    ),
    (
        88447, 4.0, 1695.000, 8, 4, 526
    ),
    (
        88454, 4.0, 4615.000, 2, 5, 655
    ),
    (
        88459, 3.0, 28152.000, 4, 1, 634
    ),
    (
        88462, 1.0, 12770.000, 7, 2, 754
    ),
    (
        88465, 1.0, 27333.000, 9, 1, 834
    ),
    (
        88473, 5.0, 17266.000, 7, 4, 34
    ),
    (
        88474, 4.0, 21276.000, 9, 3, 296
    ),
    (
        88477, 2.0, 2498.000, 4, 3, 857
    ),
    (
        88479, 2.0, 24854.000, 6, 3, 281
    ),
    (
        88485, 3.0, 26137.000, 5, 1, 83
    ),
    (
        88486, 1.0, 7615.000, 9, 3, 57
    ),
    (
        88488, 3.0, 14734.000, 8, 2, 666
    ),
    (
        88499, 5.0, 8967.000, 4, 5, 855
    ),
    (
        88500, 2.0, 1812.000, 4, 2, 692
    ),
    (
        88501, 3.0, 16813.000, 9, 2, 42
    ),
    (
        88504, 2.0, 14263.000, 6, 4, 690
    ),
    (
        88508, 3.0, 6148.000, 5, 4, 922
    ),
    (
        88510, 1.0, 21454.000, 2, 3, 458
    ),
    (
        88512, 2.0, 1139.000, 2, 2, 456
    ),
    (
        88521, 3.0, 5740.000, 4, 1, 432
    ),
    (
        88522, 5.0, 11978.000, 10, 4, 124
    ),
    (
        88523, 2.0, 19576.000, 4, 4, 233
    ),
    (
        88528, 1.0, 15082.000, 10, 3, 148
    ),
    (
        88530, 1.0, 11906.000, 6, 4, 638
    ),
    (
        88533, 4.0, 24928.000, 5, 2, 434
    ),
    (
        88546, 1.0, 4516.000, 5, 1, 650
    ),
    (
        88548, 3.0, 2375.000, 1, 1, 147
    ),
    (
        88550, 1.0, 26078.000, 7, 1, 532
    ),
    (
        88556, 4.0, 23900.000, 1, 5, 923
    ),
    (
        88557, 3.0, 11422.000, 8, 1, 948
    ),
    (
        88559, 2.0, 10021.000, 4, 5, 416
    ),
    (
        88571, 3.0, 28892.000, 10, 2, 135
    ),
    (
        88576, 4.0, 26910.000, 2, 5, 424
    ),
    (
        88577, 2.0, 17749.000, 6, 1, 918
    ),
    (
        88582, 5.0, 22065.000, 5, 2, 83
    ),
    (
        88584, 2.0, 334.000, 6, 1, 185
    ),
    (
        88593, 3.0, 28763.000, 9, 1, 321
    ),
    (
        88596, 4.0, 31201.000, 6, 2, 49
    ),
    (
        88599, 4.0, 24941.000, 5, 5, 181
    ),
    (
        88605, 2.0, 11749.000, 7, 1, 340
    ),
    (
        88628, 4.0, 19230.000, 9, 5, 902
    ),
    (
        88629, 4.0, 27005.000, 9, 5, 258
    ),
    (
        88641, 3.0, 32522.000, 6, 4, 130
    ),
    (
        88642, 3.0, 25967.000, 6, 2, 147
    ),
    (
        88646, 3.0, 7226.000, 7, 3, 545
    ),
    (88651, 1.0, 997.000, 9, 2, 51),
    (
        88658, 1.0, 22640.000, 4, 3, 861
    ),
    (
        88659, 4.0, 18876.000, 9, 4, 321
    ),
    (
        88660, 2.0, 1782.000, 7, 1, 592
    ),
    (
        88662, 1.0, 13745.000, 8, 3, 474
    ),
    (
        88676, 3.0, 6262.000, 6, 2, 392
    ),
    (
        88678, 4.0, 7230.000, 3, 2, 839
    ),
    (
        88679, 2.0, 9994.000, 4, 1, 17
    ),
    (
        88680, 5.0, 29156.000, 4, 2, 711
    ),
    (
        88681, 1.0, 14029.000, 8, 3, 990
    ),
    (
        88683, 2.0, 336.000, 4, 4, 492
    ),
    (
        88686, 3.0, 25534.000, 3, 1, 356
    ),
    (
        88689, 5.0, 21692.000, 4, 3, 797
    ),
    (
        88695, 1.0, 2793.000, 4, 3, 366
    ),
    (
        88701, 3.0, 495.000, 7, 3, 326
    ),
    (
        88712, 3.0, 24966.000, 3, 5, 131
    ),
    (
        88716, 1.0, 21806.000, 3, 1, 680
    ),
    (
        88720, 1.0, 33321.000, 8, 4, 760
    ),
    (
        88726, 5.0, 12447.000, 2, 3, 68
    ),
    (
        88728, 2.0, 29055.000, 4, 2, 493
    ),
    (
        88731, 4.0, 15628.000, 5, 4, 331
    ),
    (
        88736, 4.0, 21326.000, 2, 5, 212
    ),
    (
        88745, 3.0, 23059.000, 2, 2, 136
    ),
    (
        88747, 1.0, 16451.000, 2, 2, 144
    ),
    (
        88749, 4.0, 20158.000, 9, 5, 851
    ),
    (
        88752, 3.0, 14679.000, 5, 1, 20
    ),
    (
        88757, 1.0, 10073.000, 3, 2, 71
    ),
    (
        88765, 3.0, 31335.000, 9, 5, 667
    ),
    (
        88767, 4.0, 20316.000, 6, 5, 872
    );

INSERT INTO
    `tiendas_productos` (
        `id`, `compra_maxima`, `valor`, `id_promocion`, `id_tienda`, `id_producto`
    )
VALUES (
        88773, 1.0, 13389.000, 8, 4, 103
    ),
    (
        88786, 2.0, 12003.000, 10, 5, 546
    ),
    (
        88791, 3.0, 19343.000, 1, 2, 611
    ),
    (
        88792, 1.0, 18587.000, 6, 5, 927
    ),
    (
        88799, 1.0, 10367.000, 3, 1, 667
    ),
    (
        88800, 2.0, 31993.000, 2, 4, 950
    ),
    (
        88807, 2.0, 26296.000, 4, 3, 32
    ),
    (
        88820, 4.0, 4346.000, 8, 2, 553
    ),
    (
        88824, 5.0, 32164.000, 10, 5, 950
    ),
    (
        88825, 4.0, 13830.000, 5, 2, 442
    ),
    (
        88827, 4.0, 32760.000, 6, 1, 756
    ),
    (
        88836, 2.0, 20927.000, 3, 1, 525
    ),
    (
        88847, 2.0, 14113.000, 4, 3, 631
    ),
    (
        88850, 2.0, 25307.000, 2, 3, 457
    ),
    (
        88861, 1.0, 22187.000, 2, 4, 979
    ),
    (
        88862, 5.0, 15723.000, 7, 5, 871
    ),
    (
        88868, 4.0, 12363.000, 5, 5, 461
    ),
    (
        88872, 2.0, 6228.000, 2, 1, 23
    ),
    (
        88873, 4.0, 9429.000, 8, 1, 29
    ),
    (
        88882, 5.0, 18942.000, 8, 2, 312
    ),
    (
        88885, 3.0, 4894.000, 3, 4, 152
    ),
    (
        88886, 3.0, 23997.000, 3, 1, 533
    ),
    (
        88888, 1.0, 14012.000, 8, 3, 921
    ),
    (
        88891, 2.0, 23732.000, 6, 4, 858
    ),
    (
        88897, 4.0, 24020.000, 1, 1, 361
    ),
    (
        88904, 1.0, 6781.000, 7, 5, 302
    ),
    (
        88909, 4.0, 24707.000, 1, 1, 191
    ),
    (
        88914, 1.0, 5940.000, 7, 1, 72
    ),
    (
        88915, 2.0, 31366.000, 9, 5, 664
    ),
    (
        88920, 2.0, 12850.000, 9, 1, 998
    ),
    (
        88929, 1.0, 32041.000, 6, 4, 873
    ),
    (
        88932, 2.0, 3852.000, 2, 1, 15
    ),
    (
        88939, 3.0, 23351.000, 7, 2, 744
    ),
    (
        88949, 1.0, 11445.000, 5, 1, 130
    ),
    (
        88950, 3.0, 23516.000, 3, 5, 278
    ),
    (
        88951, 3.0, 12402.000, 6, 3, 657
    ),
    (
        88956, 3.0, 15870.000, 2, 3, 539
    ),
    (
        88958, 4.0, 23062.000, 1, 1, 441
    ),
    (
        88965, 1.0, 10944.000, 6, 5, 720
    ),
    (
        88966, 5.0, 18392.000, 9, 4, 348
    ),
    (
        88971, 4.0, 5288.000, 9, 5, 20
    ),
    (
        88973, 4.0, 30211.000, 2, 4, 931
    ),
    (
        88974, 1.0, 26083.000, 5, 2, 479
    ),
    (
        88976, 3.0, 518.000, 3, 1, 885
    ),
    (
        88982, 2.0, 13479.000, 5, 2, 444
    ),
    (
        88985, 3.0, 21828.000, 5, 1, 367
    ),
    (
        88987, 3.0, 14665.000, 10, 3, 108
    ),
    (
        88993, 1.0, 27545.000, 9, 4, 477
    ),
    (
        88998, 4.0, 32794.000, 6, 4, 682
    ),
    (
        88999, 4.0, 33178.000, 5, 3, 639
    ),
    (
        89000, 5.0, 31360.000, 7, 4, 774
    ),
    (
        89001, 3.0, 10663.000, 10, 5, 17
    ),
    (
        89005, 4.0, 19412.000, 8, 5, 690
    ),
    (
        89027, 2.0, 14195.000, 6, 3, 683
    ),
    (
        89031, 2.0, 25014.000, 6, 4, 780
    ),
    (
        89033, 5.0, 4623.000, 7, 1, 482
    ),
    (
        89034, 1.0, 27435.000, 9, 5, 319
    ),
    (
        89036, 3.0, 3530.000, 3, 1, 411
    ),
    (
        89037, 5.0, 12040.000, 1, 1, 118
    ),
    (
        89043, 4.0, 286.000, 5, 1, 334
    ),
    (
        89052, 4.0, 30352.000, 10, 1, 421
    ),
    (
        89054, 3.0, 33840.000, 4, 5, 321
    ),
    (
        89058, 2.0, 9545.000, 7, 2, 885
    ),
    (
        89061, 4.0, 7642.000, 6, 5, 352
    ),
    (
        89065, 4.0, 24193.000, 3, 5, 793
    ),
    (
        89068, 5.0, 21580.000, 5, 3, 576
    ),
    (
        89070, 2.0, 13697.000, 6, 4, 741
    ),
    (
        89075, 3.0, 17749.000, 1, 3, 432
    ),
    (
        89085, 3.0, 26625.000, 5, 5, 141
    ),
    (
        89087, 2.0, 28600.000, 5, 4, 790
    ),
    (
        89095, 1.0, 11089.000, 5, 2, 447
    ),
    (
        89096, 1.0, 8334.000, 9, 4, 587
    ),
    (
        89097, 1.0, 8923.000, 4, 4, 642
    ),
    (
        89101, 4.0, 29873.000, 9, 4, 379
    ),
    (
        89113, 3.0, 22095.000, 6, 4, 779
    ),
    (89114, 5.0, 3017.000, 8, 4, 2),
    (
        89123, 4.0, 12364.000, 4, 3, 910
    ),
    (
        89135, 3.0, 13360.000, 5, 1, 704
    ),
    (
        89141, 3.0, 4114.000, 10, 3, 343
    ),
    (
        89145, 5.0, 29074.000, 4, 2, 213
    ),
    (89150, 5.0, 7253.000, 4, 2, 4),
    (
        89156, 1.0, 31616.000, 6, 5, 787
    ),
    (
        89158, 4.0, 7862.000, 6, 2, 406
    ),
    (
        89159, 2.0, 15110.000, 3, 4, 279
    ),
    (
        89170, 3.0, 8822.000, 7, 3, 972
    ),
    (
        89174, 3.0, 14151.000, 7, 2, 808
    ),
    (
        89176, 3.0, 4980.000, 5, 4, 906
    ),
    (
        89180, 1.0, 23949.000, 3, 4, 511
    ),
    (
        89197, 3.0, 14101.000, 9, 1, 607
    ),
    (
        89201, 2.0, 21177.000, 3, 1, 606
    ),
    (
        89207, 4.0, 27603.000, 7, 1, 956
    ),
    (
        89212, 1.0, 31723.000, 6, 1, 792
    ),
    (
        89215, 3.0, 33155.000, 5, 1, 183
    ),
    (
        89216, 4.0, 28968.000, 3, 3, 89
    ),
    (
        89219, 5.0, 31257.000, 7, 3, 237
    ),
    (
        89220, 5.0, 25229.000, 1, 5, 759
    ),
    (
        89221, 4.0, 1565.000, 7, 1, 330
    ),
    (
        89222, 3.0, 17983.000, 2, 1, 7
    ),
    (
        89223, 4.0, 30954.000, 3, 2, 634
    ),
    (
        89229, 1.0, 30793.000, 3, 2, 806
    ),
    (
        89230, 2.0, 17662.000, 1, 3, 969
    ),
    (
        89238, 4.0, 24360.000, 3, 4, 231
    ),
    (
        89245, 4.0, 12383.000, 3, 1, 751
    ),
    (
        89246, 3.0, 4766.000, 3, 5, 715
    ),
    (
        89247, 4.0, 6757.000, 4, 2, 554
    ),
    (
        89259, 4.0, 30284.000, 5, 3, 37
    ),
    (
        89265, 3.0, 30494.000, 9, 5, 140
    ),
    (
        89273, 4.0, 15871.000, 2, 2, 467
    ),
    (
        89275, 4.0, 17094.000, 3, 4, 672
    ),
    (
        89285, 2.0, 23363.000, 1, 1, 233
    ),
    (
        89286, 5.0, 6670.000, 1, 4, 40
    ),
    (
        89287, 2.0, 11559.000, 8, 1, 64
    ),
    (
        89292, 2.0, 18462.000, 2, 4, 842
    ),
    (
        89296, 4.0, 22730.000, 4, 4, 643
    ),
    (
        89300, 2.0, 28441.000, 6, 2, 983
    ),
    (
        89303, 4.0, 24581.000, 5, 5, 235
    ),
    (
        89310, 2.0, 21796.000, 2, 4, 673
    ),
    (
        89312, 3.0, 18075.000, 5, 4, 306
    ),
    (
        89315, 1.0, 1699.000, 9, 3, 742
    ),
    (89318, 1.0, 55.000, 7, 3, 449),
    (
        89320, 3.0, 18721.000, 10, 2, 966
    ),
    (
        89321, 2.0, 22568.000, 4, 5, 456
    ),
    (
        89322, 3.0, 7145.000, 6, 5, 957
    ),
    (
        89335, 3.0, 9106.000, 6, 4, 995
    ),
    (
        89340, 3.0, 17658.000, 2, 2, 522
    ),
    (
        89343, 4.0, 19617.000, 10, 1, 678
    ),
    (
        89345, 4.0, 5476.000, 9, 1, 566
    ),
    (
        89347, 2.0, 12736.000, 9, 2, 775
    ),
    (
        89349, 3.0, 15781.000, 9, 1, 378
    ),
    (
        89356, 2.0, 14983.000, 4, 3, 232
    ),
    (
        89358, 5.0, 14609.000, 4, 2, 500
    ),
    (
        89364, 2.0, 9292.000, 8, 2, 917
    ),
    (
        89365, 4.0, 1956.000, 1, 4, 182
    ),
    (
        89367, 3.0, 10147.000, 8, 1, 37
    ),
    (
        89368, 5.0, 17602.000, 8, 3, 125
    ),
    (
        89374, 4.0, 28927.000, 9, 4, 163
    ),
    (
        89377, 3.0, 10409.000, 3, 1, 811
    ),
    (
        89383, 4.0, 27469.000, 2, 1, 75
    ),
    (
        89385, 3.0, 688.000, 7, 2, 985
    ),
    (
        89401, 2.0, 2931.000, 7, 4, 410
    ),
    (
        89403, 5.0, 3885.000, 9, 2, 506
    ),
    (
        89404, 4.0, 11241.000, 4, 4, 629
    ),
    (
        89410, 2.0, 4984.000, 4, 2, 639
    ),
    (
        89413, 5.0, 24054.000, 8, 3, 288
    ),
    (
        89421, 3.0, 30610.000, 9, 5, 848
    ),
    (
        89423, 1.0, 30012.000, 4, 2, 781
    ),
    (
        89424, 3.0, 18518.000, 6, 2, 849
    ),
    (
        89428, 4.0, 16867.000, 5, 5, 270
    ),
    (
        89430, 5.0, 8175.000, 5, 3, 342
    ),
    (
        89431, 1.0, 14253.000, 8, 5, 965
    ),
    (
        89435, 1.0, 19663.000, 8, 3, 518
    ),
    (
        89438, 4.0, 20456.000, 10, 1, 443
    ),
    (
        89440, 4.0, 1516.000, 9, 1, 709
    ),
    (
        89443, 2.0, 926.000, 7, 1, 401
    ),
    (
        89448, 4.0, 33988.000, 7, 1, 705
    ),
    (
        89456, 4.0, 7397.000, 8, 2, 196
    ),
    (
        89462, 2.0, 30861.000, 6, 4, 486
    ),
    (
        89472, 3.0, 3421.000, 3, 5, 724
    ),
    (
        89476, 5.0, 14766.000, 3, 1, 292
    ),
    (
        89480, 5.0, 32195.000, 10, 5, 615
    ),
    (
        89484, 1.0, 23853.000, 5, 5, 200
    ),
    (
        89488, 4.0, 32125.000, 4, 1, 230
    ),
    (
        89489, 5.0, 31468.000, 9, 3, 14
    ),
    (
        89496, 5.0, 677.000, 3, 2, 178
    ),
    (
        89503, 2.0, 134.000, 4, 3, 880
    ),
    (
        89507, 2.0, 6390.000, 8, 3, 126
    ),
    (
        89510, 3.0, 153.000, 5, 2, 745
    ),
    (
        89513, 1.0, 15324.000, 2, 1, 280
    ),
    (
        89515, 1.0, 11796.000, 7, 3, 580
    ),
    (
        89516, 2.0, 18747.000, 10, 2, 357
    ),
    (
        89518, 2.0, 31013.000, 6, 2, 155
    ),
    (
        89525, 4.0, 913.000, 7, 2, 125
    ),
    (
        89526, 5.0, 14346.000, 3, 5, 784
    ),
    (
        89527, 2.0, 27037.000, 4, 1, 420
    ),
    (
        89529, 2.0, 5843.000, 2, 1, 875
    ),
    (
        89532, 3.0, 24474.000, 8, 5, 395
    ),
    (
        89535, 4.0, 28394.000, 3, 3, 809
    ),
    (
        89536, 3.0, 19934.000, 2, 4, 944
    ),
    (
        89540, 2.0, 28448.000, 7, 1, 305
    ),
    (
        89542, 5.0, 14458.000, 3, 1, 409
    ),
    (
        89547, 2.0, 12087.000, 2, 4, 943
    ),
    (
        89550, 3.0, 9846.000, 2, 5, 28
    ),
    (
        89554, 4.0, 646.000, 8, 1, 586
    ),
    (
        89555, 5.0, 27739.000, 4, 2, 145
    ),
    (
        89560, 1.0, 29026.000, 3, 4, 460
    ),
    (
        89564, 4.0, 14952.000, 7, 5, 953
    ),
    (
        89569, 3.0, 13120.000, 3, 5, 967
    ),
    (
        89572, 5.0, 2076.000, 5, 5, 623
    ),
    (
        89575, 3.0, 29572.000, 5, 4, 845
    ),
    (
        89578, 2.0, 12225.000, 7, 2, 676
    ),
    (
        89579, 2.0, 23028.000, 4, 4, 835
    ),
    (
        89584, 2.0, 6521.000, 9, 1, 555
    ),
    (
        89585, 3.0, 6032.000, 3, 3, 352
    ),
    (
        89586, 3.0, 1254.000, 4, 3, 696
    ),
    (
        89602, 3.0, 4567.000, 2, 5, 271
    ),
    (
        89605, 3.0, 2179.000, 9, 1, 564
    ),
    (
        89606, 4.0, 4555.000, 4, 3, 231
    ),
    (
        89612, 1.0, 15377.000, 2, 3, 512
    ),
    (
        89614, 3.0, 18627.000, 6, 2, 798
    ),
    (
        89622, 3.0, 5693.000, 2, 5, 249
    ),
    (
        89625, 3.0, 11601.000, 4, 3, 460
    ),
    (
        89631, 5.0, 28670.000, 5, 3, 39
    ),
    (
        89634, 5.0, 23980.000, 8, 4, 940
    ),
    (
        89642, 5.0, 24401.000, 10, 4, 347
    ),
    (
        89645, 2.0, 5708.000, 10, 3, 15
    ),
    (
        89647, 3.0, 22876.000, 8, 4, 55
    ),
    (
        89649, 2.0, 1241.000, 6, 3, 595
    ),
    (
        89650, 4.0, 24852.000, 6, 3, 61
    ),
    (
        89651, 4.0, 7738.000, 2, 4, 625
    ),
    (
        89652, 4.0, 1296.000, 9, 1, 972
    ),
    (
        89653, 3.0, 29784.000, 7, 5, 376
    ),
    (
        89668, 4.0, 3293.000, 5, 1, 974
    ),
    (
        89671, 3.0, 4085.000, 1, 4, 400
    ),
    (
        89674, 3.0, 32612.000, 1, 3, 768
    ),
    (
        89676, 3.0, 27439.000, 7, 4, 113
    ),
    (
        89677, 2.0, 10897.000, 3, 1, 761
    ),
    (
        89680, 4.0, 5599.000, 8, 3, 718
    ),
    (
        89686, 5.0, 18648.000, 2, 4, 617
    ),
    (
        89687, 4.0, 32628.000, 6, 4, 883
    ),
    (
        89691, 2.0, 19757.000, 8, 2, 762
    ),
    (
        89693, 3.0, 4330.000, 10, 3, 333
    ),
    (
        89694, 2.0, 21436.000, 3, 5, 397
    ),
    (
        89701, 4.0, 24927.000, 3, 1, 647
    ),
    (
        89705, 3.0, 430.000, 5, 5, 537
    ),
    (
        89707, 1.0, 6386.000, 9, 5, 44
    ),
    (
        89709, 3.0, 248.000, 7, 2, 710
    ),
    (
        89715, 2.0, 1113.000, 5, 2, 377
    ),
    (
        89718, 5.0, 3798.000, 7, 1, 348
    ),
    (
        89723, 1.0, 7387.000, 9, 5, 837
    ),
    (
        89732, 5.0, 8649.000, 5, 4, 727
    ),
    (
        89735, 4.0, 760.000, 10, 5, 457
    ),
    (
        89741, 2.0, 19765.000, 9, 5, 850
    ),
    (
        89748, 4.0, 8434.000, 7, 4, 249
    ),
    (
        89752, 2.0, 14637.000, 3, 1, 366
    ),
    (
        89753, 4.0, 19273.000, 7, 3, 484
    ),
    (
        89758, 3.0, 27344.000, 7, 1, 955
    ),
    (
        89765, 4.0, 9651.000, 4, 4, 411
    ),
    (
        89769, 4.0, 10956.000, 6, 3, 230
    ),
    (
        89778, 5.0, 3365.000, 7, 2, 915
    ),
    (
        89783, 3.0, 8053.000, 6, 4, 543
    ),
    (
        89792, 2.0, 3473.000, 7, 5, 656
    ),
    (
        89800, 2.0, 29184.000, 3, 3, 358
    ),
    (
        89802, 2.0, 30244.000, 6, 2, 269
    ),
    (
        89811, 3.0, 7631.000, 5, 4, 341
    ),
    (
        89814, 3.0, 23323.000, 2, 4, 377
    ),
    (
        89816, 5.0, 10233.000, 6, 1, 306
    ),
    (
        89817, 3.0, 18875.000, 4, 4, 123
    ),
    (
        89827, 2.0, 4065.000, 3, 4, 961
    ),
    (
        89833, 1.0, 28936.000, 10, 2, 550
    ),
    (
        89847, 3.0, 27981.000, 6, 2, 773
    ),
    (
        89853, 4.0, 3702.000, 2, 2, 403
    ),
    (
        89855, 2.0, 16434.000, 5, 3, 830
    ),
    (
        89857, 2.0, 10521.000, 6, 5, 751
    ),
    (
        89858, 1.0, 6885.000, 8, 1, 216
    ),
    (
        89865, 4.0, 11919.000, 8, 4, 972
    ),
    (
        89867, 3.0, 23589.000, 7, 1, 170
    ),
    (
        89868, 4.0, 22444.000, 8, 1, 697
    ),
    (
        89872, 3.0, 25846.000, 4, 2, 224
    ),
    (
        89879, 2.0, 25418.000, 3, 1, 414
    ),
    (
        89881, 4.0, 17401.000, 4, 5, 934
    ),
    (
        89885, 4.0, 3086.000, 4, 2, 988
    ),
    (
        89905, 2.0, 5572.000, 10, 3, 440
    ),
    (
        89909, 2.0, 3875.000, 7, 1, 35
    ),
    (
        89915, 2.0, 3349.000, 7, 5, 740
    ),
    (
        89916, 5.0, 7864.000, 5, 4, 241
    ),
    (
        89927, 2.0, 5528.000, 2, 2, 797
    ),
    (
        89930, 5.0, 4116.000, 8, 4, 852
    ),
    (
        89931, 2.0, 32403.000, 9, 3, 632
    ),
    (
        89942, 1.0, 16448.000, 4, 5, 992
    ),
    (
        89943, 1.0, 9756.000, 3, 3, 796
    ),
    (
        89944, 3.0, 21436.000, 9, 4, 247
    ),
    (
        89947, 5.0, 22518.000, 6, 5, 18
    ),
    (
        89951, 3.0, 32634.000, 3, 2, 906
    ),
    (
        89957, 5.0, 32938.000, 2, 4, 499
    ),
    (
        89958, 2.0, 8183.000, 8, 1, 128
    ),
    (
        89961, 3.0, 2871.000, 2, 2, 599
    ),
    (
        89965, 2.0, 22903.000, 9, 2, 911
    ),
    (
        89966, 4.0, 18192.000, 7, 5, 681
    ),
    (
        89969, 3.0, 16430.000, 2, 5, 291
    ),
    (
        89973, 4.0, 28155.000, 9, 5, 31
    ),
    (
        89979, 4.0, 17752.000, 4, 1, 140
    ),
    (
        89988, 3.0, 7208.000, 7, 3, 637
    ),
    (
        89989, 4.0, 14962.000, 3, 4, 592
    ),
    (
        89993, 2.0, 8176.000, 3, 1, 97
    ),
    (
        89995, 5.0, 27770.000, 2, 5, 666
    ),
    (
        90005, 5.0, 15858.000, 7, 5, 919
    ),
    (
        90006, 3.0, 12336.000, 9, 3, 279
    ),
    (
        90011, 1.0, 24162.000, 5, 1, 61
    ),
    (
        90013, 2.0, 3985.000, 5, 5, 504
    ),
    (
        90032, 1.0, 4227.000, 4, 3, 417
    ),
    (
        90036, 3.0, 10626.000, 9, 4, 458
    ),
    (
        90043, 2.0, 11332.000, 7, 2, 539
    ),
    (
        90047, 4.0, 33733.000, 8, 1, 989
    ),
    (
        90050, 4.0, 25838.000, 4, 3, 133
    ),
    (
        90051, 2.0, 14726.000, 2, 1, 987
    ),
    (
        90052, 4.0, 5064.000, 4, 5, 890
    ),
    (
        90054, 5.0, 7241.000, 4, 1, 213
    ),
    (
        90057, 2.0, 4248.000, 9, 4, 472
    ),
    (
        90062, 1.0, 3685.000, 3, 4, 419
    ),
    (
        90065, 2.0, 8043.000, 8, 1, 286
    ),
    (
        90068, 1.0, 30644.000, 4, 1, 387
    ),
    (
        90075, 4.0, 12077.000, 5, 2, 416
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendas_promociones`
--

CREATE TABLE `tiendas_promociones` (
    `id` mediumint UNSIGNED NOT NULL, `estado` tinyint UNSIGNED NOT NULL COMMENT '0=Inactivo 1=Activo', `inicio` date NOT NULL, `fin` date NOT NULL, `id_tienda` smallint UNSIGNED NOT NULL, `id_promocion` mediumint UNSIGNED NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son las fechas de vigencia de una Promoción para un Cedis';

--
-- Volcado de datos para la tabla `tiendas_promociones`
--

INSERT INTO
    `tiendas_promociones` (
        `id`, `estado`, `inicio`, `fin`, `id_tienda`, `id_promocion`
    )
VALUES (
        91, 1, '2024-02-11', '2024-02-17', 1, 1
    ),
    (
        92, 1, '2024-02-11', '2024-02-17', 1, 2
    ),
    (
        93, 1, '2024-02-11', '2024-02-17', 2, 3
    ),
    (
        94, 1, '2024-02-11', '2024-02-17', 2, 4
    ),
    (
        95, 1, '2024-02-11', '2024-02-17', 3, 5
    ),
    (
        96, 1, '2024-02-11', '2024-02-17', 3, 6
    ),
    (
        97, 1, '2024-02-11', '2024-02-17', 4, 7
    ),
    (
        98, 1, '2024-02-11', '2024-02-17', 4, 8
    ),
    (
        99, 1, '2024-02-11', '2024-02-17', 5, 8
    ),
    (
        100, 1, '2024-02-11', '2024-02-17', 5, 10
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
    `id` mediumint UNSIGNED NOT NULL, `estado` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0=Inactivo 1=Activo.', `tipo` tinyint UNSIGNED NOT NULL COMMENT '1=Admin 2=Tienda 3=Cliente', `login` tinyint UNSIGNED NOT NULL COMMENT '1=Teléfono 2=Correo', `telefono` bigint UNSIGNED DEFAULT NULL COMMENT 'Identificador Principal. Unique', `codigo_temporal` mediumint UNSIGNED DEFAULT NULL COMMENT 'Código temporal para Login por mensaje de texto o correo', `correo` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `password` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son todos los Usuarios del sistema';

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO
    `users` (
        `id`, `estado`, `tipo`, `login`, `telefono`, `codigo_temporal`, `correo`, `password`
    )
VALUES (
        1, 1, 5, 1, 3195883224, NULL, NULL, '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        2, 1, 5, 1, 3195883223, NULL, 'developergbp34@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        3, 1, 5, 1, NULL, NULL, 'jorgemogotocoro05@outlook.es', '$2y$10$V.lre1tbl6ISqfkTbCI12uzTk7KMrAJwwhpKcPH3GU/Uu43xcraia'
    ),
    (
        4, 1, 5, 2, NULL, NULL, 'maleja2995@hotmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        5, 1, 5, 2, NULL, NULL, 'pascualdas@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        6, 1, 5, 2, NULL, NULL, 'developergbp36@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        7, 1, 5, 1, 316291219, NULL, 'andres.lizarazo02@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        8, 1, 5, 1, 3165317822, NULL, 'jica0725@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        9, 1, 5, 1, 3209596193, NULL, 'juniorgalansanchez@hotmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        10, 1, 5, 2, NULL, NULL, 'carofierro9525@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        11, 1, 5, 1, 3174370238, NULL, 'rian198@hotmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        12, 1, 5, 2, NULL, NULL, 'mariaisabela2008@hotmail.es', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        13, 1, 5, 2, NULL, NULL, 'paula.galvis.v@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        14, 1, 5, 2, 3229215024, NULL, 'yiretg26@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        15, 1, 5, 2, NULL, NULL, 'yihaguga@hotmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        16, 1, 5, 2, NULL, NULL, 'jarret87x_i44s@fuluj.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        17, 1, 5, 2, NULL, NULL, 'developergbp18@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        18, 1, 5, 1, 3208129176, NULL, 'developergbp10@gmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        19, 1, 5, 2, NULL, NULL, 'carloseduardohernandez@hotmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    ),
    (
        20, 1, 5, 2, NULL, NULL, 'diegof.17@hotmail.com', '$2y$10$aCnWY46fHu1YL4SARaEZr.FGGxqDMX8l3bP2ljx09pL8nBUKOGzgi'
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_clientes`
--

CREATE TABLE `users_clientes` (
    `id` mediumint UNSIGNED NOT NULL, `telefono` bigint UNSIGNED DEFAULT NULL, `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL, `genero` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=Otro 2=Masculino 3=Femenino', `nacimiento` date DEFAULT NULL, `identificacion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'El label se obtiene de x_parametros.tipo=101', `id_direccion` mediumint UNSIGNED DEFAULT NULL COMMENT 'Conexión a dirección que actualmente está como Principal', `id_user` mediumint UNSIGNED NOT NULL COMMENT 'User al que está asociado este Cliente'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son los datos específicos de los Clientes';

--
-- Volcado de datos para la tabla `users_clientes`
--

INSERT INTO
    `users_clientes` (
        `id`, `telefono`, `nombre`, `genero`, `nacimiento`, `identificacion`, `id_direccion`, `id_user`
    )
VALUES (
        5, NULL, 'Oscar Zorrilla', 2, '1999-10-31', '12345648912336', 8050, 3
    ),
    (
        6, NULL, 'Alejandra Gómez Reatiga', 3, '1995-06-29', NULL, 497, 4
    ),
    (
        7, NULL, 'Dany Pascual Gomez Sanchez', 2, '1986-07-13', '1098763132', 7, 5
    ),
    (
        8, NULL, 'Andrés Lizarazo', 2, '1992-01-04', '109876313', 8, 7
    ),
    (
        9, NULL, 'Joaquín Carreño', 2, '1994-07-25', NULL, 3215, 8
    ),
    (
        10, NULL, 'Oscar Rodríguez', 2, '1994-10-31', NULL, 10, 6
    ),
    (
        11, NULL, 'Gian Carlos Galán Sánchez', 2, '2001-05-27', NULL, 1358, 9
    ),
    (
        12, NULL, 'Liseth Carolina Fierro Rojas', 3, '1995-04-25', NULL, 1388, 10
    ),
    (
        13, NULL, 'Richard Antonio Amell Cumplido', 2, '1980-03-06', NULL, 13, 11
    ),
    (
        14, NULL, 'maria', 3, '1970-09-24', NULL, 14, 12
    ),
    (
        15, NULL, 'Paula', 3, '1998-02-20', NULL, 15, 13
    ),
    (
        16, NULL, 'Yiret Gutiérrez', 3, '1995-12-26', NULL, 1352, 14
    ),
    (
        17, NULL, 'Alan brito delgado', 3, '1985-03-02', NULL, 18, 16
    ),
    (
        18, NULL, 'Mérida Rosario Gutiérrez Sarmiento.', 3, '1995-03-27', NULL, 19, 15
    ),
    (
        19, NULL, 'Rafael', 3, '2021-03-27', NULL, 20, 17
    ),
    (
        20, NULL, 'Yesid Ortiz', 2, '2003-04-05', NULL, 8108, 18
    ),
    (
        21, NULL, 'Diego Benitez', 2, '1992-03-11', NULL, 22, 20
    ),
    (
        23, NULL, 'carlos eduardo hernandez rueda', 2, '1988-02-05', NULL, 24, 19
    ),
    (
        27, NULL, 'lucho text', 1, '1996-04-11', NULL, 8125, 1
    ),
    (
        71, NULL, 'Developer gbp 34', 2, '1995-04-05', NULL, 8034, 2
    );

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_direcciones`
--

CREATE TABLE `users_direcciones` (
    `id` mediumint UNSIGNED NOT NULL, `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del lugar. Oficina, Casa, Trabajo', `direccion` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL, `distancia` smallint UNSIGNED NOT NULL, `id_user` mediumint UNSIGNED NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Son todas las direcciones del Cliente, disponibles para reemplazar la principal';

--
-- Volcado de datos para la tabla `users_direcciones`
--

INSERT INTO
    `users_direcciones` (
        `id`, `nombre`, `direccion`, `distancia`, `id_user`
    )
VALUES (
        6, 'Barrio candiles', 'calle 50 # 13 20', 451, 4
    ),
    (
        7, 'miCasa', 'av bucaros 3-155', 314, 5
    ),
    (
        8, 'Casa', 'calle 105 22 22', 284, 7
    ),
    (
        9, 'hogar', 'cra 32 #62 26', 381, 8
    ),
    (
        10, 'casa', 'carrera 21b #115-116 torre 10b apto 301', 169, 6
    ),
    (
        13, 'casa', 'Secretaría de Gobierno Dc, Cl. 11 #8-17', 124, 11
    ),
    (
        14, 'portal de israel-el carme', 'diagonal 59 # 134-16 piso 2 portal de israel- el carmen', 289, 12
    ),
    (
        15, 'Mi casa', 'cra 25#25-32 El bosque sector A', 447, 13
    ),
    (
        17, 'Trabajo', 'provincia de soto 2', 123, 14
    ),
    (
        18, 'Caseiro', 'hdhdhdjd', 13, 16
    ),
    (
        19, 'Dirección de la Oficina 🏢', 'Calle 41 #19-69', 371, 15
    ),
    (
        20, 'Casa 1', 'Calle 87#24-09', 448, 17
    ),
    (
        22, 'Monteverdi', 'calle68b#24a-03', 180, 20
    ),
    (
        24, 'leechero', 'Carrera 29 51 10 giron', 205, 19
    ),
    (
        28, 'STHEFANNY NIÑO', 'Calle 106 #22-138', 48, 1
    ),
    (
        42, 'casa papa', 'calle 68a 27 29', 456, 11
    ),
    (
        75, 'kjlkjljlj', 'Barrio Manzanares Bucaramanga, Cl. 59 #26 Oeste-2 a 26 Oeste-40,, Bucaramanga, Santander, Colombia', 339, 2
    ),
    (
        497, 'trabajo', 'Vias de acceso a Provincia de Soto II, Bucaramanga, Santander, Colombia', 134, 4
    ),
    (
        1211, 'trabajo', 'Vias de acceso a Provincia de Soto II, Bucaramanga, Santander, Colombia', 401, 10
    ),
    (
        1327, 'Casa', 'Calle 128 #47 - 174, Floridablanca, Santander, Colombia', 312, 1
    ),
    (
        1352, 'Casa 🏡', 'Cra. 20 #51, Bucaramanga, Santander, Colombia', 121, 14
    ),
    (
        1358, 'casa', 'Cl. 39 #18-49, Girón, Santander, Colombia', 330, 9
    ),
    (
        1388, 'Apto Liseth', 'Cl. 104d #8-37, Bucaramanga, Santander, Colombia', 498, 10
    ),
    (
        3215, 'Apto Provenza', 'Cl. 112 #21ABIS-56, Bucaramanga, Santander, Colombia', 54, 8
    ),
    (
        3591, 'trabajo', 'Vias de acceso a Provincia de Soto II, Bucaramanga, Santander, Colombia', 416, 1
    ),
    (
        4694, 'casa2', 'Cl. 51 #12-76, Bucaramanga, Santander, Colombia', 210, 18
    ),
    (
        6236, 'casa', 'Cl. 34 #39-11, Bucaramanga, Santander, Colombia', 410, 11
    ),
    (
        6777, 'oficina', '3VP7+QV Bucaramanga, Santander, Colombia', 182, 11
    ),
    (
        7218, 'rest', '4R4P+VV Bucaramanga, Santander, Colombia', 177, 11
    ),
    (
        7948, 'Casa', 'Cra 20 # 37 - 61', 295, 18
    ),
    (
        8013, 'egg go jr', '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA', 348, 3
    ),
    (
        8014, 'Eric', 'Barrio Manzanares Bucaramanga, Cl. 59 #26 Oeste-2 a 26 Oeste-40,, Bucaramanga, Santander, Colombia', 126, 3
    ),
    (
        8033, 'GB cc vv', 'Parque Residencial Cerrado Punta Estrella', 166, 2
    ),
    (
        8034, 'we rrr', '1600 Amphitheatre Pkwy Building 43, Mountain View, CA 94043, USA', 309, 2
    ),
    (
        8050, 'hotes', 'Centro Comercial Parque Caracolí, Local 321, Floridablanca, Santander, Colombia', 84, 3
    ),
    (
        8058, 'hotelstmta', 'Cra. 5 #2174, Santa Marta, Magdalena, Colombia', 41, 3
    ),
    (
        8108, 'dsfsd', 'Conjunto Residencial Punto Estrella, La Concordia, Bucaramanga, Santander, Colombia', 343, 18
    ),
    (
        8121, 'mi casa', 'Gigiomania, Cra. 17 #No. 57 - 32, La Concordia, Bucaramanga, Santander, Colombia', 143, 1
    ),
    (
        8122, 'mi casa', 'Estacion de servicio GNV, Cl. 46 #19 - 122, Nuevo Sotomayor, Bucaramanga, Santander, Colombia', 467, 1
    ),
    (
        8123, 'frrrr', 'Hotel San Juan Internacional, Km. 6, Girón-Bucaramanga, Girón, Santander, Colombia', 406, 1
    ),
    (
        8124, 'ihiuhiuhiuhu', 'Tienda yaneth, Cl. 59b 43bw-27, La Concordia, Bucaramanga, Santander, Colombia', 128, 1
    ),
    (
        8125, 'qqqqqqqq', 'Parque Residencial Cerrado Punta Estrella, La Concordia, Bucaramanga, Santander, Colombia', 418, 1
    );

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carritos`
--
ALTER TABLE `carritos`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `id_producto_2` (
    `id_producto`, `id_tienda`, `id_user`
),
ADD KEY `created_by` (`id_user`),
ADD KEY `id_producto` (`id_producto`),
ADD KEY `id_tienda` (`id_tienda`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
ADD PRIMARY KEY (`id`),
ADD KEY `created_by` (`id_user`),
ADD KEY `id_tienda` (`id_tienda`);

--
-- Indices de la tabla `pedidos_estados`
--
ALTER TABLE `pedidos_estados`
ADD PRIMARY KEY (`id`),
ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
ADD PRIMARY KEY (`id`),
ADD KEY `id_promocion` (`id_promocion`),
ADD KEY `id_producto` (`id_producto`),
ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `barcode` (`barcode`),
ADD UNIQUE KEY `nombre` (`nombre`, `presentacion`),
ADD KEY `barcode_2` (`barcode`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones` ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiendas`
--
ALTER TABLE `tiendas` ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiendas_distancias`
--
ALTER TABLE `tiendas_distancias`
ADD PRIMARY KEY (`id`),
ADD KEY `id_tienda` (`id_tienda`);

--
-- Indices de la tabla `tiendas_productos`
--
ALTER TABLE `tiendas_productos`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `id_tienda_2` (`id_tienda`, `id_producto`),
ADD KEY `id_producto` (`id_producto`),
ADD KEY `id_tienda` (`id_tienda`),
ADD KEY `id_promocion` (`id_promocion`);

--
-- Indices de la tabla `tiendas_promociones`
--
ALTER TABLE `tiendas_promociones`
ADD PRIMARY KEY (`id`),
ADD KEY `id_tienda` (`id_tienda`),
ADD KEY `id_promocion` (`id_promocion`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `telefono` (`telefono`),
ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `users_clientes`
--
ALTER TABLE `users_clientes`
ADD PRIMARY KEY (`id`),
ADD UNIQUE KEY `id_user_2` (`id_user`),
ADD UNIQUE KEY `identificacion` (`identificacion`),
ADD KEY `id_user` (`id_user`),
ADD KEY `id_direccion` (`id_direccion`);

--
-- Indices de la tabla `users_direcciones`
--
ALTER TABLE `users_direcciones`
ADD PRIMARY KEY (`id`),
ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carritos`
--
ALTER TABLE `carritos`
MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 150405;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 29466;

--
-- AUTO_INCREMENT de la tabla `pedidos_estados`
--
ALTER TABLE `pedidos_estados`
MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 179937;

--
-- AUTO_INCREMENT de la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 167644;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1024;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 16;

--
-- AUTO_INCREMENT de la tabla `tiendas`
--
ALTER TABLE `tiendas`
MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 44;

--
-- AUTO_INCREMENT de la tabla `tiendas_distancias`
--
ALTER TABLE `tiendas_distancias`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 178;

--
-- AUTO_INCREMENT de la tabla `tiendas_productos`
--
ALTER TABLE `tiendas_productos`
MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 93279;

--
-- AUTO_INCREMENT de la tabla `tiendas_promociones`
--
ALTER TABLE `tiendas_promociones`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 101;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 12225;

--
-- AUTO_INCREMENT de la tabla `users_clientes`
--
ALTER TABLE `users_clientes`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 8227;

--
-- AUTO_INCREMENT de la tabla `users_direcciones`
--
ALTER TABLE `users_direcciones`
MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 8164;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carritos`
--
ALTER TABLE `carritos`
ADD CONSTRAINT `carritos_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `carritos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `carritos_ibfk_4` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos_estados`
--
ALTER TABLE `pedidos_estados`
ADD CONSTRAINT `pedidos_estados_ibfk_2` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
ADD CONSTRAINT `pedidos_productos_ibfk_4` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `pedidos_productos_ibfk_5` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT `pedidos_productos_ibfk_6` FOREIGN KEY (`id_promocion`) REFERENCES `promociones` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `tiendas_distancias`
--
ALTER TABLE `tiendas_distancias`
ADD CONSTRAINT `tiendas_distancias_ibfk_4` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tiendas_productos`
--
ALTER TABLE `tiendas_productos`
ADD CONSTRAINT `cedis_productos_ibfk_3` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `cedis_productos_ibfk_4` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `tiendas_productos_ibfk_1` FOREIGN KEY (`id_promocion`) REFERENCES `promociones` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `tiendas_promociones`
--
ALTER TABLE `tiendas_promociones`
ADD CONSTRAINT `tiendas_promociones_ibfk_3` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `tiendas_promociones_ibfk_4` FOREIGN KEY (`id_promocion`) REFERENCES `promociones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_clientes`
--
ALTER TABLE `users_clientes`
ADD CONSTRAINT `users_clientes_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `users_clientes_ibfk_3` FOREIGN KEY (`id_direccion`) REFERENCES `users_direcciones` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_direcciones`
--
ALTER TABLE `users_direcciones`
ADD CONSTRAINT `users_direcciones_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;

