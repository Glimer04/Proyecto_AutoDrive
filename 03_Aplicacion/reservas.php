<?php
require 'lib.php'; 
requerir([1, 2, 3]); 
$u = usuario(); 
$esCliente = ($u['rol'] == 3);

$id_cliente_real = 0;
if ($esCliente) {
    $clienteData = q("SELECT Clientes_ID FROM Clientes WHERE Clientes_Nombre = ?", [$u['nombre']])->fetch();
    if ($clienteData) { $id_cliente_real = $clienteData['Clientes_ID']; }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try { 
    $id_cliente_reserva = $esCliente ? $id_cliente_real : (int)$_POST['cliente'];
    q('INSERT INTO Reservas(Clientes_ID, Vehiculos_ID, Reservas_FechaInicio, Reservas_FechaFin) VALUES(?,?,?,?)', 
      [$id_cliente_reserva, (int)$_POST['vehiculo'], $_POST['inicio'], $_POST['fin']]); 
    msg('Reserva registrada exitosamente.'); 
  } catch (PDOException $e) { 
    msg('Error al registrar la reserva. Verifique las fechas o el vehículo.', 'err'); 
  }
  header('Location: reservas.php'); exit;
}
cabecera('Reservas'); ?>

<form method="post" id="form-reserva"><?= campo() ?>
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

  <label>Desde<input type="date" name="inicio" id="fecha_inicio" min="<?= date('Y-m-d') ?>" required></label>
  <label>Hasta<input type="date" name="fin" id="fecha_fin" required></label>
  <button id="btn-reservar">Reservar</button>
</form>

<script>
    // 1. Validación de fechas en tiempo real
    const fechaInicio = document.getElementById('fecha_inicio');
    const fechaFin = document.getElementById('fecha_fin');
    
    fechaInicio.addEventListener('change', function() {
        fechaFin.min = this.value; // El mínimo de la fecha fin será la fecha de inicio
        if(fechaFin.value && fechaFin.value <= this.value) {
            fechaFin.value = ''; // Borra la fecha si es menor
        }
    });

    // 2. Efecto de carga en el botón
    document.getElementById('form-reserva').addEventListener('submit', function() {
        const btn = document.getElementById('btn-reservar');
        btn.textContent = 'Procesando...';
        btn.disabled = true;
        btn.style.opacity = '0.7';
    });
</script>

<div class="tw"><table>
<tr><th>ID</th><th>Cliente</th><th>Vehículo</th><th>Inicio</th><th>Fin</th></tr>
<?php 
if ($esCliente) {
    $sql_reservas = "SELECT r.*, c.Clientes_Nombre, v.Vehiculos_Placa FROM Reservas r JOIN Clientes c ON r.Clientes_ID = c.Clientes_ID JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID WHERE r.Clientes_ID = ? ORDER BY r.Reservas_ID DESC";
    $reservas = q($sql_reservas, [$id_cliente_real])->fetchAll();
} else {
    $sql_reservas = "SELECT r.*, c.Clientes_Nombre, v.Vehiculos_Placa FROM Reservas r JOIN Clientes c ON r.Clientes_ID = c.Clientes_ID JOIN Vehiculos v ON r.Vehiculos_ID = v.Vehiculos_ID ORDER BY r.Reservas_ID DESC";
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
