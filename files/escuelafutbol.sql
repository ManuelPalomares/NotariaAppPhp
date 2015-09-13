-- phpMyAdmin SQL Dump
-- version 2.8.0.1
-- http://www.phpmyadmin.net
-- 
-- Servidor: custsql-ipg10.eigbox.net
-- Tiempo de generación: 07-09-2015 a las 21:42:06
-- Versión del servidor: 5.5.44
-- Versión de PHP: 4.4.9
-- 
-- Base de datos: `escuelafutbol`
-- 

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `acciones_rol`
-- 

CREATE TABLE IF NOT EXISTS `acciones_rol` (
  `codigo_accion` int(15) NOT NULL,
  `codigo_opcion` bigint(20) NOT NULL,
  `codigo_rol` bigint(20) NOT NULL,
  KEY `codigo_opcion` (`codigo_opcion`),
  KEY `codigo_accion` (`codigo_accion`),
  KEY `codigo_rol` (`codigo_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `agendados_eventos`
-- 

CREATE TABLE IF NOT EXISTS `agendados_eventos` (
  `evento` int(15) NOT NULL,
  `jugador` int(15) DEFAULT NULL,
  `suscriptor` int(15) DEFAULT NULL,
  KEY `jugador` (`jugador`),
  KEY `evento` (`evento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `aspectos_evaluacion`
-- 

CREATE TABLE IF NOT EXISTS `aspectos_evaluacion` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id del detalle de los avisos de evaluacion',
  `descripcion_detalle` varchar(500) NOT NULL COMMENT 'descripcion del detalle del aviso',
  `codigo_aviso` int(11) DEFAULT NULL,
  `codigo_padre` int(11) DEFAULT NULL,
  `tipo` varchar(2) NOT NULL COMMENT 'A (ASPECTO)  D (DETALLE) P (PREGUNTA)\r\nS (SI/NO)',
  `estado` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `detalle_aspectos_fk` (`codigo_aviso`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `categorias`
-- 

CREATE TABLE IF NOT EXISTS `categorias` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de la categoria',
  `descripcion` varchar(100) NOT NULL COMMENT 'descripcion de la categoria',
  `codigo_padre` int(11) DEFAULT NULL COMMENT 'codigo del padre (gorrion, infantil etc)',
  `estado` varchar(1) DEFAULT NULL COMMENT 'estado de la categoria (A: activa, I: inactiva)',
  `anno_categoria` int(4) DEFAULT NULL COMMENT 'define el año de la categoria',
  `codigo_entrenador` int(11) DEFAULT NULL COMMENT 'codigo del entrenador',
  PRIMARY KEY (`codigo`),
  KEY `categorias_entren_fk` (`codigo_entrenador`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ciudades`
-- 

CREATE TABLE IF NOT EXISTS `ciudades` (
  `codigo` varchar(20) NOT NULL COMMENT 'codigo de la ciudad',
  `descripcion` varchar(100) NOT NULL COMMENT 'descripcion de la ciudad',
  `DEPARTAMENTO` varchar(50) DEFAULT NULL COMMENT 'Nombre del departamento al que pertenece la ciudad',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `cobros`
-- 

CREATE TABLE IF NOT EXISTS `cobros` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id del cobro',
  `fecha_generacion` date DEFAULT NULL COMMENT 'fecha generacion del cobro, se genera 5 dias antes de la fecha de cobro',
  `fecha_cobro` date DEFAULT NULL COMMENT 'fecha en la que se debe pagar el cobro según la fecha de ingreso del jugador',
  `fecha_fin_cobro` date DEFAULT NULL COMMENT 'Es la fecha hasta donde cubre el pago de la mensualidad por parte del jugador',
  `fecha_vigencia` date DEFAULT NULL COMMENT 'fecha maxima para realizar el pago, 5 dias despues de la fecha de cobro',
  `fecha_pago` date DEFAULT NULL COMMENT 'Fecha en la que se realiza el pago por parte del jugador',
  `valor` double(15,3) DEFAULT NULL COMMENT 'valor a pagar o pagado',
  `codigo_concepto` int(11) DEFAULT NULL COMMENT 'codigo del concepto del pago',
  `codigo_jugador` int(11) DEFAULT NULL COMMENT 'codigo del jugador',
  `usuario_creacion` varchar(100) DEFAULT NULL COMMENT 'usuario que ingresó el cobro',
  `estado` varchar(20) DEFAULT NULL COMMENT 'indica el estado del cobro (cancelado, anulado, pendiente por pagar, etc) (C,A,P)',
  PRIMARY KEY (`codigo`),
  KEY `codigo_concepto` (`codigo_concepto`),
  KEY `codigo_jugador` (`codigo_jugador`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1 AUTO_INCREMENT=81 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `conceptos_cobros`
-- 

CREATE TABLE IF NOT EXISTS `conceptos_cobros` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del concepto',
  `descripcion` varchar(100) DEFAULT NULL COMMENT 'descripcion del concepto',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `conceptos_pagos`
-- 

CREATE TABLE IF NOT EXISTS `conceptos_pagos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del concepto del pago',
  `descripcion` varchar(100) DEFAULT NULL COMMENT 'descripcion de los conceptos de pago',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `detalle_evaluacion`
-- 

CREATE TABLE IF NOT EXISTS `detalle_evaluacion` (
  `codigo_respuesta` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_evaluacion` int(11) NOT NULL COMMENT 'codigo de la evaluacion',
  `codigo_detalle_aspecto` int(11) NOT NULL COMMENT 'codigo del detalle del aspecto',
  `calificacion` varchar(3) DEFAULT NULL COMMENT 'calificacion del detalle de cada aspecto (SI, CD: Con dificultad, NA: No aplica)',
  `respuesta_si_no` varchar(2) DEFAULT NULL COMMENT 'para las preguntas del cuestionario, que tienen respuesta SI/NO',
  `respuesta_texto` varchar(1000) DEFAULT NULL COMMENT 'respuesta adicional para el SI/NO',
  PRIMARY KEY (`codigo_respuesta`),
  KEY `det_eva_cod_eva_fk` (`codigo_evaluacion`),
  KEY `det_eva_det_asp_fk` (`codigo_detalle_aspecto`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=latin1 AUTO_INCREMENT=116 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `entrenadores`
-- 

CREATE TABLE IF NOT EXISTS `entrenadores` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id del entrenador',
  `documento_identidad` varchar(50) NOT NULL COMMENT 'documento de identidad del entrenador',
  `tipo_documento` varchar(2) NOT NULL COMMENT 'tipo documento de indentidad (TI: TARJETA DE IDENTIDAD, CC: CEDULA CIUDADANIA, TE: TARJETA DE EXTRANJERIA)',
  `nombres` varchar(100) NOT NULL COMMENT 'nombres del entrenador',
  `apellidos` varchar(100) NOT NULL COMMENT 'apellidos del entrenador',
  `telefono` varchar(50) DEFAULT NULL COMMENT 'telefono fijo del domicilio',
  `celular` varchar(50) DEFAULT NULL COMMENT 'número del celular',
  `direccion` varchar(200) DEFAULT NULL COMMENT 'direccion residencia',
  `barrio` varchar(100) DEFAULT NULL COMMENT 'barrio del domicilio',
  `fecha_nacimiento` date NOT NULL COMMENT 'fecha de nacimiento',
  `estado` varchar(1) DEFAULT NULL COMMENT 'estado del entrenador, indica si está activo o no (A: activo, I: inactivo)',
  `genero` varchar(1) DEFAULT NULL COMMENT 'sexo del entrenador',
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `documento_identidad` (`documento_identidad`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `entrenadores_categoria`
-- 

CREATE TABLE IF NOT EXISTS `entrenadores_categoria` (
  `codigo_entrenador` int(11) NOT NULL,
  `codigo_categoria` int(11) NOT NULL,
  KEY `codigo_entrenador` (`codigo_entrenador`),
  KEY `codigo_categoria` (`codigo_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `evaluacion`
-- 

CREATE TABLE IF NOT EXISTS `evaluacion` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id de la evaluacion a los jugadores',
  `codigo_jugador` int(11) NOT NULL COMMENT 'codigo del jugador',
  `codigo_entrenador` int(11) NOT NULL COMMENT 'codigo del entrenador',
  `resultado` varchar(50) DEFAULT NULL COMMENT 'resultado de la evaluacion',
  `fecha_evaluacion` date DEFAULT NULL,
  `observaciones` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `evaluacion_jugador_fk` (`codigo_jugador`),
  KEY `evaluacion_entrenador_fk` (`codigo_entrenador`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `eventos_deportivos`
-- 

CREATE TABLE IF NOT EXISTS `eventos_deportivos` (
  `codigo` int(15) NOT NULL AUTO_INCREMENT COMMENT 'codigo_del_evento',
  `titulo_evento` varchar(200) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `descripcion_evento` text COMMENT 'Descripcion de texto html',
  `estado_evento` varchar(2) DEFAULT NULL COMMENT 'Estado del evento',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1 AUTO_INCREMENT=60 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `horarios`
-- 

CREATE TABLE IF NOT EXISTS `horarios` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del horario',
  `dia` varchar(20) NOT NULL COMMENT 'dia del horario',
  `hora_inicio` time DEFAULT NULL COMMENT 'hora de inicio',
  `hora_fin` time DEFAULT NULL COMMENT 'hora finalizacion',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `horarios_categoria`
-- 

CREATE TABLE IF NOT EXISTS `horarios_categoria` (
  `codigo_horario` int(11) DEFAULT NULL COMMENT 'codigo del horario',
  `codigo_categoria` int(11) DEFAULT NULL COMMENT 'codigo de la categoria',
  KEY `hor_cat_horario_fk` (`codigo_horario`),
  KEY `hor_cat_categoria_fk` (`codigo_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `jugadores`
-- 

CREATE TABLE IF NOT EXISTS `jugadores` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id del jugador',
  `doc_identidad` varchar(50) DEFAULT NULL COMMENT 'documento de identidad',
  `tipo_documento` varchar(2) DEFAULT NULL COMMENT 'tipo del documento de identidad (RC: registro civil, TI: tarjeta de identidad, CC: cedula de ciudadania, CE: cedula de extranjeria)',
  `fecha_expedicion` date DEFAULT NULL COMMENT 'fecha expedicion documento de identidad',
  `fecha_nacimiento` datetime NOT NULL,
  `nombres` varchar(100) NOT NULL COMMENT 'nombres del jugador',
  `apellidos` varchar(100) NOT NULL COMMENT 'apellidos del jugador',
  `seguridad_social` varchar(100) DEFAULT NULL COMMENT 'Eps del jugador',
  `codigo_lugar_nacimiento` varchar(20) DEFAULT NULL COMMENT 'codigo lugar de nacimiento',
  `tipo_sangre` varchar(20) DEFAULT NULL COMMENT 'tipo de sangre',
  `direccion` varchar(200) DEFAULT NULL COMMENT 'direccion domicilio',
  `barrio` varchar(100) DEFAULT NULL COMMENT 'barrio del domicilio',
  `telefono` varchar(50) DEFAULT NULL COMMENT 'telefono domicilio',
  `celular` varchar(50) DEFAULT NULL COMMENT 'número de celular ',
  `email` varchar(100) DEFAULT NULL COMMENT 'correo electronico',
  `BB_PIN` varchar(20) DEFAULT NULL COMMENT 'codigo del PIN de blackberry',
  `colegio` varchar(100) DEFAULT NULL COMMENT 'nombre del colegio donde estudia actualmente',
  `grado` varchar(50) DEFAULT NULL COMMENT 'nivel escolar que cursa actualmente',
  `codigo_suscriptor` int(11) DEFAULT NULL COMMENT 'codigo del suscriptor',
  `foto` varchar(100) DEFAULT NULL COMMENT 'nombre dle archivo de la foto del jugador',
  `genero` varchar(1) DEFAULT NULL COMMENT 'sexo del jugador',
  `estado` varchar(1) DEFAULT NULL COMMENT 'estado del jugador, indica si esta activo o no (A: ACTIVO, I: INACTIVO)',
  `fecha_ingreso` date DEFAULT NULL COMMENT 'fecha en que se inscribió el jugador en el sistema',
  `codigo_categoria` int(11) DEFAULT NULL COMMENT 'codigo de la categoria a la que pertenece',
  `observaciones` varchar(2000) DEFAULT NULL COMMENT 'Observaciones generales para el jugador',
  `usuario_atencion` bigint(20) DEFAULT NULL COMMENT 'Usuario quien lo atendio por primera ves',
  `fecha_registro` datetime DEFAULT NULL COMMENT 'Fecha de Registro inicial',
  `periodo_de_pago` int(11) DEFAULT NULL COMMENT 'periodo de pago',
  `inscripcion` double(15,3) DEFAULT NULL,
  `mensualidad` double(15,3) DEFAULT NULL,
  `transporte` double(15,3) DEFAULT NULL,
  `exp_deportiva` varchar(2) DEFAULT NULL COMMENT 'SI/NO',
  `jornada_colegio` varchar(2) DEFAULT NULL COMMENT 'AM/PM',
  `referido` varchar(100) DEFAULT NULL,
  `responsable` varchar(200) DEFAULT NULL,
  `nombre_madre` varchar(100) DEFAULT NULL COMMENT 'nombre de la madre',
  `celular_madre` varchar(20) DEFAULT NULL COMMENT 'celular de la madre',
  `email_madre` varchar(100) DEFAULT NULL COMMENT 'email de la madre',
  `ocupacion_madre` varchar(100) DEFAULT NULL COMMENT 'ocupacion madre',
  `empresa_madre` varchar(100) DEFAULT NULL COMMENT 'empresa donde labora la madre',
  `nombre_padre` varchar(100) DEFAULT NULL COMMENT 'nombre del padre',
  `celular_padre` varchar(20) DEFAULT NULL COMMENT 'celular del padre',
  `email_padre` varchar(100) DEFAULT NULL COMMENT 'email del padre',
  `ocupacion_padre` varchar(100) DEFAULT NULL COMMENT 'ocupacion del padre',
  `empresa_padre` varchar(100) DEFAULT NULL COMMENT 'empresa donde labora el padre',
  PRIMARY KEY (`codigo`),
  KEY `jugadores_fk` (`codigo_suscriptor`),
  KEY `jugadores_ciudad_fk1` (`codigo_lugar_nacimiento`),
  KEY `jugadores_cat_fk1` (`codigo_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1 AUTO_INCREMENT=84 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `menusopciones`
-- 

CREATE menusopciones AS select `a`.`CODIGO` AS `CODIGO`,`a`.`DESCRIPCION_LARGA` AS `DESCRIPCION_LARGA`,`a`.`DESCRIPCION` AS `DESCRIPCION`,`a`.`MODULO` AS `MODULO`,`a`.`CODIGO_PADRE` AS `CODIGO_PADRE`,`a`.`NOMBRE_VIEW` AS `NOMBRE_VIEW`,`a`.`WIDGETALIAS` AS `WIDGETALIAS`,`d`.`USUARIO` AS `usuario` from (((`escuelafutbol`.`opciones` `a` join `escuelafutbol`.`roles_opciones` `b`) join `escuelafutbol`.`usuarios_rol` `c`) join `escuelafutbol`.`usuarios` `d`) where ((`a`.`CODIGO` = `b`.`OPCION`) and (`b`.`ROL` = `c`.`ROL`) and (`c`.`CODIGO_USUARIO` = `d`.`CODIGO`) and (`a`.`MODULO` = 0));

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `modulosusuario`
-- 

CREATE ALGORITHM=UNDEFINED DEFINER=`manuelpalomares`@`10.%` SQL SECURITY DEFINER VIEW `escuelafutbol`.`modulosusuario` AS select `a`.`CODIGO` AS `CODIGO`,`a`.`DESCRIPCION_LARGA` AS `DESCRIPCION_LARGA`,`a`.`DESCRIPCION` AS `DESCRIPCION`,`a`.`MODULO` AS `MODULO`,`a`.`CODIGO_PADRE` AS `CODIGO_PADRE`,`a`.`NOMBRE_VIEW` AS `NOMBRE_VIEW`,`a`.`URL_ICON` AS `URL_ICON`,`d`.`USUARIO` AS `usuario` from (((`escuelafutbol`.`opciones` `a` join `escuelafutbol`.`roles_opciones` `b`) join `escuelafutbol`.`usuarios_rol` `c`) join `escuelafutbol`.`usuarios` `d`) where ((`a`.`CODIGO` = `b`.`OPCION`) and (`b`.`ROL` = `c`.`ROL`) and (`c`.`CODIGO_USUARIO` = `d`.`CODIGO`) and (`a`.`MODULO` = 1));

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `novedades_seguimiento`
-- 

CREATE TABLE IF NOT EXISTS `novedades_seguimiento` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo de la novedad',
  `descripcion` varchar(50) DEFAULT NULL COMMENT 'descripcion de la novedad',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `opciones`
-- 

CREATE TABLE IF NOT EXISTS `opciones` (
  `CODIGO` bigint(20) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION_LARGA` varchar(100) DEFAULT NULL,
  `DESCRIPCION` varchar(50) DEFAULT NULL,
  `MODULO` char(1) DEFAULT NULL,
  `CODIGO_PADRE` bigint(20) DEFAULT NULL,
  `NOMBRE_VIEW` varchar(60) DEFAULT NULL,
  `WIDGETALIAS` varchar(100) DEFAULT NULL COMMENT 'Nombre del alias para el cliente',
  `URL_ICON` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE KEY `WIDGETALIAS` (`WIDGETALIAS`),
  UNIQUE KEY `WIDGETALIAS_2` (`WIDGETALIAS`),
  KEY `opciones_fk` (`CODIGO_PADRE`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `opciones_acciones`
-- 

CREATE TABLE IF NOT EXISTS `opciones_acciones` (
  `CODIGO_ACCION` int(11) NOT NULL AUTO_INCREMENT,
  `CODIGO_OPCION` bigint(20) NOT NULL,
  `DESCRIPCION_ACCION` varchar(100) DEFAULT NULL,
  `COMENTARIO` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CODIGO_ACCION`),
  UNIQUE KEY `CODIGO_ACCION` (`CODIGO_ACCION`),
  KEY `CODIGO_OPCION` (`CODIGO_OPCION`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `pagos`
-- 

CREATE TABLE IF NOT EXISTS `pagos` (
  `codigo` int(20) NOT NULL AUTO_INCREMENT COMMENT 'codigo del pago realizado',
  `fecha_pago` date DEFAULT NULL COMMENT 'fecha de pago de un cobro',
  `codigo_cobro` int(20) DEFAULT NULL COMMENT 'codigo del cobro que se está pagando',
  `valor` double(15,3) DEFAULT NULL COMMENT 'valor a pagar de un cobro',
  `codigo_jugador` int(11) DEFAULT NULL COMMENT 'codigo del jugador que efectua el pago de un cobro',
  PRIMARY KEY (`codigo`),
  KEY `codigo_jugador` (`codigo_jugador`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `roles`
-- 

CREATE TABLE IF NOT EXISTS `roles` (
  `CODIGO` bigint(20) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  UNIQUE KEY `CODIGO` (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `roles_opciones`
-- 

CREATE TABLE IF NOT EXISTS `roles_opciones` (
  `OPCION` bigint(20) NOT NULL,
  `ROL` bigint(20) NOT NULL,
  UNIQUE KEY `ROLES_OPCIONES__UN` (`OPCION`,`ROL`),
  KEY `roles_opciones_fk` (`ROL`),
  KEY `OPCION` (`OPCION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `seguimiento_jugadores`
-- 

CREATE TABLE IF NOT EXISTS `seguimiento_jugadores` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'codigo del registro de seguimiento',
  `fecha_seguimiento` date DEFAULT NULL COMMENT 'fecha del seguimiento',
  `codigo_jugador` int(11) DEFAULT NULL COMMENT 'codigo del jugador al que se le registra el seguimiento',
  `codigo_entrenador` int(11) DEFAULT NULL COMMENT 'codigo del entrenador que hace el seguimiento',
  `codigo_categoria` int(11) DEFAULT NULL COMMENT 'codigo de la categoria',
  `codigo_novedad` int(11) DEFAULT NULL COMMENT 'codigo de la novedad del seguimiento',
  `fecha_registro` date DEFAULT NULL COMMENT 'fecha en la que se registra la informacion',
  `comentairo_noasistencia` varchar(4000) DEFAULT NULL COMMENT 'Se almacena toda la inforamcion de la no asistencia informacion por el papa. del jugador o el jugador.',
  PRIMARY KEY (`codigo`),
  KEY `seg_jug_fk` (`codigo_jugador`),
  KEY `seg_cat_fk` (`codigo_categoria`),
  KEY `seg_entren_fk` (`codigo_entrenador`),
  KEY `seg_novedad_fk` (`codigo_novedad`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1 AUTO_INCREMENT=82 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `suscriptores`
-- 

CREATE TABLE IF NOT EXISTS `suscriptores` (
  `codigo` int(15) NOT NULL AUTO_INCREMENT COMMENT 'CODIGO DEL CLIENTE',
  `nombres` varchar(50) DEFAULT NULL COMMENT 'NOMBRES DEL CLIENTE',
  `apellidos` varchar(50) DEFAULT NULL COMMENT 'APELLIDOS DEL CLIENTE',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'TELEFONO',
  `celular` varchar(20) DEFAULT NULL COMMENT 'numero de celular',
  `email` varchar(100) DEFAULT NULL COMMENT 'correo electronico',
  `genero` varchar(1) DEFAULT NULL COMMENT 'genero de la persona (M: masculino, F:femenino)',
  `estado` varchar(1) NOT NULL COMMENT 'indica si el suscriptor está activo o no (A: activo, I:inactivo)',
  `fecha_ingreso` date DEFAULT NULL COMMENT 'FECHA DE REGISTRO EN EL SISTEMA',
  `tipo_documento` varchar(2) DEFAULT NULL COMMENT 'tipo de documento de identidad (CC: cedula ciudadania,TE: tarjeta extranjeria)',
  `numero_documento` varchar(20) DEFAULT NULL COMMENT 'numero documento identidad',
  `parentesco` varchar(20) DEFAULT NULL COMMENT 'parentesco (Padre, Madre, Otro)',
  `nombres2` varchar(50) DEFAULT NULL COMMENT 'nombres del segundo responsable',
  `apellidos2` varchar(50) DEFAULT NULL COMMENT 'apellidos del segundo responsable',
  `tipo_documento2` varchar(2) DEFAULT NULL COMMENT 'tipo documento del segundo responsable',
  `numero_documento2` varchar(20) DEFAULT NULL COMMENT 'numero_documento del segundo responsable',
  `parentesco2` varchar(20) DEFAULT NULL COMMENT 'parentesco del segundo responsable',
  `email2` varchar(100) DEFAULT NULL COMMENT 'email del segundo responsable',
  `genero2` varchar(1) DEFAULT NULL COMMENT 'Genero del segundo responsable (M:masculino, F: femenino)',
  `celular2` varchar(20) DEFAULT NULL COMMENT 'celular del segundo responsable',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `usuarios`
-- 

CREATE TABLE IF NOT EXISTS `usuarios` (
  `CODIGO` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Codigo del usuario',
  `USUARIO` varchar(100) DEFAULT NULL COMMENT 'nombre del usuario',
  `PASSWORD` varchar(100) DEFAULT NULL COMMENT 'contraseña de usuario',
  `NOMBRE` varchar(100) DEFAULT NULL COMMENT 'Nombre completo usuario',
  `CORREO` varchar(100) DEFAULT NULL COMMENT 'Email usuario',
  `ESTADO` varchar(2) DEFAULT NULL COMMENT 'Estado del usuario A Activo I Inactivo',
  PRIMARY KEY (`CODIGO`),
  UNIQUE KEY `usuarios_PK` (`CODIGO`),
  UNIQUE KEY `usuarios__UNv1` (`USUARIO`,`PASSWORD`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `usuarios_rol`
-- 

CREATE TABLE IF NOT EXISTS `usuarios_rol` (
  `CODIGO_USUARIO` bigint(20) NOT NULL,
  `ROL` bigint(20) NOT NULL,
  `ESTADO` char(1) DEFAULT NULL,
  UNIQUE KEY `USUARIOS_ROL__UN` (`CODIGO_USUARIO`,`ROL`),
  KEY `CODIGO_USUARIO` (`CODIGO_USUARIO`),
  KEY `usuarios_rol_fk1` (`ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `vw_agendadoseventos`
-- 

CREATE ALGORITHM=UNDEFINED DEFINER=`manuelpalomares`@`10.%` SQL SECURITY DEFINER VIEW `escuelafutbol`.`vw_agendadoseventos` AS select `a`.`codigo` AS `evento`,`c`.`email` AS `email`,`c`.`nombres` AS `nombres`,'J' AS `tipo`,`b`.`jugador` AS `jugador`,(select concat(`e`.`descripcion`,' ',`d`.`descripcion`) from `escuelafutbol`.`categorias` `e` where (`e`.`codigo` = `d`.`codigo_padre`)) AS `categoria` from (((`escuelafutbol`.`eventos_deportivos` `a` join `escuelafutbol`.`agendados_eventos` `b`) join `escuelafutbol`.`jugadores` `c`) join `escuelafutbol`.`categorias` `d`) where ((`a`.`codigo` = `b`.`evento`) and (`c`.`codigo` = `b`.`jugador`) and (`c`.`codigo_categoria` = `d`.`codigo`));

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `vw_seguimiento_jugadores`
-- 

CREATE ALGORITHM=UNDEFINED DEFINER=`manuelpalomares`@`10.%` SQL SECURITY DEFINER VIEW `escuelafutbol`.`vw_seguimiento_jugadores` AS select `escuelafutbol`.`seguimiento_jugadores`.`codigo` AS `codigo_seguimiento`,`escuelafutbol`.`jugadores`.`codigo` AS `codigo_jugador`,`escuelafutbol`.`seguimiento_jugadores`.`fecha_seguimiento` AS `fecha_seguimiento`,`escuelafutbol`.`seguimiento_jugadores`.`codigo_entrenador` AS `codigo_entrenador`,`escuelafutbol`.`jugadores`.`codigo_categoria` AS `codigo_categoria`,`escuelafutbol`.`seguimiento_jugadores`.`codigo_novedad` AS `codigo_novedad`,`escuelafutbol`.`seguimiento_jugadores`.`fecha_registro` AS `fecha_registro`,`escuelafutbol`.`seguimiento_jugadores`.`comentairo_noasistencia` AS `comentairo_noasistencia`,concat(`escuelafutbol`.`jugadores`.`apellidos`,' ',`escuelafutbol`.`jugadores`.`nombres`) AS `nombre_jugador`,(select `escuelafutbol`.`categorias`.`descripcion` from `escuelafutbol`.`categorias` where (`escuelafutbol`.`categorias`.`codigo` = `escuelafutbol`.`jugadores`.`codigo_categoria`)) AS `descripcion_categoria` from ((`escuelafutbol`.`jugadores` join `escuelafutbol`.`seguimiento_jugadores` on((`escuelafutbol`.`seguimiento_jugadores`.`codigo_jugador` = `escuelafutbol`.`jugadores`.`codigo`))) join `escuelafutbol`.`categorias` on((`escuelafutbol`.`jugadores`.`codigo_categoria` = `escuelafutbol`.`categorias`.`codigo`))) where (`escuelafutbol`.`jugadores`.`estado` = 'A') union select NULL AS `codigo_seguimiento`,`escuelafutbol`.`jugadores`.`codigo` AS `codigo_jugador`,NULL AS `fecha_seguimiento`,NULL AS `codigo_entrenador`,`escuelafutbol`.`jugadores`.`codigo_categoria` AS `codigo_categoria`,NULL AS `codigo_novedad`,NULL AS `fecha_registro`,NULL AS `comentairo_noasistencia`,concat(`escuelafutbol`.`jugadores`.`apellidos`,' ',`escuelafutbol`.`jugadores`.`nombres`) AS `nombre_jugador`,(select `escuelafutbol`.`categorias`.`descripcion` from `escuelafutbol`.`categorias` where (`escuelafutbol`.`categorias`.`codigo` = `escuelafutbol`.`jugadores`.`codigo_categoria`)) AS `descripcion_categoria` from (`escuelafutbol`.`jugadores` join `escuelafutbol`.`categorias` on((`escuelafutbol`.`jugadores`.`codigo_categoria` = `escuelafutbol`.`categorias`.`codigo`))) where (`escuelafutbol`.`jugadores`.`estado` = 'A');

-- 
-- Filtros para las tablas descargadas (dump)
-- 

-- 
-- Filtros para la tabla `acciones_rol`
-- 
ALTER TABLE `acciones_rol`
  ADD CONSTRAINT `acciones_rol_fk` FOREIGN KEY (`codigo_accion`) REFERENCES `opciones_acciones` (`CODIGO_ACCION`),
  ADD CONSTRAINT `acciones_rol_fk1` FOREIGN KEY (`codigo_opcion`) REFERENCES `opciones` (`CODIGO`),
  ADD CONSTRAINT `acciones_rol_fk2` FOREIGN KEY (`codigo_rol`) REFERENCES `roles` (`CODIGO`);

-- 
-- Filtros para la tabla `agendados_eventos`
-- 
ALTER TABLE `agendados_eventos`
  ADD CONSTRAINT `agendados_eventos_fk` FOREIGN KEY (`jugador`) REFERENCES `jugadores` (`codigo`),
  ADD CONSTRAINT `agendados_eventos_fk1` FOREIGN KEY (`evento`) REFERENCES `eventos_deportivos` (`codigo`);

-- 
-- Filtros para la tabla `categorias`
-- 
ALTER TABLE `categorias`
  ADD CONSTRAINT `categorias_entren_fk` FOREIGN KEY (`codigo_entrenador`) REFERENCES `entrenadores` (`codigo`);

-- 
-- Filtros para la tabla `cobros`
-- 
ALTER TABLE `cobros`
  ADD CONSTRAINT `cobros_concepto_fk` FOREIGN KEY (`codigo_concepto`) REFERENCES `conceptos_pagos` (`codigo`),
  ADD CONSTRAINT `cobros_jugador_fk` FOREIGN KEY (`codigo_jugador`) REFERENCES `jugadores` (`codigo`);

-- 
-- Filtros para la tabla `detalle_evaluacion`
-- 
ALTER TABLE `detalle_evaluacion`
  ADD CONSTRAINT `det_eva_cod_eva_fk` FOREIGN KEY (`codigo_evaluacion`) REFERENCES `evaluacion` (`codigo`),
  ADD CONSTRAINT `det_eva_det_asp_fk` FOREIGN KEY (`codigo_detalle_aspecto`) REFERENCES `aspectos_evaluacion` (`codigo`);

-- 
-- Filtros para la tabla `entrenadores_categoria`
-- 
ALTER TABLE `entrenadores_categoria`
  ADD CONSTRAINT `entrenadores_categoria_fk` FOREIGN KEY (`codigo_entrenador`) REFERENCES `entrenadores` (`codigo`),
  ADD CONSTRAINT `entrenadores_categoria_fk1` FOREIGN KEY (`codigo_categoria`) REFERENCES `categorias` (`codigo`);

-- 
-- Filtros para la tabla `evaluacion`
-- 
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `evaluacion_entrenador_fk` FOREIGN KEY (`codigo_entrenador`) REFERENCES `entrenadores` (`codigo`),
  ADD CONSTRAINT `evaluacion_fk` FOREIGN KEY (`codigo_jugador`) REFERENCES `jugadores` (`codigo`);

-- 
-- Filtros para la tabla `horarios_categoria`
-- 
ALTER TABLE `horarios_categoria`
  ADD CONSTRAINT `hor_cat_categoria_fk` FOREIGN KEY (`codigo_categoria`) REFERENCES `categorias` (`codigo`),
  ADD CONSTRAINT `hor_cat_horario_fk` FOREIGN KEY (`codigo_horario`) REFERENCES `horarios` (`codigo`);

-- 
-- Filtros para la tabla `jugadores`
-- 
ALTER TABLE `jugadores`
  ADD CONSTRAINT `jugadores_cat_fk1` FOREIGN KEY (`codigo_categoria`) REFERENCES `categorias` (`codigo`),
  ADD CONSTRAINT `jugadores_ciudad_fk1` FOREIGN KEY (`codigo_lugar_nacimiento`) REFERENCES `ciudades` (`codigo`);

-- 
-- Filtros para la tabla `opciones_acciones`
-- 
ALTER TABLE `opciones_acciones`
  ADD CONSTRAINT `opciones_acciones_fk` FOREIGN KEY (`CODIGO_OPCION`) REFERENCES `opciones` (`CODIGO`);

-- 
-- Filtros para la tabla `pagos`
-- 
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_jugador_fk` FOREIGN KEY (`codigo_jugador`) REFERENCES `jugadores` (`codigo`);

-- 
-- Filtros para la tabla `roles_opciones`
-- 
ALTER TABLE `roles_opciones`
  ADD CONSTRAINT `roles_opciones_fk` FOREIGN KEY (`ROL`) REFERENCES `roles` (`CODIGO`),
  ADD CONSTRAINT `roles_opciones_fk1` FOREIGN KEY (`OPCION`) REFERENCES `opciones` (`CODIGO`);

-- 
-- Filtros para la tabla `seguimiento_jugadores`
-- 
ALTER TABLE `seguimiento_jugadores`
  ADD CONSTRAINT `seguimiento_jugadores_fk` FOREIGN KEY (`codigo_jugador`) REFERENCES `jugadores` (`codigo`),
  ADD CONSTRAINT `seg_cat_fk` FOREIGN KEY (`codigo_categoria`) REFERENCES `categorias` (`codigo`),
  ADD CONSTRAINT `seg_entren_fk` FOREIGN KEY (`codigo_entrenador`) REFERENCES `entrenadores` (`codigo`),
  ADD CONSTRAINT `seg_novedad_fk` FOREIGN KEY (`codigo_novedad`) REFERENCES `novedades_seguimiento` (`codigo`);

-- 
-- Filtros para la tabla `usuarios_rol`
-- 
ALTER TABLE `usuarios_rol`
  ADD CONSTRAINT `usuarios_rol_fk` FOREIGN KEY (`CODIGO_USUARIO`) REFERENCES `usuarios` (`CODIGO`),
  ADD CONSTRAINT `usuarios_rol_fk1` FOREIGN KEY (`ROL`) REFERENCES `roles` (`CODIGO`);
