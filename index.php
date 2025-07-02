<?php
$page_title = "Bienvenido"; // Puedes definir un título específico para esta página
require_once 'includes/nuevo_header.php';
?>

<script>
    // Añadir la clase al body específicamente para esta página si se va a usar un estilo particular desde CSS
    // Si los estilos ya están en css/estilo.css para body.body-bg-logo, esto asegura que se aplique.
    document.addEventListener('DOMContentLoaded', function() {
        document.body.classList.add('body-bg-logo');
    });
</script>

<!-- Contenido principal de la página de bienvenida -->
<div class="index-content-wrapper">
    <!-- Aquí podrías añadir algún mensaje de bienvenida o contenido adicional si lo deseas en el futuro -->
    <!-- Por ahora, se mostrará principalmente el fondo con el logo y el header -->
</div>

<?php
// Verificar si footer.php existe antes de incluirlo
if (file_exists('footer.php')) {
    require_once 'footer.php';
}
?>
