<?php
// Establecer la zona horaria por defecto para todas las funciones de fecha/hora de PHP
date_default_timezone_set('America/Lima');

$host = 'localhost';
$db   = 'u505676278_inet_ampara';
$user = 'root';
$pass = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Establecer la zona horaria para la sesión de MySQL
    // America/Lima es generalmente UTC-5
    $pdo->exec("SET time_zone = '-05:00';");
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}
?>