<?php
require 'lib.php'; 
// Permitimos que cualquier rol (1=Admin, 2=Agente, 3=Cliente) entre al panel
requerir([1, 2, 3]); 
$u = usuario();
cabecera('Bienvenido, ' . $u['nombre']);

if ($u['rol'] == 3) {
    // Si es CLIENTE (Rol 3)
    // Buscamos su ID de cliente usando su nombre de usuario
    $cliente = q("SELECT Clientes_ID FROM Clientes WHERE Clientes_Nombre = ?", [$u['nombre']])->fetch();
    $id_cliente = $cliente ? $cliente['Clientes_ID'] : 0;
    
    $mis_reservas = q("SELECT COUNT(*) FROM Reservas WHERE Clientes_ID = ?", [$id_cliente])->fetchColumn();
    
    echo "<div class='cards'>
            <div><b>$mis_reservas</b>Mis Reservas Activas</div>
          </div>";
    echo "<a href='catalogo.php' class='btn'>Ver Catálogo de Vehículos</a>";
} else {
    // Si es ADMIN o AGENTE (Rol 1 o 2)
    $totalVehiculos = q("SELECT COUNT(*) FROM Vehiculos")->fetchColumn();
    $totalClientes = q("SELECT COUNT(*) FROM Clientes")->fetchColumn();
    $totalReservas = q("SELECT COUNT(*) FROM Reservas")->fetchColumn();

    echo "<div class='cards'>
        <div><b>$totalVehiculos</b>Vehículos en Flota</div>
        <div><b>$totalClientes</b>Clientes Registrados</div>
        <div><b>$totalReservas</b>Reservas Activas</div>
    </div>";
}
pie();