<?php
require 'lib.php'; 
requerir([1, 2, 3]); 
$u = usuario(); 
$esCliente = ($u['rol'] == 3);

// Lógica para eliminar una reserva (solo Admin/Agente)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['eliminar_reserva']) && !$esCliente) {
    validar();
    $id_reserva = (int)$_POST['eliminar_reserva'];
    try {
        // Primero eliminamos las referencias en tablas hijas (Contratos)
        q("DELETE FROM Contratos WHERE Reservas_ID = ?", [$id_reserva]);
        // Luego eliminamos la reserva
        q("DELETE FROM Reservas WHERE Reservas_ID = ?", [$id_reserva]);
        msg('Reserva eliminada correctamente.');
    } catch (PDOException $e) {
        msg('No se pudo eliminar la reserva: ' . $e->getMessage(), 'err');
    }
    header('Location: reservas.php'); exit;
}

// Obtener el ID del cliente si el usuario es un cliente
$id_cliente_real = 0;
if ($esCliente) {
    $clienteData = q("SELECT Clientes_ID FROM Clientes WHERE Clientes_Nombre = ?", [$u['nombre']])->fetch();
    if ($clienteData) { $id_cliente_real = $clienteData['Clientes_ID']; }
}

// Lógica para insertar una nueva reserva
if ($_SERVER['REQUEST_METHOD'] === 'POST' && !isset($_POST['eliminar_reserva'])) {
    try {
        // Validación básica de fechas
        if (strtotime($_POST['inicio']) >= strtotime($_POST['fin'])) {
            throw new Exception("La fecha de fin debe ser posterior a la fecha de inicio.");
        }

        $id_cliente_reserva = $esCliente ? $id_cliente_real : (int)$_POST['cliente'];
        
        // Validar que el cliente y vehículo existan
        if (!$id_cliente_reserva || empty($_POST['vehiculo'])) {
            throw new Exception("Debe seleccionar un cliente y un vehículo válidos.");
        }

        q('INSERT INTO Reservas(Clientes_ID, Vehiculos_ID, Reservas_FechaInicio, Reservas_FechaFin) VALUES(?,?,?,?)', 
          [$id_cliente_reserva, (int)$_POST['vehiculo'], $_POST['inicio'], $_POST['fin']]); 
        msg('Reserva registrada exitosamente.'); 
    } catch (Exception $e) { 
        msg('Error al registrar la reserva: ' . $e->getMessage(), 'err'); 
    }
    header('Location: reservas.php'); exit;
}

// Capturamos el ID del vehículo que viene por GET desde el catálogo
$id_vehiculo_get = isset($_GET['vehiculo']) ? (int)$_GET['vehiculo'] : 0;

cabecera('Reservas'); ?>

<div class="container">
    <div class="seccion-titulo" style="text-align: center; margin-bottom: 40px;">
        <h2 style="font-size: clamp(2rem, 4vw, 2.8rem); color: var(--navy); margin-bottom: 15px;">Gestión de Reservas</h2>
        <p style="color: var(--m); font-size: 1.1rem;"><?= $esCliente ? 'Consulta y gestiona tus reservas activas.' : 'Administra las reservas de tus clientes.' ?></p>
    </div>

    <!-- Formulario de Nueva Reserva -->
    <div class="card" style="max-width: 800px; margin: 0 auto 40px;">
        <h3 style="color: var(--navy); margin-bottom: 20px;"><?= $esCliente ? 'Hacer una Nueva Reserva' : 'Agendar Nueva Reserva' ?></h3>
        <form method="post" id="form-reserva" style="display: grid; gap: 15px;">
            <?= campo() ?>
            <?php if (!$esCliente): ?>
            <div class="form-grupo">
                <label>Cliente</label>
                <select name="cliente" required>
                    <option value="">Seleccione un cliente...</option>
                    <?php foreach (q('SELECT * FROM Clientes ORDER BY Clientes_Nombre ASC') as $c): ?>
                        <option value="<?= $c['Clientes_ID'] ?>"><?= h($c['Clientes_Nombre']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <?php endif; ?>

            <div class="form-grupo">
                <label>Vehículo</label>
                <select name="vehiculo" required>
                    <option value="">Seleccione un vehículo...</option>
                    <?php 
                    $sql_vehiculos = "SELECT v.Vehiculos_ID, v.Vehiculos_Placa, m.Marcas_Nombre, c.Categorias_Nombre 
                                      FROM Vehiculos v 
                                      JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID 
                                      JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID 
                                      WHERE v.EstadosVehiculo_ID = 1";
                    foreach (q($sql_vehiculos) as $v): ?>
                        <!-- Aquí aplicamos la corrección para pre-seleccionar el vehículo -->
                        <option value="<?= $v['Vehiculos_ID'] ?>" <?= ($id_vehiculo_get == $v['Vehiculos_ID']) ? 'selected' : '' ?>>
                            <?= h($v['Marcas_Nombre'] . ' ' . $v['Categorias_Nombre'] . ' (' . $v['Vehiculos_Placa'] . ')') ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                <div class="form-grupo">
                    <label>Fecha de Inicio</label>
                    <input type="date" name="inicio" id="fecha_inicio" min="<?= date('Y-m-d') ?>" required>
                </div>
                <div class="form-grupo">
                    <label>Fecha de Fin</label>
                    <input type="date" name="fin" id="fecha_fin" required>
                </div>
            </div>
            
            <button id="btn-reservar" class="btn btn-block" style="margin-top: 10px;">Confirmar Reserva</button>
        </form>
    </div>

    <!-- Tabla de Historial de Reservas -->
    <h3 style="color: var(--navy); margin-bottom: 20px;">Historial de Reservas</h3>
    <div class="tw">
        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Cliente</th><th>Vehículo</th><th>Inicio</th><th>Fin</th><th>Estado</th>
                    <?php if (!$esCliente): ?><th>Acciones</th><?php endif; ?>
                </tr>
            </thead>
            <tbody>
                <?php 
                if ($esCliente) {
                    $sql_reservas = "SELECT r.*, c.Clientes_Nombre, v.Vehiculos_Placa FROM Reservas r JOIN Clientes c ON r.Clientes_ID = c.Clientes_ID JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID WHERE r.Clientes_ID = ? ORDER BY r.Reservas_ID DESC";
                    $reservas = q($sql_reservas, [$id_cliente_real])->fetchAll();
                } else {
                    $sql_reservas = "SELECT r.*, c.Clientes_Nombre, v.Vehiculos_Placa FROM Reservas r JOIN Clientes c ON r.Clientes_ID = c.Clientes_ID JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID ORDER BY r.Reservas_ID DESC";
                    $reservas = q($sql_reservas)->fetchAll();
                }
                
                if (empty($reservas)): ?>
                    <tr><td colspan="<?= $esCliente ? '6' : '7' ?>" style="text-align: center; padding: 30px;">No hay reservas registradas.</td></tr>
                <?php else: 
                    foreach ($reservas as $r): ?>
                    <tr>
                        <td><?= $r['Reservas_ID'] ?></td>
                        <td><?= h($r['Clientes_Nombre']) ?></td>
                        <td><?= h($r['Vehiculos_Placa']) ?></td>
                        <td><?= h($r['Reservas_FechaInicio']) ?></td>
                        <td><?= h($r['Reservas_FechaFin']) ?></td>
                        <td><span class="badge" style="background: #e0f2fe; color: #075985; padding: 4px 10px; border-radius: 20px; font-size: 0.85rem; font-weight: 600;"><?= h($r['Reservas_Estado']) ?></span></td>
                        <?php if (!$esCliente): ?>
                        <td>
                            <form method="post" onsubmit="return confirm('¿Estás seguro de que deseas eliminar esta reserva?');" style="display:inline;">
                                <?= campo() ?>
                                <input type="hidden" name="eliminar_reserva" value="<?= $r['Reservas_ID'] ?>">
                                <button type="submit" style="background:#ef4444; padding: 6px 12px; font-size: 0.85rem; border-radius: 6px; border: none; color: white; cursor: pointer;">Eliminar</button>
                            </form>
                        </td>
                        <?php endif; ?>
                    </tr>
                <?php endforeach; endif; ?>
            </tbody>
        </table>
    </div>
</div>

<script>
    const fechaInicio = document.getElementById('fecha_inicio');
    const fechaFin = document.getElementById('fecha_fin');
    fechaInicio.addEventListener('change', function() {
        fechaFin.min = this.value; 
        if(fechaFin.value && fechaFin.value <= this.value) { fechaFin.value = ''; }
    });
    document.getElementById('form-reserva').addEventListener('submit', function() {
        const btn = document.getElementById('btn-reservar');
        btn.textContent = 'Procesando...';
        btn.disabled = true;
        btn.style.opacity = '0.7';
    });
</script>

<?php pie(); ?>