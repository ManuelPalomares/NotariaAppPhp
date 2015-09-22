<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Formulario
 *
 * @author Guillermo Vanegas
 */


//lIBRERIA PHP DE CONEXION A LA BASE DE DATOS
require_once(dirname(dirname(__FILE__)) . "/libs/conexionBD.php");
//LIBRERIA PARA VALIDACION DE PERMISOS


define('ADODB_FETCH_ASSOC', 2);



class Formulario {
    //put your code here
    
    
    function guardar($codigo,$descripcion,$fecha,$valor){
        $res = null;
        $con = new conexionBD();
        $db = $con->getConexDB();
        
        $sql ="insert into formularioprueba(codigo,descripcion,fecha,valor) values(null,'$descripcion','$fecha',$valor)";
        
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
    
    function consultar(){
    
        $con = new conexionBD();
        $db = $con->getConexDB();
        
        $sql ="SELECT codigo, descripcion, fecha, valor FROM formularioprueba";
        
        //echo $sql;
        $rs = $db->Execute($sql);
        $res = $rs->getrows();
        $datos = $res;
        return array("datos" => $datos, "totalRows" => sizeof($datos));
    }
        function modificar($codigo,$descripcion,$fecha,$valor){
        $res = null;
        $con = new conexionBD();
        $db = $con->getConexDB();
        
        $sql ="UPDATE formularioprueba SET 
                descripcion='$descripcion', fecha ='$fecha', valor =$valor 
                WHERE 
                codigo = $codigo";
        
        //echo $sql;
        $rs = $db->Execute($sql);
        $id = $db->Insert_ID();


        if ($rs == false) {
            $res["success"] = true;
            $res["msg"] = "Error almacenando el registro " . $db->ErrorMsg();
            return $res;
        }
        $res["success"] = true;
        $res["msg"] = "Se modifico el registro correctamente";
        $res["newId"] = $id;
        return($res);
    }
    //TODO function consultar
    
    //TODO function eliminar
    
    //TODO function consultarporcodigo
}
