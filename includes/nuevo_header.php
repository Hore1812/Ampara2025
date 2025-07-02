<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
require_once '../auth_check.php'; // Proteger todas las páginas que usen este header
require_once '../conexion.php';   // Para obtener datos de la BD como la foto

// Variables para los datos del usuario
$ruta_foto_usuario = '../img/fotos/empleados/default_avatar.png'; // Imagen por defecto
$nombre_usuario_display = 'Usuario';
$tipo_usuario_actual = null; // Para determinar si es Admin

if (isset($_SESSION['idusuario'])) {
    if (isset($_SESSION['nombre_usuario'])) {
        $nombre_usuario_display = htmlspecialchars($_SESSION['nombre_usuario']);
    }

    if (isset($_SESSION['idemp']) && $pdo) {
        try {
            $stmt_foto = $pdo->prepare("SELECT rutafoto FROM empleado WHERE idempleado = :idemp AND activo = 1");
            $stmt_foto->bindParam(':idemp', $_SESSION['idemp']);
            $stmt_foto->execute();
            $empleado_info = $stmt_foto->fetch(PDO::FETCH_ASSOC);
            if ($empleado_info && !empty($empleado_info['rutafoto'])) {
                // rutafoto guarda la ruta desde la raíz, ej: img/fotos/empleados/usuario01.png
                // Como header.php está en includes/, necesitamos prefijar con ../
                $ruta_foto_usuario = '../' . htmlspecialchars($empleado_info['rutafoto']);
            }
        } catch (PDOException $e) {
            error_log("Error al obtener rutafoto: " . $e->getMessage());
            // Se mantiene la imagen por defecto
        }
    }

    if (isset($_SESSION['tipo_usuario'])) {
        $tipo_usuario_actual = $_SESSION['tipo_usuario'];
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicons: Ajustar ruta y nombre de archivo si es diferente -->
    <link rel="apple-touch-icon" sizes="180x180" href="../img/logo.webp"/>
    <link rel="icon" type="image/png" sizes="32x32" href="../img/logo.webp"/>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/logo.webp"/>
    <title><?php echo isset($page_title) ? htmlspecialchars($page_title) : 'Sistema Web'; ?></title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- DataTables CSS (si se sigue usando globalmente) -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="../css/estilo.css">
    <style>
        /* Estilos adicionales para el header si son necesarios */
        body {
            padding-top: 56px; /* Ajuste para el navbar fijo */
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            object-fit: cover;
        }
        .main-content {
            padding-top: 1rem; /* Espacio adicional después del header */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="../index.php">
                <img src="../img/logo.webp" alt="Logo" style="height: 30px; margin-right: 10px;">
                Sistema
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavPrincipal" aria-controls="navbarNavPrincipal" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavPrincipal">
                <!-- Menú Principal (Izquierda) -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="../index.php">Inicio</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownControl" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Control
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownControl">
                            <li><a class="dropdown-item" href="../control_registrar.php">Registrar</a></li>
                            <li><a class="dropdown-item" href="../historico_liquidaciones.php">Histórico</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCalendario" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Calendario
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownCalendario">
                            <li><a class="dropdown-item" href="../calendario_personal.php">Personal</a></li>
                            <li><a class="dropdown-item" href="../calendario_reuniones.php">Reuniones</a></li>
                            <li><a class="dropdown-item" href="../calendario_normativas.php">Normativas</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownNoticias" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Noticias
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownNoticias">
                            <li><a class="dropdown-item" href="../noticias_horas.php">Horas</a></li>
                            <li><a class="dropdown-item" href="../noticias_equipo.php">Equipo</a></li>
                            <li><a class="dropdown-item" href="../noticias_noticias.php">Noticias</a></li>
                            <li><a class="dropdown-item" href="../noticias_aprendizaje.php">Aprendizaje</a></li>
                        </ul>
                    </li>
                    <?php if ($tipo_usuario_actual == 1): // Solo para Admin ?>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownAdministrativo" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Administrativo
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownAdministrativo">
                            <li><a class="dropdown-item" href="../admin_reporte.php">Reporte</a></li>
                            <li><a class="dropdown-item" href="../admin_anuncios.php">Anuncios</a></li>
                            <li><a class="dropdown-item" href="../admin_usuarios.php">Usuarios</a></li>
                            <li><a class="dropdown-item" href="../admin_liquidaciones.php">Liquidaciones</a></li>
                        </ul>
                    </li>
                    <?php endif; ?>
                </ul>

                <!-- Zona de Usuario (Derecha) -->
                <ul class="navbar-nav ms-auto">
                    <?php if (isset($_SESSION['idusuario'])): ?>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="<?php echo $ruta_foto_usuario; ?>" alt="Foto de perfil" class="rounded-circle me-2 user-avatar">
                                <?php echo $nombre_usuario_display; ?>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownUser">
                                <li><a class="dropdown-item" href="#">Perfil</a></li> <!-- Enlace a # según lo solicitado -->
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="../logout.php"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    <?php else: ?>
                        <li class="nav-item">
                            <a class="nav-link" href="../login.php">Iniciar Sesión</a>
                        </li>
                    <?php endif; ?>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Contenedor principal para empujar el contenido debajo del navbar fijo -->
    <div class="container-fluid main-content">
        <?php if (isset($_SESSION['mensaje_exito'])): ?>
            <div class="alert alert-success alert-dismissible fade show mt-3">
                <?php echo htmlspecialchars($_SESSION['mensaje_exito']); ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <?php unset($_SESSION['mensaje_exito']); ?>
        <?php endif; ?>

        <?php if (isset($_SESSION['mensaje_error'])): ?>
            <div class="alert alert-danger alert-dismissible fade show mt-3">
                <?php echo htmlspecialchars($_SESSION['mensaje_error']); ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <?php unset($_SESSION['mensaje_error']); ?>
        <?php endif; ?>
        <!-- El contenido de la página específica se cargará aquí -->
    </div>

    <!-- Bootstrap Bundle with Popper (Importante para Dropdowns y otros componentes BS) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery (necesario para DataTables) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS y dependencias Bootstrap 5 (si se sigue usando) -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <!-- Tus otros scripts si los tienes -->
    <!-- <script src="../scripts.js"></script> --> <!-- Ejemplo si tienes un scripts.js en la raíz -->
</body>
</html>
