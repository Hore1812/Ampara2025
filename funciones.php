<?php
require_once 'conexion.php';

function obtenerLiquidaciones($filtros = []) {
    global $pdo;
    
    $sql = "SELECT LIQ.idliquidacion AS 'ID', LIQ.fecha AS 'FECHA', CLI.nombrecomercial AS 'CLIENTE', 
            TEM.descripcion AS TEMA, LIQ.asunto AS ASUNTO, LIQ.motivo as MOTIVO, 
            LID.nombrecorto AS 'LIDER', CAR.nombrecorto AS 'ENCARGADO', LIQ.estado AS 'ESTADO', 
            LIQ.cantidahoras AS 'HORAS', LIQ.tipohora AS 'TIPOHORA' 
            FROM liquidacion LIQ 
            INNER JOIN contratocliente CON ON LIQ.idcontratocli=CON.idcontratocli 
            INNER JOIN cliente CLI ON CLI.idcliente=CON.idcliente 
            INNER JOIN empleado LID ON LIQ.lider=LID.idempleado 
            INNER JOIN empleado CAR ON LIQ.acargode=CAR.idempleado 
            INNER JOIN tema TEM ON LIQ.tema=TEM.idtema 
            WHERE LIQ.activo=1";
    
    $params = [];
    
    if (!empty($filtros['anio'])) {
        $sql .= " AND YEAR(LIQ.fecha) = ?";
        $params[] = $filtros['anio'];
    }
    
    if (!empty($filtros['mes'])) {
        $sql .= " AND MONTH(LIQ.fecha) = ?";
        $params[] = $filtros['mes'];
    }
    
    if (!empty($filtros['cliente'])) {
        $sql .= " AND CLI.idcliente = ?";
        $params[] = $filtros['cliente'];
    }
    
    if (!empty($filtros['lider'])) {
        $sql .= " AND LID.idempleado = ?";
        $params[] = $filtros['lider'];
    }
    
    if (!empty($filtros['estado'])) {
        $sql .= " AND LIQ.estado = ?";
        $params[] = $filtros['estado'];
    }
    
    $sql .= " ORDER BY LIQ.idliquidacion DESC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerColaboradores() {
    global $pdo;
 $sql = "SELECT idempleado AS 'ID', nombrecorto AS 'COLABORADOR' 
            FROM empleado WHERE activo=1  ORDER BY 2";
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerClientes() {
    global $pdo;
    $sql = "SELECT idcliente, nombrecomercial FROM cliente ORDER BY nombrecomercial";
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerLideres() {
    global $pdo;
    $sql = "SELECT idempleado, nombrecorto FROM empleado WHERE activo = 1 ORDER BY nombrecorto";
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerTiposHora() {
    global $pdo;
    $sql = "SELECT DISTINCT tipohora FROM contratocliente";
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerClientesPorTipoHora($tipoHora) {
    global $pdo;
    $sql = "SELECT CON.idcontratocli, CONCAT(CON.idcliente,' – ',CLI.nombrecomercial) AS CLIENTE 
            FROM contratocliente AS CON 
            INNER JOIN cliente AS CLI ON CON.idcliente = CLI.idcliente 
            WHERE CON.tipohora=?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$tipoHora]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerLiderPorContrato($idContrato) {
    global $pdo;
    $sql = "SELECT CON.lider, EMP.nombrecorto 
            FROM contratocliente AS CON 
            INNER JOIN empleado EMP ON CON.lider = EMP.idempleado 
            WHERE CON.idcontratocli=?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$idContrato]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function obtenerTemas() {
    global $pdo;
    $sql = "SELECT idtema, descripcion FROM tema";
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerEncargadoPorTema($idTema) {
    global $pdo;
    $sql = "SELECT EMP.idempleado, EMP.nombrecorto 
            FROM empleado EMP 
            INNER JOIN tema TEM ON EMP.idempleado = TEM.idencargado 
            WHERE TEM.idtema=?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$idTema]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function obtenerColaboradoresPorLiquidacion($idLiquidacion) {
    global $pdo;
    $sql = "SELECT DIS.participante AS 'ID', EMP.nombrecorto AS 'COLABORADOR', 
            DIS.porcentaje AS 'Porcentaje', DIS.calculo AS 'CALCULO', 
            DIS.comentario AS 'COMENTARIO' 
            FROM distribucionhora DIS 
            INNER JOIN empleado EMP ON EMP.idempleado=DIS.participante 
            INNER JOIN liquidacion LIQ ON DIS.idliquidacion=LIQ.idliquidacion 
            WHERE LIQ.idliquidacion=?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$idLiquidacion]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function obtenerHistoricoColaborador($idColaborador, $anio = null, $mes = null, $estado = null) { // <--- Nuevo parámetro $estado
    global $pdo;
    
    $sql = "SELECT LIQ.idliquidacion AS 'ID', LIQ.fecha AS 'FECHA', CLI.nombrecomercial AS 'CLIENTE', 
            TEM.descripcion AS TEMA, LIQ.asunto AS ASUNTO, LIQ.motivo as MOTIVO, 
            LID.nombrecorto AS 'LIDER', CAR.nombrecorto AS 'ENCARGADO', 
            LIQ.estado AS 'ESTADO', DIS.calculo AS 'ACUMULADO', LIQ.tipohora AS 'TIPOHORA' 
            FROM liquidacion LIQ 
            INNER JOIN contratocliente CON ON LIQ.idcontratocli=CON.idcontratocli 
            INNER JOIN cliente CLI ON CLI.idcliente=CON.idcliente 
            INNER JOIN empleado LID ON LIQ.lider=LID.idempleado 
            INNER JOIN empleado CAR ON LIQ.acargode=CAR.idempleado 
            INNER JOIN tema TEM ON LIQ.tema=TEM.idtema 
            INNER JOIN distribucionhora DIS ON LIQ.idliquidacion=DIS.idliquidacion 
            WHERE LIQ.activo=1 AND DIS.participante=?";
    
    $params = [$idColaborador];
    
    if ($anio) {
        $sql .= " AND YEAR(LIQ.fecha) = ?";
        $params[] = $anio;
    }
    
    if ($mes) {
        $sql .= " AND MONTH(LIQ.fecha) = ?";
        $params[] = $mes;
    }

    if (!empty($estado)) { // <--- Nueva condición para el estado
        $sql .= " AND LIQ.estado = ?";
        $params[] = $estado;
    }
    
    $sql .= " ORDER BY LIQ.idliquidacion DESC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function registrarLiquidacion($datos) {
    global $pdo;
    
    try {
        $pdo->beginTransaction();
        
        // Insertar en tabla liquidacion
        $sql = "INSERT INTO liquidacion (fecha, asunto, tema, motivo, tipohora, acargode, lider, 
                cantidahoras, estado, idcontratocli, activo) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $datos['fecha'],
            $datos['asunto'],
            $datos['tema'],
            $datos['motivo'],
            $datos['tipohora'],
            $datos['acargode'],
            $datos['lider'],
            $datos['cantidahoras'],
            $datos['estado'],
            $datos['idcontratocli']
        ]);
        
        $idLiquidacion = $pdo->lastInsertId();
        
        // Si el estado es "Completo", insertar en distribucionhora
        if ($datos['estado'] == 'Completo' && !empty($datos['colaboradores'])) {
            foreach ($datos['colaboradores'] as $colaborador) {
                $sql = "INSERT INTO distribucionhora (participante, porcentaje, comentario, 
                        idliquidacion, fecha, horas, calculo) 
                        VALUES (?, ?, ?, ?, ?, ?, ?)";
                
                $stmt = $pdo->prepare($sql);
                $stmt->execute([
                    $colaborador['id'],
                    $colaborador['porcentaje'],
                    $colaborador['comentario'],
                    $idLiquidacion,
                    $datos['fecha'],
                    $datos['cantidahoras'],
                    $datos['cantidahoras']*($colaborador['porcentaje'] / 100)
                ]);
            }
        }
        
        $pdo->commit();
        return $idLiquidacion;
    } catch (Exception $e) {
        $pdo->rollBack();
        throw $e;
    }
}

function actualizarLiquidacion($idLiquidacion, $datos) {
    global $pdo;
    
    try {
        $pdo->beginTransaction();
        
        // Actualizar tabla liquidacion
        $sql = "UPDATE liquidacion SET 
                fecha = ?, asunto = ?, tema = ?, motivo = ?, tipohora = ?, 
                acargode = ?, lider = ?, cantidahoras = ?, estado = ?, idcontratocli = ?, 
                modificado = CURRENT_TIMESTAMP 
                WHERE idliquidacion = ?";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $datos['fecha'],
            $datos['asunto'],
            $datos['tema'],
            $datos['motivo'],
            $datos['tipohora'],
            $datos['acargode'],
            $datos['lider'],
            $datos['cantidahoras'],
            $datos['estado'],
            $datos['idcontratocli'],
            $idLiquidacion
        ]);
        
        // Eliminar distribuciones anteriores si el estado es "Completo"
        if ($datos['estado'] == 'Completo') {
            $sql = "DELETE FROM distribucionhora WHERE idliquidacion = ?";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$idLiquidacion]);
            
            // Insertar nuevas distribuciones
            if (!empty($datos['colaboradores'])) {
                foreach ($datos['colaboradores'] as $colaborador) {
                    $sql = "INSERT INTO distribucionhora (participante, porcentaje, comentario, 
                            idliquidacion, fecha, horas, calculo) 
                            VALUES (?, ?, ?, ?, ?, ?, ?)";
                    
                    $stmt = $pdo->prepare($sql);
                    $stmt->execute([
                        $colaborador['id'],
                        $colaborador['porcentaje'],
                        $colaborador['comentario'],
                        $idLiquidacion,
                        $datos['fecha'],
                        $datos['cantidahoras'],
                         $datos['cantidahoras']*($colaborador['porcentaje'] / 100)
                    ]);
                }
            }
        } else {
            // Si no es "Completo", eliminar cualquier distribución existente
            $sql = "DELETE FROM distribucionhora WHERE idliquidacion = ?";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$idLiquidacion]);
        }
        
        $pdo->commit();
        return true;
    } catch (Exception $e) {
        $pdo->rollBack();
        throw $e;
    }
}

function desactivarLiquidacion($idLiquidacion) {
    global $pdo;
    
    $sql = "UPDATE liquidacion SET activo = 0, modificado = CURRENT_TIMESTAMP WHERE idliquidacion = ?";
    $stmt = $pdo->prepare($sql);
    return $stmt->execute([$idLiquidacion]);
}

function obtenerLiquidacion($idLiquidacion) {
    global $pdo;
    
    $sql = "SELECT * FROM liquidacion WHERE idliquidacion = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$idLiquidacion]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function obtenerEstadisticasHoras($filtros = []) {
    global $pdo;
    
    $sql = "SELECT 
            SUM(CASE WHEN estado = 'Programado' THEN cantidahoras ELSE 0 END) AS programado,
            SUM(CASE WHEN estado = 'En revisión' THEN cantidahoras ELSE 0 END) AS en_revision,
            SUM(CASE WHEN estado = 'En proceso' THEN cantidahoras ELSE 0 END) AS en_proceso,
            SUM(CASE WHEN estado = 'Completo' THEN cantidahoras ELSE 0 END) AS completo,
            SUM(cantidahoras) AS total
            FROM liquidacion LIQ
            INNER JOIN contratocliente CON ON LIQ.idcontratocli=CON.idcontratocli
            INNER JOIN cliente CLI ON CLI.idcliente=CON.idcliente
            INNER JOIN empleado LID ON LIQ.lider=LID.idempleado
            WHERE LIQ.activo=1";
    
    $params = [];
    
    if (!empty($filtros['anio'])) {
        $sql .= " AND YEAR(LIQ.fecha) = ?";
        $params[] = $filtros['anio'];
    }
    
    if (!empty($filtros['mes'])) {
        $sql .= " AND MONTH(LIQ.fecha) = ?";
        $params[] = $filtros['mes'];
    }
    
    if (!empty($filtros['cliente'])) {
        $sql .= " AND CLI.idcliente = ?";
        $params[] = $filtros['cliente'];
    }
    
    if (!empty($filtros['lider'])) {
        $sql .= " AND LID.idempleado = ?";
        $params[] = $filtros['lider'];
    }
    
    if (!empty($filtros['estado'])) {
        $sql .= " AND LIQ.estado = ?";
        $params[] = $filtros['estado'];
    }
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
?>