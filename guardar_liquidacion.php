<?php
require_once 'funciones.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $datos = [
            'fecha' => $_POST['fecha'],
            'asunto' => $_POST['asunto'],
            'tema' => $_POST['tema'],
            'motivo' => $_POST['motivo'],
            'tipohora' => $_POST['tipohora'],
            'acargode' => $_POST['acargode'],
            'lider' => $_POST['lider'],
            'cantidahoras' => $_POST['cantidahoras'],
            'estado' => $_POST['estado'],
            'idcontratocli' => $_POST['cliente'],
            'colaboradores' => []
        ];
        
        if ($datos['estado'] == 'Completo' && isset($_POST['colaboradores'])) {
            $totalPorcentaje = 0;
            
            foreach ($_POST['colaboradores'] as $colab) {
                if (!empty($colab['id']) && !empty($colab['porcentaje'])) {
                    $datos['colaboradores'][] = [
                        'id' => $colab['id'],
                        'porcentaje' => $colab['porcentaje'],
                        'comentario' => $colab['comentario'] ?? ''
                    ];
                    $totalPorcentaje += $colab['porcentaje'];
                }
            }
            
            if ($totalPorcentaje != 100) {
                throw new Exception("La suma total de porcentajes debe ser exactamente 100%. Actual: $totalPorcentaje%");
            }
        }
        
        $idLiquidacion = registrarLiquidacion($datos);
        
        $_SESSION['mensaje_exito'] = "Liquidación registrada correctamente con ID: $idLiquidacion";
        header('Location: index.php');
        exit;
    } catch (Exception $e) {
        $_SESSION['mensaje_error'] = "Error al registrar la liquidación: " . $e->getMessage();
        header('Location: registrar.php');
        exit;
    }
} else {
    header('Location: registrar.php');
    exit;
}
?>