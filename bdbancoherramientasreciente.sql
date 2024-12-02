-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-12-2024 a las 19:06:33
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdh`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `documento` int(11) NOT NULL,
  `contrasena` varchar(80) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipo` enum('admin','contratista','practicante','supervisor') NOT NULL,
  `areas_idarea` int(11) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `numero` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`documento`, `contrasena`, `nombre`, `tipo`, `areas_idarea`, `correo`, `numero`) VALUES
(1040873224, '$2a$10$jDUEh2joQle.SgP/MOaXLur5U1hITUwHi8L2738/rsLzu2B/RrsG.', 'admin supervisor', 'supervisor', 0, 'adminsupervisor@gmmail.com', '12345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adminsesion`
--

CREATE TABLE `adminsesion` (
  `idsesion` int(11) NOT NULL,
  `administradores_documento` int(11) NOT NULL,
  `login` datetime NOT NULL,
  `logout` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `idarea` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`idarea`, `nombre`) VALUES
(0, 'Ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bajas`
--

CREATE TABLE `bajas` (
  `idbaja` int(11) NOT NULL,
  `elementos_idelemento` int(11) NOT NULL,
  `tipo` enum('reintegro','traspaso') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `observaciones` varchar(300) DEFAULT NULL,
  `areas_idarea` int(11) NOT NULL,
  `clientes_documento` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `idadmin` int(11) NOT NULL,
  `estado` enum('des','hab') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `documento` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(80) DEFAULT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `observaciones` varchar(300) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `roles_idrol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consumos`
--

CREATE TABLE `consumos` (
  `idconsumo` int(11) NOT NULL,
  `clientes_documento` int(11) NOT NULL,
  `areas_idarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `danos`
--

CREATE TABLE `danos` (
  `iddano` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `observaciones` varchar(200) DEFAULT NULL,
  `elementos_idelemento` int(11) NOT NULL,
  `clientes_documento` int(11) NOT NULL,
  `areas_idarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos`
--

CREATE TABLE `elementos` (
  `idelemento` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `disponibles` int(11) NOT NULL,
  `ubicacion` varchar(45) NOT NULL,
  `tipo` enum('devolutivo','consumible') NOT NULL,
  `estado` enum('disponible','agotado') NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `minimo` int(5) NOT NULL,
  `areas_idarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos_has_consumos`
--

CREATE TABLE `elementos_has_consumos` (
  `elementos_idelemento` int(11) NOT NULL,
  `consumos_idconsumo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `administradores_documento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos_has_encargos`
--

CREATE TABLE `elementos_has_encargos` (
  `elementos_idelemento` int(11) NOT NULL,
  `encargos_idencargo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `fecha_devolucion` datetime DEFAULT NULL,
  `estado` enum('pendiente','aceptado','rechazado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos_has_prestamoscorrientes`
--

CREATE TABLE `elementos_has_prestamoscorrientes` (
  `elementos_idelemento` int(11) NOT NULL,
  `prestamoscorrientes_idprestamo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha_entrega` datetime NOT NULL,
  `fecha_devolucion` datetime DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `estado` enum('actual','finalizado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos_has_prestamosespeciales`
--

CREATE TABLE `elementos_has_prestamosespeciales` (
  `elementos_idelemento` int(11) NOT NULL,
  `prestamosespeciales_idprestamo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha_entrega` datetime NOT NULL,
  `fecha_devolucion` datetime DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `estado` enum('actual','finalizado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encargos`
--

CREATE TABLE `encargos` (
  `idencargo` int(11) NOT NULL,
  `clientes_documento` int(11) NOT NULL,
  `areas_idarea` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL,
  `fecha_reclamo` datetime NOT NULL,
  `contacto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialpemdb`
--

CREATE TABLE `historialpemdb` (
  `id_historial` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `tipo_entidad` varchar(50) DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `cliente_nombre` varchar(100) DEFAULT NULL,
  `elemento_id` int(11) DEFAULT NULL,
  `elemento_descripcion` varchar(100) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `observaciones` varchar(300) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `accion` varchar(50) DEFAULT NULL,
  `fecha_accion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moras`
--

CREATE TABLE `moras` (
  `idmora` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `observaciones` varchar(200) DEFAULT NULL,
  `elementos_idelemento` int(11) NOT NULL,
  `clientes_documento` int(11) NOT NULL,
  `areas_idarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamoscorrientes`
--

CREATE TABLE `prestamoscorrientes` (
  `idprestamo` int(11) NOT NULL,
  `clientes_documento` int(11) NOT NULL,
  `estado` enum('actual','finalizado') NOT NULL,
  `areas_idarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamosespeciales`
--

CREATE TABLE `prestamosespeciales` (
  `idprestamo` int(11) NOT NULL,
  `clientes_documento` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `estado` enum('actual','finalizado') NOT NULL,
  `areas_idarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idrol` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idrol`, `descripcion`) VALUES
(1, 'instructor');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`documento`),
  ADD KEY `administradores_ibfk_1` (`areas_idarea`);

--
-- Indices de la tabla `adminsesion`
--
ALTER TABLE `adminsesion`
  ADD PRIMARY KEY (`idsesion`),
  ADD KEY `adminsesion_ibfk_1` (`administradores_documento`);

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`idarea`);

--
-- Indices de la tabla `bajas`
--
ALTER TABLE `bajas`
  ADD PRIMARY KEY (`idbaja`),
  ADD KEY `bajas_ibfk_1` (`elementos_idelemento`) USING BTREE,
  ADD KEY `bajas_ibfk_3` (`areas_idarea`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`documento`),
  ADD KEY `fk_usuarios_roles1_idx` (`roles_idrol`);

--
-- Indices de la tabla `consumos`
--
ALTER TABLE `consumos`
  ADD PRIMARY KEY (`idconsumo`) USING BTREE,
  ADD KEY `fk_consumos_clientes1_idx` (`clientes_documento`) USING BTREE,
  ADD KEY `areas_idarea` (`areas_idarea`);

--
-- Indices de la tabla `danos`
--
ALTER TABLE `danos`
  ADD PRIMARY KEY (`iddano`) USING BTREE,
  ADD KEY `fk_danos_elementos1_idx` (`elementos_idelemento`),
  ADD KEY `fk_danos_clientes1_idx` (`clientes_documento`) USING BTREE,
  ADD KEY `areas_idarea` (`areas_idarea`);

--
-- Indices de la tabla `elementos`
--
ALTER TABLE `elementos`
  ADD PRIMARY KEY (`idelemento`),
  ADD KEY `elementos_ibfk_1` (`areas_idarea`);

--
-- Indices de la tabla `elementos_has_consumos`
--
ALTER TABLE `elementos_has_consumos`
  ADD PRIMARY KEY (`elementos_idelemento`,`consumos_idconsumo`),
  ADD KEY `fk_elementos_has_consumos_consumos1_idx` (`consumos_idconsumo`),
  ADD KEY `fk_elementos_has_consumos_elementos1_idx` (`elementos_idelemento`);

--
-- Indices de la tabla `elementos_has_encargos`
--
ALTER TABLE `elementos_has_encargos`
  ADD PRIMARY KEY (`elementos_idelemento`,`encargos_idencargo`),
  ADD KEY `fk_elementos_has_encargos_encargos1_idx` (`encargos_idencargo`),
  ADD KEY `fk_elementos_has_encargos_elementos1_idx` (`elementos_idelemento`);

--
-- Indices de la tabla `elementos_has_prestamoscorrientes`
--
ALTER TABLE `elementos_has_prestamoscorrientes`
  ADD PRIMARY KEY (`elementos_idelemento`,`prestamoscorrientes_idprestamo`),
  ADD KEY `fk_elementos_has_prestamos_prestamos1_idx` (`prestamoscorrientes_idprestamo`),
  ADD KEY `fk_elementos_has_prestamos_elementos1_idx` (`elementos_idelemento`);

--
-- Indices de la tabla `elementos_has_prestamosespeciales`
--
ALTER TABLE `elementos_has_prestamosespeciales`
  ADD PRIMARY KEY (`elementos_idelemento`,`prestamosespeciales_idprestamo`),
  ADD KEY `elementos_idelemento` (`elementos_idelemento`),
  ADD KEY `elementos_has_prestamosespeciales_ibfk_2` (`prestamosespeciales_idprestamo`);

--
-- Indices de la tabla `encargos`
--
ALTER TABLE `encargos`
  ADD PRIMARY KEY (`idencargo`) USING BTREE,
  ADD KEY `fk_encargos_clientes1_idx` (`clientes_documento`) USING BTREE,
  ADD KEY `areas_idarea` (`areas_idarea`);

--
-- Indices de la tabla `historialpemdb`
--
ALTER TABLE `historialpemdb`
  ADD PRIMARY KEY (`id_historial`);

--
-- Indices de la tabla `moras`
--
ALTER TABLE `moras`
  ADD PRIMARY KEY (`idmora`) USING BTREE,
  ADD KEY `fk_moras_elementos1_idx` (`elementos_idelemento`),
  ADD KEY `fk_moras_clientes1_idx` (`clientes_documento`) USING BTREE,
  ADD KEY `areas_idarea` (`areas_idarea`);

--
-- Indices de la tabla `prestamoscorrientes`
--
ALTER TABLE `prestamoscorrientes`
  ADD PRIMARY KEY (`idprestamo`) USING BTREE,
  ADD KEY `fk_prestamos_clientes1_idx` (`clientes_documento`) USING BTREE,
  ADD KEY `areas_idarea` (`areas_idarea`);

--
-- Indices de la tabla `prestamosespeciales`
--
ALTER TABLE `prestamosespeciales`
  ADD PRIMARY KEY (`idprestamo`),
  ADD KEY `clientes_documento` (`clientes_documento`),
  ADD KEY `areas_idarea` (`areas_idarea`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `adminsesion`
--
ALTER TABLE `adminsesion`
  MODIFY `idsesion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `idarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `bajas`
--
ALTER TABLE `bajas`
  MODIFY `idbaja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `consumos`
--
ALTER TABLE `consumos`
  MODIFY `idconsumo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT de la tabla `danos`
--
ALTER TABLE `danos`
  MODIFY `iddano` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `encargos`
--
ALTER TABLE `encargos`
  MODIFY `idencargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT de la tabla `historialpemdb`
--
ALTER TABLE `historialpemdb`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `moras`
--
ALTER TABLE `moras`
  MODIFY `idmora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de la tabla `prestamoscorrientes`
--
ALTER TABLE `prestamoscorrientes`
  MODIFY `idprestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=503;

--
-- AUTO_INCREMENT de la tabla `prestamosespeciales`
--
ALTER TABLE `prestamosespeciales`
  MODIFY `idprestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD CONSTRAINT `administradores_ibfk_1` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `adminsesion`
--
ALTER TABLE `adminsesion`
  ADD CONSTRAINT `adminsesion_ibfk_1` FOREIGN KEY (`administradores_documento`) REFERENCES `administradores` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `bajas`
--
ALTER TABLE `bajas`
  ADD CONSTRAINT `bajas_ibfk_3` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_usuarios_roles1` FOREIGN KEY (`roles_idrol`) REFERENCES `roles` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `consumos`
--
ALTER TABLE `consumos`
  ADD CONSTRAINT `consumos_ibfk_1` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_consumos_usuarios1` FOREIGN KEY (`clientes_documento`) REFERENCES `clientes` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `danos`
--
ALTER TABLE `danos`
  ADD CONSTRAINT `danos_ibfk_1` FOREIGN KEY (`elementos_idelemento`) REFERENCES `elementos` (`idelemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `danos_ibfk_2` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_danos_usuarios1` FOREIGN KEY (`clientes_documento`) REFERENCES `clientes` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `elementos`
--
ALTER TABLE `elementos`
  ADD CONSTRAINT `elementos_ibfk_1` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `elementos_has_consumos`
--
ALTER TABLE `elementos_has_consumos`
  ADD CONSTRAINT `elementos_has_consumos_ibfk_1` FOREIGN KEY (`elementos_idelemento`) REFERENCES `elementos` (`idelemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_elementos_has_consumos_consumos1` FOREIGN KEY (`consumos_idconsumo`) REFERENCES `consumos` (`idconsumo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `elementos_has_encargos`
--
ALTER TABLE `elementos_has_encargos`
  ADD CONSTRAINT `elementos_has_encargos_ibfk_1` FOREIGN KEY (`elementos_idelemento`) REFERENCES `elementos` (`idelemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_elementos_has_encargos_encargos1` FOREIGN KEY (`encargos_idencargo`) REFERENCES `encargos` (`idencargo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `elementos_has_prestamoscorrientes`
--
ALTER TABLE `elementos_has_prestamoscorrientes`
  ADD CONSTRAINT `elementos_has_prestamoscorrientes_ibfk_1` FOREIGN KEY (`elementos_idelemento`) REFERENCES `elementos` (`idelemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_elementos_has_prestamos_prestamos1` FOREIGN KEY (`prestamoscorrientes_idprestamo`) REFERENCES `prestamoscorrientes` (`idprestamo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `elementos_has_prestamosespeciales`
--
ALTER TABLE `elementos_has_prestamosespeciales`
  ADD CONSTRAINT `elementos_has_prestamosespeciales_ibfk_2` FOREIGN KEY (`prestamosespeciales_idprestamo`) REFERENCES `prestamosespeciales` (`idprestamo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `elementos_has_prestamosespeciales_ibfk_3` FOREIGN KEY (`elementos_idelemento`) REFERENCES `elementos` (`idelemento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `encargos`
--
ALTER TABLE `encargos`
  ADD CONSTRAINT `encargos_ibfk_1` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_encargos_usuarios1` FOREIGN KEY (`clientes_documento`) REFERENCES `clientes` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `moras`
--
ALTER TABLE `moras`
  ADD CONSTRAINT `fk_moras_usuarios1` FOREIGN KEY (`clientes_documento`) REFERENCES `clientes` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `moras_ibfk_1` FOREIGN KEY (`elementos_idelemento`) REFERENCES `elementos` (`idelemento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `moras_ibfk_2` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`);

--
-- Filtros para la tabla `prestamoscorrientes`
--
ALTER TABLE `prestamoscorrientes`
  ADD CONSTRAINT `fk_prestamos_usuarios1` FOREIGN KEY (`clientes_documento`) REFERENCES `clientes` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prestamoscorrientes_ibfk_1` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `prestamosespeciales`
--
ALTER TABLE `prestamosespeciales`
  ADD CONSTRAINT `prestamosespeciales_ibfk_1` FOREIGN KEY (`clientes_documento`) REFERENCES `clientes` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prestamosespeciales_ibfk_2` FOREIGN KEY (`areas_idarea`) REFERENCES `areas` (`idarea`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
