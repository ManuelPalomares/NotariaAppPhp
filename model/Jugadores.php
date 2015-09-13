<?php

//lIBRERIA PHP DE CONEXION A LA BASE DE DATOS
require_once(dirname(dirname(__FILE__)) . "/libs/conexionBD.php");
//LIBRERIA PARA VALIDACION DE PERMISOS
require_once(dirname(__FILE__) . "/permisos.php");

require_once(dirname(dirname(__FILE__)) . "/libs/utf8Array.php");
require_once(dirname(dirname(__FILE__)) . "/libs/fileUpload.php");

define('ADODB_FETCH_ASSOC', 2);

//librerias libs
require_once(dirname(dirname(__FILE__)) . "/libs/phpmailer/PHPMailerAutoload.php");
require_once(dirname(dirname(__FILE__)) . "/libs/doompdf/dompdf_config.inc.php");

class Jugadores {
    /* En todas las clases PHP de maestros vamos a dejar el siguiente codigo */

    public function __construct($usuario, $accion, $opcion) {
        $res = null;
        //permiso
        $permisos = new PermisosApp();

        $usuarioData = $permisos->usuarioExiste($usuario);

        //valido si existe el usuario
        if (!isset($usuarioData[0]["NOMBRE"])) {
            $res["success"] = true;
            $res["mensaje_error"] = "Usuario invalido o no existe";
            echo json_encode($res);
            exit();
        }

        $permiso = $permisos->validarPermisoSistema($usuario, $accion, $opcion);
        if ($permiso == false) {
            $res["success"] = true;
            $res["permiso"] = false;
            $res["mensaje_error"] = "No tiene permiso para ejecutar la opcion o acceso por favor comunicar con su administrador";
            echo json_encode($res);
            exit();
        }
    }

    public function guardarJugador($fecha_ingreso, $estado, $tipo_documento, $doc_identidad, $fecha_expedicion, $nombres, $apellidos, $fecha_nacimiento, $codigo_lugar_nacimiento, $tipo_sangre, $direccion, $barrio, $telefono, $celular, $email, $bb_pin, $colegio, $grado, $genero, $seguridad_social, $codigo_categoria, $codigo_suscriptor, $observaciones, $foto, $inscripcion, $mensualidad, $transporte, $exp_deportiva ="",$jornada_colegio ="",$referido ="",$responsable ="",$nombre_madre ="",$celular_madre ="",$email_madre ="",$ocupacion_madre ="",$empresa_madre ="",$nombre_padre ="",$celular_padre ="",$email_padre ="",$ocupacion_padre ="",$empresa_padre ="", $usuario_atencion="") {
        $res = null;
        $con = new conexionBD();
        $db = $con->getConexDB();
        $sql = "insert into jugadores(codigo,"
                . "fecha_ingreso,estado,tipo_documento,"
                . "doc_identidad,fecha_expedicion,nombres,"
                . "apellidos,fecha_nacimiento,codigo_lugar_nacimiento,"
                . "tipo_sangre,direccion,barrio,telefono,"
                . "celular,email,bb_pin,colegio,"
                . "grado,genero,seguridad_social,"
                . "codigo_categoria,codigo_suscriptor,"
                . "observaciones,foto,"
                ."usuario_atencion,"
                . "inscripcion,mensualidad,transporte,"
                . "exp_deportiva,jornada_colegio,referido, responsable,nombre_madre,"
                . "celular_madre,email_madre,ocupacion_madre,empresa_madre,nombre_padre,"
                . "celular_padre,email_padre,ocupacion_padre,empresa_padre) "
                . "values (null,SYSDATE(),'$estado','$tipo_documento',"
                . "'$doc_identidad','$fecha_expedicion','$nombres',"
                . "'$apellidos','$fecha_nacimiento','$codigo_lugar_nacimiento',"
                . "'$tipo_sangre','$direccion','$barrio','$telefono','$celular',"
                . "'$email','$bb_pin','$colegio','$grado','$genero','$seguridad_social',"
                . "'$codigo_categoria','$codigo_suscriptor','$observaciones',"
                . "'$foto',"
                . "'$usuario_atencion',"
                . "'$inscripcion','$mensualidad','$transporte',"
                . "'$exp_deportiva','$jornada_colegio','$referido','$responsable','$nombre_madre',"
                . "'$celular_madre','$email_madre','$ocupacion_madre','$empresa_madre','$nombre_padre',"
                . "'$celular_padre','$email_padre','$ocupacion_padre','$empresa_padre')";
        
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

    public function consultarJugadoresJson($start, $end, $categoria = 0, $queryNombre = "") {
        $result = null;
        $res = $this->consultarJugadores($start, $end, $categoria, $queryNombre);

        $result["jugadores"] = utf8Array::Utf8_string_array_encode($res["datos"]);
        $result["totalRows"] = $res["totalRows"];
        //print_r($result);

        echo json_encode($result);
    }

    public function consultarJugadores($start = 0, $end = 50, $categoria = 0, $queryNombre = "") {

        if ($categoria != "")
            $QueryCategoria = "and codigo_categoria=$categoria";

        if ($queryNombre != "")
            $queryNombre = "and CONCAT(nombres,' ',apellidos) like '%$queryNombre%'";

        $res = null;
        $con1 = new conexionBD();
        $db = $con1->getConexDB();
        $totalRows = null;
        $datos = null;
        $sql1 = "SELECT count(1) cantidad FROM jugadores j where 1=1 $QueryCategoria $queryNombre";

        $db->SetFetchMode(ADODB_FETCH_ASSOC);


        $rs = $db->Execute($sql1);
        $res = $rs->getrows();
        $totalRows = $res[0]["cantidad"];

        $sql2 = "SELECT codigo,"
                . "DATE_FORMAT(fecha_ingreso,'%Y-%m-%d') fecha_ingreso,"
                . "estado,tipo_documento,"
                . "doc_identidad,"
                . "DATE_FORMAT(fecha_expedicion,'%Y-%m-%d') fecha_expedicion,"
                . "nombres,"
                . "apellidos,"
                . "DATE_FORMAT(j.fecha_nacimiento,'%Y-%m-%d') fecha_nacimiento,"
                . "codigo_lugar_nacimiento,"
                . "tipo_sangre,"
                . "direccion,"
                . "barrio,"
                . "telefono,"
                . "celular,"
                . "email,"
                . "bb_pin,"
                . "colegio,"
                . "grado,"
                . "genero"
                . ",seguridad_social,"
                . "codigo_categoria,"
                . "codigo_suscriptor,"
                . " observaciones,"
                . "foto,"
                . "CONCAT(j.nombres,' ',j.apellidos) nombre_completo, "
                . "inscripcion,"
                . "mensualidad,"
                . "transporte,"
                . "exp_deportiva,"
                . "jornada_colegio,"
                . "referido,"
                . "responsable,"
                . "nombre_madre,"
                . "celular_madre,"
                . "email_madre,"
                . "ocupacion_madre,"
                . "empresa_madre,"
                . "nombre_padre,"
                . "celular_padre,"
                . "email_padre,"
                . "ocupacion_padre,"
                . "empresa_padre"
                . " FROM jugadores j where 1=1 $QueryCategoria $queryNombre LIMIT $start,$end;";
        //echo $sql2;
        $db->SetFetchMode(ADODB_FETCH_ASSOC);

        $rs = $db->Execute($sql2);
        $res = $rs->getrows();
        $datos = $res;
        return array("datos" => $datos, "totalRows" => $totalRows);
    }
    
    
    public function consultarTodosJugadoresxCategoria($categoria){
        $con1 = new conexionBD();
        $db = $con1->getConexDB();
        $sql1  = "select * from jugadores where codigo_categoria =$categoria;";
        $rs = $db->Execute($sql1);
        
        if ($rs == false) {
            $res["success"] = true;
            $res["msg"] = "Error almacenando el registro " . $db->ErrorMsg();
            $res["error"] = true;
            return $res;
        }
        $res = $rs->getrows();
        
        return $res; 
    }

    public function actualizarJugador($codigo, $fecha_ingreso, $estado, $tipo_documento, $doc_identidad, $fecha_expedicion, $nombres, $apellidos, $fecha_nacimiento, $codigo_lugar_nacimiento, $tipo_sangre, $direccion, $barrio, $telefono, $celular, $email, $bb_pin, $colegio, $grado, $genero, $seguridad_social, $codigo_categoria, $codigo_suscriptor, $observaciones, $foto, $inscripcion, $mensualidad, $transporte, $exp_deportiva ="",$jornada_colegio ="",$referido ="",$responsable ="",$nombre_madre ="",$celular_madre ="",$email_madre ="",$ocupacion_madre ="",$empresa_madre ="", $nombre_padre ="",$celular_padre ="",$email_padre ="",$ocupacion_padre ="",$empresa_padre ="", $usuario_atencion = "") {
        $res = null;
        $con = new conexionBD();
        $db = $con->getConexDB();
        $sql = "UPDATE jugadores "
                . "set estado='$estado', "
                . "tipo_documento='$tipo_documento', "
                . "doc_identidad='$doc_identidad',"
                . "fecha_expedicion='$fecha_expedicion', "
                . "fecha_nacimiento='$fecha_nacimiento',"
                . "nombres='$nombres', "
                . "apellidos='$apellidos', "
                . "codigo_lugar_nacimiento='$codigo_lugar_nacimiento', "
                . "tipo_sangre='$tipo_sangre', "
                . "direccion='$direccion', "
                . "barrio='$barrio', "
                . "telefono='$telefono', "
                . "celular='$celular', "
                . "email='$email', "
                . "bb_pin='$bb_pin', "
                . "colegio='$colegio', "
                . "grado='$grado', "
                . "genero='$genero', "
                . "seguridad_social='$seguridad_social', "
                . "codigo_categoria=$codigo_categoria, "
                . "codigo_suscriptor='$codigo_suscriptor',"
                . "observaciones='$observaciones',"
                . "foto='$foto',"
                . "usuario_atencion='$usuario_atencion',"
                . "inscripcion='$inscripcion',"
                . "mensualidad='$mensualidad',"
                . "transporte='$transporte',"
                . "exp_deportiva='$exp_deportiva',"
                . "jornada_colegio='$jornada_colegio',"
                . "referido='$referido',"
                . "responsable='$responsable',"
                . "nombre_madre='$nombre_madre',"
                . "celular_madre='$celular_madre',"
                . "email_madre='$email_madre',"
                . "ocupacion_madre='$ocupacion_madre',"
                . "empresa_madre='$empresa_madre',"
                . "nombre_padre='$nombre_padre',"
                . "celular_padre='$celular_padre',"
                . "email_padre='$email_padre',"
                . "ocupacion_padre='$ocupacion_padre',"
                . "empresa_padre='$empresa_padre'"
                . " where codigo = '$codigo'";
        //echo $sql;
        $rs = $db->Execute($sql);

        if ($rs == false) {
            $res["success"] = true;
            $res["msg"] = "Error actualizando el registro " . $db->ErrorMsg();
            $res["newId"] = $codigo;
            $res["error"] = true;
            return $res;
        }
        $res["success"] = true;
        $res["msg"] = "Se actualizo el registro correctamente";
        $res["newId"] = $codigo;
        return($res);
    }

    public function cargarFoto($foto) {
        $resFile = null;
        $res = "";
        $fileUp = new fileUpload();
        $n = rand(1, 100000);
        $nameLoaded = "foto_" + $n;
        $resFile = $fileUp->cargarArchivo($foto, "fotosjugadores", $nameLoaded);

        if ($resFile == false) {
            $res["success"] = true;
            $res["permiso"] = false;
            $res["mensaje_error"] = "Error cargando el archivo de imagen vuelva intentar de nuevo";
            echo json_encode($res);
            exit();
        }

        $res["success"] = true;
        $res["foto"] = $resFile;
        $res["msg"] = "Foto cargada con exito";
        echo json_encode($res);
    }

    
    public function generarPlantillaJugador($codJugador){
        $datosJugador = $this->consultarJugador($codJugador);
        $html_informacion ="";
        
        $html_informacion = file_get_contents("../../plantillas/plantilla_jugadores.html");
        $html_informacion = str_replace("{nombres}", $datosJugador['nombres'], $html_informacion);
        $html_informacion = str_replace("{tipo_documento}", $datosJugador['tipo_documento'], $html_informacion);
        $html_informacion = str_replace("{doc_identidad}",$datosJugador['doc_identidad'], $html_informacion);
        $html_informacion = str_replace("{fecha_expedicion}",$datosJugador['fecha_expedicion'], $html_informacion);
        $html_informacion = str_replace("{fecha_nacimiento}",$datosJugador['fecha_nacimiento'], $html_informacion);
        $html_informacion = str_replace("{lugar_nacimiento}",$datosJugador['lugar_nacimiento'], $html_informacion);
        $html_informacion = str_replace("{tipo_sangre}",$datosJugador['tipo_sangre'], $html_informacion);
        $html_informacion = str_replace("{direccion}",$datosJugador['direccion'], $html_informacion);        
        $html_informacion = str_replace("{barrio}",$datosJugador['barrio'], $html_informacion);
        $html_informacion = str_replace("{genero}",$datosJugador['genero'], $html_informacion);
        $html_informacion = str_replace("{telefono}",$datosJugador['telefono'], $html_informacion);
        $html_informacion = str_replace("{celular}",$datosJugador['celular'], $html_informacion);
        $html_informacion = str_replace("{BB_PIN}",$datosJugador['BB_PIN'], $html_informacion);
        $html_informacion = str_replace("{seguridad_social}",$datosJugador['seguridad_social'], $html_informacion);
        $html_informacion = str_replace("{colegio}",$datosJugador['colegio'], $html_informacion);
        $html_informacion = str_replace("{grado}",$datosJugador['grado'], $html_informacion);
        $html_informacion = str_replace("{jornada_colegio}",$datosJugador['jornada_colegio'], $html_informacion);
        $html_informacion = str_replace("{email}",$datosJugador['email'], $html_informacion);
        $html_informacion = str_replace("{nombre_madre}",$datosJugador['nombre_madre'], $html_informacion);
        $html_informacion = str_replace("{celular_madre}",$datosJugador['celular_madre'], $html_informacion);
        $html_informacion = str_replace("{email_madre}",$datosJugador['email_madre'], $html_informacion);
        $html_informacion = str_replace("{ocupacion_madre}",$datosJugador['ocupacion_madre'], $html_informacion);
        $html_informacion = str_replace("{empresa_madre}",$datosJugador['empresa_madre'], $html_informacion);
        $html_informacion = str_replace("{nombre_padre}",$datosJugador['nombre_padre'], $html_informacion);
        $html_informacion = str_replace("{celular_padre}",$datosJugador['celular_padre'], $html_informacion);
        $html_informacion = str_replace("{email_padre}",$datosJugador['email_padre'], $html_informacion);
        $html_informacion = str_replace("{ocupacion_padre}",$datosJugador['ocupacion_padre'], $html_informacion);
        $html_informacion = str_replace("{empresa_padre}",$datosJugador['empresa_padre'], $html_informacion);
        $html_informacion = str_replace("{foto}",$datosJugador['foto'], $html_informacion);
        $html_informacion = str_replace("{fecha_ingreso}",$datosJugador['fecha_ingreso'], $html_informacion);
        
        return $html_informacion;
      
        
    }    
    
    public function enviarMailEvaluacion($codJugador,$json=false){
        $htmlEvaluacion = $this->generarPlantillaJugador($codJugador);
        $datosJugador = $this->consultarJugador($codJugador);
        $email =  $datosJugador['email'];
        
        date_default_timezone_set('Etc/UTC');
        //Create a new PHPMailer instance
        $mail = new PHPMailer;

//Tell PHPMailer to use SMTP
        $mail->isSMTP();

//Enable SMTP debugging
// 0 = off (for production use)
// 1 = client messages
// 2 = client and server messages
        $mail->SMTPDebug = 0;

//Ask for HTML-friendly debug output
        $mail->Debugoutput = 'html';

//Set the hostname of the mail server
        $mail->Host = 'smtp.gmail.com';

//Set the SMTP port number - 587 for authenticated TLS, a.k.a. RFC4409 SMTP submission
        $mail->Port = 465;

//Set the encryption system to use - ssl (deprecated) or tls
        $mail->SMTPSecure = 'ssl';

//Whether to use SMTP authentication
        $mail->SMTPAuth = true;

//Username to use for SMTP authentication - use full email address for gmail
        $mail->Username = "diegochampionsfc@gmail.com";

//Password to use for SMTP authentication
        $mail->Password = "Ch4mpi0nsfc_2014";

//Set who the message is to be sent from
        $mail->setFrom('diegochampionsfc@gmail.com', 'Escuela de Futbol Champions');

//Set an alternative reply-to address
        //$mail->addReplyTo('aymer.com', 'First Last');
//Set who the message is to be sent to
        $mail->addAddress($email, 'Jugador');
        //$mail->addAddress('manuel936@gmail.com', 'Manuel');
//Set the subject line
        $mail->Subject = "Escuela de futbol champions [Evaluacion deportiva inicial]";

//Read an HTML message body from an external file, convert referenced images to embedded,
//convert HTML into a basic plain-text alternative body
        $mail->msgHTML($htmlEvaluacion, dirname(__FILE__));

//Replace the plain text body with one created manually
        $mail->AltBody = 'This is a plain-text message body';

//Attach an image file
        //$mail->addAttachment('images/phpmailer_mini.png');
//send the message, check for errors

        $res["success"] = true;
        if (!$mail->send()) {
            $res["mensaje_error"] = "Error enviando el mail del evento : Mailer Error: " . $mail->ErrorInfo;
            $res["error"] = true;
        } else {
            $res["msg"] = "Correo enviado con exito";
        }

        if ($json == true) {
            echo json_encode($res);
            exit();
        }
        return $res;
    }
    
    public function generarPdfFichaJugador($codJugador){
        
        define("DOMPDF_ENABLE_REMOTE",true);
        $htmlPlantilla = $this->generarPlantillaJugador($codJugador);
        $dompdf = new DOMPDF();
        
        $dompdf->load_html($htmlPlantilla);
        $dompdf->set_paper('ra3');
        
        
        $dompdf->render();
        $dompdf->stream("Ficha_jugador.pdf", array("Attachment" => true));
        return array("success"=>true);
    }

    
    public function consultarJugador($codJugador) {

        $res = null;
        $con = new conexionBD();
        $db = $con->getConexDB();
        $sql = "select concat(b.nombres,' ', b.apellidos) nombres, "
               . " b.tipo_documento, "
               . " b.doc_identidad, "
               . " b.fecha_expedicion, "
               . " b.fecha_nacimiento, "
               . " (select concat(c.descripcion,'(', c.departamento,')')  "
               . "  from ciudades c where c.codigo = b.codigo_lugar_nacimiento) lugar_nacimiento, "
               . " b.tipo_sangre, "
               . " b.direccion, "
               . " b.barrio, "
               . " b.genero, "
               . " b.telefono, "
               . " b.celular, "
               . " concat(b.BB_PIN,' ') BB_PIN, "
               . " b.seguridad_social, "
               . " b.colegio, "
               . " b.grado, "
               . " b.jornada_colegio, "
               . " b.email, "
               . " concat(b.nombre_madre,' ') nombre_madre, "
               . " concat(b.celular_madre,' ') celular_madre, "
               . " concat(b.email_madre,' ') email_madre, "
               . " concat(b.ocupacion_madre,' ') ocupacion_madre, "
               . " concat(b.empresa_madre,' ') empresa_madre, "
               . " concat(b.nombre_padre,' ') nombre_padre, "
               . " concat(b.celular_padre,' ') celular_padre, "
               . " concat(b.email_padre,' ') email_padre, "
               . " concat(b.ocupacion_padre,' ') ocupacion_padre, "
               . " concat(b.empresa_padre,' ') empresa_padre,"
               . " b.foto,"
               . " b.fecha_ingreso "
               . " from jugadores b "
               . "where  b.codigo =$codJugador";
        //echo $sql;
        $db->SetFetchMode(ADODB_FETCH_ASSOC);
        $rs = $db->Execute($sql);
        $res = $rs->getrows();
        return $res[0];
    }

    
    public function consultarJugadorJson($codJugador) {
        $datos = $this->consultarJugador($codJugador);
        $res["success"] = true;
        $res["datos"] = $datos;
        echo json_encode($res, JSON_HEX_QUOT | JSON_HEX_TAG);
    }
  
    
}

?>