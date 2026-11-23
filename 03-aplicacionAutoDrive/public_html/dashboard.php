<?php
require 'lib.php';
requerir([1, 2, 3]); // Todos los roles pueden acceder
$u = usuario();
$esCliente = ($u['rol'] == 3);
$esAdmin = ($u['rol'] == 1);

cabecera('Panel de Control'); ?>

<div class="container">
    <!-- Saludo -->
    <div style="background: linear-gradient(135deg, var(--navy) 0%, var(--navy-soft) 100%); padding: 40px; border-radius: var(--radio); color: white; margin-bottom: 40px; box-shadow: var(--sombra);">
        <h1 style="margin: 0; font-size: clamp(1.8rem, 4vw, 2.5rem);">Bienvenido, <?= h($u['nombre']) ?></h1>
        <p style="margin: 10px 0 0; opacity: 0.9; font-size: 1.1rem;">Rol: <?= $esAdmin ? 'Administrador' : ($esCliente ? 'Cliente' : 'Agente de Ventas') ?></p>
    </div>

    <?php if ($esCliente): ?>
        <!-- VISTA PARA CLIENTES -->
        <h2 style="color: var(--navy); margin-bottom: 20px;">Mis Reservas Recientes</h2>
        <div class="tw" style="margin-bottom: 30px;">
            <table>
                <thead><tr><th>Vehículo</th><th>Inicio</th><th>Fin</th><th>Estado</th></tr></thead>
                <tbody>
                    <?php
                    // Obtener el ID del cliente
                    $cli = q("SELECT Clientes_ID FROM Clientes WHERE Clientes_Nombre = ?", [$u['nombre']])->fetch();
                    $id_cli = $cli ? $cli['Clientes_ID'] : 0;
                    
                    $reservas = q("SELECT r.*, v.Vehiculos_Placa, m.Marcas_Nombre, c.Categorias_Nombre 
                                   FROM Reservas r 
                                   JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID 
                                   JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID
                                   JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID
                                   WHERE r.Clientes_ID = ? ORDER BY r.Reservas_ID DESC LIMIT 3", [$id_cli])->fetchAll();
                    if (empty($reservas)): ?>
                        <tr><td colspan="4" style="text-align: center; padding: 20px;">No tienes reservas aún. <a href="catalogo.php" style="color: var(--a);">¡Explora nuestra flota!</a></td></tr>
                    <?php else: foreach ($reservas as $r): ?>
                        <tr>
                            <td><?= h($r['Marcas_Nombre'] . ' ' . $r['Categorias_Nombre'] . ' (' . $r['Vehiculos_Placa'] . ')') ?></td>
                            <td><?= h($r['Reservas_FechaInicio']) ?></td>
                            <td><?= h($r['Reservas_FechaFin']) ?></td>
                            <td><span style="background: #e0f2fe; color: #075985; padding: 4px 10px; border-radius: 20px; font-size: 0.85rem; font-weight: 600;"><?= h($r['Reservas_Estado']) ?></span></td>
                        </tr>
                    <?php endforeach; endif; ?>
                </tbody>
            </table>
        </div>
        <div style="display: flex; gap: 15px; flex-wrap: wrap;">
            <a href="reservas.php" class="btn">Hacer una Nueva Reserva</a>
            <a href="catalogo.php" class="btn" style="background: var(--navy);">Ver Catálogo Completo</a>
        </div>

    <?php else: ?>
        <!-- VISTA PARA ADMINISTRADORES Y AGENTES -->
        <h2 style="color: var(--navy); margin-bottom: 20px;">Resumen de Gestión</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 40px;">
            <?php
            // Estadísticas rápidas
            $totalVehiculos = q("SELECT COUNT(*) as c FROM Vehiculos")->fetch()['c'] ?? 0;
            $totalClientes = q("SELECT COUNT(*) as c FROM Clientes")->fetch()['c'] ?? 0;
            $totalReservas = q("SELECT COUNT(*) as c FROM Reservas")->fetch()['c'] ?? 0;
            $vehiculosDisponibles = q("SELECT COUNT(*) as c FROM Vehiculos WHERE EstadosVehiculo_ID = 1")->fetch()['c'] ?? 0;
            ?>
            <div class="card" style="padding: 25px; text-align: center; border-top: 4px solid var(--a);">
                <h3 style="color: var(--a); font-size: 2rem; margin-bottom: 5px;"><?= $totalVehiculos ?></h3>
                <p style="color: var(--m); margin: 0; font-weight: 600;">Vehículos Totales</p>
                <small style="color: #666; display: block; margin-top: 5px;">(<?= $vehiculosDisponibles ?> disponibles)</small>
            </div>
            <div class="card" style="padding: 25px; text-align: center; border-top: 4px solid var(--exito);">
                <h3 style="color: var(--exito); font-size: 2rem; margin-bottom: 5px;"><?= $totalClientes ?></h3>
                <p style="color: var(--m); margin: 0; font-weight: 600;">Clientes Registrados</p>
            </div>
            <div class="card" style="padding: 25px; text-align: center; border-top: 4px solid #f5a623;">
                <h3 style="color: #f5a623; font-size: 2rem; margin-bottom: 5px;"><?= $totalReservas ?></h3>
                <p style="color: var(--m); margin: 0; font-weight: 600;">Reservas Realizadas</p>
            </div>
        </div>

        <h2 style="color: var(--navy); margin-bottom: 20px;">Accesos Rápidos</h2>
        <div class="grid-beneficios" style="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));">
            <a href="vehiculos.php" class="card" style="text-decoration: none; padding: 30px; text-align: center; transition: transform 0.2s;">
                <span style="font-size: 2.5rem; display: block; margin-bottom: 10px;">🚗</span>
                <h3 style="color: var(--navy); margin: 0;">Gestionar Vehículos</h3>
            </a>
            <a href="clientes.php" class="card" style="text-decoration: none; padding: 30px; text-align: center; transition: transform 0.2s;">
                <span style="font-size: 2.5rem; display: block; margin-bottom: 10px;">👥</span>
                <h3 style="color: var(--navy); margin: 0;">Gestionar Clientes</h3>
            </a>
            <a href="reservas.php" class="card" style="text-decoration: none; padding: 30px; text-align: center; transition: transform 0.2s;">
                <span style="font-size: 2.5rem; display: block; margin-bottom: 10px;">📅</span>
                <h3 style="color: var(--navy); margin: 0;">Gestionar Reservas</h3>
            </a>
            <?php if ($esAdmin): ?>
            <a href="mantenimientos.php" class="card" style="text-decoration: none; padding: 30px; text-align: center; transition: transform 0.2s;">
                <span style="font-size: 2.5rem; display: block; margin-bottom: 10px;">🔧</span>
                <h3 style="color: var(--navy); margin: 0;">Gestionar Taller</h3>
            </a>
            <?php endif; ?>
        </div>
    <?php endif; ?>
</div>

<?php pie(); ?>