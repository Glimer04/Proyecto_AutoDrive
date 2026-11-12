<?php
require 'lib.php';
if (usuario()) { header('Location: index.php'); exit; }

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  validar();
  try {
    $pdo->beginTransaction();
    
    // 1. Insertar en Clientes
    q('INSERT INTO Clientes (Clientes_Nombre, Clientes_Cedula, Clientes_Licencia) VALUES (?, ?, ?)', 
      [trim($_POST['nombre']), trim($_POST['cedula']), trim($_POST['licencia'])]);
    
    // 2. Insertar en Usuarios (Rol 3 = Cliente)
    q('INSERT INTO Usuarios (Usuarios_Nombre, Usuarios_Clave, Roles_ID) VALUES (?, ?, 3)', 
      [trim($_POST['usuario']), trim($_POST['clave'])]);
      
    $pdo->commit();
    msg('¡Cuenta creada con éxito! Ya puedes iniciar sesión.');
    header('Location: login.php'); exit;
    
  } catch (PDOException $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    // Mensaje amigable si hay cédula o usuario duplicado
    if ($e->getCode() == 23000) {
        msg('Error: La cédula o el nombre de usuario ya están en uso.', 'err');
    } else {
        msg('Ocurrió un error al crear la cuenta.', 'err');
    }
  }
}
cabecera('Registro de Clientes'); ?>

<div class="centro">
    <p>Crea tu cuenta para poder reservar vehículos en línea.</p>
    <form method="post"><?= campo() ?>
        <label>Nombre Completo<input name="nombre" required></label>
        <label>Cédula<input name="cedula" required></label>
        <label>Licencia de Conducir<input name="licencia" required></label>
        <label>Nombre de Usuario (para entrar)<input name="usuario" required></label>
        <label>Contraseña<input type="password" name="clave" required minlength="4"></label>
        <button>Registrarme</button>
    </form>
    <p style="margin-top: 1rem;">¿Ya tienes cuenta? <a href="login.php">Inicia Sesión aquí</a></p>
</div>
<?php pie(); ?>