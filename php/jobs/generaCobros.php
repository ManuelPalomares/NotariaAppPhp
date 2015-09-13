<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: X-Requested-With');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

require_once("../include/index.php"); 
require_once ("../../model/GeneradorCobros.php");

$generadorCobros = new GeneradorCobros(); 
$generadorCobros->calcularCobroJob();

