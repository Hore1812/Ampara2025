<?php
require_once 'funciones.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['idliquidacion'])) {
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
        
        $actualizado = actualizarLiquidacion($_POST['idliquidacion'], $datos);
        
        if ($actualizado) {
            $_SESSION['mensaje_exito'] = "Liquidación actualizada correctamente";
        } else {
            throw new Exception("No se pudo actualizar la liquidación");
        }
        
        header('Location: index.php');
        exit;
    } catch (Exception $e) {
        $_SESSION['mensaje_error'] = "Error al actualizar la liquidación: " . $e->getMessage();
        header('Location: editar.php?id=' . $_POST['idliquidacion']);
        exit;
    }
} else {
    header('Location: index.php');
    exit;
}
?>