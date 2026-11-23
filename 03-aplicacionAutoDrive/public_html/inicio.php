<?php
require 'lib.php'; 
// Si el usuario ya inició sesión, lo enviamos a su panel
if (usuario()) { header('Location: index.php'); exit; }
cabecera('Bienvenido a AutoDrive'); 
?>

<!-- HERO SECTION (Video/Imagen de fondo) -->
<div class="hero-section">
    <div class="hero-overlay">
        <div class="hero-content">
            <h1>Descubre República Dominicana sobre ruedas</h1>
            <p>La mejor flota de vehículos con la atención que mereces.</p>
            <a href="catalogo.php" class="btn-hero">Ver Vehículos Disponibles</a>
        </div>
    </div>
</div>

<!-- PRESENTACIÓN EMPRESA -->
<section class="seccion-empresa">
    <div class="container">
        <h2>¿Quiénes Somos?</h2>
        <p>AutoDrive S.R.L. es una empresa dominicana dedicada a brindar soluciones de movilidad flexible y segura al sector turístico y corporativo. Contamos con un taller propio que garantiza que cada vehículo entregado cumpla con los más altos estándares de calidad.</p>
        
        <div class="grid-mision-vision">
            <div class="card-info-empresa">
                <h3>Nuestra Misión</h3>
                <p>Proporcionar soluciones integrales de movilidad a turistas y al sector corporativo, garantizando la disponibilidad de una flota moderna y segura.</p>
            </div>
            <div class="card-info-empresa">
                <h3>Nuestra Visión</h3>
                <p>Consolidarnos para el año 2030 como la empresa líder en el mercado de alquiler de vehículos en la República Dominicana, siendo reconocidos por nuestra innovación tecnológica.</p>
            </div>
        </div>
    </div>
</section>

<!-- VEHÍCULOS DESTACADOS -->
<section class="seccion-destacados">
    <div class="container">
        <h2>Nuestros Vehículos Destacados</h2>
        <div class="grid-catalogo">
            <?php 
            // Traemos los 3 primeros vehículos disponibles
            $sql = "SELECT v.Vehiculos_ID, v.Vehiculos_Placa, v.Vehiculos_Anio, m.Marcas_Nombre, c.Categorias_Nombre, t.Tarifas_PrecioDiario 
                    FROM Vehiculos v 
                    JOIN Marcas m ON v.Marcas_ID = m.Marcas_ID 
                    JOIN Categorias c ON v.Categorias_ID = c.Categorias_ID
                    JOIN Tarifas t ON c.Categorias_ID = t.Categorias_ID
                    WHERE v.EstadosVehiculo_ID = 1 LIMIT 3"; 
            $vehiculos = q($sql)->fetchAll();
            foreach ($vehiculos as $v): 
                $marca = strtolower($v['Marcas_Nombre']);
                $img1 = ($marca == 'toyota') ? 'img/toyota_1.jpg' : (($marca == 'hyundai') ? 'img/hyundai_1.jpg' : 'img/honda_1.jpg');
            ?>
                <div class="card-vehiculo">
                    <div class="galeria-css" style="height: 200px;">
                        <img src="<?= $img1 ?>" alt="<?= h($v['Marcas_Nombre']) ?>" style="opacity: 1; animation: none;">
                    </div>
                    <div class="card-info">
                        <h3><?= h($v['Marcas_Nombre']) ?> <?= h($v['Categorias_Nombre']) ?></h3>
                        <p class="categoria">Año <?= h($v['Vehiculos_Anio']) ?></p>
                        <div class="precio">RD$<?= number_format((float)$v['Tarifas_PrecioDiario'], 2) ?> <span>/ día</span></div>
                        <a href="catalogo.php" class="btn btn-block">Ver más detalles</a>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
        <div style="text-align: center; margin-top: 2rem;">
            <a href="catalogo.php" class="btn btn-grande">Explorar todo el catálogo</a>
        </div>
    </div>
</section>

<!-- GUÍA TURÍSTICA (Nuevo) -->
<section class="seccion-guia">
    <div class="container">
        <h2>Guía para Turistas</h2>
        <p>Consejos para tu viaje por República Dominicana:</p>
        <div class="grid-guia">
            <div class="card-guia">
                <h4>🏖️ Playas</h4>
                <p>Visita Punta Cana y Bávaro. Recuerda que nuestros vehículos cuentan con aire acondicionado para el trayecto.</p>
            </div>
            <div class="card-guia">
                <h4>🏛️ Zona Colonial</h4>
                <p>Recorre la primera ciudad de América. Nuestros autos compactos son ideales para estacionar en esta zona.</p>
            </div>
            <div class="card-guia">
                <h4>⛰️ Zonas Montañosas</h4>
                <p>Si vas a Jarabacoa o Constanza, te recomendamos alquilar una de nuestras SUV 4x4.</p>
            </div>
        </div>
    </div>
</section>

<?php pie(); ?>