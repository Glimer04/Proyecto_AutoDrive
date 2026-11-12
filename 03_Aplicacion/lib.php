<?php
declare(strict_types=1);
$cfg = require __DIR__ . '/config.php';
session_set_cookie_params(['httponly'=>true,'samesite'=>'Strict','secure'=>!empty($_SERVER['HTTPS'])]);
session_start();

try {
  $pdo = new PDO("mysql:host={$cfg['host']};dbname={$cfg['db']};charset=utf8mb4", $cfg['user'], $cfg['pass'],
    [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES=>false]);
} catch (PDOException $e) { 
    exit('No se pudo conectar a la base de datos. Revise config.php'); 
}

function h($s): string { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }
function q(string $sql, array $p = []) { global $pdo; $s = $pdo->prepare($sql); $s->execute($p); return $s; }
function msg(string $t, string $tipo = 'ok'): void { $_SESSION['m'] = [$t, $tipo]; }
function csrf(): string { return $_SESSION['t'] ??= bin2hex(random_bytes(32)); }
function campo(): string { return '<input type="hidden" name="t" value="' . csrf() . '">'; }
function validar(): void {
  if ($_SERVER['REQUEST_METHOD'] === 'POST' && !hash_equals($_SESSION['t'] ?? '', $_POST['t'] ?? '')) { 
      http_response_code(403); exit('Solicitud inválida.'); 
  }
}
function usuario(): ?array { return $_SESSION['u'] ?? null; }
function requerir(array $roles): void {
  $u = usuario();
  if (!$u) { header('Location: login.php'); exit; }
  if (!in_array($u['rol'], $roles, true)) { http_response_code(403); exit('Acceso denegado.'); }
  validar();
}

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
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
<header>
    <a class="logo" href="index.php">
        <img src="img/logo.png" alt="AutoDrive" style="height: 40px; margin-right: 10px;" onerror="this.style.display='none'">
        AutoDrive <small>S.R.L</small>
    </a>
    <?php if ($u): ?>
    <nav>
        <a href="index.php">Panel</a>
        <a href="catalogo.php">Catálogo</a>
        <?php if ($u['rol'] == 1 || $u['rol'] == 2): ?>
            <a href="clientes.php">Clientes</a>
            <a href="vehiculos.php">Vehículos</a>
        <?php endif; ?>
        <a href="reservas.php">Reservas</a>
        <?php if ($u['rol'] == 1): ?>
            <a href="mantenimientos.php">Taller</a>
        <?php endif; ?>
        <a href="soporte.php">Soporte</a>
        <a href="logout.php">Salir (<?= h($u['nombre']) ?>)</a>
    </nav>
    <?php endif; ?>
</header>

<?php if (basename($_SERVER['PHP_SELF']) == 'index.php' || basename($_SERVER['PHP_SELF']) == 'catalogo.php'): ?>
    <div style="width: 100%; height: 350px; background: url('img/banner.jpg') center/cover no-repeat; margin-bottom: 2rem; border-radius: 0 0 20px 20px; position: relative;">
        <div style="position: absolute; top:0; left:0; width: 100%; height: 100%; background: rgba(29, 78, 216, 0.6); display: flex; align-items: center; justify-content: center; border-radius: 0 0 20px 20px;">
            <h1 style="color: white; font-size: 3rem; text-shadow: 2px 2px 4px rgba(0,0,0,0.5); margin: 0;">Bienvenido a AutoDrive</h1>
        </div>
    </div>
<?php endif; ?>

<main>
<?php if ($m): ?>
    <div class="msg <?= h($m[1]) ?>" id="mensaje-flash"><?= h($m[0]) ?></div>
    <script>
        // Script para que el mensaje desaparezca suavemente a los 3.5 segundos
        setTimeout(() => {
            const msg = document.getElementById('mensaje-flash');
            if(msg) { 
                msg.style.opacity = '0'; 
                setTimeout(() => msg.remove(), 500); 
            }
        }, 3500); 
    </script>
<?php endif; ?>
<h1><?= h($t) ?></h1>
<?php 
}

function pie(): void { 
    echo '</main><footer style="text-align:center; padding: 2rem; color: #64748b;">© 2026 AutoDrive S.R.L - Sistema de Alquiler</footer></body></html>'; 
}
