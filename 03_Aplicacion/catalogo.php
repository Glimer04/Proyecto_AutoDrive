<?php
require 'lib.php'; 
cabecera('Catálogo de Vehículos'); 

$sql = "SELECT v.Vehiculos_ID, v.Vehiculos_Placa, v.Vehiculos_Anio, m.Marcas_Nombre, c.Categorias_Nombre, t.Tarifas_PrecioDiario 
        FROM Vehiculos v 
        JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID 
        JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID
        JOIN Tarifas t ON c.Categorias_ID = t.Categorias_ID
        WHERE v.EstadosVehiculo_ID = 1"; 
$vehiculos = q($sql)->fetchAll();
?>

<div class="grid-catalogo">
    <?php foreach ($vehiculos as $v): 
        $marca = strtolower($v['Marcas_Nombre']);
        // Asignación de imágenes según la marca
        if ($marca == 'toyota') {
            $img1 = 'img/toyota_1.jpg'; $img2 = 'img/toyota_2.jpg'; $img3 = 'img/toyota_3.jpg';
        } elseif ($marca == 'hyundai') {
            $img1 = 'img/hyundai_1.jpg'; $img2 = 'img/hyundai_2.jpg'; $img3 = 'img/hyundai_3.jpg';
        } else {
            $img1 = 'img/honda_1.jpg'; $img2 = 'img/honda_2.jpg'; $img3 = 'img/honda_3.jpg';
        }
    ?>
        <div class="card-vehiculo">
            <div class="galeria-css">
                <img src="<?= $img1 ?>" alt="Vista 1" onerror="this.src='https://via.placeholder.com/400x200?text=AutoDrive'">
                <img src="<?= $img2 ?>" alt="Vista 2" onerror="this.src='https://via.placeholder.com/400x200?text=AutoDrive'">
                <img src="<?= $img3 ?>" alt="Vista 3" onerror="this.src='https://via.placeholder.com/400x200?text=AutoDrive'">
            </div>
            
            <div class="card-info">
                <h3><?= h($v['Marcas_Nombre']) ?> <?= h($v['Categorias_Nombre']) ?></h3>
                <p class="categoria">Año <?= h($v['Vehiculos_Anio']) ?> · Placa: <?= h($v['Vehiculos_Placa']) ?></p>
                <div class="precio">RD$<?= number_format((float)$v['Tarifas_PrecioDiario'], 2) ?> <span>/ día</span></div>
                <a href="reservas.php" class="btn btn-block">Reservar Ahora</a>
            </div>
        </div>
    <?php endforeach; ?>
</div>

<?php pie(); ?>