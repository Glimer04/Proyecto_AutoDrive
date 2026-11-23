<?php
require 'lib.php';
$enviado = false;
$error = '';
$u = usuario(); // Puede ser null si no ha iniciado sesión

// Si hay un usuario logueado, obtenemos su rol, si no, es un visitante
$esCliente = ($u && $u['rol'] == 3); 
$esAdminAgente = ($u && ($u['rol'] == 1 || $u['rol'] == 2));

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  validar();
  try {
    q('INSERT INTO SolicitudesSoporte(SolicitudesSoporte_Nombre, SolicitudesSoporte_Email, SolicitudesSoporte_Categoria, SolicitudesSoporte_Mensaje) VALUES(?,?,?,?)',
      [trim($_POST['nombre']), trim($_POST['email']), trim($_POST['categoria']), trim($_POST['mensaje'])]);
    $enviado = true;
  } catch (Exception $e) {
    $error = "Hubo un error al enviar el mensaje. Intente de nuevo.";
  }
}
cabecera('Soporte y Ayuda'); ?>

<div class="container centro" style="max-width: 800px; margin: 0 auto;">
    <?php if ($enviado): ?>
        <div class="card" style="text-align: center; padding: 50px 30px;">
            <div style="font-size: 4rem; margin-bottom: 20px;">✅</div>
            <h2 style="color: var(--exito); margin-bottom: 15px;">¡Mensaje Enviado!</h2>
            <p style="color: var(--m); font-size: 1.1rem; margin-bottom: 30px;">Pronto recibirás una respuesta de nuestro equipo de soporte.</p>
            <a href="index.php" class="btn btn-grande">Volver al Inicio</a>
        </div>
    <?php else: ?>
        <div class="seccion-titulo" style="text-align: center; margin-bottom: 30px;">
            <h2 style="font-size: clamp(2rem, 4vw, 2.5rem); color: var(--navy);">Soporte y Ayuda</h2>
            <p style="color: var(--m); font-size: 1.05rem; max-width: 600px; margin: 0 auto;">
                <?php if ($esCliente): ?>
                    ¿Necesitas ayuda con tu cuenta, una reserva o tienes una queja? Escríbenos y te atenderemos a la brevedad.
                <?php elseif ($esAdminAgente): ?>
                    Utilice este formulario para reportar incidencias técnicas o solicitar asistencia interna.
                <?php else: ?>
                    ¿Tienes dudas sobre nuestros servicios? Déjanos tu mensaje y te contactaremos.
                <?php endif; ?>
            </p>
        </div>

        <?php if ($error): ?><div class="msg err" style="margin-bottom: 20px;"><?= h($error) ?></div><?php endif; ?>

        <div class="card" style="padding: 30px;">
            <form method="post" style="display: flex; flex-direction: column; gap: 20px;">
                <?= campo() ?>
                <div class="form-grupo">
                    <label>Nombre del Reportante</label>
                    <input name="nombre" value="<?= $u ? h($u['nombre']) : '' ?>" required placeholder="Tu nombre completo">
                </div>
                
                <div class="form-grupo">
                    <label>Correo o Teléfono de Contacto</label>
                    <input type="text" name="email" placeholder="<?= $esCliente ? 'Ej: cliente@correo.com' : 'Ej: ventas@autodrive.do' ?>" required>
                </div>
                
                <div class="form-grupo">
                    <label>Categoría del Reporte</label>
                    <select name="categoria" required>
                        <option value="">Seleccione una opción...</option>
                        <?php if ($esCliente): ?>
                            <option value="Ayuda">Ayuda con mi cuenta</option>
                            <option value="Reserva">Problema con una Reserva</option>
                            <option value="Queja">Queja o Reclamo</option>
                        <?php elseif ($esAdminAgente): ?>
                            <option value="Sistema">Fallo en el Sistema / Base de Datos</option>
                            <option value="Cliente">Problema con un Cliente</option>
                            <option value="Vehiculo">Incidencia con un Vehículo</option>
                            <option value="Reserva">Error en Reserva o Contrato</option>
                        <?php else: ?>
                            <option value="Informacion">Solicitud de Información</option>
                            <option value="Reserva">Quiero hacer una Reserva</option>
                            <option value="Otro">Otro motivo</option>
                        <?php endif; ?>
                    </select>
                </div>
                
                <div class="form-grupo">
                    <label>Descripción del Problema</label>
                    <textarea name="mensaje" rows="5" required placeholder="Describe detalladamente tu consulta o inconveniente..." style="width: 100%; padding: 12px; border: 1px solid var(--b); border-radius: 9px; font-family: inherit; resize: vertical;"></textarea>
                </div>
                
                <button class="btn btn-block" style="padding: 14px; font-size: 1.05rem;">Enviar Mensaje</button>
            </form>
        </div>
    <?php endif; ?>
</div>
<?php pie(); ?>