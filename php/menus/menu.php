<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: X-Requested-With');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

require_once("../include/index.php"); 
require_once ("../../model/menu.php");
require_once ("../../model/session.php");


$session = new SessionApp();
$usuario = $session->isRegisterUserJson(false);

$datos = $_REQUEST;
$accion = $datos["accion"];
$node = $datos["node"];
$menu = new MenuApp();
if($accion === "CONSULTARMODULOS"){
    
    if($node == "root"){
        $menu->menuModulosJson($usuario);
    }
    else{
         $menu->menuSubMenusJson($usuario, $node);
    }
    
    
       
    
    
}

?>

