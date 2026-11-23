<?php
require 'lib.php'; 
requerir([1, 2]); // Admin y Agente
cabecera('Gestión de Clientes');
?>

<div class="container">
    <div class="seccion-titulo" style="text-align: center; margin-bottom: 40px;">
        <h2 style="font-size: clamp(2rem, 4vw, 2.5rem); color: var(--navy);">Directorio de Clientes</h2>
        <p style="color: var(--m);">Consulta y gestiona la información de tus clientes.</p>
    </div>

    <div class="tw">
        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Nombre</th><th>Cédula</th><th>Licencia</th><th>Teléfono</th><th>Email</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                $sql = "SELECT c.*, co.Contactos_Telefono, co.Contactos_Email 
                        FROM Clientes c 
                        LEFT JOIN Contactos co ON c.Clientes_ID = co.Clientes_ID 
                        ORDER BY c.Clientes_Nombre ASC";
                $clientes = q($sql)->fetchAll();
                
                if (empty($clientes)): ?>
                    <tr><td colspan="6" style="text-align: center; padding: 30px;">No hay clientes registrados aún.</td></tr>
                <?php else: foreach ($clientes as $c): ?>
                <tr>
                    <td><?= $c['Clientes_ID'] ?></td>
                    <td><strong><?= h($c['Clientes_Nombre']) ?></strong></td>
                    <td><?= h($c['Clientes_Cedula']) ?></td>
                    <td><?= h($c['Clientes_Licencia']) ?></td>
                    <td><?= h($c['Contactos_Telefono'] ?? 'N/A') ?></td>
                    <td><?= h($c['Contactos_Email'] ?? 'N/A') ?></td>
                </tr>
                <?php endforeach; endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php pie(); ?>