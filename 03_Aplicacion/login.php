<?php
require 'lib.php';
if (usuario()) { header('Location: index.php'); exit; }
$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  validar();
  $u = q('SELECT * FROM Usuarios WHERE Usuarios_Nombre=?', [trim($_POST['usuario'] ?? '')])->fetch();
  
  if ($u && $_POST['clave'] === $u['Usuarios_Clave']) {
    session_regenerate_id(true);
    $_SESSION['u'] = ['id'=>$u['Usuarios_ID'],'nombre'=>$u['Usuarios_Nombre'],'rol'=>$u['Roles_ID']];
    header('Location: index.php'); exit;
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
    <!-- Usamos la hoja de estilos general -->
    <link rel="stylesheet" href="estilos.css">
</head>
<body class="login-body">

    <div class="login-overlay">
        <div class="login-card">
            <div style="text-align: center; margin-bottom: 1.5rem;">
                <!-- Logo de la empresa -->
                <img src="img/logo.png" alt="AutoDrive" style="height: 60px;" onerror="this.style.display='none'">
                <h2 style="color: #1e293b; margin-top: 10px; font-size: 1.5rem; margin-bottom: 5px;">AutoDrive S.R.L</h2>
                <p style="color: #64748b; font-size: 0.9rem; margin: 0;">Sistema de Alquiler de Vehículos</p>
            </div>

            <!-- Mostrar error si las credenciales fallan -->
            <?php if ($err): ?><div class="msg err"><?= h($err) ?></div><?php endif; ?>
            
            <!-- Formulario de Login -->
            <form method="post" class="login-form">
                <?= campo() ?>
                <label>Usuario
                    <input type="text" name="usuario" required autofocus placeholder="Ingrese su usuario">
                </label>
                <label>Contraseña
                    <input type="password" name="clave" required placeholder="Ingrese su contraseña">
                </label>
                <button style="margin-top: 1rem;">Entrar al Sistema</button>
            </form>
            
            <div style="text-align: center; margin-top: 1.5rem; font-size: 0.9rem;">
                <a href="registro.php" style="color: #1d4ed8; text-decoration: none;">¿Eres un cliente nuevo? Crea tu cuenta aquí</a>
            </div>
        </div>
    </div>

</body>
</html>