USE AutoDriveDB;
GO

-- 1. Consulta con INNER JOIN: Mostrar las reservas con nombre de cliente y placa del vehículo.
SELECT R.Reservas_ID, C.Clientes_Nombre, V.Vehiculos_Placa, R.Reservas_FechaInicio, R.Reservas_FechaFin
FROM Reservas R
INNER JOIN Clientes C ON R.Clientes_ID = C.Clientes_ID
INNER JOIN Vehiculos V ON R.Vehiculos_ID = V.Vehiculos_ID;
GO

-- 2. Consulta con Funciones de Agregación: Total facturado por cliente.
SELECT C.Clientes_Nombre, SUM(F.Facturas_MontoTotal) AS TotalFacturado
FROM Clientes C
INNER JOIN Reservas R ON C.Clientes_ID = R.Clientes_ID
INNER JOIN Contratos CT ON R.Reservas_ID = CT.Reservas_ID
INNER JOIN Facturas F ON CT.Contratos_ID = F.Contratos_ID
GROUP BY C.Clientes_Nombre;
GO

-- 3. Consulta con GROUP BY y HAVING: Vehículos que han tenido más de 1 mantenimiento.
SELECT V.Vehiculos_Placa, COUNT(M.Mantenimientos_ID) AS CantidadMantenimientos
FROM Vehiculos V
INNER JOIN Mantenimientos M ON V.Vehiculos_ID = M.Vehiculos_ID
GROUP BY V.Vehiculos_Placa
HAVING COUNT(M.Mantenimientos_ID) > 0;
GO

-- 4. Subconsulta: Clientes que no tienen ninguna reserva registrada.
SELECT Clientes_Nombre 
FROM Clientes 
WHERE Clientes_ID NOT IN (SELECT Clientes_ID FROM Reservas);
GO
