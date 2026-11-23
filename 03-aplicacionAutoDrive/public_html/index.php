<?php
require 'lib.php'; 
if (usuario()) { header('Location: dashboard.php'); exit; }
cabecera('Alquiler de Vehículos en RD'); 
?>

<!-- HERO SECTION -->
<div class="hero-section">
    <div class="hero-overlay">
        <div class="hero-content">
            <h1>Alquila tu vehículo en República Dominicana</h1>
            <p>Flota moderna, seguro incluido y atención 24/7. Descubre el país a tu ritmo.</p>
            
            <div class="buscador-hero">
                <form action="catalogo.php" method="GET">
                    <div class="input-group">
                        <label>Recogida</label>
                        <select name="lugar">
                            <option value="santo_domingo">Santo Domingo</option>
                            <option value="punta_cana">Punta Cana</option>
                            <option value="santiago">Santiago</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>Fecha Inicio</label>
                        <input type="date" name="inicio" required>
                    </div>
                    <div class="input-group">
                        <label>Fecha Fin</label>
                        <input type="date" name="fin" required>
                    </div>
                    <button type="submit" class="btn-buscar">Buscar Vehículos</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- BARRA DE CONFIANZA -->
<div class="barra-confianza">
    <div><span>🛡️</span> Seguro Todo Riesgo</div>
    <div><span>🛣️</span> Kilometraje Ilimitado</div>
    <div><span>🔧</span> Taller Propio</div>
    <div><span>🕒</span> Asistencia 24/7</div>
</div>

<!-- SECCIÓN DE VEHÍCULOS DESTACADOS (Dinámica desde la BD) -->
<section class="seccion-destacados" style="background: var(--bg); padding: 76px 0;">
    <div class="container">
        <div class="seccion-titulo" style="text-align: center; margin-bottom: 40px;">
            <h2 style="font-size: clamp(1.8rem, 3vw, 2.5rem); color: var(--navy); margin-bottom: 10px;">Nuestros Vehículos Destacados</h2>
            <p style="color: var(--m); font-size: 1.1rem;">Explora nuestra flota y elige el vehículo perfecto para tu viaje.</p>
        </div>
        
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
                        <img src="<?= $img1 ?>" alt="<?= h($v['Marcas_Nombre']) ?>" style="opacity: 1; animation: none; object-fit: cover;">
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
        <div style="text-align: center; margin-top: 3rem;">
            <a href="catalogo.php" class="btn btn-grande">Explorar todo el catálogo</a>
        </div>
    </div>
</section>

<!-- BENEFICIOS -->
<section class="seccion-beneficios">
    <div class="container">
        <h2>¿Por qué elegir AutoDrive?</h2>
        <div class="grid-beneficios">
            <div class="beneficio-item">
                <span class="icono">🛡️</span>
                <h3>Seguro Todo Riesgo</h3>
                <p>Cobertura completa para tu tranquilidad en cada viaje.</p>
            </div>
            <div class="beneficio-item">
                <span class="icono">🕒</span>
                <h3>Asistencia 24/7</h3>
                <p>Disponibles en todo momento para ayudarte ante cualquier imprevisto.</p>
            </div>
            <div class="beneficio-item">
                <span class="icono">🔧</span>
                <h3>Taller Propio</h3>
                <p>Mantenimiento garantizado para la seguridad de nuestra flota.</p>
            </div>
            <div class="beneficio-item">
                <span class="icono">📍</span>
                <h3>Entrega en Aeropuerto</h3>
                <p>Recoge tu vehículo al llegar a Santo Domingo o Punta Cana.</p>
            </div>
        </div>
    </div>
</section>

<!-- PRESENTACIÓN DE LA EMPRESA -->
<section class="seccion-empresa">
    <div class="container">
        <h2>Sobre AutoDrive S.R.L.</h2>
        <p>Somos una empresa dominicana dedicada a brindar soluciones de movilidad flexible y segura al sector turístico y corporativo. Contamos con un taller propio que garantiza que cada vehículo entregado cumpla con los más altos estándares de calidad.</p>
        
        <div class="grid-mision-vision">
            <div class="card-info-empresa">
                <h3>Nuestra Misión</h3>
                <p>Proporcionar soluciones integrales de movilidad a turistas y al sector corporativo, garantizando la disponibilidad de una flota moderna y segura.</p>
            </div>
            <div class="card-info-empresa">
                <h3>Nuestra Visión</h3>
                <p>Consolidarnos para el año 2030 como la empresa líder en el mercado de alquiler de vehículos en la República Dominicana.</p>
            </div>
        </div>
    </div>
</section>

<!-- GUÍA TURÍSTICA -->
<section class="seccion-guia">
    <div class="container">
        <h2>Guía para Turistas</h2>
        <p style="color: var(--m); max-width: 700px; margin: 0 auto 30px;">Consejos y recomendaciones para que tu viaje por República Dominicana sea inolvidable.</p>
        <div class="grid-guia">
            <div class="card-guia">
                <h4>🏖️ Punta Cana</h4>
                <p>Playas de arena blanca. Nuestras SUV son perfectas para el trayecto por la carretera del este.</p>
            </div>
            <div class="card-guia">
                <h4>🏛️ Zona Colonial</h4>
                <p>Historia pura. Te recomendamos nuestros vehículos compactos para estacionar fácilmente.</p>
            </div>
            <div class="card-guia">
                <h4>⛰️ Jarabacoa</h4>
                <p>Aventura en la montaña. Alquila una 4x4 para disfrutar de los ríos y el clima fresco.</p>
            </div>
        </div>
    </div>
</section>

<!-- TESTIMONIOS -->
<section class="seccion-testimonios">
    <div class="container">
        <h2>Lo que dicen nuestros clientes</h2>
        <div class="grid-testimonios">
            <div class="testimonio-card">
                <div class="estrellas">★★★★★</div>
                <p>"Excelente servicio. El vehículo estaba impecable y la entrega en el aeropuerto fue muy puntual."</p>
                <strong>- Carlos M., Turista</strong>
            </div>
            <div class="testimonio-card">
                <div class="estrellas">★★★★★</div>
                <p>"Alquilamos una SUV para ir a Jarabacoa y todo funcionó perfecto. El seguro nos dio mucha tranquilidad."</p>
                <strong>- Laura G., Turista</strong>
            </div>
        </div>
    </div>
</section>

<!-- FORMULARIO DE RESEÑA PÚBLICO -->
<section class="seccion-resena-publica">
    <div class="container centro">
        <h2>¡Tu opinión nos ayuda a mejorar!</h2>
        <p style="color: var(--m); margin-bottom: 20px;">Si has alquilado con nosotros, déjanos tu calificación.</p>
        <form method="post" action="procesar_resena.php" class="form-resena">
            <?= campo() ?>
            <div class="estrellas" style="display: flex; justify-content: center; gap: 10px; flex-direction: row-reverse; margin-bottom: 15px;">
                <input type="radio" name="estrellas" id="star5" value="5" required style="display: none;"><label for="star5" style="cursor: pointer; font-size: 2rem; color: #ccc;">★</label>
                <input type="radio" name="estrellas" id="star4" value="4" style="display: none;"><label for="star4" style="cursor: pointer; font-size: 2rem; color: #ccc;">★</label>
                <input type="radio" name="estrellas" id="star3" value="3" style="display: none;"><label for="star3" style="cursor: pointer; font-size: 2rem; color: #ccc;">★</label>
                <input type="radio" name="estrellas" id="star2" value="2" style="display: none;"><label for="star2" style="cursor: pointer; font-size: 2rem; color: #ccc;">★</label>
                <input type="radio" name="estrellas" id="star1" value="1" style="display: none;"><label for="star1" style="cursor: pointer; font-size: 2rem; color: #ccc;">★</label>
            </div>
            <style>
                /* Estilo para las estrellas seleccionables */
                .estrellas input:checked ~ label,
                .estrellas label:hover,
                .estrellas label:hover ~ label {
                    color: #f5a623 !important;
                }
            </style>
            <textarea name="comentario" placeholder="Cuéntanos tu experiencia..." required></textarea>
            <button type="submit" class="btn btn-block">Enviar Reseña</button>
        </form>
    </div>
</section>

<!-- MAPA DE UBICACIÓN -->
<section class="seccion-ubicacion">
    <div class="container">
        <h2>¿Dónde estamos?</h2>
        <div class="mapa-container">
            <iframe width="100%" height="400" frameborder="0" scrolling="no" 
                src="https://www.openstreetmap.org/export/embed.html?bbox=-69.95%2C18.45%2C-69.85%2C18.50&amp;layer=mapnik&amp;marker=18.475%2C-69.90" 
                style="border-radius: 12px; filter: saturate(1.5) contrast(1.1);">
            </iframe>
        </div>
    </div>
</section>

<?php pie(); ?>