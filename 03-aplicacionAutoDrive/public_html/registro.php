<?php
require 'lib.php';
if (usuario()) { header('Location: index.php'); exit; }

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  validar();
  
  // Validación básica
  if (empty($_POST['nombre']) || empty($_POST['cedula']) || empty($_POST['licencia']) || empty($_POST['usuario']) || empty($_POST['clave'])) {
      msg('Todos los campos son obligatorios.', 'err');
  } elseif ($_POST['clave'] !== $_POST['clave_confirm']) {
      msg('Las contraseñas no coinciden.', 'err');
  } else {
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
}
cabecera('Registro de Clientes'); ?>

<div class="container centro" style="max-width: 600px; margin: 0 auto;">
    <div class="seccion-titulo" style="text-align: center; margin-bottom: 30px;">
        <h2 style="font-size: clamp(2rem, 4vw, 2.5rem); color: var(--navy);">Únete a AutoDrive</h2>
        <p style="color: var(--m); font-size: 1.05rem;">Crea tu cuenta para reservar vehículos en línea de forma rápida y segura.</p>
    </div>

    <div class="card" style="padding: 30px;">
        <form method="post">
            <?= campo() ?>
            <div class="form-grupo" style="margin-bottom: 15px;">
                <label>Nombre Completo</label>
                <input name="nombre" required placeholder="Ej. Juan Pérez">
            </div>
            <div class="form-grupo" style="margin-bottom: 15px;">
                <label>Cédula</label>
                <input name="cedula" required placeholder="Ej. 001-1234567-8">
            </div>
            <div class="form-grupo" style="margin-bottom: 15px;">
                <label>Licencia de Conducir</label>
                <input name="licencia" required placeholder="Ej. LIC-12345">
            </div>
            <hr style="border: none; border-top: 1px solid var(--b); margin: 25px 0;">
            <div class="form-grupo" style="margin-bottom: 15px;">
                <label>Nombre de Usuario</label>
                <input name="usuario" required placeholder="Ej. juanperez">
            </div>
            <div class="form-grupo" style="margin-bottom: 15px;">
                <label>Contraseña</label>
                <input type="password" name="clave" required minlength="4" placeholder="Mínimo 4 caracteres">
            </div>
            <div class="form-grupo" style="margin-bottom: 25px;">
                <label>Confirmar Contraseña</label>
                <input type="password" name="clave_confirm" required minlength="4" placeholder="Repite tu contraseña">
            </div>
            
            <button class="btn btn-block" style="padding: 14px; font-size: 1.05rem;">Registrarme</button>
        </form>
        <p style="margin-top: 20px; text-align: center; color: var(--m);">
            ¿Ya tienes cuenta? <a href="login.php" style="color: var(--a); font-weight: 600; text-decoration: none;">Inicia Sesión aquí</a>
        </p>
    </div>
</div>
<?php pie(); ?>