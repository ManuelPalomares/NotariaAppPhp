<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: X-Requested-With');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

require_once("../include/index.php"); 
require_once ("../../model/session.php");
require_once ("../../model/Cobros.php");

/* Controla el acceso a usuarios externos no logueados */
$session = new SessionApp();
$usuario = $session->isRegisterUserJson(false);
$opcion_actual = $session->getOpcionActual();
$datos = $_REQUEST;

$accion= $datos["accion"];
$codigo = $datos["codigo"];
$codigo_jugador = $datos["codigoJugador"];
$codigo_concepto = $datos["codigo_concepto"];
$valor = $datos["valor"];
$fecha_generacion = $datos["fecha_generacion"];
$fecha_vigencia = $datos["fecha_vigencia"];
$usuario_creacion = $usuario;
$estado = $datos["estado"];
$codigo_jugadorStore = $datos["codigo_jugador"];
$email = $datos["email"];
/*TODO Operaciones con las variables POST O GET*/
//crear clase Roles
$cobros = new Cobros($usuario, $accion, $opcion_actual);

if($accion=="CONSULTARCOBROS"){
    $cobros->consultarCobrosJson($codigo_jugadorStore);
}

if($accion == "CREARCOBRO"){
    $rs = $cobros->crearCobro($codigo_jugador, $codigo_concepto, $valor, $fecha_generacion,
                              $fecha_vigencia, $usuario_creacion);
    
    echo json_encode($rs);
    exit();
}

if($accion =="ACTUALIZARCOBRO"){
    $rs = $cobros->actualizarCobro($codigo, $codigo_jugador, $codigo_concepto, $valor, $fecha_generacion,$fecha_vigencia,$usuario_creacion, $estado);
    echo json_encode($rs);
    exit(); 
}

if($accion =="PAGARCOBRO"){
    $rs = $cobros->pagarCobro($codigo, $codigo_jugador, $codigo_concepto, $valor, $fecha_generacion,$fecha_vigencia,$usuario_creacion, $estado, $email);
   /* $rs = $cobros->actualizarCobro($codigo, $codigo_jugador, $codigo_concepto, $valor, $fecha_generacion,
                                   $fecha_vigencia, $usuario_creacion, 'PAGADO');*/
    $rs1 = $cobros-> enviarMailReciboPago($codigo, $codigo_jugador, $usuario_creacion, $email, true);
    echo json_encode($rs);
    exit(); 
}

if($accion=='GENERARPDFRECIBOPAGO'){
    $res = $cobros->generarPdfReciboPago($codigo, $codigo_jugador, $usuario);
    echo json_encode($res);
    exit();
}


?>
