<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
require_once 'conexion.php'; // $pdo debe estar disponible aquí

// Actualizar el log de sesión si existe el ID en la sesión
if (isset($_SESSION['id_sesion_log_db']) && isset($pdo)) {
    try {
        $stmt_log_update = $pdo->prepare("UPDATE sesiones_log SET timestamp_fin = NOW() WHERE id_sesion_log = :id_sesion_log");
        $stmt_log_update->bindParam(':id_sesion_log', $_SESSION['id_sesion_log_db']);
        $stmt_log_update->execute();
    } catch (PDOException $e) {
        // Si hay un error (ej. tabla no existe, columna incorrecta), registrarlo pero no detener el logout.
        error_log("Error al actualizar timestamp_fin en sesiones_log: " . $e->getMessage());
    }
}

// Destruir todas las variables de sesión.
$_SESSION = array();

// Si se desea destruir la sesión completamente, borre también la cookie de sesión.
// Nota: ¡Esto destruirá la sesión, y no la información de la sesión!
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Finalmente, destruir la sesión.
session_destroy();

// Redirigir a la página de login (asumiendo que está en la raíz)
header("Location: login.php");
exit;
?>
