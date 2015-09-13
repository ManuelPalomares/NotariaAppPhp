<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: X-Requested-With');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

require_once("../include/index.php");
require_once ("../../model/session.php");
require_once ("../../model/SeguimientoJugadores.php");



/* Controla el acceso a usuarios externos no logueados */
$session = new SessionApp();
$usuario = $session->isRegisterUserJson(false);
$opcion_actual = $session->getOpcionActual();

$datos = $_REQUEST;

$accion = $datos["accion"];
$save = $datos["save"];
$fechaAsist = $datos["fecha_seguimiento"];
$entrenador = $datos["codigo_entrenador"];
$categoria = $datos["codigo_categoria"];
$start = $datos["start"];
$end = $datos["limit"];
$codasist = $datos["codasist"];
$comentario= $datos["observacionNoasist"];


if($accion=="EnviarNoAsistencia"){
    $seguimientoJugadores = new SeguimientoJugadores($usuario, $accion, $opcion_actual,false);
}else
{
    $seguimientoJugadores = new SeguimientoJugadores($usuario, $accion, $opcion_actual);
}

$res = null;

if($accion == "GUARDARSEGUIMIENTOJUGADORES"){   
    $rawpostdata = file_get_contents("php://input");
    $rawpostdata = json_decode($rawpostdata);
    

    
    if(sizeof($rawpostdata)==1){
            //echo sizeof($rawpostdata)."cantidad 1 ".$rawpostdata->fecha_seguimiento;
          if(!isset($rawpostdata->codigo_seguimiento)){
           
            $res = $seguimientoJugadores->guardarSeguimiento($rawpostdata->codigo_seguimiento, $rawpostdata->fecha_seguimiento, $rawpostdata->codigo_jugador, $rawpostdata->codigo_entrenador, $rawpostdata->codigo_categoria, $rawpostdata->codigo_novedad);
           
            if($rawpostdata->codigo_novedad !=1){
                //enviar mail
                $codSeg= $res["newId"];
                $seguimientoJugadores->enviarMailNoAsistencia($codSeg);
            }
            if (isset($res["error"])) {
                echo json_encode($res);
                exit();
            }
        }
        else{
            $res = $seguimientoJugadores->actualizarSeguimiento($rawpostdata->codigo_seguimiento, $rawpostdata->fecha_seguimiento, $rawpostdata->codigo_jugador, $rawpostdata->codigo_entrenador, $rawpostdata->codigo_categoria, $rawpostdata->codigo_novedad);            
            if($rawpostdata->codigo_novedad !=1){
                $seguimientoJugadores->enviarMailNoAsistencia($rawpostdata->codigo_seguimiento);
            } 
            
            if (isset($res["error"])) {
                echo json_encode($res);
                exit();
            }
        }
    }
            
    foreach ($rawpostdata as $seguimientos => $seguimiento) {
        $res = null;
    
        if(!isset($seguimiento->codigo_seguimiento)){
           
            $res = $seguimientoJugadores->guardarSeguimiento($seguimiento->codigo_seguimiento, $seguimiento->fecha_seguimiento, $seguimiento->codigo_jugador, $seguimiento->codigo_entrenador, $seguimiento->codigo_categoria, $seguimiento->codigo_novedad);
           
            if($seguimiento->codigo_novedad !=1){
                //enviar mail
                $codSeg= $res["newId"];
                $seguimientoJugadores->enviarMailNoAsistencia($codSeg);
            }
            if (isset($res["error"])) {
                echo json_encode($res);
                exit();
            }
        }
        else{
            $res = $seguimientoJugadores->actualizarSeguimiento($seguimiento->codigo_seguimiento, $seguimiento->fecha_seguimiento, $seguimiento->codigo_jugador, $seguimiento->codigo_entrenador, $seguimiento->codigo_categoria, $seguimiento->codigo_novedad);            
            if($seguimiento->codigo_novedad !=1){
                $seguimientoJugadores->enviarMailNoAsistencia($seguimiento->codigo_seguimiento);
            } 
            
            if (isset($res["error"])) {
                echo json_encode($res);
                exit();
            }
        }
    }
}

if ($accion == "CONSULTARJUGADORESSEGUIMIENTO") {
       $seguimientoJugadores->consultarJugadoresSegJson($start,$end,$fechaAsist,$entrenador,$categoria);
}


if($accion == "CONSULTARFECHASSEG"){
    $seguimientoJugadores->consultarSeguimientosxFechasJson($start,$end);
}


if($accion=="EnviarNoAsistencia"){
    $res = $seguimientoJugadores->actualizaNotaSeg($codasist, $comentario);
    echo json_encode($res);
    exit();
    
}

