<?php
require 'lib.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    validar();
    $u = usuario();
    
    // Si el usuario está logueado, usamos su ID
    if ($u) {
        $cliente = q("SELECT Clientes_ID FROM Clientes WHERE Clientes_Nombre = ?", [$u['nombre']])->fetch();
        $id_cliente = $cliente ? $cliente['Clientes_ID'] : null;
    } else {
        // Si es un visitante, lo asignamos a un cliente "genérico" o lo dejamos nulo
        // Para este proyecto, lo asignaremos al primer cliente para no romper la FK
        $id_cliente = 1; 
    }

    if ($id_cliente && isset($_POST['estrellas']) && isset($_POST['comentario'])) {
        try {
            q("INSERT INTO Resenas (Clientes_ID, Resenas_Estrellas, Resenas_Comentario) VALUES (?, ?, ?)", 
              [$id_cliente, (int)$_POST['estrellas'], trim($_POST['comentario'])]);
            msg('¡Gracias por tu reseña! Nos ayuda a mejorar.');
        } catch (Exception $e) {
            msg('Hubo un error al guardar tu reseña.', 'err');
        }
    }
    header('Location: index.php'); exit;
}
?>