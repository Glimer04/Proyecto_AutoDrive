-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: sql211.byetcluster.com
-- Tiempo de generación: 23-11-2026 a las 15:54:24
-- Versión del servidor: 11.4.14-MariaDB
-- Versión de PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `if0_43419035_autodrive`
--
CREATE DATABASE IF NOT EXISTS `if0_43419035_autodrive` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `if0_43419035_autodrive`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Auditoria`
--

DROP TABLE IF EXISTS `Auditoria`;
CREATE TABLE `Auditoria` (
  `Auditoria_ID` int(11) NOT NULL,
  `Auditoria_Tabla` varchar(50) NOT NULL,
  `Auditoria_Operacion` varchar(20) NOT NULL,
  `Auditoria_Fecha` datetime DEFAULT current_timestamp(),
  `Auditoria_Usuario` varchar(50) DEFAULT NULL,
  `Auditoria_Detalle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Categorias`
--

DROP TABLE IF EXISTS `Categorias`;
CREATE TABLE `Categorias` (
  `Categorias_ID` int(11) NOT NULL,
  `Categorias_Nombre` varchar(50) NOT NULL,
  `Categorias_Descripcion` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Categorias`
--

INSERT INTO `Categorias` (`Categorias_ID`, `Categorias_Nombre`, `Categorias_Descripcion`) VALUES
(1, 'SUV', 'Vehículos utilitarios deportivos'),
(2, 'Sedán', 'Vehículos de paseo'),
(3, 'Camioneta', 'Vehículos de carga ligera');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Clientes`
--

DROP TABLE IF EXISTS `Clientes`;
CREATE TABLE `Clientes` (
  `Clientes_ID` int(11) NOT NULL,
  `Clientes_Cedula` varchar(15) NOT NULL,
  `Clientes_Nombre` varchar(100) NOT NULL,
  `Clientes_Licencia` varchar(20) NOT NULL,
  `Clientes_FechaRegistro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Clientes`
--

INSERT INTO `Clientes` (`Clientes_ID`, `Clientes_Cedula`, `Clientes_Nombre`, `Clientes_Licencia`, `Clientes_FechaRegistro`) VALUES
(1, '402-1234567-8', 'Luis Martínez', 'LIC-99881', '2026-11-11 20:31:54'),
(2, '402-8765432-1', 'María Rodríguez', 'LIC-77662', '2026-11-11 20:31:54'),
(3, '001-5555555-5', 'Empresa XYZ S.R.L.', 'LIC-CORP01', '2026-11-11 20:31:54'),
(10, '999-9999999-9', 'Pedro Nuevo', 'LIC-99999', '2026-11-11 22:37:18'),
(12, '00118980000', 'Carlos Prueba', '00118980000', '2026-11-11 22:38:01'),
(13, '40220633178', 'Dodany Pichardo', 'LIC-998819', '2026-11-12 15:43:37'),
(18, '001-000005555-0', 'Waldo Jimanez', 'LIC5550', '2026-11-22 06:47:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Contactos`
--

DROP TABLE IF EXISTS `Contactos`;
CREATE TABLE `Contactos` (
  `Contactos_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Contactos_Telefono` varchar(15) NOT NULL,
  `Contactos_Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Contactos`
--

INSERT INTO `Contactos` (`Contactos_ID`, `Clientes_ID`, `Contactos_Telefono`, `Contactos_Email`) VALUES
(1, 1, '809-555-1234', 'luis@gmail.com'),
(2, 2, '829-555-5678', 'maria@hotmail.com'),
(3, 3, '809-555-0000', 'logistica@xyz.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Contratos`
--

DROP TABLE IF EXISTS `Contratos`;
CREATE TABLE `Contratos` (
  `Contratos_ID` int(11) NOT NULL,
  `Reservas_ID` int(11) NOT NULL,
  `Empleados_ID` int(11) NOT NULL,
  `Contratos_FechaFirma` datetime DEFAULT current_timestamp(),
  `Contratos_Estado` varchar(20) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DetalleMantenimiento`
--

DROP TABLE IF EXISTS `DetalleMantenimiento`;
CREATE TABLE `DetalleMantenimiento` (
  `DetalleMantenimiento_ID` int(11) NOT NULL,
  `Mantenimientos_ID` int(11) NOT NULL,
  `DetalleMantenimiento_Descripcion` varchar(150) NOT NULL,
  `DetalleMantenimiento_Costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Devoluciones`
--

DROP TABLE IF EXISTS `Devoluciones`;
CREATE TABLE `Devoluciones` (
  `Devoluciones_ID` int(11) NOT NULL,
  `Contratos_ID` int(11) NOT NULL,
  `Devoluciones_Fecha` datetime DEFAULT current_timestamp(),
  `Devoluciones_Kilometraje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Direcciones`
--

DROP TABLE IF EXISTS `Direcciones`;
CREATE TABLE `Direcciones` (
  `Direcciones_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Direcciones_Detalle` varchar(150) NOT NULL,
  `Direcciones_Ciudad` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Direcciones`
--

INSERT INTO `Direcciones` (`Direcciones_ID`, `Clientes_ID`, `Direcciones_Detalle`, `Direcciones_Ciudad`) VALUES
(1, 1, 'Calle 1 #23, Ensanche Naco', 'Santo Domingo'),
(2, 2, 'Av. Estrella Sadhalá #45', 'Santiago'),
(3, 3, 'Av. 27 de Febrero #100', 'Santo Domingo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Empleados`
--

DROP TABLE IF EXISTS `Empleados`;
CREATE TABLE `Empleados` (
  `Empleados_ID` int(11) NOT NULL,
  `Empleados_Cedula` varchar(15) NOT NULL,
  `Empleados_Nombre` varchar(100) NOT NULL,
  `Empleados_Cargo` varchar(50) NOT NULL,
  `Empleados_FechaIngreso` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Empleados`
--

INSERT INTO `Empleados` (`Empleados_ID`, `Empleados_Cedula`, `Empleados_Nombre`, `Empleados_Cargo`, `Empleados_FechaIngreso`) VALUES
(1, '001-1111111-1', 'Carlos Pérez', 'Gerente', '2026-11-11'),
(2, '001-2222222-2', 'Ana Gómez', 'Agente de Alquiler', '2026-11-11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Entregas`
--

DROP TABLE IF EXISTS `Entregas`;
CREATE TABLE `Entregas` (
  `Entregas_ID` int(11) NOT NULL,
  `Contratos_ID` int(11) NOT NULL,
  `Entregas_Kilometraje` int(11) NOT NULL,
  `Entregas_NivelCombustible` varchar(20) NOT NULL,
  `Entregas_Observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `EstadosVehiculo`
--

DROP TABLE IF EXISTS `EstadosVehiculo`;
CREATE TABLE `EstadosVehiculo` (
  `EstadosVehiculo_ID` int(11) NOT NULL,
  `EstadosVehiculo_Descripcion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `EstadosVehiculo`
--

INSERT INTO `EstadosVehiculo` (`EstadosVehiculo_ID`, `EstadosVehiculo_Descripcion`) VALUES
(1, 'Disponible'),
(2, 'Alquilado'),
(3, 'En Mantenimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Facturas`
--

DROP TABLE IF EXISTS `Facturas`;
CREATE TABLE `Facturas` (
  `Facturas_ID` int(11) NOT NULL,
  `Contratos_ID` int(11) NOT NULL,
  `Facturas_FechaEmision` datetime DEFAULT current_timestamp(),
  `Facturas_MontoTotal` decimal(10,2) NOT NULL,
  `Facturas_Estado` varchar(20) DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Mantenimientos`
--

DROP TABLE IF EXISTS `Mantenimientos`;
CREATE TABLE `Mantenimientos` (
  `Mantenimientos_ID` int(11) NOT NULL,
  `Vehiculos_ID` int(11) NOT NULL,
  `Proveedores_ID` int(11) NOT NULL,
  `Mantenimientos_Fecha` date DEFAULT curdate(),
  `Mantenimientos_CostoTotal` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Mantenimientos`
--

INSERT INTO `Mantenimientos` (`Mantenimientos_ID`, `Vehiculos_ID`, `Proveedores_ID`, `Mantenimientos_Fecha`, `Mantenimientos_CostoTotal`) VALUES
(1, 4, 2, '2023-10-15', '150.00'),
(2, 3, 1, '2026-11-11', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Marcas`
--

DROP TABLE IF EXISTS `Marcas`;
CREATE TABLE `Marcas` (
  `Marcas_ID` int(11) NOT NULL,
  `Marcas_Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Marcas`
--

INSERT INTO `Marcas` (`Marcas_ID`, `Marcas_Nombre`) VALUES
(1, 'Toyota'),
(2, 'Hyundai'),
(3, 'Honda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MetodosPago`
--

DROP TABLE IF EXISTS `MetodosPago`;
CREATE TABLE `MetodosPago` (
  `MetodosPago_ID` int(11) NOT NULL,
  `MetodosPago_Descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Multas`
--

DROP TABLE IF EXISTS `Multas`;
CREATE TABLE `Multas` (
  `Multas_ID` int(11) NOT NULL,
  `Devoluciones_ID` int(11) NOT NULL,
  `Multas_Motivo` varchar(150) NOT NULL,
  `Multas_Monto` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pagos`
--

DROP TABLE IF EXISTS `Pagos`;
CREATE TABLE `Pagos` (
  `Pagos_ID` int(11) NOT NULL,
  `Facturas_ID` int(11) NOT NULL,
  `MetodosPago_ID` int(11) NOT NULL,
  `Pagos_Monto` decimal(10,2) NOT NULL,
  `Pagos_Fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Proveedores`
--

DROP TABLE IF EXISTS `Proveedores`;
CREATE TABLE `Proveedores` (
  `Proveedores_ID` int(11) NOT NULL,
  `Proveedores_Nombre` varchar(100) NOT NULL,
  `Proveedores_Telefono` varchar(15) DEFAULT NULL,
  `Proveedores_Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Proveedores`
--

INSERT INTO `Proveedores` (`Proveedores_ID`, `Proveedores_Nombre`, `Proveedores_Telefono`, `Proveedores_Email`) VALUES
(1, 'Repuestos El Motor', '809-123-4567', NULL),
(2, 'Taller La Rueda', '809-765-4321', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Resenas`
--

DROP TABLE IF EXISTS `Resenas`;
CREATE TABLE `Resenas` (
  `Resenas_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Resenas_Estrellas` int(11) NOT NULL,
  `Resenas_Comentario` varchar(255) DEFAULT NULL,
  `Resenas_Fecha` datetime DEFAULT current_timestamp()
) ;

--
-- Volcado de datos para la tabla `Resenas`
--

INSERT INTO `Resenas` (`Resenas_ID`, `Clientes_ID`, `Resenas_Estrellas`, `Resenas_Comentario`, `Resenas_Fecha`) VALUES
(1, 1, 5, 'Excelente servicio, el vehículo estaba impecable.', '2026-11-23 05:29:19'),
(2, 2, 4, 'Buen trato, pero la entrega tardó un poco.', '2026-11-23 05:29:19'),
(3, 1, 3, NULL, '2026-11-23 05:29:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Reservas`
--

DROP TABLE IF EXISTS `Reservas`;
CREATE TABLE `Reservas` (
  `Reservas_ID` int(11) NOT NULL,
  `Clientes_ID` int(11) NOT NULL,
  `Vehiculos_ID` int(11) NOT NULL,
  `Reservas_FechaInicio` date NOT NULL,
  `Reservas_FechaFin` date NOT NULL,
  `Reservas_Estado` varchar(20) DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Reservas`
--

INSERT INTO `Reservas` (`Reservas_ID`, `Clientes_ID`, `Vehiculos_ID`, `Reservas_FechaInicio`, `Reservas_FechaFin`, `Reservas_Estado`) VALUES
(1, 2, 1, '2026-11-16', '2026-11-20', 'Pendiente'),
(2, 1, 1, '2026-11-17', '2026-11-22', 'Pendiente'),
(3, 1, 3, '2026-11-11', '2026-11-12', 'Pendiente'),
(4, 12, 3, '2026-11-24', '2026-11-30', 'Pendiente'),
(5, 1, 1, '2026-11-30', '2026-12-01', 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roles`
--

DROP TABLE IF EXISTS `Roles`;
CREATE TABLE `Roles` (
  `Roles_ID` int(11) NOT NULL,
  `Roles_Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Roles`
--

INSERT INTO `Roles` (`Roles_ID`, `Roles_Nombre`) VALUES
(1, 'Administrador'),
(2, 'Agente de Ventas'),
(3, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Seguros`
--

DROP TABLE IF EXISTS `Seguros`;
CREATE TABLE `Seguros` (
  `Seguros_ID` int(11) NOT NULL,
  `Vehiculos_ID` int(11) NOT NULL,
  `Seguros_Poliza` varchar(50) NOT NULL,
  `Seguros_Costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SolicitudesSoporte`
--

DROP TABLE IF EXISTS `SolicitudesSoporte`;
CREATE TABLE `SolicitudesSoporte` (
  `SolicitudesSoporte_ID` int(11) NOT NULL,
  `SolicitudesSoporte_Nombre` varchar(100) NOT NULL,
  `SolicitudesSoporte_Email` varchar(100) NOT NULL,
  `SolicitudesSoporte_Categoria` varchar(50) DEFAULT 'Otro',
  `SolicitudesSoporte_Mensaje` varchar(500) NOT NULL,
  `SolicitudesSoporte_Fecha` datetime DEFAULT current_timestamp(),
  `SolicitudesSoporte_Estado` varchar(20) DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `SolicitudesSoporte`
--

INSERT INTO `SolicitudesSoporte` (`SolicitudesSoporte_ID`, `SolicitudesSoporte_Nombre`, `SolicitudesSoporte_Email`, `SolicitudesSoporte_Categoria`, `SolicitudesSoporte_Mensaje`, `SolicitudesSoporte_Fecha`, `SolicitudesSoporte_Estado`) VALUES
(1, 'admin', '55221332@gmail.com', 'Cliente', 'Pedro Prueba necesita asistencia via Telefonica', '2026-11-13 15:20:42', 'Pendiente'),
(2, 'admin', '55221332@gmail.com', 'Vehiculo', 'Falla Identificada en las Luces Nocturnas', '2026-11-13 15:52:03', 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tarifas`
--

DROP TABLE IF EXISTS `Tarifas`;
CREATE TABLE `Tarifas` (
  `Tarifas_ID` int(11) NOT NULL,
  `Categorias_ID` int(11) NOT NULL,
  `Tarifas_PrecioDiario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Tarifas`
--

INSERT INTO `Tarifas` (`Tarifas_ID`, `Categorias_ID`, `Tarifas_PrecioDiario`) VALUES
(1, 1, '4500.00'),
(2, 2, '2700.00'),
(3, 3, '5400.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

DROP TABLE IF EXISTS `Usuarios`;
CREATE TABLE `Usuarios` (
  `Usuarios_ID` int(11) NOT NULL,
  `Usuarios_Nombre` varchar(50) NOT NULL,
  `Usuarios_Clave` varchar(255) NOT NULL,
  `Roles_ID` int(11) NOT NULL,
  `Usuarios_Estado` varchar(20) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Usuarios`
--

INSERT INTO `Usuarios` (`Usuarios_ID`, `Usuarios_Nombre`, `Usuarios_Clave`, `Roles_ID`, `Usuarios_Estado`) VALUES
(1, 'admin', '12345', 1, 'Activo'),
(2, 'juan_agente', '12345', 2, 'Activo'),
(9, 'pedro_nuevo', '12345', 3, 'Activo'),
(10, 'carlos_prueba', '12345', 3, 'Activo'),
(11, 'Waldo', '12345', 3, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Vehiculos`
--

DROP TABLE IF EXISTS `Vehiculos`;
CREATE TABLE `Vehiculos` (
  `Vehiculos_ID` int(11) NOT NULL,
  `Vehiculos_Placa` varchar(10) NOT NULL,
  `Vehiculos_Anio` int(11) NOT NULL,
  `Marcas_ID` int(11) NOT NULL,
  `Categorias_ID` int(11) NOT NULL,
  `EstadosVehiculo_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Vehiculos`
--

INSERT INTO `Vehiculos` (`Vehiculos_ID`, `Vehiculos_Placa`, `Vehiculos_Anio`, `Marcas_ID`, `Categorias_ID`, `EstadosVehiculo_ID`) VALUES
(1, 'A123456', 2022, 1, 1, 1),
(2, 'B987654', 2021, 2, 2, 1),
(3, 'C555555', 2023, 3, 3, 1),
(4, 'D111111', 2020, 1, 1, 3);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `Vista_PromedioResenas`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `Vista_PromedioResenas`;
CREATE TABLE `Vista_PromedioResenas` (
`Clientes_ID` int(11)
,`Clientes_Nombre` varchar(100)
,`TotalResenas` bigint(21)
,`PromedioEstrellas` decimal(12,1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `Vista_VehiculosDisponibles`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `Vista_VehiculosDisponibles`;
CREATE TABLE `Vista_VehiculosDisponibles` (
`Vehiculos_Placa` varchar(10)
,`Marca` varchar(50)
,`Categoria` varchar(50)
,`Precio_Diario` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `Vista_PromedioResenas`
--
DROP TABLE IF EXISTS `Vista_PromedioResenas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`if0_43419035`@`192.168.0.%` SQL SECURITY DEFINER VIEW `Vista_PromedioResenas`  AS  select `C`.`Clientes_ID` AS `Clientes_ID`,`C`.`Clientes_Nombre` AS `Clientes_Nombre`,count(`R`.`Resenas_ID`) AS `TotalResenas`,round(avg(`R`.`Resenas_Estrellas`),1) AS `PromedioEstrellas` from (`Clientes` `C` join `Resenas` `R` on(`C`.`Clientes_ID` = `R`.`Clientes_ID`)) group by `C`.`Clientes_ID`,`C`.`Clientes_Nombre` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `Vista_VehiculosDisponibles`
--
DROP TABLE IF EXISTS `Vista_VehiculosDisponibles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`if0_43419035`@`192.168.0.%` SQL SECURITY DEFINER VIEW `Vista_VehiculosDisponibles`  AS  select `V`.`Vehiculos_Placa` AS `Vehiculos_Placa`,`M`.`Marcas_Nombre` AS `Marca`,`C`.`Categorias_Nombre` AS `Categoria`,`T`.`Tarifas_PrecioDiario` AS `Precio_Diario` from ((((`Vehiculos` `V` join `Marcas` `M` on(`V`.`Marcas_ID` = `M`.`Marcas_ID`)) join `Categorias` `C` on(`V`.`Categorias_ID` = `C`.`Categorias_ID`)) join `Tarifas` `T` on(`C`.`Categorias_ID` = `T`.`Categorias_ID`)) join `EstadosVehiculo` `E` on(`V`.`EstadosVehiculo_ID` = `E`.`EstadosVehiculo_ID`)) where `E`.`EstadosVehiculo_Descripcion` = 'Disponible' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Auditoria`
--
ALTER TABLE `Auditoria`
  ADD PRIMARY KEY (`Auditoria_ID`);

--
-- Indices de la tabla `Categorias`
--
ALTER TABLE `Categorias`
  ADD PRIMARY KEY (`Categorias_ID`),
  ADD UNIQUE KEY `Categorias_Nombre` (`Categorias_Nombre`);

--
-- Indices de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  ADD PRIMARY KEY (`Clientes_ID`),
  ADD UNIQUE KEY `Clientes_Cedula` (`Clientes_Cedula`),
  ADD UNIQUE KEY `Clientes_Licencia` (`Clientes_Licencia`);

--
-- Indices de la tabla `Contactos`
--
ALTER TABLE `Contactos`
  ADD PRIMARY KEY (`Contactos_ID`),
  ADD KEY `Clientes_ID` (`Clientes_ID`);

--
-- Indices de la tabla `Contratos`
--
ALTER TABLE `Contratos`
  ADD PRIMARY KEY (`Contratos_ID`),
  ADD UNIQUE KEY `Reservas_ID` (`Reservas_ID`),
  ADD KEY `FK_Contratos_Empleados` (`Empleados_ID`);

--
-- Indices de la tabla `DetalleMantenimiento`
--
ALTER TABLE `DetalleMantenimiento`
  ADD PRIMARY KEY (`DetalleMantenimiento_ID`),
  ADD KEY `FK_Detalle_Mantenimientos` (`Mantenimientos_ID`);

--
-- Indices de la tabla `Devoluciones`
--
ALTER TABLE `Devoluciones`
  ADD PRIMARY KEY (`Devoluciones_ID`),
  ADD UNIQUE KEY `Contratos_ID` (`Contratos_ID`);

--
-- Indices de la tabla `Direcciones`
--
ALTER TABLE `Direcciones`
  ADD PRIMARY KEY (`Direcciones_ID`),
  ADD KEY `FK_Direcciones_Clientes` (`Clientes_ID`);

--
-- Indices de la tabla `Empleados`
--
ALTER TABLE `Empleados`
  ADD PRIMARY KEY (`Empleados_ID`),
  ADD UNIQUE KEY `Empleados_Cedula` (`Empleados_Cedula`);

--
-- Indices de la tabla `Entregas`
--
ALTER TABLE `Entregas`
  ADD PRIMARY KEY (`Entregas_ID`),
  ADD KEY `FK_Entregas_Contratos` (`Contratos_ID`);

--
-- Indices de la tabla `EstadosVehiculo`
--
ALTER TABLE `EstadosVehiculo`
  ADD PRIMARY KEY (`EstadosVehiculo_ID`);

--
-- Indices de la tabla `Facturas`
--
ALTER TABLE `Facturas`
  ADD PRIMARY KEY (`Facturas_ID`),
  ADD UNIQUE KEY `Contratos_ID` (`Contratos_ID`);

--
-- Indices de la tabla `Mantenimientos`
--
ALTER TABLE `Mantenimientos`
  ADD PRIMARY KEY (`Mantenimientos_ID`),
  ADD KEY `FK_Mantenimientos_Vehiculos` (`Vehiculos_ID`),
  ADD KEY `FK_Mantenimientos_Proveedores` (`Proveedores_ID`);

--
-- Indices de la tabla `Marcas`
--
ALTER TABLE `Marcas`
  ADD PRIMARY KEY (`Marcas_ID`);

--
-- Indices de la tabla `MetodosPago`
--
ALTER TABLE `MetodosPago`
  ADD PRIMARY KEY (`MetodosPago_ID`);

--
-- Indices de la tabla `Multas`
--
ALTER TABLE `Multas`
  ADD PRIMARY KEY (`Multas_ID`),
  ADD KEY `FK_Multas_Devoluciones` (`Devoluciones_ID`);

--
-- Indices de la tabla `Pagos`
--
ALTER TABLE `Pagos`
  ADD PRIMARY KEY (`Pagos_ID`),
  ADD KEY `FK_Pagos_Facturas` (`Facturas_ID`),
  ADD KEY `FK_Pagos_Metodos` (`MetodosPago_ID`);

--
-- Indices de la tabla `Proveedores`
--
ALTER TABLE `Proveedores`
  ADD PRIMARY KEY (`Proveedores_ID`);

--
-- Indices de la tabla `Resenas`
--
ALTER TABLE `Resenas`
  ADD PRIMARY KEY (`Resenas_ID`),
  ADD KEY `FK_Resenas_Clientes` (`Clientes_ID`);

--
-- Indices de la tabla `Reservas`
--
ALTER TABLE `Reservas`
  ADD PRIMARY KEY (`Reservas_ID`),
  ADD KEY `FK_Reservas_Clientes` (`Clientes_ID`),
  ADD KEY `FK_Reservas_Vehiculos` (`Vehiculos_ID`);

--
-- Indices de la tabla `Roles`
--
ALTER TABLE `Roles`
  ADD PRIMARY KEY (`Roles_ID`);

--
-- Indices de la tabla `Seguros`
--
ALTER TABLE `Seguros`
  ADD PRIMARY KEY (`Seguros_ID`),
  ADD KEY `FK_Seguros_Vehiculos` (`Vehiculos_ID`);

--
-- Indices de la tabla `SolicitudesSoporte`
--
ALTER TABLE `SolicitudesSoporte`
  ADD PRIMARY KEY (`SolicitudesSoporte_ID`);

--
-- Indices de la tabla `Tarifas`
--
ALTER TABLE `Tarifas`
  ADD PRIMARY KEY (`Tarifas_ID`),
  ADD KEY `FK_Tarifas_Categorias` (`Categorias_ID`);

--
-- Indices de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`Usuarios_ID`),
  ADD UNIQUE KEY `Usuarios_Nombre` (`Usuarios_Nombre`),
  ADD KEY `FK_Usuarios_Roles` (`Roles_ID`);

--
-- Indices de la tabla `Vehiculos`
--
ALTER TABLE `Vehiculos`
  ADD PRIMARY KEY (`Vehiculos_ID`),
  ADD UNIQUE KEY `Vehiculos_Placa` (`Vehiculos_Placa`),
  ADD KEY `FK_Vehiculos_Marcas` (`Marcas_ID`),
  ADD KEY `FK_Vehiculos_Categorias` (`Categorias_ID`),
  ADD KEY `FK_Vehiculos_Estados` (`EstadosVehiculo_ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Auditoria`
--
ALTER TABLE `Auditoria`
  MODIFY `Auditoria_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Categorias`
--
ALTER TABLE `Categorias`
  MODIFY `Categorias_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  MODIFY `Clientes_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `Contactos`
--
ALTER TABLE `Contactos`
  MODIFY `Contactos_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `Contratos`
--
ALTER TABLE `Contratos`
  MODIFY `Contratos_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `DetalleMantenimiento`
--
ALTER TABLE `DetalleMantenimiento`
  MODIFY `DetalleMantenimiento_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Devoluciones`
--
ALTER TABLE `Devoluciones`
  MODIFY `Devoluciones_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Direcciones`
--
ALTER TABLE `Direcciones`
  MODIFY `Direcciones_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `Empleados`
--
ALTER TABLE `Empleados`
  MODIFY `Empleados_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Entregas`
--
ALTER TABLE `Entregas`
  MODIFY `Entregas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `EstadosVehiculo`
--
ALTER TABLE `EstadosVehiculo`
  MODIFY `EstadosVehiculo_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `Facturas`
--
ALTER TABLE `Facturas`
  MODIFY `Facturas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Mantenimientos`
--
ALTER TABLE `Mantenimientos`
  MODIFY `Mantenimientos_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Marcas`
--
ALTER TABLE `Marcas`
  MODIFY `Marcas_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `MetodosPago`
--
ALTER TABLE `MetodosPago`
  MODIFY `MetodosPago_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Multas`
--
ALTER TABLE `Multas`
  MODIFY `Multas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Pagos`
--
ALTER TABLE `Pagos`
  MODIFY `Pagos_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Proveedores`
--
ALTER TABLE `Proveedores`
  MODIFY `Proveedores_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Resenas`
--
ALTER TABLE `Resenas`
  MODIFY `Resenas_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Reservas`
--
ALTER TABLE `Reservas`
  MODIFY `Reservas_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `Roles`
--
ALTER TABLE `Roles`
  MODIFY `Roles_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `Seguros`
--
ALTER TABLE `Seguros`
  MODIFY `Seguros_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `SolicitudesSoporte`
--
ALTER TABLE `SolicitudesSoporte`
  MODIFY `SolicitudesSoporte_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Tarifas`
--
ALTER TABLE `Tarifas`
  MODIFY `Tarifas_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `Usuarios_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `Vehiculos`
--
ALTER TABLE `Vehiculos`
  MODIFY `Vehiculos_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Contactos`
--
ALTER TABLE `Contactos`
  ADD CONSTRAINT `FK_Contactos_Clientes` FOREIGN KEY (`Clientes_ID`) REFERENCES `Clientes` (`Clientes_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Contratos`
--
ALTER TABLE `Contratos`
  ADD CONSTRAINT `FK_Contratos_Empleados` FOREIGN KEY (`Empleados_ID`) REFERENCES `Empleados` (`Empleados_ID`),
  ADD CONSTRAINT `FK_Contratos_Reservas` FOREIGN KEY (`Reservas_ID`) REFERENCES `Reservas` (`Reservas_ID`);

--
-- Filtros para la tabla `DetalleMantenimiento`
--
ALTER TABLE `DetalleMantenimiento`
  ADD CONSTRAINT `FK_Detalle_Mantenimientos` FOREIGN KEY (`Mantenimientos_ID`) REFERENCES `Mantenimientos` (`Mantenimientos_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Devoluciones`
--
ALTER TABLE `Devoluciones`
  ADD CONSTRAINT `FK_Devoluciones_Contratos` FOREIGN KEY (`Contratos_ID`) REFERENCES `Contratos` (`Contratos_ID`);

--
-- Filtros para la tabla `Direcciones`
--
ALTER TABLE `Direcciones`
  ADD CONSTRAINT `FK_Direcciones_Clientes` FOREIGN KEY (`Clientes_ID`) REFERENCES `Clientes` (`Clientes_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Entregas`
--
ALTER TABLE `Entregas`
  ADD CONSTRAINT `FK_Entregas_Contratos` FOREIGN KEY (`Contratos_ID`) REFERENCES `Contratos` (`Contratos_ID`);

--
-- Filtros para la tabla `Facturas`
--
ALTER TABLE `Facturas`
  ADD CONSTRAINT `FK_Facturas_Contratos` FOREIGN KEY (`Contratos_ID`) REFERENCES `Contratos` (`Contratos_ID`);

--
-- Filtros para la tabla `Mantenimientos`
--
ALTER TABLE `Mantenimientos`
  ADD CONSTRAINT `FK_Mantenimientos_Proveedores` FOREIGN KEY (`Proveedores_ID`) REFERENCES `Proveedores` (`Proveedores_ID`),
  ADD CONSTRAINT `FK_Mantenimientos_Vehiculos` FOREIGN KEY (`Vehiculos_ID`) REFERENCES `Vehiculos` (`Vehiculos_ID`);

--
-- Filtros para la tabla `Multas`
--
ALTER TABLE `Multas`
  ADD CONSTRAINT `FK_Multas_Devoluciones` FOREIGN KEY (`Devoluciones_ID`) REFERENCES `Devoluciones` (`Devoluciones_ID`);

--
-- Filtros para la tabla `Pagos`
--
ALTER TABLE `Pagos`
  ADD CONSTRAINT `FK_Pagos_Facturas` FOREIGN KEY (`Facturas_ID`) REFERENCES `Facturas` (`Facturas_ID`),
  ADD CONSTRAINT `FK_Pagos_Metodos` FOREIGN KEY (`MetodosPago_ID`) REFERENCES `MetodosPago` (`MetodosPago_ID`);

--
-- Filtros para la tabla `Resenas`
--
ALTER TABLE `Resenas`
  ADD CONSTRAINT `FK_Resenas_Clientes` FOREIGN KEY (`Clientes_ID`) REFERENCES `Clientes` (`Clientes_ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Reservas`
--
ALTER TABLE `Reservas`
  ADD CONSTRAINT `FK_Reservas_Clientes` FOREIGN KEY (`Clientes_ID`) REFERENCES `Clientes` (`Clientes_ID`),
  ADD CONSTRAINT `FK_Reservas_Vehiculos` FOREIGN KEY (`Vehiculos_ID`) REFERENCES `Vehiculos` (`Vehiculos_ID`);

--
-- Filtros para la tabla `Seguros`
--
ALTER TABLE `Seguros`
  ADD CONSTRAINT `FK_Seguros_Vehiculos` FOREIGN KEY (`Vehiculos_ID`) REFERENCES `Vehiculos` (`Vehiculos_ID`);

--
-- Filtros para la tabla `Tarifas`
--
ALTER TABLE `Tarifas`
  ADD CONSTRAINT `FK_Tarifas_Categorias` FOREIGN KEY (`Categorias_ID`) REFERENCES `Categorias` (`Categorias_ID`);

--
-- Filtros para la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD CONSTRAINT `FK_Usuarios_Roles` FOREIGN KEY (`Roles_ID`) REFERENCES `Roles` (`Roles_ID`);

--
-- Filtros para la tabla `Vehiculos`
--
ALTER TABLE `Vehiculos`
  ADD CONSTRAINT `FK_Vehiculos_Categorias` FOREIGN KEY (`Categorias_ID`) REFERENCES `Categorias` (`Categorias_ID`),
  ADD CONSTRAINT `FK_Vehiculos_Estados` FOREIGN KEY (`EstadosVehiculo_ID`) REFERENCES `EstadosVehiculo` (`EstadosVehiculo_ID`),
  ADD CONSTRAINT `FK_Vehiculos_Marcas` FOREIGN KEY (`Marcas_ID`) REFERENCES `Marcas` (`Marcas_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
