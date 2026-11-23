<?php
require 'lib.php'; 
cabecera('Catálogo de Vehículos'); 

// Consulta para obtener los vehículos disponibles
$sql = "SELECT v.Vehiculos_ID, v.Vehiculos_Placa, v.Vehiculos_Anio, m.Marcas_Nombre, c.Categorias_Nombre, t.Tarifas_PrecioDiario 
        FROM Vehiculos v 
        JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID 
        JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID
        JOIN Tarifas t ON c.Categorias_ID = t.Categorias_ID
        WHERE v.EstadosVehiculo_ID = 1"; 
$vehiculos = q($sql)->fetchAll();
?>

<div class="container">
    <!-- Título de la sección -->
    <div class="seccion-titulo" style="text-align: center; margin-bottom: 50px;">
        <h2 style="font-size: clamp(2rem, 4vw, 2.8rem); color: var(--navy); margin-bottom: 15px;">Nuestra Flota Disponible</h2>
        <p style="color: var(--m); font-size: 1.1rem; max-width: 700px; margin: 0 auto;">
            Explora nuestros vehículos y encuentra el ideal para tu viaje. Todos incluyen seguro y asistencia.
        </p>
    </div>

    <!-- Grid de Vehículos -->
    <div class="grid-catalogo">
        <?php if (empty($vehiculos)): ?>
            <div style="grid-column: 1 / -1; text-align: center; padding: 50px;">
                <p style="font-size: 1.2rem; color: var(--m);">No hay vehículos disponibles en este momento. Por favor, vuelve más tarde.</p>
            </div>
        <?php else: ?>
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
                        <!-- Enviamos el ID del vehículo a la página de reservas -->
                        <a href="reservas.php?vehiculo=<?= $v['Vehiculos_ID'] ?>" class="btn btn-block">Reservar Ahora</a>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</div>

<?php pie(); ?>