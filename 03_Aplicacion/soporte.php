<?php
require 'lib.php';
$enviado = false;
$u = usuario(); // Obtenemos el usuario actual
$esCliente = ($u['rol'] == 3); // Verificamos si es Cliente (Rol 3)

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  validar();
  try {
    q('INSERT INTO SolicitudesSoporte(SolicitudesSoporte_Nombre, SolicitudesSoporte_Email, SolicitudesSoporte_Categoria, SolicitudesSoporte_Mensaje) VALUES(?,?,?,?)',
      [trim($_POST['nombre']), trim($_POST['email']), trim($_POST['categoria']), trim($_POST['mensaje'])]);
    $enviado = true;
  } catch (Exception $e) {
    $error = "Hubo un error al enviar el mensaje.";
  }
}
cabecera('Soporte y Ayuda'); ?>

<div class="centro">
    <?php if ($enviado): ?>
        <div class="msg ok">¡Mensaje enviado con éxito! Pronto recibirás una respuesta.</div>
        <a href="index.php" class="btn">Volver al Panel</a>
    <?php else: ?>
        
        <!-- Texto dinámico según el rol -->
        <p style="text-align: center; margin-bottom: 2rem; color: #64748b;">
            <?php if ($esCliente): ?>
                ¿Necesitas ayuda con tu cuenta, una reserva o tienes una queja? Escríbenos y te atenderemos a la brevedad.
            <?php else: ?>
                Utilice este formulario para reportar incidencias técnicas, problemas con el sistema, o para solicitar asistencia relacionada con clientes, vehículos o reservas.
            <?php endif; ?>
        </p>

        <form method="post"><?= campo() ?>
            <label>Nombre del Reportante<input name="nombre" value="<?= h($u['nombre']) ?>" required></label>
            <label>Correo o Teléfono<input type="text" name="email" placeholder="<?= $esCliente ? 'Ej: cliente@correo.com' : 'Ej: ventas@autodrive.do' ?>" required></label>
            
            <label>Categoría del Reporte
                <select name="categoria" required>
                    <option value="">Seleccione una opción...</option>
                    <?php if ($esCliente): ?>
                        <!-- Opciones para CLIENTES -->
                        <option value="Ayuda">Ayuda con mi cuenta</option>
                        <option value="Reserva">Problema con una Reserva</option>
                        <option value="Queja">Queja o Reclamo</option>
                        <option value="Otro">Otro motivo</option>
                    <?php else: ?>
                        <!-- Opciones para ADMINISTRADORES Y AGENTES -->
                        <option value="Sistema">Fallo en el Sistema / Base de Datos</option>
                        <option value="Cliente">Problema con un Cliente</option>
                        <option value="Vehiculo">Incidencia con un Vehículo</option>
                        <option value="Reserva">Error en Reserva o Contrato</option>
                        <option value="Otro">Otro tipo de solicitud</option>
                    <?php endif; ?>
                </select>
            </label>
            
            <label>Descripción del Problema<textarea name="mensaje" rows="5" required placeholder="Describa detalladamente el inconveniente..."></textarea></label>
            <button>Enviar Mensaje</button>
        </form>
    <?php endif; ?>
</div>
<?php pie(); ?>