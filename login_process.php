<?php
session_start(); // Iniciar la sesión al principio de todo

require 'conexion.php'; // Conexión a la BD
// require 'funciones.php'; // Crearemos este archivo para funciones auxiliares si es necesario

$mensajeError = '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty($_POST['username']) || empty($_POST['password'])) {
        $mensajeError = "Por favor, ingresa tu nombre de usuario y contraseña.";
    } else {
        $username = $_POST['username'];
        $password = $_POST['password'];

        try {
            // Buscar al usuario en la base de datos
            $stmt = $pdo->prepare("SELECT idusuario, nombre, password, activo FROM usuario WHERE nombre = :username");
            $stmt->bindParam(':username', $username);
            $stmt->execute();
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user) {
                // Verificar si el usuario está activo
                if ($user['activo'] != 1) { // Asumiendo que 1 significa activo
                    $mensajeError = "Tu cuenta no está activa. Contacta al administrador.";
                }
                // Verificar la contraseña
                // Verificar la contraseña usando password_verify(), ya que están hasheadas con password_hash()
                else if (password_verify($password, $user['password'])) {
                    // Contraseña correcta y usuario activo

                    // Iniciar sesión
                    $_SESSION['idusuario'] = $user['idusuario'];
                    $_SESSION['nombre_usuario'] = $user['nombre'];
                    $session_php_id = session_id(); // Obtener el ID de la sesión de PHP

                    // Registrar inicio de sesión en sesiones_log
                    $ip_address = $_SERVER['REMOTE_ADDR']; // Simple IP, considera X-Forwarded-For si usas proxy

                    $stmt_log_insert = $pdo->prepare("
                        INSERT INTO sesiones_log
                            (idusuario, session_php_id, ip_address_inicio, timestamp_inicio)
                        VALUES
                            (:idusuario, :session_php_id, :ip_address, NOW())
                    ");
                    $stmt_log_insert->bindParam(':idusuario', $user['idusuario']);
                    $stmt_log_insert->bindParam(':session_php_id', $session_php_id);
                    $stmt_log_insert->bindParam(':ip_address', $ip_address);
                    $stmt_log_insert->execute();

                    // Guardar el ID del log de sesión en la sesión de PHP para usarlo en el logout
                    // Este ID es el de la tabla `sesiones_log`, no el session_php_id
                    $_SESSION['id_sesion_log_db'] = $pdo->lastInsertId();

                    // Redirigir a la página principal de la aplicación (ahora protegida)
                    header("Location: index.php");
                    exit;
                } else {
                    $mensajeError = "Nombre de usuario o contraseña incorrectos.";
                }
            } else {
                $mensajeError = "Nombre de usuario o contraseña incorrectos.";
            }
        } catch (PDOException $e) {
            // Idealmente, loguear este error en un archivo en lugar de mostrarlo al usuario
            error_log("Error en login_process.php: " . $e->getMessage());
            $mensajeError = "Ocurrió un error en el servidor. Inténtalo más tarde.";
        }
    }
}

// Si hay un mensaje de error, redirigir de vuelta al formulario de login con el mensaje
if (!empty($mensajeError)) {
    $_SESSION['login_error'] = $mensajeError;
    // Redirigir de vuelta a login.php para mostrar el error
    header("Location: login.php");
    exit;
}
?>
