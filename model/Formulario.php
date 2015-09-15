<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Formulario
 *
 * @author mpalomar
 */


//lIBRERIA PHP DE CONEXION A LA BASE DE DATOS
require_once(dirname(dirname(__FILE__)) . "/libs/conexionBD.php");
//LIBRERIA PARA VALIDACION DE PERMISOS


define('ADODB_FETCH_ASSOC', 2);



class Formulario {
    //put your code here
    
    
    function guardar($codigo,$descripcion){
        $res = null;
        $con = new conexionBD();
        $db = $con->getConexDB();
        
        $sql ="insert into formularioprueba(codigo,descripcion) values(null,'$descripcion')";
        
        //echo $sql;
        $rs = $db->Execute($sql);
        $id = $db->Insert_ID();


        if ($rs == false) {
            $res["success"] = true;
            $res["msg"] = "Error almacenando el registro " . $db->ErrorMsg();
            return $res;
        }
        $res["success"] = true;
        $res["msg"] = "Se guardo el registro correctamente";
        $res["newId"] = $id;
        return($res);
    }
    
    //TODO function consultar
    
    //TODO function eliminar
    
    //TODO function consultarporcodigo
}
