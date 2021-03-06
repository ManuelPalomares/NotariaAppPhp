<?php


header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: X-Requested-With');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

require_once("../include/index.php"); 
require_once ("../../model/Formulario.php");



define('ADODB_FETCH_ASSOC', 2);

$conexion = new conexionBD();
$db = $conexion->getConexDB();


$datos = $_REQUEST;


$accion = $datos["accion"];

 if($accion == "GUARDAR"){
     
     $formulario = new Formulario();
     $res = $formulario->guardar($datos["codigo"],$datos["descripcion"],$datos["fecha"],$datos["valor"]);
 
     echo json_encode($res);
     
 }
 
  if($accion == "CONSULTAR"){
     
     $formulario = new Formulario();
     $res = $formulario->consultar();
 
     echo json_encode($res);
     
 }
 
  if($accion == "ACTUALIZAR"){
     
     $formulario = new Formulario();
     $res = $formulario->modificar($datos["codigo"],$datos["descripcion"],$datos["fecha"],$datos["valor"]);
 
     echo json_encode($res);
     
 }
