# Proyecto Final: Sistema de Alquiler de Vehículos (AutoDrive S.R.L.)

**Universidad Autónoma de Santo Domingo (UASD)**
**Asignatura:** Base de Datos I (INF-4200)
**Grupo:** 5

## 👥 Integrantes
*   Esteyesí Martínez
*   Glimmer Méndez
*   Dodany Pichardo
*   Jorge Vásquez
*   Pedro Estanilao

## 📝 Descripción del Proyecto
Este repositorio contiene los archivos correspondientes al Proyecto Final de la asignatura Base de Datos I. El sistema (SARV) gestiona los procesos de una empresa de rent-a-car (AutoDrive S.R.L.), incluyendo la administración de clientes, flota, reservas, mantenimiento y facturación.

## 📂 Contenido del Repositorio
*   `01_Documento_Informe/`: Informe final en formato PDF.
*   `02_Scripts_SQL/`: Scripts de creación (DDL), inserción (DML), consultas, vistas, triggers y procedimientos almacenados.
*   `03_Aplicacion/`: Código fuente de la aplicación desarrollada en Python (`sistema.py`) y el archivo de dependencias (`requirements.txt`).

## ⚙️ Requisitos e Instalación
Para ejecutar este proyecto en tu computadora, sigue estos pasos:

1. Tener instalado **Microsoft SQL Server** y **SQL Server Management Studio (SSMS)**.
2. Ejecutar los scripts de la carpeta `02_Scripts_SQL` en el siguiente orden:
   * `01_Creacion_BD.sql`
   * `02_Insercion_Datos.sql`
   * `04_Vistas_Triggers_SP.sql`
3. Tener instalado **Python 3.15** o superior.
4. Abrir una terminal en la carpeta del proyecto e instalar las dependencias:
   ```bash
   pip install -r 03_Aplicacion/requirements.txt
