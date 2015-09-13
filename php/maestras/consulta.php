<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: X-Requested-With');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

require_once("../include/index.php");



//lIBRERIA PHP DE CONEXION A LA BASE DE DATOS
require_once("../../libs/conexionBD.php");


$res = null;
$con1 = new conexionBD();
$db = $con1->getConexDB();
$sql = "SELECT codigo,CONCAT(descripcion,' (',departamento,')') descripcion FROM ciudades ORDER BY DESCRIPCION ASC;";
$db->SetFetchMode(ADODB_FETCH_ASSOC);

$rs = $db->Execute($sql);
$res = $rs->getrows();
echo json_encode($res);
?>