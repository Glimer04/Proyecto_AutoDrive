USE AutoDriveDB;
GO

INSERT INTO Roles (Roles_Nombre) VALUES ('Administrador'), ('Agente de Ventas');
INSERT INTO Usuarios (Usuarios_Nombre, Usuarios_Clave, Roles_ID) VALUES ('admin', '12345', 1), ('juan_agente', '12345', 2);
INSERT INTO Empleados (Empleados_Cedula, Empleados_Nombre, Empleados_Cargo) VALUES ('001-1111111-1', 'Carlos Pérez', 'Gerente'), ('001-2222222-2', 'Ana Gómez', 'Agente de Alquiler');
INSERT INTO Clientes (Clientes_Cedula, Clientes_Nombre, Clientes_Licencia) VALUES ('402-1234567-8', 'Luis Martínez', 'LIC-99881'), ('402-8765432-1', 'María Rodríguez', 'LIC-77662'), ('001-5555555-5', 'Empresa XYZ S.R.L.', 'LIC-CORP01');

INSERT INTO Contactos (Clientes_ID, Contactos_Telefono, Contactos_Email) VALUES (1, '809-555-1234', 'luis@gmail.com'), (2, '829-555-5678', 'maria@hotmail.com'), (3, '809-555-0000', 'logistica@xyz.com');
INSERT INTO Direcciones (Clientes_ID, Direcciones_Detalle, Direcciones_Ciudad) VALUES (1, 'Calle 1 #23, Ensanche Naco', 'Santo Domingo'), (2, 'Av. Estrella Sadhalá #45', 'Santiago'), (3, 'Av. 27 de Febrero #100', 'Santo Domingo');

INSERT INTO Marcas (Marcas_Nombre) VALUES ('Toyota'), ('Hyundai'), ('Honda');
INSERT INTO Categorias (Categorias_Nombre, Categorias_Descripcion) VALUES ('SUV', 'Vehículos utilitarios deportivos'), ('Sedán', 'Vehículos de paseo'), ('Camioneta', 'Vehículos de carga ligera');
INSERT INTO EstadosVehiculo (EstadosVehiculo_Descripcion) VALUES ('Disponible'), ('Alquilado'), ('En Mantenimiento');
INSERT INTO Tarifas (Categorias_ID, Tarifas_PrecioDiario) VALUES (1, 75.00), (2, 45.00), (3, 90.00);

INSERT INTO Vehiculos (Vehiculos_Placa, Vehiculos_Anio, Marcas_ID, Categorias_ID, EstadosVehiculo_ID) VALUES ('A123456', 2022, 1, 1, 1), ('B987654', 2021, 2, 2, 1), ('C555555', 2023, 3, 3, 2), ('D111111', 2020, 1, 2, 3);
INSERT INTO Seguros (Vehiculos_ID, Seguros_Poliza, Seguros_Costo) VALUES (1, 'POL-1234', 15.00), (2, 'POL-5678', 12.00), (3, 'POL-9012', 20.00);

INSERT INTO Proveedores (Proveedores_Nombre, Proveedores_Telefono) VALUES ('Repuestos El Motor', '809-123-4567'), ('Taller La Rueda', '809-765-4321');
INSERT INTO Mantenimientos (Vehiculos_ID, Proveedores_ID, Mantenimientos_Fecha, Mantenimientos_CostoTotal) VALUES (4, 2, '2023-10-15', 150.00);

INSERT INTO Reservas (Clientes_ID, Vehiculos_ID, Reservas_FechaInicio, Reservas_FechaFin, Reservas_Estado) VALUES (1, 3, '2023-11-01', '2023-11-05', 'Confirmada'), (2, 1, '2023-11-10', '2023-11-12', 'Pendiente'), (3, 2, '2023-10-20', '2023-10-25', 'Confirmada');
INSERT INTO Contratos (Reservas_ID, Empleados_ID, Contratos_FechaFirma, Contratos_Estado) VALUES (1, 2, GETDATE(), 'Activo'), (3, 2, '2023-10-20', 'Cerrado');

INSERT INTO Entregas (Contratos_ID, Entregas_Kilometraje, Entregas_NivelCombustible) VALUES (1, 45000, 'Lleno'), (2, 12000, '3/4');
INSERT INTO Devoluciones (Contratos_ID, Devoluciones_Fecha, Devoluciones_Kilometraje) VALUES (2, '2023-10-25 10:00:00', 12500);
INSERT INTO Multas (Devoluciones_ID, Multas_Monto, Multas_Motivo) VALUES (1, 50.00, 'Retraso de 2 horas en la entrega');

INSERT INTO MetodosPago (MetodosPago_Descripcion) VALUES ('Efectivo'), ('Tarjeta de Crédito'), ('Transferencia');
INSERT INTO Facturas (Contratos_ID, Facturas_MontoTotal, Facturas_Estado) VALUES (1, 450.00, 'Pendiente'), (2, 240.00, 'Pagada');
INSERT INTO Pagos (Facturas_ID, MetodosPago_ID, Pagos_Monto) VALUES (2, 2, 240.00);
GO
