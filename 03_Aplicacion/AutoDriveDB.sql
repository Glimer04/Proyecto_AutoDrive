-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2026 a las 00:13:10
-- Versión del servidor: 10.11.16-MariaDB
-- Versión de PHP: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `autodrivedb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `Auditoria_ID` int(11) NOT NULL,
  `Auditoria_Tabla` varchar(50) NOT NULL,
  `Auditoria_Operacion` varchar(20) NOT NULL,
  `Auditoria_Fecha` datetime DEFAULT current_timestamp(),
  `Auditoria_Usuario` varchar(50) DEFAULT NULL,
  `Auditoria_Detalle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `Categorias_ID` int(11) NOT NULL,
  `Categorias_Nombre` varchar(50) NOT NULL,
  `Categorias_Descripcion` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`Categorias_ID`, `Categorias_Nombre`, `Categorias_Descripcion`) VALUES
(1, 'SUV', 'Vehículos utilitarios deportivos'),
(2, 'Sedán', 'Vehículos de paseo'),
(3, 'Camioneta', 'Vehículos de carga ligera');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `Clientes_ID` int(11) NOT NULL,
  `Clientes_Cedula` varchar(15) NOT NULL,
  `Clientes_Nombre` varchar(100) NOT NULL,
  `Clientes_Licencia` varchar(20) NOT NULL,
  `Clientes_FechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Clientes_ID`, `Clientes_Cedula`, `Clientes_Nombre`, `Clientes_Licencia`, `Clientes_FechaRegistro`) VALUES
(1, '402-1234567-8', 'Luis Martínez', 'LIC-99881', '2026-11-11 20:31:54'),
(2, '402-8765432-1', 'María Rodríguez', 'LIC-77662', '2026-11-11 20:31:54'),
(3, '001-5555555-5', 'Empresa XYZ S.R.L.', 'LIC-CORP01', '2026-11-11 20:31:54'),
(10, '999-9999999-9', 'Pedro Nuevo', 'LIC-99999', '2026-11-11 22:37:18'),
(12, '00118980000', 'Carlos Prueba', '00118980000', '2026-11-11 22:38:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE `contactos` (
  `Contactos_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Contactos_Telefono` varchar(15) NOT NULL,
  `Contactos_Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contactos`
--

INSERT INTO `contactos` (`Contactos_ID`, `Clientes_ID`, `Contactos_Telefono`, `Contactos_Email`) VALUES
(1, 1, '809-555-1234', 'luis@gmail.com'),
(2, 2, '829-555-5678', 'maria@hotmail.com'),
(3, 3, '809-555-0000', 'logistica@xyz.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratos`
--

CREATE TABLE `contratos` (
  `Contratos_ID` int(11) NOT NULL,
  `Reservas_ID` int(11) NOT NULL,
  `Empleados_ID` int(11) NOT NULL,
  `Contratos_FechaFirma` datetime DEFAULT current_timestamp(),
  `Contratos_Estado` varchar(20) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallemantenimiento`
--

CREATE TABLE `detallemantenimiento` (
  `DetalleMantenimiento_ID` int(11) NOT NULL,
  `Mantenimientos_ID` int(11) NOT NULL,
  `DetalleMantenimiento_Descripcion` varchar(150) NOT NULL,
  `DetalleMantenimiento_Costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones`
--

CREATE TABLE `devoluciones` (
  `Devoluciones_ID` int(11) NOT NULL,
  `Contratos_ID` int(11) NOT NULL,
  `Devoluciones_Fecha` datetime DEFAULT current_timestamp(),
  `Devoluciones_Kilometraje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

CREATE TABLE `direcciones` (
  `Direcciones_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Direcciones_Detalle` varchar(150) NOT NULL,
  `Direcciones_Ciudad` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `direcciones`
--

INSERT INTO `direcciones` (`Direcciones_ID`, `Clientes_ID`, `Direcciones_Detalle`, `Direcciones_Ciudad`) VALUES
(1, 1, 'Calle 1 #23, Ensanche Naco', 'Santo Domingo'),
(2, 2, 'Av. Estrella Sadhalá #45', 'Santiago'),
(3, 3, 'Av. 27 de Febrero #100', 'Santo Domingo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `Empleados_ID` int(11) NOT NULL,
  `Empleados_Cedula` varchar(15) NOT NULL,
  `Empleados_Nombre` varchar(100) NOT NULL,
  `Empleados_Cargo` varchar(50) NOT NULL,
  `Empleados_FechaIngreso` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`Empleados_ID`, `Empleados_Cedula`, `Empleados_Nombre`, `Empleados_Cargo`, `Empleados_FechaIngreso`) VALUES
(1, '001-1111111-1', 'Carlos Pérez', 'Gerente', '2026-11-11'),
(2, '001-2222222-2', 'Ana Gómez', 'Agente de Alquiler', '2026-11-11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entregas`
--

CREATE TABLE `entregas` (
  `Entregas_ID` int(11) NOT NULL,
  `Contratos_ID` int(11) NOT NULL,
  `Entregas_Kilometraje` int(11) NOT NULL,
  `Entregas_NivelCombustible` varchar(20) NOT NULL,
  `Entregas_Observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadosvehiculo`
--

CREATE TABLE `estadosvehiculo` (
  `EstadosVehiculo_ID` int(11) NOT NULL,
  `EstadosVehiculo_Descripcion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estadosvehiculo`
--

INSERT INTO `estadosvehiculo` (`EstadosVehiculo_ID`, `EstadosVehiculo_Descripcion`) VALUES
(2, 'Alquilado'),
(1, 'Disponible'),
(3, 'En Mantenimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `Facturas_ID` int(11) NOT NULL,
  `Contratos_ID` int(11) NOT NULL,
  `Facturas_FechaEmision` datetime DEFAULT current_timestamp(),
  `Facturas_MontoTotal` decimal(10,2) NOT NULL,
  `Facturas_Estado` varchar(20) DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimientos`
--

CREATE TABLE `mantenimientos` (
  `Mantenimientos_ID` int(11) NOT NULL,
  `Vehiculos_ID` int(11) NOT NULL,
  `Proveedores_ID` int(11) NOT NULL,
  `Mantenimientos_Fecha` date DEFAULT curdate(),
  `Mantenimientos_CostoTotal` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mantenimientos`
--

INSERT INTO `mantenimientos` (`Mantenimientos_ID`, `Vehiculos_ID`, `Proveedores_ID`, `Mantenimientos_Fecha`, `Mantenimientos_CostoTotal`) VALUES
(1, 4, 2, '2023-10-15', 150.00),
(2, 3, 1, '2026-11-11', 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `Marcas_ID` int(11) NOT NULL,
  `Marcas_Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`Marcas_ID`, `Marcas_Nombre`) VALUES
(3, 'Honda'),
(2, 'Hyundai'),
(1, 'Toyota');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodospago`
--

CREATE TABLE `metodospago` (
  `MetodosPago_ID` int(11) NOT NULL,
  `MetodosPago_Descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `multas`
--

CREATE TABLE `multas` (
  `Multas_ID` int(11) NOT NULL,
  `Devoluciones_ID` int(11) NOT NULL,
  `Multas_Motivo` varchar(150) NOT NULL,
  `Multas_Monto` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `Pagos_ID` int(11) NOT NULL,
  `Facturas_ID` int(11) NOT NULL,
  `MetodosPago_ID` int(11) NOT NULL,
  `Pagos_Monto` decimal(10,2) NOT NULL,
  `Pagos_Fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `Proveedores_ID` int(11) NOT NULL,
  `Proveedores_Nombre` varchar(100) NOT NULL,
  `Proveedores_Telefono` varchar(15) DEFAULT NULL,
  `Proveedores_Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`Proveedores_ID`, `Proveedores_Nombre`, `Proveedores_Telefono`, `Proveedores_Email`) VALUES
(1, 'Repuestos El Motor', '809-123-4567', NULL),
(2, 'Taller La Rueda', '809-765-4321', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `Reservas_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Vehiculos_ID` int(11) NOT NULL,
  `Reservas_FechaInicio` date NOT NULL,
  `Reservas_FechaFin` date NOT NULL,
  `Reservas_Estado` varchar(20) DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`Reservas_ID`, `Clientes_ID`, `Vehiculos_ID`, `Reservas_FechaInicio`, `Reservas_FechaFin`, `Reservas_Estado`) VALUES
(1, 2, 1, '2026-11-16', '2026-11-20', 'Pendiente'),
(2, 1, 1, '2026-11-17', '2026-11-22', 'Pendiente'),
(3, 1, 3, '2026-11-11', '2026-11-12', 'Pendiente');

--
-- Disparadores `reservas`
--
DELIMITER $$
CREATE TRIGGER `tr_validar_doble_reserva` BEFORE INSERT ON `reservas` FOR EACH ROW BEGIN
    -- Validar que la fecha de fin sea mayor a la de inicio
    IF NEW.Reservas_FechaFin <= NEW.Reservas_FechaInicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de fin debe ser posterior a la de inicio.';
    END IF;

    -- Validar que el vehículo no esté reservado en esas fechas
    IF EXISTS (
        SELECT 1 FROM Reservas 
        WHERE Vehiculos_ID = NEW.Vehiculos_ID 
        AND Reservas_Estado IN ('Pendiente', 'Confirmada')
        AND (NEW.Reservas_FechaInicio <= Reservas_FechaFin AND NEW.Reservas_FechaFin >= Reservas_FechaInicio)
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El vehículo ya está reservado en esas fechas.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `Roles_ID` int(11) NOT NULL,
  `Roles_Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`Roles_ID`, `Roles_Nombre`) VALUES
(1, 'Administrador'),
(2, 'Agente de Ventas'),
(3, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguros`
--

CREATE TABLE `seguros` (
  `Seguros_ID` int(11) NOT NULL,
  `Vehiculos_ID` int(11) NOT NULL,
  `Seguros_Poliza` varchar(50) NOT NULL,
  `Seguros_Costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudessoporte`
--

CREATE TABLE `solicitudessoporte` (
  `SolicitudesSoporte_ID` int(11) NOT NULL,
  `SolicitudesSoporte_Nombre` varchar(100) NOT NULL,
  `SolicitudesSoporte_Email` varchar(100) NOT NULL,
  `SolicitudesSoporte_Categoria` varchar(50) DEFAULT 'Otro',
  `SolicitudesSoporte_Mensaje` varchar(500) NOT NULL,
  `SolicitudesSoporte_Fecha` datetime DEFAULT current_timestamp(),
  `SolicitudesSoporte_Estado` varchar(20) DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifas`
--

CREATE TABLE `tarifas` (
  `Tarifas_ID` int(11) NOT NULL,
  `Categorias_ID` int(11) NOT NULL,
  `Tarifas_PrecioDiario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarifas`
--

INSERT INTO `tarifas` (`Tarifas_ID`, `Categorias_ID`, `Tarifas_PrecioDiario`) VALUES
(1, 1, 4500.00),
(2, 2, 2700.00),
(3, 3, 5400.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Usuarios_ID` int(11) NOT NULL,
  `Usuarios_Nombre` varchar(50) NOT NULL,
  `Usuarios_Clave` varchar(255) NOT NULL,
  `Roles_ID` int(11) NOT NULL,
  `Usuarios_Estado` varchar(20) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Usuarios_ID`, `Usuarios_Nombre`, `Usuarios_Clave`, `Roles_ID`, `Usuarios_Estado`) VALUES
(1, 'admin', '12345', 1, 'Activo'),
(2, 'juan_agente', '12345', 2, 'Activo'),
(9, 'pedro_nuevo', '12345', 3, 'Activo'),
(10, 'carlos_prueba', '12345', 3, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `Vehiculos_ID` int(11) NOT NULL,
  `Vehiculos_Placa` varchar(10) NOT NULL,
  `Vehiculos_Anio` int(11) NOT NULL,
  `Marcas_ID` int(11) NOT NULL,
  `Categorias_ID` int(11) NOT NULL,
  `EstadosVehiculo_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`Vehiculos_ID`, `Vehiculos_Placa`, `Vehiculos_Anio`, `Marcas_ID`, `Categorias_ID`, `EstadosVehiculo_ID`) VALUES
(1, 'A123456', 2022, 1, 1, 1),
(2, 'B987654', 2021, 2, 2, 1),
(3, 'C555555', 2023, 3, 3, 1),
(4, 'D111111', 2020, 1, 1, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`Auditoria_ID`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`Categorias_ID`),
  ADD UNIQUE KEY `Categorias_Nombre` (`Categorias_Nombre`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Clientes_ID`),
  ADD UNIQUE KEY `Clientes_Cedula` (`Clientes_Cedula`),
  ADD UNIQUE KEY `Clientes_Licencia` (`Clientes_Licencia`);

--
-- Indices de la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD PRIMARY KEY (`Contactos_ID`),
  ADD KEY `Clientes_ID` (`Clientes_ID`);

--
-- Indices de la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`Contratos_ID`),
  ADD UNIQUE KEY `Reservas_ID` (`Reservas_ID`),
  ADD KEY `Empleados_ID` (`Empleados_ID`);

--
-- Indices de la tabla `detallemantenimiento`
--
ALTER TABLE `detallemantenimiento`
  ADD PRIMARY KEY (`DetalleMantenimiento_ID`),
  ADD KEY `Mantenimientos_ID` (`Mantenimientos_ID`);

--
-- Indices de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`Devoluciones_ID`),
  ADD UNIQUE KEY `Contratos_ID` (`Contratos_ID`);

--
-- Indices de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`Direcciones_ID`),
  ADD KEY `Clientes_ID` (`Clientes_ID`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`Empleados_ID`),
  ADD UNIQUE KEY `Empleados_Cedula` (`Empleados_Cedula`);

--
-- Indices de la tabla `entregas`
--
ALTER TABLE `entregas`
  ADD PRIMARY KEY (`Entregas_ID`),
  ADD KEY `Contratos_ID` (`Contratos_ID`);

--
-- Indices de la tabla `estadosvehiculo`
--
ALTER TABLE `estadosvehiculo`
  ADD PRIMARY KEY (`EstadosVehiculo_ID`),
  ADD UNIQUE KEY `EstadosVehiculo_Descripcion` (`EstadosVehiculo_Descripcion`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`Facturas_ID`),
  ADD UNIQUE KEY `Contratos_ID` (`Contratos_ID`);

--
-- Indices de la tabla `mantenimientos`
--
ALTER TABLE `mantenimientos`
  ADD PRIMARY KEY (`Mantenimientos_ID`),
  ADD KEY `Vehiculos_ID` (`Vehiculos_ID`),
  ADD KEY `Proveedores_ID` (`Proveedores_ID`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`Marcas_ID`),
  ADD UNIQUE KEY `Marcas_Nombre` (`Marcas_Nombre`);

--
-- Indices de la tabla `metodospago`
--
ALTER TABLE `metodospago`
  ADD PRIMARY KEY (`MetodosPago_ID`),
  ADD UNIQUE KEY `MetodosPago_Descripcion` (`MetodosPago_Descripcion`);

--
-- Indices de la tabla `multas`
--
ALTER TABLE `multas`
  ADD PRIMARY KEY (`Multas_ID`),
  ADD KEY `Devoluciones_ID` (`Devoluciones_ID`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`Pagos_ID`),
  ADD KEY `Facturas_ID` (`Facturas_ID`),
  ADD KEY `MetodosPago_ID` (`MetodosPago_ID`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`Proveedores_ID`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`Reservas_ID`),
  ADD KEY `Clientes_ID` (`Clientes_ID`),
  ADD KEY `Vehiculos_ID` (`Vehiculos_ID`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Roles_ID`),
  ADD UNIQUE KEY `Roles_Nombre` (`Roles_Nombre`);

--
-- Indices de la tabla `seguros`
--
ALTER TABLE `seguros`
  ADD PRIMARY KEY (`Seguros_ID`),
  ADD KEY `Vehiculos_ID` (`Vehiculos_ID`);

--
-- Indices de la tabla `solicitudessoporte`
--
ALTER TABLE `solicitudessoporte`
  ADD PRIMARY KEY (`SolicitudesSoporte_ID`);

--
-- Indices de la tabla `tarifas`
--
ALTER TABLE `tarifas`
  ADD PRIMARY KEY (`Tarifas_ID`),
  ADD KEY `Categorias_ID` (`Categorias_ID`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Usuarios_ID`),
  ADD UNIQUE KEY `Usuarios_Nombre` (`Usuarios_Nombre`),
  ADD KEY `Roles_ID` (`Roles_ID`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`Vehiculos_ID`),
  ADD UNIQUE KEY `Vehiculos_Placa` (`Vehiculos_Placa`),
  ADD KEY `Marcas_ID` (`Marcas_ID`),
  ADD KEY `Categorias_ID` (`Categorias_ID`),
  ADD KEY `EstadosVehiculo_ID` (`EstadosVehiculo_ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `Auditoria_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `Categorias_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `Clientes_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `Contactos_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `contratos`
--
ALTER TABLE `contratos`
  MODIFY `Contratos_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detallemantenimiento`
--
ALTER TABLE `detallemantenimiento`
  MODIFY `DetalleMantenimiento_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `Devoluciones_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `Direcciones_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `Empleados_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `entregas`
--
ALTER TABLE `entregas`
  MODIFY `Entregas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estadosvehiculo`
--
ALTER TABLE `estadosvehiculo`
  MODIFY `EstadosVehiculo_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `Facturas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mantenimientos`
--
ALTER TABLE `mantenimientos`
  MODIFY `Mantenimientos_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `Marcas_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `metodospago`
--
ALTER TABLE `metodospago`
  MODIFY `MetodosPago_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `multas`
--
ALTER TABLE `multas`
  MODIFY `Multas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `Pagos_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `Proveedores_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `Reservas_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `Roles_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `seguros`
--
ALTER TABLE `seguros`
  MODIFY `Seguros_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudessoporte`
--
ALTER TABLE `solicitudessoporte`
  MODIFY `SolicitudesSoporte_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarifas`
--
ALTER TABLE `tarifas`
  MODIFY `Tarifas_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Usuarios_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `Vehiculos_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD CONSTRAINT `contactos_ibfk_1` FOREIGN KEY (`Clientes_ID`) REFERENCES `clientes` (`Clientes_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_ibfk_1` FOREIGN KEY (`Reservas_ID`) REFERENCES `reservas` (`Reservas_ID`),
  ADD CONSTRAINT `contratos_ibfk_2` FOREIGN KEY (`Empleados_ID`) REFERENCES `empleados` (`Empleados_ID`);

--
-- Filtros para la tabla `detallemantenimiento`
--
ALTER TABLE `detallemantenimiento`
  ADD CONSTRAINT `detallemantenimiento_ibfk_1` FOREIGN KEY (`Mantenimientos_ID`) REFERENCES `mantenimientos` (`Mantenimientos_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`Contratos_ID`) REFERENCES `contratos` (`Contratos_ID`);

--
-- Filtros para la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD CONSTRAINT `direcciones_ibfk_1` FOREIGN KEY (`Clientes_ID`) REFERENCES `clientes` (`Clientes_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `entregas`
--
ALTER TABLE `entregas`
  ADD CONSTRAINT `entregas_ibfk_1` FOREIGN KEY (`Contratos_ID`) REFERENCES `contratos` (`Contratos_ID`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`Contratos_ID`) REFERENCES `contratos` (`Contratos_ID`);

--
-- Filtros para la tabla `mantenimientos`
--
ALTER TABLE `mantenimientos`
  ADD CONSTRAINT `mantenimientos_ibfk_1` FOREIGN KEY (`Vehiculos_ID`) REFERENCES `vehiculos` (`Vehiculos_ID`),
  ADD CONSTRAINT `mantenimientos_ibfk_2` FOREIGN KEY (`Proveedores_ID`) REFERENCES `proveedores` (`Proveedores_ID`);

--
-- Filtros para la tabla `multas`
--
ALTER TABLE `multas`
  ADD CONSTRAINT `multas_ibfk_1` FOREIGN KEY (`Devoluciones_ID`) REFERENCES `devoluciones` (`Devoluciones_ID`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`Facturas_ID`) REFERENCES `facturas` (`Facturas_ID`),
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`MetodosPago_ID`) REFERENCES `metodospago` (`MetodosPago_ID`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`Clientes_ID`) REFERENCES `clientes` (`Clientes_ID`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`Vehiculos_ID`) REFERENCES `vehiculos` (`Vehiculos_ID`);

--
-- Filtros para la tabla `seguros`
--
ALTER TABLE `seguros`
  ADD CONSTRAINT `seguros_ibfk_1` FOREIGN KEY (`Vehiculos_ID`) REFERENCES `vehiculos` (`Vehiculos_ID`);

--
-- Filtros para la tabla `tarifas`
--
ALTER TABLE `tarifas`
  ADD CONSTRAINT `tarifas_ibfk_1` FOREIGN KEY (`Categorias_ID`) REFERENCES `categorias` (`Categorias_ID`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Roles_ID`) REFERENCES `roles` (`Roles_ID`);

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `vehiculos_ibfk_1` FOREIGN KEY (`Marcas_ID`) REFERENCES `marcas` (`Marcas_ID`),
  ADD CONSTRAINT `vehiculos_ibfk_2` FOREIGN KEY (`Categorias_ID`) REFERENCES `categorias` (`Categorias_ID`),
  ADD CONSTRAINT `vehiculos_ibfk_3` FOREIGN KEY (`EstadosVehiculo_ID`) REFERENCES `estadosvehiculo` (`EstadosVehiculo_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
