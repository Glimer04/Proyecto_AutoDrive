<?php
require 'lib.php'; requerir([1, 2]); // Admin y Agente
$adm = usuario()['rol'] == 1;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try { 
    // Adaptado a las columnas de tu tabla Vehiculos
    q('INSERT INTO Vehiculos(Vehiculos_Placa, Vehiculos_Anio, Marcas_ID, Categorias_ID, EstadosVehiculo_ID) VALUES(?,?,?,?,1)', 
      [strtoupper(trim($_POST['placa'])), (int)$_POST['anio'], (int)$_POST['marca'], (int)$_POST['cat']]); 
    msg('Vehículo registrado.'); 
  } catch (PDOException $e) { 
    msg('Error: La placa ya existe o los datos son inválidos.', 'err'); 
  }
  header('Location: vehiculos.php'); exit;
}
cabecera('Vehículos');

if ($adm): ?>
<form method="post"><?= campo() ?>
<label>Placa<input name="placa" required></label>
<label>Año<input type="number" name="anio" required></label>
<label>Marca<select name="marca">
  <?php foreach (q('SELECT * FROM Marcas') as $m): ?>
    <option value="<?= $m['Marcas_ID'] ?>"><?= h($m['Marcas_Nombre']) ?></option>
  <?php endforeach; ?>
</select></label>
<label>Categoría<select name="cat">
  <?php foreach (q('SELECT * FROM Categorias') as $c): ?>
    <option value="<?= $c['Categorias_ID'] ?>"><?= h($c['Categorias_Nombre']) ?></option>
  <?php endforeach; ?>
</select></label>
<button>Agregar Vehículo</button></form>
<?php endif; ?>

<div class="tw"><table>
<tr><th>Placa</th><th>Año</th><th>Marca</th><th>Categoría</th><th>Estado</th></tr>
<?php 
// Hacemos un JOIN para mostrar los nombres en lugar de los IDs
$sql = "SELECT v.*, m.Marcas_Nombre, c.Categorias_Nombre, e.EstadosVehiculo_Descripcion 
        FROM Vehiculos v 
        JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID 
        JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID 
        JOIN EstadosVehiculo e ON v.EstadosVehiculo_ID = e.EstadosVehiculo_ID
        ORDER BY v.Vehiculos_Placa";
foreach (q($sql) as $r): ?>
<tr>
  <td><?= h($r['Vehiculos_Placa']) ?></td>
  <td><?= h($r['Vehiculos_Anio']) ?></td>
  <td><?= h($r['Marcas_Nombre']) ?></td>
  <td><?= h($r['Categorias_Nombre']) ?></td>
  <td><?= h($r['EstadosVehiculo_Descripcion']) ?></td>
</tr>
<?php endforeach; ?></table></div>
<?php pie();