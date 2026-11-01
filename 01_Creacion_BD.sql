-- =============================================
-- PROYECTO FINAL: AUTODRIVE S.R.L.
-- SCRIPT DE CREACIÓN DE BASE DE DATOS (DDL)
-- =============================================

CREATE DATABASE AutoDriveDB;
GO

USE AutoDriveDB;
GO

-- 1. MÓDULO DE SEGURIDAD Y EMPLEADOS
CREATE TABLE Roles (
    Roles_ID INT IDENTITY(1,1) PRIMARY KEY,
    Roles_Nombre VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Usuarios (
    Usuarios_ID INT IDENTITY(1,1) PRIMARY KEY,
    Usuarios_Nombre VARCHAR(50) NOT NULL UNIQUE,
    Usuarios_Clave VARCHAR(255) NOT NULL,
    Roles_ID INT NOT NULL,
    Usuarios_Estado VARCHAR(20) DEFAULT 'Activo' CHECK (Usuarios_Estado IN ('Activo', 'Inactivo')),
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (Roles_ID) REFERENCES Roles(Roles_ID)
);
GO

CREATE TABLE Empleados (
    Empleados_ID INT IDENTITY(1,1) PRIMARY KEY,
    Empleados_Cedula VARCHAR(15) NOT NULL UNIQUE,
    Empleados_Nombre VARCHAR(100) NOT NULL,
    Empleados_Cargo VARCHAR(50) NOT NULL,
    Empleados_FechaIngreso DATE DEFAULT GETDATE()
);
GO

-- 2. MÓDULO DE CLIENTES
CREATE TABLE Clientes (
    Clientes_ID INT IDENTITY(1,1) PRIMARY KEY,
    Clientes_Cedula VARCHAR(15) NOT NULL UNIQUE,
    Clientes_Nombre VARCHAR(100) NOT NULL,
    Clientes_Licencia VARCHAR(20) NOT NULL UNIQUE,
    Clientes_FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Direcciones (
    Direcciones_ID INT IDENTITY(1,1) PRIMARY KEY,
    Clientes_ID INT NOT NULL,
    Direcciones_Detalle VARCHAR(150) NOT NULL,
    Direcciones_Ciudad VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Direcciones_Clientes FOREIGN KEY (Clientes_ID) REFERENCES Clientes(Clientes_ID) ON DELETE CASCADE
);
GO

CREATE TABLE Contactos (
    Contactos_ID INT IDENTITY(1,1) PRIMARY KEY,
    Clientes_ID INT NOT NULL,
    Contactos_Telefono VARCHAR(15) NOT NULL,
    Contactos_Email VARCHAR(100) CHECK (Contactos_Email LIKE '%@%.%'),
    CONSTRAINT FK_Contactos_Clientes FOREIGN KEY (Clientes_ID) REFERENCES Clientes(Clientes_ID) ON DELETE CASCADE
);
GO

-- 3. MÓDULO DE FLOTA
CREATE TABLE Marcas (
    Marcas_ID INT IDENTITY(1,1) PRIMARY KEY,
    Marcas_Nombre VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Categorias (
    Categorias_ID INT IDENTITY(1,1) PRIMARY KEY,
    Categorias_Nombre VARCHAR(50) NOT NULL UNIQUE,
    Categorias_Descripcion VARCHAR(150)
);
GO

CREATE TABLE EstadosVehiculo (
    EstadosVehiculo_ID INT IDENTITY(1,1) PRIMARY KEY,
    EstadosVehiculo_Descripcion VARCHAR(30) NOT NULL UNIQUE
);
GO

CREATE TABLE Vehiculos (
    Vehiculos_ID INT IDENTITY(1,1) PRIMARY KEY,
    Vehiculos_Placa VARCHAR(10) NOT NULL UNIQUE,
    Vehiculos_Anio INT NOT NULL CHECK (Vehiculos_Anio >= 2000),
    Marcas_ID INT NOT NULL,
    Categorias_ID INT NOT NULL,
    EstadosVehiculo_ID INT NOT NULL,
    CONSTRAINT FK_Vehiculos_Marcas FOREIGN KEY (Marcas_ID) REFERENCES Marcas(Marcas_ID),
    CONSTRAINT FK_Vehiculos_Categorias FOREIGN KEY (Categorias_ID) REFERENCES Categorias(Categorias_ID),
    CONSTRAINT FK_Vehiculos_Estados FOREIGN KEY (EstadosVehiculo_ID) REFERENCES EstadosVehiculo(EstadosVehiculo_ID)
);
GO

CREATE TABLE Tarifas (
    Tarifas_ID INT IDENTITY(1,1) PRIMARY KEY,
    Categorias_ID INT NOT NULL,
    Tarifas_PrecioDiario DECIMAL(10,2) NOT NULL CHECK (Tarifas_PrecioDiario > 0),
    CONSTRAINT FK_Tarifas_Categorias FOREIGN KEY (Categorias_ID) REFERENCES Categorias(Categorias_ID)
);
GO

CREATE TABLE Seguros (
    Seguros_ID INT IDENTITY(1,1) PRIMARY KEY,
    Vehiculos_ID INT NOT NULL,
    Seguros_Poliza VARCHAR(50) NOT NULL,
    Seguros_Costo DECIMAL(10,2) NOT NULL CHECK (Seguros_Costo >= 0),
    CONSTRAINT FK_Seguros_Vehiculos FOREIGN KEY (Vehiculos_ID) REFERENCES Vehiculos(Vehiculos_ID)
);
GO

-- 4. MÓDULO DE OPERACIONES
CREATE TABLE Reservas (
    Reservas_ID INT IDENTITY(1,1) PRIMARY KEY,
    Clientes_ID INT NOT NULL,
    Vehiculos_ID INT NOT NULL,
    Reservas_FechaInicio DATE NOT NULL,
    Reservas_FechaFin DATE NOT NULL,
    Reservas_Estado VARCHAR(20) DEFAULT 'Pendiente' CHECK (Reservas_Estado IN ('Pendiente', 'Confirmada', 'Cancelada')),
    CONSTRAINT FK_Reservas_Clientes FOREIGN KEY (Clientes_ID) REFERENCES Clientes(Clientes_ID),
    CONSTRAINT FK_Reservas_Vehiculos FOREIGN KEY (Vehiculos_ID) REFERENCES Vehiculos(Vehiculos_ID),
    CONSTRAINT CHK_Fechas CHECK (Reservas_FechaFin > Reservas_FechaInicio)
);
GO

CREATE TABLE Contratos (
    Contratos_ID INT IDENTITY(1,1) PRIMARY KEY,
    Reservas_ID INT NOT NULL UNIQUE,
    Empleados_ID INT NOT NULL,
    Contratos_FechaFirma DATETIME DEFAULT GETDATE(),
    Contratos_Estado VARCHAR(20) DEFAULT 'Activo' CHECK (Contratos_Estado IN ('Activo', 'Cerrado', 'Anulado')),
    CONSTRAINT FK_Contratos_Reservas FOREIGN KEY (Reservas_ID) REFERENCES Reservas(Reservas_ID),
    CONSTRAINT FK_Contratos_Empleados FOREIGN KEY (Empleados_ID) REFERENCES Empleados(Empleados_ID)
);
GO

CREATE TABLE Entregas (
    Entregas_ID INT IDENTITY(1,1) PRIMARY KEY,
    Contratos_ID INT NOT NULL,
    Entregas_Kilometraje INT NOT NULL CHECK (Entregas_Kilometraje >= 0),
    Entregas_NivelCombustible VARCHAR(20) NOT NULL,
    Entregas_Observaciones VARCHAR(255),
    CONSTRAINT FK_Entregas_Contratos FOREIGN KEY (Contratos_ID) REFERENCES Contratos(Contratos_ID)
);
GO

CREATE TABLE Devoluciones (
    Devoluciones_ID INT IDENTITY(1,1) PRIMARY KEY,
    Contratos_ID INT NOT NULL UNIQUE,
    Devoluciones_Fecha DATETIME DEFAULT GETDATE(),
    Devoluciones_Kilometraje INT NOT NULL CHECK (Devoluciones_Kilometraje >= 0),
    CONSTRAINT FK_Devoluciones_Contratos FOREIGN KEY (Contratos_ID) REFERENCES Contratos(Contratos_ID)
);
GO

CREATE TABLE Multas (
    Multas_ID INT IDENTITY(1,1) PRIMARY KEY,
    Devoluciones_ID INT NOT NULL,
    Multas_Motivo VARCHAR(150) NOT NULL,
    Multas_Monto DECIMAL(10,2) NOT NULL CHECK (Multas_Monto > 0),
    CONSTRAINT FK_Multas_Devoluciones FOREIGN KEY (Devoluciones_ID) REFERENCES Devoluciones(Devoluciones_ID)
);
GO

-- 5. MÓDULO DE FACTURACIÓN
CREATE TABLE Facturas (
    Facturas_ID INT IDENTITY(1,1) PRIMARY KEY,
    Contratos_ID INT NOT NULL UNIQUE,
    Facturas_FechaEmision DATETIME DEFAULT GETDATE(),
    Facturas_MontoTotal DECIMAL(10,2) NOT NULL CHECK (Facturas_MontoTotal >= 0),
    Facturas_Estado VARCHAR(20) DEFAULT 'Pendiente' CHECK (Facturas_Estado IN ('Pendiente', 'Pagada', 'Anulada')),
    CONSTRAINT FK_Facturas_Contratos FOREIGN KEY (Contratos_ID) REFERENCES Contratos(Contratos_ID)
);
GO

CREATE TABLE MetodosPago (
    MetodosPago_ID INT IDENTITY(1,1) PRIMARY KEY,
    MetodosPago_Descripcion VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Pagos (
    Pagos_ID INT IDENTITY(1,1) PRIMARY KEY,
    Facturas_ID INT NOT NULL,
    MetodosPago_ID INT NOT NULL,
    Pagos_Monto DECIMAL(10,2) NOT NULL CHECK (Pagos_Monto > 0),
    Pagos_Fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Pagos_Facturas FOREIGN KEY (Facturas_ID) REFERENCES Facturas(Facturas_ID),
    CONSTRAINT FK_Pagos_Metodos FOREIGN KEY (MetodosPago_ID) REFERENCES MetodosPago(MetodosPago_ID)
);
GO

-- 6. MÓDULO DE TALLER Y SOPORTE (Para llegar a las 24 tablas)
CREATE TABLE Proveedores (
    Proveedores_ID INT IDENTITY(1,1) PRIMARY KEY,
    Proveedores_Nombre VARCHAR(100) NOT NULL,
    Proveedores_Telefono VARCHAR(15),
    Proveedores_Email VARCHAR(100)
);
GO

CREATE TABLE Mantenimientos (
    Mantenimientos_ID INT IDENTITY(1,1) PRIMARY KEY,
    Vehiculos_ID INT NOT NULL,
    Proveedores_ID INT NOT NULL,
    Mantenimientos_Fecha DATE DEFAULT GETDATE(),
    Mantenimientos_CostoTotal DECIMAL(10,2) DEFAULT 0 CHECK (Mantenimientos_CostoTotal >= 0),
    CONSTRAINT FK_Mantenimientos_Vehiculos FOREIGN KEY (Vehiculos_ID) REFERENCES Vehiculos(Vehiculos_ID),
    CONSTRAINT FK_Mantenimientos_Proveedores FOREIGN KEY (Proveedores_ID) REFERENCES Proveedores(Proveedores_ID)
);
GO

CREATE TABLE DetalleMantenimiento (
    DetalleMantenimiento_ID INT IDENTITY(1,1) PRIMARY KEY,
    Mantenimientos_ID INT NOT NULL,
    DetalleMantenimiento_Descripcion VARCHAR(150) NOT NULL,
    DetalleMantenimiento_Costo DECIMAL(10,2) NOT NULL CHECK (DetalleMantenimiento_Costo >= 0),
    CONSTRAINT FK_Detalle_Mantenimientos FOREIGN KEY (Mantenimientos_ID) REFERENCES Mantenimientos(Mantenimientos_ID) ON DELETE CASCADE
);
GO

CREATE TABLE Auditoria (
    Auditoria_ID INT IDENTITY(1,1) PRIMARY KEY,
    Auditoria_Tabla VARCHAR(50) NOT NULL,
    Auditoria_Operacion VARCHAR(20) NOT NULL,
    Auditoria_Fecha DATETIME DEFAULT GETDATE(),
    Auditoria_Usuario VARCHAR(50) DEFAULT SYSTEM_USER,
    Auditoria_Detalle VARCHAR(255)
);
GO

CREATE TABLE SolicitudesSoporte (
    SolicitudesSoporte_ID INT IDENTITY(1,1) PRIMARY KEY,
    SolicitudesSoporte_Nombre VARCHAR(100) NOT NULL,
    SolicitudesSoporte_Email VARCHAR(100) NOT NULL,
    SolicitudesSoporte_Mensaje VARCHAR(500) NOT NULL,
    SolicitudesSoporte_Fecha DATETIME DEFAULT GETDATE(),
    SolicitudesSoporte_Estado VARCHAR(20) DEFAULT 'Pendiente'
);
GO

-- CREACIÓN DE ÍNDICES
CREATE INDEX IDX_Clientes_Cedula ON Clientes(Clientes_Cedula);
CREATE INDEX IDX_Vehiculos_Placa ON Vehiculos(Vehiculos_Placa);
CREATE INDEX IDX_Reservas_Cliente ON Reservas(Clientes_ID);
CREATE INDEX IDX_Reservas_Vehiculo ON Reservas(Vehiculos_ID);
CREATE INDEX IDX_Contratos_Reserva ON Contratos(Reservas_ID);
CREATE INDEX IDX_Pagos_Factura ON Pagos(Facturas_ID);
GO
