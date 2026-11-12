<?php
require 'lib.php'; requerir([1, 2]); // Admin y Agente
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  try { 
    q('INSERT INTO Clientes(Clientes_Nombre, Clientes_Cedula, Clientes_Licencia) VALUES(?,?,?)', 
      [trim($_POST['nombre']), trim($_POST['cedula']), trim($_POST['licencia'])]); 
    msg('Cliente registrado con éxito.'); 
  } catch (PDOException $e) { 
    msg('Error: La cédula o licencia ya existen.', 'err'); 
  }
  header('Location: clientes.php'); exit;
}
cabecera('Clientes'); ?>
<form method="post"><?= campo() ?>
<label>Nombre completo<input name="nombre" required></label>
<label>Cédula<input name="cedula" required></label>
<label>Licencia<input name="licencia" required></label>
<button>Registrar Cliente</button></form>
<div class="tw"><table><tr><th>ID</th><th>Nombre</th><th>Cédula</th><th>Licencia</th></tr>
<?php foreach (q('SELECT * FROM Clientes ORDER BY Clientes_Nombre') as $r): ?>
<tr>
  <td><?= $r['Clientes_ID'] ?></td>
  <td><?= h($r['Clientes_Nombre']) ?></td>
  <td><?= h($r['Clientes_Cedula']) ?></td>
  <td><?= h($r['Clientes_Licencia']) ?></td>
</tr>
<?php endforeach; ?></table></div>
<?php pie();