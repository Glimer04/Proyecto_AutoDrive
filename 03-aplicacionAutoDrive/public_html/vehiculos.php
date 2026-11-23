<?php
require 'lib.php'; 
requerir([1, 2]); // Admin y Agente
$adm = usuario()['rol'] == 1;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  validar();
  try { 
    q('INSERT INTO Vehiculos(Vehiculos_Placa, Vehiculos_Anio, Marcas_ID, Categorias_ID, EstadosVehiculo_ID) VALUES(?,?,?,?,1)', 
      [strtoupper(trim($_POST['placa'])), (int)$_POST['anio'], (int)$_POST['marca'], (int)$_POST['cat']]); 
    msg('Vehículo registrado exitosamente.'); 
  } catch (PDOException $e) { 
    msg('Error: La placa ya existe o los datos son inválidos.', 'err'); 
  }
  header('Location: vehiculos.php'); exit;
}
cabecera('Gestión de Vehículos');
?>

<div class="container">
    <div class="seccion-titulo" style="text-align: center; margin-bottom: 40px;">
        <h2 style="font-size: clamp(2rem, 4vw, 2.5rem); color: var(--navy);">Gestión de Vehículos</h2>
        <p style="color: var(--m);">Administra la flota de AutoDrive.</p>
    </div>

    <?php if ($adm): ?>
    <div class="card" style="margin-bottom: 40px;">
        <h3 style="color: var(--navy); margin-bottom: 20px;">Agregar Nuevo Vehículo</h3>
        <form method="post" style="display: grid; gap: 15px; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); align-items: end;">
            <?= campo() ?>
            <div class="form-grupo">
                <label>Placa</label>
                <input name="placa" required placeholder="Ej. A123456">
            </div>
            <div class="form-grupo">
                <label>Año</label>
                <input type="number" name="anio" required placeholder="Ej. 2023" min="1990" max="<?= date('Y')+1 ?>">
            </div>
            <div class="form-grupo">
                <label>Marca</label>
                <select name="marca">
                    <?php foreach (q('SELECT * FROM Marcas') as $m): ?>
                        <option value="<?= $m['Marcas_ID'] ?>"><?= h($m['Marcas_Nombre']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-grupo">
                <label>Categoría</label>
                <select name="cat">
                    <?php foreach (q('SELECT * FROM Categorias') as $c): ?>
                        <option value="<?= $c['Categorias_ID'] ?>"><?= h($c['Categorias_Nombre']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <button class="btn" style="height: 45px; margin-top: 8px;">Agregar</button>
        </form>
    </div>
    <?php endif; ?>

    <div class="tw">
        <table>
            <thead>
                <tr><th>Placa</th><th>Año</th><th>Marca</th><th>Categoría</th><th>Estado</th></tr>
            </thead>
            <tbody>
                <?php 
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
                    <td>
                        <span style="background: <?= $r['EstadosVehiculo_ID']==1 ? '#d1fae5' : ($r['EstadosVehiculo_ID']==2 ? '#fef3c7' : '#fee2e2') ?>; 
                                     color: <?= $r['EstadosVehiculo_ID']==1 ? '#065f46' : ($r['EstadosVehiculo_ID']==2 ? '#92400e' : '#991b1b') ?>; 
                                     padding: 5px 10px; border-radius: 20px; font-size: 0.85rem; font-weight: bold;">
                            <?= h($r['EstadosVehiculo_Descripcion']) ?>
                        </span>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<?php pie(); ?>