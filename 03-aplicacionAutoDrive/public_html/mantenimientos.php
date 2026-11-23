<?php
require 'lib.php'; 
requerir([1]); // Solo Administrador
cabecera('Gestión de Mantenimientos');
?>

<div class="container">
    <div class="seccion-titulo" style="text-align: center; margin-bottom: 40px;">
        <h2 style="font-size: clamp(2rem, 4vw, 2.5rem); color: var(--navy);">Taller y Mantenimientos</h2>
        <p style="color: var(--m);">Controla el historial de servicios de tu flota.</p>
    </div>

    <div class="tw">
        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Vehículo (Placa)</th><th>Proveedor</th><th>Fecha</th><th>Costo Total</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                $sql = "SELECT m.*, v.Vehiculos_Placa, p.Proveedores_Nombre 
                        FROM Mantenimientos m 
                        JOIN Vehiculos v ON m.Vehiculos_ID = v.Vehiculos_ID 
                        LEFT JOIN Proveedores p ON m.Proveedores_ID = p.Proveedores_ID
                        ORDER BY m.Mantenimientos_Fecha DESC";
                $mantenimientos = q($sql)->fetchAll();
                
                if (empty($mantenimientos)): ?>
                    <tr><td colspan="5" style="text-align: center; padding: 30px;">No hay mantenimientos registrados.</td></tr>
                <?php else: foreach ($mantenimientos as $m): ?>
                <tr>
                    <td><?= $m['Mantenimientos_ID'] ?></td>
                    <td><?= h($m['Vehiculos_Placa']) ?></td>
                    <td><?= h($m['Proveedores_Nombre'] ?? 'N/A') ?></td>
                    <td><?= h($m['Mantenimientos_Fecha']) ?></td>
                    <td>RD$<?= number_format((float)$m['Mantenimientos_CostoTotal'], 2) ?></td>
                </tr>
                <?php endforeach; endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php pie(); ?>