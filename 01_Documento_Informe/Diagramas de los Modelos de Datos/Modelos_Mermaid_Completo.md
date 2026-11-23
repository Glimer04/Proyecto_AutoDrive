# Modelos de datos de AutoDrive (SARV) en Mermaid

## Modelo_Conceptual

```mermaid
%%{init: {"theme":"base","themeVariables":{"fontSize":"17px","fontFamily":"Arial","primaryColor":"#DEEAF6","primaryTextColor":"#000000","primaryBorderColor":"#1F3864","lineColor":"#1F3864","secondaryColor":"#FFF2CC","tertiaryColor":"#FFFFFF","edgeLabelBackground":"#FFFFFF","attributeBackgroundColorOdd":"#FFFFFF","attributeBackgroundColorEven":"#EAF1FB"}}}%%
flowchart TB
    Roles["<b>ROLES</b><br/><u><b>Roles_ID</b></u> (identificador)<br/>Roles_Nombre"]:::m0
    Usuarios["<b>USUARIOS</b><br/><u><b>Usuarios_ID</b></u> (identificador)<br/>Usuarios_Nombre<br/>Usuarios_Clave<br/>Usuarios_Estado"]:::m0
    Empleados["<b>EMPLEADOS</b><br/><u><b>Empleados_ID</b></u> (identificador)<br/>Empleados_Cedula<br/>Empleados_Nombre<br/>Empleados_Cargo<br/>Empleados_FechaIngreso"]:::m0
    Clientes["<b>CLIENTES</b><br/><u><b>Clientes_ID</b></u> (identificador)<br/>Clientes_Cedula<br/>Clientes_Nombre<br/>Clientes_Licencia<br/>Clientes_FechaRegistro"]:::m1
    Direcciones["<b>DIRECCIONES</b><br/><u><b>Direcciones_ID</b></u> (identificador)<br/>Direcciones_Detalle<br/>Direcciones_Ciudad"]:::m1
    Contactos["<b>CONTACTOS</b><br/><u><b>Contactos_ID</b></u> (identificador)<br/>Contactos_Telefono<br/>Contactos_Email"]:::m1
    Resenas["<b>RESENAS</b><br/><u><b>Resenas_ID</b></u> (identificador)<br/>Resenas_Estrellas<br/>Resenas_Comentario<br/>Resenas_Fecha"]:::m1
    Marcas["<b>MARCAS</b><br/><u><b>Marcas_ID</b></u> (identificador)<br/>Marcas_Nombre"]:::m2
    Categorias["<b>CATEGORIAS</b><br/><u><b>Categorias_ID</b></u> (identificador)<br/>Categorias_Nombre<br/>Categorias_Descripcion"]:::m2
    EstadosVehiculo["<b>ESTADOSVEHICULO</b><br/><u><b>EstadosVehiculo_ID</b></u> (identificador)<br/>EstadosVehiculo_Descripcion"]:::m2
    Vehiculos["<b>VEHICULOS</b><br/><u><b>Vehiculos_ID</b></u> (identificador)<br/>Vehiculos_Placa<br/>Vehiculos_Anio"]:::m2
    Tarifas["<b>TARIFAS</b><br/><u><b>Tarifas_ID</b></u> (identificador)<br/>Tarifas_PrecioDiario"]:::m2
    Seguros["<b>SEGUROS</b><br/><u><b>Seguros_ID</b></u> (identificador)<br/>Seguros_Poliza<br/>Seguros_Costo"]:::m2
    Reservas["<b>RESERVAS</b><br/><u><b>Reservas_ID</b></u> (identificador)<br/>Reservas_FechaInicio<br/>Reservas_FechaFin<br/>Reservas_Estado"]:::m3
    Contratos["<b>CONTRATOS</b><br/><u><b>Contratos_ID</b></u> (identificador)<br/>Contratos_FechaFirma<br/>Contratos_Estado"]:::m3
    Entregas["<b>ENTREGAS</b><br/><u><b>Entregas_ID</b></u> (identificador)<br/>Entregas_Kilometraje<br/>Entregas_NivelCombustible<br/>Entregas_Observaciones"]:::m3
    Devoluciones["<b>DEVOLUCIONES</b><br/><u><b>Devoluciones_ID</b></u> (identificador)<br/>Devoluciones_Fecha<br/>Devoluciones_Kilometraje"]:::m3
    Multas["<b>MULTAS</b><br/><u><b>Multas_ID</b></u> (identificador)<br/>Multas_Motivo<br/>Multas_Monto"]:::m3
    Facturas["<b>FACTURAS</b><br/><u><b>Facturas_ID</b></u> (identificador)<br/>Facturas_FechaEmision<br/>Facturas_MontoTotal<br/>Facturas_Estado"]:::m4
    MetodosPago["<b>METODOSPAGO</b><br/><u><b>MetodosPago_ID</b></u> (identificador)<br/>MetodosPago_Descripcion"]:::m4
    Pagos["<b>PAGOS</b><br/><u><b>Pagos_ID</b></u> (identificador)<br/>Pagos_Monto<br/>Pagos_Fecha"]:::m4
    Proveedores["<b>PROVEEDORES</b><br/><u><b>Proveedores_ID</b></u> (identificador)<br/>Proveedores_Nombre<br/>Proveedores_Telefono<br/>Proveedores_Email"]:::m5
    Mantenimientos["<b>MANTENIMIENTOS</b><br/><u><b>Mantenimientos_ID</b></u> (identificador)<br/>Mantenimientos_Fecha<br/>Mantenimientos_CostoTotal"]:::m5
    DetalleMantenimiento["<b>DETALLEMANTENIMIENTO</b><br/><u><b>DetalleMantenimiento_ID</b></u> (identificador)<br/>DetalleMantenimiento_Descripcion<br/>DetalleMantenimiento_Costo"]:::m5
    Auditoria["<b>AUDITORIA</b><br/><u><b>Auditoria_ID</b></u> (identificador)<br/>Auditoria_Tabla<br/>Auditoria_Operacion<br/>Auditoria_Fecha<br/>Auditoria_Usuario<br/>Auditoria_Detalle"]:::m6
    SolicitudesSoporte["<b>SOLICITUDESSOPORTE</b><br/><u><b>SolicitudesSoporte_ID</b></u> (identificador)<br/>SolicitudesSoporte_Nombre<br/>SolicitudesSoporte_Email<br/>SolicitudesSoporte_Categoria<br/>SolicitudesSoporte_Mensaje<br/>SolicitudesSoporte_Fecha<br/>SolicitudesSoporte_Estado"]:::m6
    R0{"tiene"}:::rel
    Roles ---|"(0,N)"| R0
    R0 ---|"(1,1)"| Usuarios
    R1{"posee"}:::rel
    Clientes ---|"(0,N)"| R1
    R1 ---|"(1,1)"| Contactos
    R2{"escribe"}:::rel
    Clientes ---|"(0,N)"| R2
    R2 ---|"(1,1)"| Resenas
    R3{"reside en"}:::rel
    Clientes ---|"(0,N)"| R3
    R3 ---|"(1,1)"| Direcciones
    R4{"es de la marca"}:::rel
    Marcas ---|"(0,N)"| R4
    R4 ---|"(1,1)"| Vehiculos
    R5{"pertenece a"}:::rel
    Categorias ---|"(0,N)"| R5
    R5 ---|"(1,1)"| Vehiculos
    R6{"tiene estado"}:::rel
    EstadosVehiculo ---|"(0,N)"| R6
    R6 ---|"(1,1)"| Vehiculos
    R7{"se aplica a"}:::rel
    Categorias ---|"(0,N)"| R7
    R7 ---|"(1,1)"| Tarifas
    R8{"asegura"}:::rel
    Vehiculos ---|"(0,N)"| R8
    R8 ---|"(1,1)"| Seguros
    R9{"realiza"}:::rel
    Clientes ---|"(0,N)"| R9
    R9 ---|"(1,1)"| Reservas
    R10{"reserva"}:::rel
    Vehiculos ---|"(0,N)"| R10
    R10 ---|"(1,1)"| Reservas
    R11{"formaliza"}:::rel
    Reservas ---|"(0,1)"| R11
    R11 ---|"(1,1)"| Contratos
    R12{"firma"}:::rel
    Empleados ---|"(0,N)"| R12
    R12 ---|"(1,1)"| Contratos
    R13{"documenta"}:::rel
    Contratos ---|"(0,N)"| R13
    R13 ---|"(1,1)"| Entregas
    R14{"cierra"}:::rel
    Contratos ---|"(0,1)"| R14
    R14 ---|"(1,1)"| Devoluciones
    R15{"genera"}:::rel
    Devoluciones ---|"(0,N)"| R15
    R15 ---|"(1,1)"| Multas
    R16{"factura"}:::rel
    Contratos ---|"(0,1)"| R16
    R16 ---|"(1,1)"| Facturas
    R17{"salda"}:::rel
    Facturas ---|"(0,N)"| R17
    R17 ---|"(1,1)"| Pagos
    R18{"se paga con"}:::rel
    MetodosPago ---|"(0,N)"| R18
    R18 ---|"(1,1)"| Pagos
    R19{"recibe"}:::rel
    Vehiculos ---|"(0,N)"| R19
    R19 ---|"(1,1)"| Mantenimientos
    R20{"realiza"}:::rel
    Proveedores ---|"(0,N)"| R20
    R20 ---|"(1,1)"| Mantenimientos
    R21{"detalla"}:::rel
    Mantenimientos ---|"(0,N)"| R21
    R21 ---|"(1,1)"| DetalleMantenimiento
    L0{"audita"}:::rell
    Vehiculos -.-|"(0,N)"| L0
    L0 -.-|"(0,N)"| Auditoria
    L1{"audita"}:::rell
    Clientes -.-|"(0,N)"| L1
    L1 -.-|"(0,N)"| Auditoria
    L2{"audita"}:::rell
    Reservas -.-|"(0,N)"| L2
    L2 -.-|"(0,N)"| Auditoria
    L3{"solicita soporte por correo"}:::rell
    Clientes -.-|"(0,N)"| L3
    L3 -.-|"(0,N)"| SolicitudesSoporte
    classDef m0 fill:#E4DFEC,stroke:#5B3F8C,stroke-width:3px,color:#000000,font-size:16px
    classDef m1 fill:#DEEAF6,stroke:#1F3864,stroke-width:3px,color:#000000,font-size:16px
    classDef m2 fill:#E2EFDA,stroke:#375623,stroke-width:3px,color:#000000,font-size:16px
    classDef m3 fill:#FFF2CC,stroke:#7F6000,stroke-width:3px,color:#000000,font-size:16px
    classDef m4 fill:#FCE4D6,stroke:#9C3B0B,stroke-width:3px,color:#000000,font-size:16px
    classDef m5 fill:#EDEDED,stroke:#404040,stroke-width:3px,color:#000000,font-size:16px
    classDef m6 fill:#D9F2F0,stroke:#0B6B63,stroke-width:3px,color:#000000,font-size:16px
    classDef rel fill:#FFFFFF,stroke:#2E75B6,stroke-width:3px,color:#000000,font-size:15px
    classDef rell fill:#FFFFFF,stroke:#7F7F7F,stroke-width:3px,stroke-dasharray:5 4,color:#000000,font-size:15px
    linkStyle default stroke:#1F3864,stroke-width:2.5px
```

## Modelo_Logico

```mermaid
%%{init: {"theme":"base","themeVariables":{"fontSize":"18px","fontFamily":"Arial","primaryColor":"#DEEAF6","primaryTextColor":"#000000","primaryBorderColor":"#1F3864","lineColor":"#1F3864","secondaryColor":"#FFF2CC","tertiaryColor":"#FFFFFF","edgeLabelBackground":"#FFFFFF","attributeBackgroundColorOdd":"#FFFFFF","attributeBackgroundColorEven":"#EAF1FB"}}}%%
erDiagram
    Roles ||--o{ Usuarios : "tiene"
    Clientes ||--o{ Contactos : "posee"
    Clientes ||--o{ Resenas : "escribe"
    Clientes ||--o{ Direcciones : "reside en"
    Marcas ||--o{ Vehiculos : "es de la marca"
    Categorias ||--o{ Vehiculos : "pertenece a"
    EstadosVehiculo ||--o{ Vehiculos : "tiene estado"
    Categorias ||--o{ Tarifas : "se aplica a"
    Vehiculos ||--o{ Seguros : "asegura"
    Clientes ||--o{ Reservas : "realiza"
    Vehiculos ||--o{ Reservas : "reserva"
    Reservas ||--o| Contratos : "formaliza"
    Empleados ||--o{ Contratos : "firma"
    Contratos ||--o{ Entregas : "documenta"
    Contratos ||--o| Devoluciones : "cierra"
    Devoluciones ||--o{ Multas : "genera"
    Contratos ||--o| Facturas : "factura"
    Facturas ||--o{ Pagos : "salda"
    MetodosPago ||--o{ Pagos : "se paga con"
    Vehiculos ||--o{ Mantenimientos : "recibe"
    Proveedores ||--o{ Mantenimientos : "realiza"
    Mantenimientos ||--o{ DetalleMantenimiento : "detalla"
    Vehiculos ||..o{ Auditoria : "audita (sin FK)"
    Clientes ||..o{ Auditoria : "audita (sin FK)"
    Reservas ||..o{ Auditoria : "audita (sin FK)"
    Clientes ||..o{ SolicitudesSoporte : "solicita soporte por correo (sin FK)"

    Roles {
        entero Roles_ID PK "obligatorio"
        texto Roles_Nombre UK "obligatorio"
    }
    Usuarios {
        entero Usuarios_ID PK "obligatorio"
        texto Usuarios_Nombre UK "obligatorio"
        texto Usuarios_Clave "obligatorio"
        entero Roles_ID FK "obligatorio"
        texto Usuarios_Estado "opcional"
    }
    Empleados {
        entero Empleados_ID PK "obligatorio"
        texto Empleados_Cedula UK "obligatorio"
        texto Empleados_Nombre "obligatorio"
        texto Empleados_Cargo "obligatorio"
        fecha Empleados_FechaIngreso "opcional"
    }
    Clientes {
        entero Clientes_ID PK "obligatorio"
        texto Clientes_Cedula UK "obligatorio"
        texto Clientes_Nombre "obligatorio"
        texto Clientes_Licencia UK "obligatorio"
        fechahora Clientes_FechaRegistro "opcional"
    }
    Direcciones {
        entero Direcciones_ID PK "obligatorio"
        entero Clientes_ID FK "obligatorio"
        texto Direcciones_Detalle "obligatorio"
        texto Direcciones_Ciudad "obligatorio"
    }
    Contactos {
        entero Contactos_ID PK "obligatorio"
        entero Clientes_ID FK "obligatorio"
        texto Contactos_Telefono "obligatorio"
        texto Contactos_Email "opcional"
    }
    Resenas {
        entero Resenas_ID PK "obligatorio"
        entero Clientes_ID FK "obligatorio"
        entero Resenas_Estrellas "obligatorio"
        texto Resenas_Comentario "opcional"
        fechahora Resenas_Fecha "opcional"
    }
    Marcas {
        entero Marcas_ID PK "obligatorio"
        texto Marcas_Nombre UK "obligatorio"
    }
    Categorias {
        entero Categorias_ID PK "obligatorio"
        texto Categorias_Nombre UK "obligatorio"
        texto Categorias_Descripcion "opcional"
    }
    EstadosVehiculo {
        entero EstadosVehiculo_ID PK "obligatorio"
        texto EstadosVehiculo_Descripcion UK "obligatorio"
    }
    Vehiculos {
        entero Vehiculos_ID PK "obligatorio"
        texto Vehiculos_Placa UK "obligatorio"
        entero Vehiculos_Anio "obligatorio"
        entero Marcas_ID FK "obligatorio"
        entero Categorias_ID FK "obligatorio"
        entero EstadosVehiculo_ID FK "obligatorio"
    }
    Tarifas {
        entero Tarifas_ID PK "obligatorio"
        entero Categorias_ID FK "obligatorio"
        decimal Tarifas_PrecioDiario "obligatorio"
    }
    Seguros {
        entero Seguros_ID PK "obligatorio"
        entero Vehiculos_ID FK "obligatorio"
        texto Seguros_Poliza "obligatorio"
        decimal Seguros_Costo "obligatorio"
    }
    Reservas {
        entero Reservas_ID PK "obligatorio"
        entero Clientes_ID FK "obligatorio"
        entero Vehiculos_ID FK "obligatorio"
        fecha Reservas_FechaInicio "obligatorio"
        fecha Reservas_FechaFin "obligatorio"
        texto Reservas_Estado "opcional"
    }
    Contratos {
        entero Contratos_ID PK "obligatorio"
        entero Reservas_ID FK, UK "obligatorio"
        entero Empleados_ID FK "obligatorio"
        fechahora Contratos_FechaFirma "opcional"
        texto Contratos_Estado "opcional"
    }
    Entregas {
        entero Entregas_ID PK "obligatorio"
        entero Contratos_ID FK "obligatorio"
        entero Entregas_Kilometraje "obligatorio"
        texto Entregas_NivelCombustible "obligatorio"
        texto Entregas_Observaciones "opcional"
    }
    Devoluciones {
        entero Devoluciones_ID PK "obligatorio"
        entero Contratos_ID FK, UK "obligatorio"
        fechahora Devoluciones_Fecha "opcional"
        entero Devoluciones_Kilometraje "obligatorio"
    }
    Multas {
        entero Multas_ID PK "obligatorio"
        entero Devoluciones_ID FK "obligatorio"
        texto Multas_Motivo "obligatorio"
        decimal Multas_Monto "obligatorio"
    }
    Facturas {
        entero Facturas_ID PK "obligatorio"
        entero Contratos_ID FK, UK "obligatorio"
        fechahora Facturas_FechaEmision "opcional"
        decimal Facturas_MontoTotal "obligatorio"
        texto Facturas_Estado "opcional"
    }
    MetodosPago {
        entero MetodosPago_ID PK "obligatorio"
        texto MetodosPago_Descripcion UK "obligatorio"
    }
    Pagos {
        entero Pagos_ID PK "obligatorio"
        entero Facturas_ID FK "obligatorio"
        entero MetodosPago_ID FK "obligatorio"
        decimal Pagos_Monto "obligatorio"
        fechahora Pagos_Fecha "opcional"
    }
    Proveedores {
        entero Proveedores_ID PK "obligatorio"
        texto Proveedores_Nombre "obligatorio"
        texto Proveedores_Telefono "opcional"
        texto Proveedores_Email "opcional"
    }
    Mantenimientos {
        entero Mantenimientos_ID PK "obligatorio"
        entero Vehiculos_ID FK "obligatorio"
        entero Proveedores_ID FK "obligatorio"
        fecha Mantenimientos_Fecha "opcional"
        decimal Mantenimientos_CostoTotal "opcional"
    }
    DetalleMantenimiento {
        entero DetalleMantenimiento_ID PK "obligatorio"
        entero Mantenimientos_ID FK "obligatorio"
        texto DetalleMantenimiento_Descripcion "obligatorio"
        decimal DetalleMantenimiento_Costo "obligatorio"
    }
    Auditoria {
        entero Auditoria_ID PK "obligatorio"
        texto Auditoria_Tabla "obligatorio"
        texto Auditoria_Operacion "obligatorio"
        fechahora Auditoria_Fecha "opcional"
        texto Auditoria_Usuario "opcional"
        texto Auditoria_Detalle "opcional"
    }
    SolicitudesSoporte {
        entero SolicitudesSoporte_ID PK "obligatorio"
        texto SolicitudesSoporte_Nombre "obligatorio"
        texto SolicitudesSoporte_Email "obligatorio"
        texto SolicitudesSoporte_Categoria "opcional"
        texto SolicitudesSoporte_Mensaje "obligatorio"
        fechahora SolicitudesSoporte_Fecha "opcional"
        texto SolicitudesSoporte_Estado "opcional"
    }
```

## Modelo_Fisico

```mermaid
%%{init: {"theme":"base","themeVariables":{"fontSize":"18px","fontFamily":"Arial","primaryColor":"#DEEAF6","primaryTextColor":"#000000","primaryBorderColor":"#1F3864","lineColor":"#1F3864","secondaryColor":"#FFF2CC","tertiaryColor":"#FFFFFF","edgeLabelBackground":"#FFFFFF","attributeBackgroundColorOdd":"#FFFFFF","attributeBackgroundColorEven":"#EAF1FB"}}}%%
erDiagram
    Roles ||--o{ Usuarios : "tiene"
    Clientes ||--o{ Contactos : "posee"
    Clientes ||--o{ Resenas : "escribe"
    Clientes ||--o{ Direcciones : "reside en"
    Marcas ||--o{ Vehiculos : "es de la marca"
    Categorias ||--o{ Vehiculos : "pertenece a"
    EstadosVehiculo ||--o{ Vehiculos : "tiene estado"
    Categorias ||--o{ Tarifas : "se aplica a"
    Vehiculos ||--o{ Seguros : "asegura"
    Clientes ||--o{ Reservas : "realiza"
    Vehiculos ||--o{ Reservas : "reserva"
    Reservas ||--o| Contratos : "formaliza"
    Empleados ||--o{ Contratos : "firma"
    Contratos ||--o{ Entregas : "documenta"
    Contratos ||--o| Devoluciones : "cierra"
    Devoluciones ||--o{ Multas : "genera"
    Contratos ||--o| Facturas : "factura"
    Facturas ||--o{ Pagos : "salda"
    MetodosPago ||--o{ Pagos : "se paga con"
    Vehiculos ||--o{ Mantenimientos : "recibe"
    Proveedores ||--o{ Mantenimientos : "realiza"
    Mantenimientos ||--o{ DetalleMantenimiento : "detalla"
    Vehiculos ||..o{ Auditoria : "audita (sin FK)"
    Clientes ||..o{ Auditoria : "audita (sin FK)"
    Reservas ||..o{ Auditoria : "audita (sin FK)"
    Clientes ||..o{ SolicitudesSoporte : "solicita soporte por correo (sin FK)"

    Roles {
        INT Roles_ID PK "NOT NULL autoincremental"
        VARCHAR(50) Roles_Nombre UK "NOT NULL"
    }
    Usuarios {
        INT Usuarios_ID PK "NOT NULL autoincremental"
        VARCHAR(50) Usuarios_Nombre UK "NOT NULL"
        VARCHAR(255) Usuarios_Clave "NOT NULL"
        INT Roles_ID FK "NOT NULL"
        VARCHAR(20) Usuarios_Estado "NULL DEFAULT Activo"
    }
    Empleados {
        INT Empleados_ID PK "NOT NULL autoincremental"
        VARCHAR(15) Empleados_Cedula UK "NOT NULL"
        VARCHAR(100) Empleados_Nombre "NOT NULL"
        VARCHAR(50) Empleados_Cargo "NOT NULL"
        DATE Empleados_FechaIngreso "NULL DEFAULT CURRENT_DATE"
    }
    Clientes {
        INT Clientes_ID PK "NOT NULL autoincremental"
        VARCHAR(15) Clientes_Cedula UK "NOT NULL"
        VARCHAR(100) Clientes_Nombre "NOT NULL"
        VARCHAR(20) Clientes_Licencia UK "NOT NULL"
        DATETIME Clientes_FechaRegistro "NULL DEFAULT CURRENT_TIMESTAMP"
    }
    Direcciones {
        INT Direcciones_ID PK "NOT NULL autoincremental"
        INT Clientes_ID FK "NOT NULL"
        VARCHAR(150) Direcciones_Detalle "NOT NULL"
        VARCHAR(50) Direcciones_Ciudad "NOT NULL"
    }
    Contactos {
        INT Contactos_ID PK "NOT NULL autoincremental"
        INT Clientes_ID FK "NOT NULL"
        VARCHAR(15) Contactos_Telefono "NOT NULL"
        VARCHAR(100) Contactos_Email "NULL"
    }
    Resenas {
        INT Resenas_ID PK "NOT NULL autoincremental"
        INT Clientes_ID FK "NOT NULL"
        INT Resenas_Estrellas "NOT NULL"
        VARCHAR(255) Resenas_Comentario "NULL"
        DATETIME Resenas_Fecha "NULL DEFAULT CURRENT_TIMESTAMP"
    }
    Marcas {
        INT Marcas_ID PK "NOT NULL autoincremental"
        VARCHAR(50) Marcas_Nombre UK "NOT NULL"
    }
    Categorias {
        INT Categorias_ID PK "NOT NULL autoincremental"
        VARCHAR(50) Categorias_Nombre UK "NOT NULL"
        VARCHAR(150) Categorias_Descripcion "NULL"
    }
    EstadosVehiculo {
        INT EstadosVehiculo_ID PK "NOT NULL autoincremental"
        VARCHAR(30) EstadosVehiculo_Descripcion UK "NOT NULL"
    }
    Vehiculos {
        INT Vehiculos_ID PK "NOT NULL autoincremental"
        VARCHAR(10) Vehiculos_Placa UK "NOT NULL"
        INT Vehiculos_Anio "NOT NULL"
        INT Marcas_ID FK "NOT NULL"
        INT Categorias_ID FK "NOT NULL"
        INT EstadosVehiculo_ID FK "NOT NULL"
    }
    Tarifas {
        INT Tarifas_ID PK "NOT NULL autoincremental"
        INT Categorias_ID FK "NOT NULL"
        DECIMAL Tarifas_PrecioDiario "(10,2) NOT NULL"
    }
    Seguros {
        INT Seguros_ID PK "NOT NULL autoincremental"
        INT Vehiculos_ID FK "NOT NULL"
        VARCHAR(50) Seguros_Poliza "NOT NULL"
        DECIMAL Seguros_Costo "(10,2) NOT NULL"
    }
    Reservas {
        INT Reservas_ID PK "NOT NULL autoincremental"
        INT Clientes_ID FK "NOT NULL"
        INT Vehiculos_ID FK "NOT NULL"
        DATE Reservas_FechaInicio "NOT NULL"
        DATE Reservas_FechaFin "NOT NULL"
        VARCHAR(20) Reservas_Estado "NULL DEFAULT Pendiente"
    }
    Contratos {
        INT Contratos_ID PK "NOT NULL autoincremental"
        INT Reservas_ID FK, UK "NOT NULL"
        INT Empleados_ID FK "NOT NULL"
        DATETIME Contratos_FechaFirma "NULL DEFAULT CURRENT_TIMESTAMP"
        VARCHAR(20) Contratos_Estado "NULL DEFAULT Activo"
    }
    Entregas {
        INT Entregas_ID PK "NOT NULL autoincremental"
        INT Contratos_ID FK "NOT NULL"
        INT Entregas_Kilometraje "NOT NULL"
        VARCHAR(20) Entregas_NivelCombustible "NOT NULL"
        VARCHAR(255) Entregas_Observaciones "NULL"
    }
    Devoluciones {
        INT Devoluciones_ID PK "NOT NULL autoincremental"
        INT Contratos_ID FK, UK "NOT NULL"
        DATETIME Devoluciones_Fecha "NULL DEFAULT CURRENT_TIMESTAMP"
        INT Devoluciones_Kilometraje "NOT NULL"
    }
    Multas {
        INT Multas_ID PK "NOT NULL autoincremental"
        INT Devoluciones_ID FK "NOT NULL"
        VARCHAR(150) Multas_Motivo "NOT NULL"
        DECIMAL Multas_Monto "(10,2) NOT NULL"
    }
    Facturas {
        INT Facturas_ID PK "NOT NULL autoincremental"
        INT Contratos_ID FK, UK "NOT NULL"
        DATETIME Facturas_FechaEmision "NULL DEFAULT CURRENT_TIMESTAMP"
        DECIMAL Facturas_MontoTotal "(10,2) NOT NULL"
        VARCHAR(20) Facturas_Estado "NULL DEFAULT Pendiente"
    }
    MetodosPago {
        INT MetodosPago_ID PK "NOT NULL autoincremental"
        VARCHAR(50) MetodosPago_Descripcion UK "NOT NULL"
    }
    Pagos {
        INT Pagos_ID PK "NOT NULL autoincremental"
        INT Facturas_ID FK "NOT NULL"
        INT MetodosPago_ID FK "NOT NULL"
        DECIMAL Pagos_Monto "(10,2) NOT NULL"
        DATETIME Pagos_Fecha "NULL DEFAULT CURRENT_TIMESTAMP"
    }
    Proveedores {
        INT Proveedores_ID PK "NOT NULL autoincremental"
        VARCHAR(100) Proveedores_Nombre "NOT NULL"
        VARCHAR(15) Proveedores_Telefono "NULL"
        VARCHAR(100) Proveedores_Email "NULL"
    }
    Mantenimientos {
        INT Mantenimientos_ID PK "NOT NULL autoincremental"
        INT Vehiculos_ID FK "NOT NULL"
        INT Proveedores_ID FK "NOT NULL"
        DATE Mantenimientos_Fecha "NULL DEFAULT CURRENT_DATE"
        DECIMAL Mantenimientos_CostoTotal "(10,2) NULL DEFAULT 0.00"
    }
    DetalleMantenimiento {
        INT DetalleMantenimiento_ID PK "NOT NULL autoincremental"
        INT Mantenimientos_ID FK "NOT NULL"
        VARCHAR(150) DetalleMantenimiento_Descripcion "NOT NULL"
        DECIMAL DetalleMantenimiento_Costo "(10,2) NOT NULL"
    }
    Auditoria {
        INT Auditoria_ID PK "NOT NULL autoincremental"
        VARCHAR(50) Auditoria_Tabla "NOT NULL"
        VARCHAR(20) Auditoria_Operacion "NOT NULL"
        DATETIME Auditoria_Fecha "NULL DEFAULT CURRENT_TIMESTAMP"
        VARCHAR(50) Auditoria_Usuario "NULL"
        VARCHAR(255) Auditoria_Detalle "NULL"
    }
    SolicitudesSoporte {
        INT SolicitudesSoporte_ID PK "NOT NULL autoincremental"
        VARCHAR(100) SolicitudesSoporte_Nombre "NOT NULL"
        VARCHAR(100) SolicitudesSoporte_Email "NOT NULL"
        VARCHAR(50) SolicitudesSoporte_Categoria "NULL DEFAULT Otro"
        VARCHAR(500) SolicitudesSoporte_Mensaje "NOT NULL"
        DATETIME SolicitudesSoporte_Fecha "NULL DEFAULT CURRENT_TIMESTAMP"
        VARCHAR(20) SolicitudesSoporte_Estado "NULL DEFAULT Pendiente"
    }
```
