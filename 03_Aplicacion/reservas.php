<?php
require 'lib.php'; 
requerir([1, 2, 3]); 
$u = usuario(); 
$esCliente = ($u['rol'] == 3);

// Si es cliente, buscamos su ID real en la tabla Clientes para no permitirle reservar a otros
$id_cliente_real = 0;
if ($esCliente) {
    $clienteData = q("SELECT Clientes_ID FROM Clientes WHERE Clientes_Nombre = ?", [$u['nombre']])->fetch();
    if ($clienteData) { $id_cliente_real = $clienteData['Clientes_ID']; }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try { 
    // Si es cliente, forzamos su propio ID. Si es Admin/Agente, usamos el que seleccionó.
    $id_cliente_reserva = $esCliente ? $id_cliente_real : (int)$_POST['cliente'];
    
    q('INSERT INTO Reservas(Clientes_ID, Vehiculos_ID, Reservas_FechaInicio, Reservas_FechaFin) VALUES(?,?,?,?)', 
      [$id_cliente_reserva, (int)$_POST['vehiculo'], $_POST['inicio'], $_POST['fin']]); 
    msg('Reserva registrada exitosamente.'); 
  } catch (PDOException $e) { 
    msg('Error al registrar la reserva.', 'err'); 
  }
  header('Location: reservas.php'); exit;
}
cabecera('Reservas'); ?>

<form method="post"><?= campo() ?>
  
  <!-- SOLO ADMIN Y AGENTE PUEDEN SELECCIONAR EL CLIENTE -->
  <?php if (!$esCliente): ?>
  <label>Cliente<select name="cliente" required>
    <option value="">Seleccione...</option>
    <?php foreach (q('SELECT * FROM Clientes') as $c): ?>
      <option value="<?= $c['Clientes_ID'] ?>"><?= h($c['Clientes_Nombre']) ?></option>
    <?php endforeach; ?>
  </select></label>
  <?php endif; ?>

  <label>Vehículo<select name="vehiculo" required>
    <option value="">Seleccione...</option>
    <?php 
    $sql_vehiculos = "SELECT v.Vehiculos_ID, v.Vehiculos_Placa, m.Marcas_Nombre, c.Categorias_Nombre 
                      FROM Vehiculos v 
                      JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID 
                      JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID 
                      WHERE v.EstadosVehiculo_ID = 1";
    foreach (q($sql_vehiculos) as $v): ?>
      <option value="<?= $v['Vehiculos_ID'] ?>"><?= h($v['Marcas_Nombre'] . ' ' . $v['Categorias_Nombre'] . ' (' . $v['Vehiculos_Placa'] . ')') ?></option>
    <?php endforeach; ?>
  </select></label>

  <label>Desde<input type="date" name="inicio" required></label>
  <label>Hasta<input type="date" name="fin" required></label>
  <button>Reservar</button>
</form>

<div class="tw"><table>
<tr><th>ID</th><th>Cliente</th><th>Vehículo</th><th>Inicio</th><th>Fin</th></tr>
<?php 
// Si es cliente, solo mostramos SUS reservas. Si es Admin, mostramos TODAS.
if ($esCliente) {
    $sql_reservas = "SELECT r.*, c.Clientes_Nombre, v.Vehiculos_Placa 
                     FROM Reservas r 
                     JOIN Clientes c ON r.Clientes_ID = c.Clientes_ID 
                     JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID 
                     WHERE r.Clientes_ID = ?
                     ORDER BY r.Reservas_ID DESC";
    $reservas = q($sql_reservas, [$id_cliente_real])->fetchAll();
} else {
    $sql_reservas = "SELECT r.*, c.Clientes_Nombre, v.Vehiculos_Placa 
                     FROM Reservas r 
                     JOIN Clientes c ON r.Clientes_ID = c.Clientes_ID 
                     JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID 
                     ORDER BY r.Reservas_ID DESC";
    $reservas = q($sql_reservas)->fetchAll();
}

foreach ($reservas as $r): ?>
<tr>
  <td><?= $r['Reservas_ID'] ?></td>
  <td><?= h($r['Clientes_Nombre']) ?></td>
  <td><?= h($r['Vehiculos_Placa']) ?></td>
  <td><?= h($r['Reservas_FechaInicio']) ?></td>
  <td><?= h($r['Reservas_FechaFin']) ?></td>
</tr>
<?php endforeach; ?></table></div>
<?php pie(); ?>