<?php
require 'lib.php'; requerir([1]); // Solo Administrador

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try { 
    // Registrar el mantenimiento
    q('INSERT INTO Mantenimientos(Vehiculos_ID, Proveedores_ID, Mantenimientos_CostoTotal) VALUES(?,?,?)', 
      [(int)$_POST['vehiculo'], (int)$_POST['proveedor'], (float)$_POST['costo']]);
      
    // Cambiar el estado del vehículo a "En Mantenimiento" (ID 3)
    q('UPDATE Vehiculos SET EstadosVehiculo_ID = 3 WHERE Vehiculos_ID = ?', [(int)$_POST['vehiculo']]);
    
    msg('Mantenimiento registrado. El vehículo está fuera de servicio.');
  } catch (PDOException $e) { 
    msg('Error al registrar: ' . $e->getMessage(), 'err'); 
  }
  header('Location: mantenimientos.php'); exit;
}
cabecera('Gestión de Mantenimientos'); ?>

<form method="post"><?= campo() ?>
<label>Vehículo<select name="vehiculo" required>
  <?php foreach (q('SELECT v.*, m.Marcas_Nombre FROM Vehiculos v JOIN Marcas m ON v.Marcas_ID=m.Marcas_ID') as $v): ?>
    <option value="<?= $v['Vehiculos_ID'] ?>"><?= h($v['Vehiculos_Placa'] . ' - ' . $v['Marcas_Nombre']) ?></option>
  <?php endforeach; ?>
</select></label>

<label>Proveedor<select name="proveedor" required>
  <?php foreach (q('SELECT * FROM Proveedores') as $p): ?>
    <option value="<?= $p['Proveedores_ID'] ?>"><?= h($p['Proveedores_Nombre']) ?></option>
  <?php endforeach; ?>
</select></label>

<label>Costo (RD$)<input type="number" name="costo" step="0.01" required></label>
<button>Registrar Entrada al Taller</button></form>

<div class="tw"><table>
<tr><th>Vehículo</th><th>Proveedor</th><th>Fecha</th><th>Costo</th><th>Estado</th></tr>
<?php 
$sql = "SELECT m.*, v.Vehiculos_Placa, p.Proveedores_Nombre 
        FROM Mantenimientos m 
        JOIN Vehiculos v ON m.Vehiculos_ID = v.Vehiculos_ID 
        JOIN Proveedores p ON m.Proveedores_ID = p.Proveedores_ID 
        ORDER BY m.Mantenimientos_ID DESC";
foreach (q($sql) as $r): ?>
<tr>
  <td><?= h($r['Vehiculos_Placa']) ?></td>
  <td><?= h($r['Proveedores_Nombre']) ?></td>
  <td><?= h($r['Mantenimientos_Fecha']) ?></td>
  <td>RD$<?= number_format($r['Mantenimientos_CostoTotal'], 2) ?></td>
  <td>Registrado</td>
</tr>
<?php endforeach; ?></table></div>
<?php pie();