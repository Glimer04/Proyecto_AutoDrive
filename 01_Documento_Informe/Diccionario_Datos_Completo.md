# Diccionario de Datos Completo - AutoDriveDB

Este documento contiene el diccionario de datos físico completo de las 25 tablas del sistema **AutoDrive S.R.L. (SARV)**, complementando el extracto presentado en el informe final.

## 1. Módulo de Seguridad y Empleados

### Tabla: Roles
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Roles_ID | INT | NOT NULL | PK (IDENTITY) | Identificador único del rol |
| Roles_Nombre | VARCHAR(50) | NOT NULL | UNIQUE | Nombre del rol (Admin, Agente) |

### Tabla: Usuarios
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Usuarios_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del usuario |
| Usuarios_Nombre | VARCHAR(50) | NOT NULL | UNIQUE | Nombre de usuario para login |
| Usuarios_Clave | VARCHAR(255) | NOT NULL | - | Contraseña del usuario |
| Roles_ID | INT | NOT NULL | FK | Referencia al rol del usuario |
| Usuarios_Estado | VARCHAR(20) | NULL | - | Estado (Activo/Inactivo) |

### Tabla: Empleados
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Empleados_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del empleado |
| Empleados_Cedula | VARCHAR(15) | NOT NULL | UNIQUE | Documento de identidad |
| Empleados_Nombre | VARCHAR(100) | NOT NULL | - | Nombre completo del empleado |
| Empleados_Cargo | VARCHAR(50) | NOT NULL | - | Puesto que desempeña |
| Empleados_FechaIngreso | DATE | NULL | - | Fecha de contratación |

## 2. Módulo de Clientes

### Tabla: Clientes
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Clientes_ID | INT | NOT NULL | PK (IDENTITY) | Identificador único del cliente |
| Clientes_Cedula | VARCHAR(15) | NOT NULL | UNIQUE | Cédula o RNC del cliente |
| Clientes_Nombre | VARCHAR(100) | NOT NULL | - | Nombre completo o Razón Social |
| Clientes_Licencia | VARCHAR(20) | NOT NULL | UNIQUE | Número de licencia de conducir |
| Clientes_FechaRegistro | DATETIME | NULL | - | Fecha en que se registró |

### Tabla: Direcciones
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Direcciones_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de la dirección |
| Clientes_ID | INT | NOT NULL | FK | Referencia al cliente |
| Direcciones_Detalle | VARCHAR(150) | NOT NULL | - | Calle, número, sector |
| Direcciones_Ciudad | VARCHAR(50) | NOT NULL | - | Ciudad de residencia |

### Tabla: Contactos
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Contactos_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de contacto |
| Clientes_ID | INT | NOT NULL | FK | Referencia al cliente |
| Contactos_Telefono | VARCHAR(15) | NOT NULL | - | Número telefónico |
| Contactos_Email | VARCHAR(100) | NULL | CHECK | Correo electrónico válido |

## 3. Módulo de Flota

### Tabla: Marcas
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Marcas_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de la marca |
| Marcas_Nombre | VARCHAR(50) | NOT NULL | UNIQUE | Nombre de la marca (Toyota, etc.) |

### Tabla: Categorias
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Categorias_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de categoría |
| Categorias_Nombre | VARCHAR(50) | NOT NULL | UNIQUE | Tipo de vehículo (SUV, Sedán) |
| Categorias_Descripcion | VARCHAR(150) | NULL | - | Detalles adicionales |

### Tabla: EstadosVehiculo
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| EstadosVehiculo_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de estado |
| EstadosVehiculo_Descripcion | VARCHAR(30) | NOT NULL | UNIQUE | Estado (Disponible, Alquilado) |

### Tabla: Vehiculos
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Vehiculos_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del vehículo |
| Vehiculos_Placa | VARCHAR(10) | NOT NULL | UNIQUE | Placa de identificación |
| Vehiculos_Anio | INT | NOT NULL | CHECK | Año de fabricación (>=2000) |
| Marcas_ID | INT | NOT NULL | FK | Referencia a la marca |
| Categorias_ID | INT | NOT NULL | FK | Referencia a la categoría |
| EstadosVehiculo_ID | INT | NOT NULL | FK | Referencia al estado actual |

### Tabla: Tarifas
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Tarifas_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de tarifa |
| Categorias_ID | INT | NOT NULL | FK | Referencia a la categoría |
| Tarifas_PrecioDiario | DECIMAL(10,2) | NOT NULL | CHECK | Precio por día (>0) |

### Tabla: Seguros
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Seguros_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del seguro |
| Vehiculos_ID | INT | NOT NULL | FK | Vehículo asegurado |
| Seguros_Poliza | VARCHAR(50) | NOT NULL | - | Número de póliza |
| Seguros_Costo | DECIMAL(10,2) | NOT NULL | CHECK | Costo del seguro (>=0) |

## 4. Módulo de Operaciones

### Tabla: Reservas
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Reservas_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de reserva |
| Clientes_ID | INT | NOT NULL | FK | Cliente que reserva |
| Vehiculos_ID | INT | NOT NULL | FK | Vehículo reservado |
| Reservas_FechaInicio | DATE | NOT NULL | - | Inicio del alquiler |
| Reservas_FechaFin | DATE | NOT NULL | CHECK | Fin del alquiler (> Inicio) |
| Reservas_Estado | VARCHAR(20) | NULL | - | Estado actual de la reserva |

### Tabla: Contratos
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Contratos_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del contrato |
| Reservas_ID | INT | NOT NULL | FK (UNIQUE)| Reserva asociada |
| Empleados_ID | INT | NOT NULL | FK | Empleado que firma |
| Contratos_FechaFirma | DATETIME | NULL | - | Fecha de formalización |
| Contratos_Estado | VARCHAR(20) | NULL | - | Estado (Activo, Cerrado) |

### Tabla: Entregas
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Entregas_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de entrega |
| Contratos_ID | INT | NOT NULL | FK | Contrato asociado |
| Entregas_Kilometraje | INT | NOT NULL | CHECK | Kilometraje al entregar |
| Entregas_NivelCombustible | VARCHAR(20) | NOT NULL | - | Nivel de combustible |
| Entregas_Observaciones | VARCHAR(255) | NULL | - | Notas de la entrega |

### Tabla: Devoluciones
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Devoluciones_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de devolución |
| Contratos_ID | INT | NOT NULL | FK (UNIQUE)| Contrato asociado |
| Devoluciones_Fecha | DATETIME | NULL | - | Fecha de devolución |
| Devoluciones_Kilometraje | INT | NOT NULL | CHECK | Kilometraje al devolver |

### Tabla: Multas
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Multas_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de multa |
| Devoluciones_ID | INT | NOT NULL | FK | Devolución asociada |
| Multas_Motivo | VARCHAR(150) | NOT NULL | - | Razón de la multa |
| Multas_Monto | DECIMAL(10,2) | NOT NULL | CHECK | Monto de la multa (>0) |

## 5. Módulo de Facturación

### Tabla: Facturas
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Facturas_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de factura |
| Contratos_ID | INT | NOT NULL | FK (UNIQUE)| Contrato asociado |
| Facturas_FechaEmision | DATETIME | NULL | - | Fecha de emisión |
| Facturas_MontoTotal | DECIMAL(10,2) | NOT NULL | CHECK | Total a pagar (>=0) |
| Facturas_Estado | VARCHAR(20) | NULL | - | Estado (Pendiente, Pagada) |

### Tabla: MetodosPago
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| MetodosPago_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del método |
| MetodosPago_Descripcion | VARCHAR(50) | NOT NULL | UNIQUE | Descripción (Efectivo, Tarjeta) |

### Tabla: Pagos
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Pagos_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de pago |
| Facturas_ID | INT | NOT NULL | FK | Factura pagada |
| MetodosPago_ID | INT | NOT NULL | FK | Método utilizado |
| Pagos_Monto | DECIMAL(10,2) | NOT NULL | CHECK | Monto pagado (>0) |
| Pagos_Fecha | DATETIME | NULL | - | Fecha del pago |

## 6. Módulo de Taller y Soporte

### Tabla: Proveedores
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Proveedores_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del proveedor |
| Proveedores_Nombre | VARCHAR(100) | NOT NULL | - | Nombre comercial |
| Proveedores_Telefono | VARCHAR(15) | NULL | - | Teléfono de contacto |
| Proveedores_Email | VARCHAR(100) | NULL | - | Correo electrónico |

### Tabla: Mantenimientos
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Mantenimientos_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del mantenimiento |
| Vehiculos_ID | INT | NOT NULL | FK | Vehículo intervenido |
| Proveedores_ID | INT | NOT NULL | FK | Proveedor del servicio |
| Mantenimientos_Fecha | DATE | NULL | - | Fecha de la intervención |
| Mantenimientos_CostoTotal | DECIMAL(10,2) | NULL | CHECK | Costo total (>=0) |

### Tabla: DetalleMantenimiento
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| DetalleMantenimiento_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del detalle |
| Mantenimientos_ID | INT | NOT NULL | FK | Mantenimiento asociado |
| DetalleMantenimiento_Descripcion | VARCHAR(150) | NOT NULL | - | Trabajo realizado |
| DetalleMantenimiento_Costo | DECIMAL(10,2) | NOT NULL | CHECK | Costo del detalle (>=0) |

### Tabla: Auditoria
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| Auditoria_ID | INT | NOT NULL | PK (IDENTITY) | Identificador de auditoría |
| Auditoria_Tabla | VARCHAR(50) | NOT NULL | - | Tabla afectada |
| Auditoria_Operacion | VARCHAR(20) | NOT NULL | - | Acción (INSERT, UPDATE) |
| Auditoria_Fecha | DATETIME | NULL | - | Fecha y hora del evento |
| Auditoria_Usuario | VARCHAR(50) | NULL | - | Usuario del sistema |
| Auditoria_Detalle | VARCHAR(255) | NULL | - | Descripción del cambio |

### Tabla: SolicitudesSoporte
| Campo | Tipo de Dato | Nulabilidad | Clave | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| SolicitudesSoporte_ID | INT | NOT NULL | PK (IDENTITY) | Identificador del ticket |
| SolicitudesSoporte_Nombre | VARCHAR(100) | NOT NULL | - | Nombre del solicitante |
| SolicitudesSoporte_Email | VARCHAR(100) | NOT NULL | - | Correo de contacto |
| SolicitudesSoporte_Mensaje | VARCHAR(500) | NOT NULL | - | Detalle del problema |
| SolicitudesSoporte_Fecha | DATETIME | NULL | - | Fecha de recepción |
| SolicitudesSoporte_Estado | VARCHAR(20) | NULL | - | Estado (Pendiente, Resuelto) |
