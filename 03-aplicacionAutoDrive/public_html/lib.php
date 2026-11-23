<?php
declare(strict_types=1);

// ACTIVAR ERRORES PARA VER QUÉ PASA
error_reporting(E_ALL);
ini_set('display_errors', '1');

// Inicio de sesión compatible con hostings gratuitos
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$cfg = require __DIR__ . '/config.php';

try {
  $pdo = new PDO("mysql:host={$cfg['host']};dbname={$cfg['db']};charset=utf8mb4", $cfg['user'], $cfg['pass'],
    [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES=>false]);
} catch (PDOException $e) { 
    exit('Error de conexión a la base de datos: ' . $e->getMessage()); 
}

// --- FUNCIONES DE UTILIDAD ---
function h($s): string { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }
function q(string $sql, array $p = []) { global $pdo; $s = $pdo->prepare($sql); $s->execute($p); return $s; }
function msg(string $t, string $tipo = 'ok'): void { $_SESSION['m'] = [$t, $tipo]; }
function csrf(): string { return $_SESSION['t'] ??= bin2hex(random_bytes(32)); }
function campo(): string { return '<input type="hidden" name="t" value="' . csrf() . '">'; }

// VALIDACIÓN DESACTIVADA TEMPORALMENTE
function validar(): void {
  return; 
}

function usuario(): ?array { return $_SESSION['u'] ?? null; }
function requerir(array $roles): void {
  $u = usuario();
  if (!$u) { header('Location: login.php'); exit; }
  if (!in_array($u['rol'], $roles, true)) { http_response_code(403); exit('Acceso denegado.'); }
}

// --- FUNCIÓN DE CABECERA (HEADER) ---
function cabecera(string $t): void { 
    $u = usuario(); 
    $m = $_SESSION['m'] ?? null; 
    unset($_SESSION['m']); 
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title><?= h($t) ?> · AutoDrive S.R.L</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
    <script>
        if (localStorage.getItem('tema') === 'oscuro') {
            document.documentElement.classList.add('dark-mode');
        }
    </script>
    <style> body { font-family: 'Montserrat', sans-serif; } </style>
</head>
<body>
<header>
    <a class="logo" href="index.php">
        <img src="img/logo.png" alt="AutoDrive" style="height: 50px; margin-right: 10px;" onerror="this.style.display='none'">
    </a>
    
    <nav>
        <a href="index.php">Inicio</a>
        <a href="catalogo.php">Flota</a>
        <a href="soporte.php">Contacto</a>
        
        <?php if ($u): ?>
            <a href="dashboard.php">Panel</a>
            <?php if ($u['rol'] == 1 || $u['rol'] == 2): ?>
                <a href="clientes.php">Clientes</a>
                <a href="vehiculos.php">Vehículos</a>
            <?php endif; ?>
            <a href="reservas.php">Reservas</a>
            <?php if ($u['rol'] == 1): ?>
                <a href="mantenimientos.php">Taller</a>
            <?php endif; ?>
            <a href="logout.php" style="color: #fca5a5;">Salir (<?= h($u['nombre']) ?>)</a>
        <?php else: ?>
            <a href="login.php" class="btn-nav">Iniciar Sesión</a>
            <a href="registro.php" class="btn-nav-verde">Registrarse</a>
        <?php endif; ?>
        
        <button id="theme-toggle" class="theme-btn" title="Cambiar Tema">
            <span id="theme-icon">🌙</span>
        </button>
    </nav>
</header>

<main>
<?php if ($m): ?>
    <div class="msg <?= h($m[1]) ?>" id="mensaje-flash"><?= h($m[0]) ?></div>
    <script>
        setTimeout(() => { const msg = document.getElementById('mensaje-flash'); if(msg) { msg.style.opacity = '0'; setTimeout(() => msg.remove(), 500); } }, 3500); 
    </script>
<?php endif; ?>
<?php 
}

// --- FUNCIÓN DE PIE DE PÁGINA (FOOTER) ---
function pie(): void { 
    echo '
    </main>
    <footer class="site-footer">
        <div class="footer-content">
            <div class="footer-col">
                <img src="img/logo.png" alt="AutoDrive Logo" class="footer-logo" onerror="this.style.display=\'none\'">
                <p style="margin-top: 15px;">Movilidad flexible y segura para turismo y negocios en República Dominicana.</p>
            </div>
            <div class="footer-col">
                <h4>Enlaces Rápidos</h4>
                <a href="index.php">Inicio</a>
                <a href="catalogo.php">Nuestra Flota</a>
                <a href="soporte.php">Soporte</a>
            </div>
            <div class="footer-col">
                <h4>Contacto</h4>
                <p>📍 Av. 27 de Febrero, Santo Domingo</p>
                <p>📞 +1 (809) 555-1234</p>
                <p>✉️ info@autodrive.do</p>
            </div>
            <div class="footer-col">
                <h4>Síguenos</h4>
                <div class="redes">
                    <a href="https://www.instagram.com/autodrive.do" target="_blank" rel="noopener">📷 Instagram</a>
                    <a href="https://www.facebook.com/autodrive.do" target="_blank" rel="noopener">📘 Facebook</a>
                    <a href="https://wa.me/18095551234" target="_blank" rel="noopener" style="color:#25D366; font-weight:bold;">💬 WhatsApp</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2026 AutoDrive S.R.L. Todos los derechos reservados.</p>
        </div>
    </footer>

    <a href="https://wa.me/18095551234" class="whatsapp-float" target="_blank" title="Contáctanos por WhatsApp">
        <svg viewBox="0 0 32 32" width="35" height="35" fill="white">
            <path d="M16 2a13 13 0 0 0-11.2 19.6L3 30l8.6-2.3A13 13 0 1 0 16 2zm0 24a11 11 0 0 1-5.6-1.5l-.4-.2-4.1 1.1 1.1-4-.2-.4A11 11 0 1 1 16 26zm6-8.3c-.3-.2-1.9-1-2.2-1s-.5-.2-.8.2-1 1.1-1.2 1.3-.4.2-.7.1a8.4 8.4 0 0 1-4.2-3.7c-.3-.5.3-.5.8-1.4.1-.2 0-.4 0-.5s-.8-1.9-1.1-2.6c-.3-.7-.6-.6-.8-.6h-.7a1.4 1.4 0 0 0-1 .5 4.2 4.2 0 0 0-1.3 3.1 7.3 7.3 0 0 0 1.5 3.9 16.7 16.7 0 0 0 6.4 5.6c.9.4 1.6.6 2.1.8a5.1 5.1 0 0 0 2.3.1 3.8 3.8 0 0 0 2.5-1.8 3.1 3.1 0 0 0 .2-1.8c-.1-.1-.3-.2-.6-.3z"/>
        </svg>
    </a>

    <script>
        const themeToggleBtn = document.getElementById("theme-toggle");
        const themeIcon = document.getElementById("theme-icon");
        function actualizarIcono() {
            if (document.documentElement.classList.contains("dark-mode")) {
                themeIcon.textContent = "☀️"; 
            } else {
                themeIcon.textContent = "🌙"; 
            }
        }
        actualizarIcono();
        if(themeToggleBtn) {
            themeToggleBtn.addEventListener("click", () => {
                document.documentElement.classList.toggle("dark-mode");
                if (document.documentElement.classList.contains("dark-mode")) {
                    localStorage.setItem("tema", "oscuro");
                } else {
                    localStorage.setItem("tema", "claro");
                }
                actualizarIcono(); 
            });
        }
    </script> 
    </body></html>'; 
}
?>