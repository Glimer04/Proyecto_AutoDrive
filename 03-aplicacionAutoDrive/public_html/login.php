<?php
require 'lib.php';

// Si ya está logueado, enviarlo al dashboard
if (usuario()) { 
    header('Location: dashboard.php'); 
    exit; 
}

$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ya no llamamos a validar() aquí porque está desactivada
    
    $nombre = trim($_POST['usuario'] ?? '');
    $clave = $_POST['clave'] ?? '';
    
    $u = q('SELECT * FROM Usuarios WHERE Usuarios_Nombre=?', [$nombre])->fetch();
    
    if ($u && $clave === $u['Usuarios_Clave']) {
        session_regenerate_id(true);
        $_SESSION['u'] = [
            'id' => $u['Usuarios_ID'],
            'nombre' => $u['Usuarios_Nombre'],
            'rol' => $u['Roles_ID']
        ];
        // REDIRECCIÓN EXITOSA
        header('Location: dashboard.php'); 
        exit;
    }
    $err = 'Usuario o contraseña incorrectos.';
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Iniciar Sesión · AutoDrive S.R.L</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
    <style> body { font-family: 'Montserrat', sans-serif; } </style>
</head>
<body class="login-body">

    <div class="login-overlay">
        <div class="login-card" style="animation: aparecer 0.6s ease-out;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <img src="img/logo.png" alt="AutoDrive" style="height: 70px; object-fit: contain;" onerror="this.style.display='none'">
                <h2 style="color: #0a192f; margin-top: 15px; font-size: 1.6rem; font-weight: 800; margin-bottom: 5px;">AutoDrive S.R.L</h2>
                <p style="color: #64748b; font-size: 0.95rem; margin: 0; font-weight: 500;">Sistema de Alquiler de Vehículos</p>
            </div>

            <?php if ($err): ?>
                <div class="msg err" style="text-align: center; font-size: 0.9rem;"><?= h($err) ?></div>
            <?php endif; ?>
            
            <form method="post" class="login-form">
                <!-- Token de seguridad desactivado, pero lo dejamos por compatibilidad -->
                <?= campo() ?>
                <label style="font-size: 0.95rem; color: #334155;">Usuario
                    <input type="text" name="usuario" required autofocus placeholder="Ingrese su usuario" style="padding: 14px; font-size: 1rem;">
                </label>
                <label style="font-size: 0.95rem; color: #334155;">Contraseña
                    <input type="password" name="clave" required placeholder="Ingrese su contraseña" style="padding: 14px; font-size: 1rem;">
                </label>
                <button style="margin-top: 1rem; padding: 15px; font-size: 1.05rem; font-weight: 700; letter-spacing: 0.5px;">Entrar al Sistema</button>
            </form>
            
            <div style="text-align: center; margin-top: 1.8rem; font-size: 0.95rem;">
                <span style="color: #64748b;">¿Eres un cliente nuevo?</span> 
                <a href="registro.php" style="color: #0878d1; text-decoration: none; font-weight: 600; margin-left: 5px;">Crea tu cuenta aquí</a>
            </div>
        </div>
    </div>

</body>
</html>