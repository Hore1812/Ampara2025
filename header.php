<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
require_once 'auth_check.php'; // Proteger todas las páginas que usen este header
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<link rel="apple-touch-icon" sizes="180x180" href="../vendors/images/logoampara.png"/>
		<link rel="icon" type="image/png" sizes="32x32"	href="../vendors/images/logoampara.png"	/>
		<link rel="icon" type="image/png" sizes="16x16"	href="../vendors/images/logoampara.png"	/>
    <title>HISTORICO DE LIQUIDACIONES</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.php">Liquidaciones</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <?php if (isset($_SESSION['idusuario'])): ?>
                        <li class="nav-item">
                            <span class="navbar-text me-2">
                                Hola, <?php echo htmlspecialchars($_SESSION['nombre_usuario']); ?>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="logout.php"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
                        </li>
                    <?php else: ?>
                        <!-- Podrías tener un enlace a login.php aquí si el header se usara en páginas públicas -->
                        <!-- <li class="nav-item">
                            <a class="nav-link active" href="login.php">Iniciar Sesión</a>
                        </li> -->
                    <?php endif; ?>
                    <!-- El enlace original a ../inicio.php puede o no ser necesario ahora -->
                    <!--
                    <li class="nav-item">
                        <a class="nav-link active" href="../inicio.php">Inicio</a>
                    </li>
                    -->
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Contenedor principal -->
    <div class="container-fluid">
        <?php if (isset($_SESSION['mensaje_exito'])): ?>
            <div class="alert alert-success alert-dismissible fade show mt-3">
                <?= $_SESSION['mensaje_exito'] ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <?php unset($_SESSION['mensaje_exito']); ?>
        <?php endif; ?>
        
        <?php if (isset($_SESSION['mensaje_error'])): ?>
            <div class="alert alert-danger alert-dismissible fade show mt-3">
                <?= $_SESSION['mensaje_error'] ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <?php unset($_SESSION['mensaje_error']); ?>
        <?php endif; ?>