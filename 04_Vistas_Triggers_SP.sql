USE AutoDriveDB;
GO

-- ==========================================
-- VISTAS
-- ==========================================
CREATE VIEW Vista_VehiculosDisponibles AS
SELECT V.Vehiculos_Placa, M.Marcas_Nombre AS Marca, C.Categorias_Nombre AS Categoria, T.Tarifas_PrecioDiario AS Precio_Diario
FROM Vehiculos V
INNER JOIN Marcas M ON V.Marcas_ID = M.Marcas_ID
INNER JOIN Categorias C ON V.Categorias_ID = C.Categorias_ID
INNER JOIN Tarifas T ON C.Categorias_ID = T.Categorias_ID
INNER JOIN EstadosVehiculo E ON V.EstadosVehiculo_ID = E.EstadosVehiculo_ID
WHERE E.EstadosVehiculo_Descripcion = 'Disponible';
GO

-- ==========================================
-- TRIGGERS (3)
-- ==========================================
CREATE TRIGGER TR_AuditarCambioEstadoVehiculo
ON Vehiculos
AFTER UPDATE
AS
BEGIN
    IF UPDATE(EstadosVehiculo_ID)
    BEGIN
        INSERT INTO Auditoria (Auditoria_Tabla, Auditoria_Operacion, Auditoria_Detalle)
        SELECT 'Vehiculos', 'UPDATE', 'El vehículo con ID ' + CAST(i.Vehiculos_ID AS VARCHAR) + ' cambió de estado.'
        FROM inserted i INNER JOIN deleted d ON i.Vehiculos_ID = d.Vehiculos_ID
        WHERE i.EstadosVehiculo_ID <> d.EstadosVehiculo_ID;
    END
END;
GO

CREATE TRIGGER TR_ValidarDobleReserva
ON Reservas
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Reservas R1
        INNER JOIN inserted i ON R1.Vehiculos_ID = i.Vehiculos_ID
        WHERE R1.Reservas_ID <> i.Reservas_ID 
          AND R1.Reservas_Estado IN ('Pendiente', 'Confirmada')
          AND i.Reservas_Estado IN ('Pendiente', 'Confirmada')
          AND (i.Reservas_FechaInicio <= R1.Reservas_FechaFin AND i.Reservas_FechaFin >= R1.Reservas_FechaInicio)
    )
    BEGIN
        RAISERROR ('Error: El vehículo ya está reservado en esas fechas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

CREATE TRIGGER TR_ActualizarEstadoAlContratar
ON Contratos
AFTER INSERT
AS
BEGIN
    DECLARE @VehiculoID INT;
    SELECT @VehiculoID = R.Vehiculos_ID 
    FROM inserted i
    INNER JOIN Reservas R ON i.Reservas_ID = R.Reservas_ID;
    
    UPDATE Vehiculos SET EstadosVehiculo_ID = 2 WHERE Vehiculos_ID = @VehiculoID;
END;
GO

-- ==========================================
-- STORED PROCEDURES (3)
-- ==========================================
CREATE PROCEDURE SP_RegistrarReserva
    @ClienteID INT, @VehiculoID INT, @FechaInicio DATE, @FechaFin DATE
AS
BEGIN
    IF @FechaInicio >= @FechaFin
    BEGIN
        PRINT 'Error: La fecha de fin debe ser mayor a la de inicio.';
        RETURN;
    END
    INSERT INTO Reservas (Clientes_ID, Vehiculos_ID, Reservas_FechaInicio, Reservas_FechaFin, Reservas_Estado)
    VALUES (@ClienteID, @VehiculoID, @FechaInicio, @FechaFin, 'Pendiente');
    PRINT 'Reserva registrada exitosamente.';
END;
GO

CREATE PROCEDURE SP_ProcesarPago
    @FacturaID INT, @MetodoPagoID INT, @Monto DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Pagos (Facturas_ID, MetodosPago_ID, Pagos_Monto)
    VALUES (@FacturaID, @MetodoPagoID, @Monto);
    UPDATE Facturas SET Facturas_Estado = 'Pagada' WHERE Facturas_ID = @FacturaID AND Facturas_MontoTotal <= @Monto;
END;
GO

CREATE PROCEDURE SP_ReporteMantenimiento
    @Placa VARCHAR(10)
AS
BEGIN
    SELECT V.Vehiculos_Placa, M.Mantenimientos_Fecha, M.Mantenimientos_CostoTotal, DM.DetalleMantenimiento_Descripcion
    FROM Mantenimientos M
    INNER JOIN Vehiculos V ON M.Vehiculos_ID = V.Vehiculos_ID
    INNER JOIN DetalleMantenimiento DM ON M.Mantenimientos_ID = DM.Mantenimientos_ID
    WHERE V.Vehiculos_Placa = @Placa;
END;
GO