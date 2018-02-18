-- MySQL dump 10.16  Distrib 10.1.31-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: pronosticador_rusia_2018
-- ------------------------------------------------------
-- Server version	10.1.31-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ciudad`
--

DROP TABLE IF EXISTS `ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ciudad` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico de la ciudad',
  `pais` int(11) DEFAULT NULL COMMENT 'Identificador numérico del país al que pertenece la ciudad',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre de la ciudad',
  PRIMARY KEY (`id`),
  KEY `fk_pais_ciudad_idx` (`pais`),
  CONSTRAINT `fk_ciudad_pais` FOREIGN KEY (`pais`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla con las ciudades que serán utilizadas en la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad`
--

LOCK TABLES `ciudad` WRITE;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `valor` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Parámetros de configuración global de la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del equipo',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del equipo para el caso de las selecciones nacionales es el nombre del país',
  `pais` int(11) NOT NULL COMMENT 'País del equipo',
  `ciudad` int(11) DEFAULT NULL COMMENT 'ciudad del equipo',
  `tipo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Tipo del equipo: 1 - Selecciones nacionales, 2 - Equipos profesionales',
  `escudo` varchar(300) DEFAULT NULL COMMENT 'ruta en donde se encuentra la imagen del escudo del equipo',
  PRIMARY KEY (`id`),
  KEY `fk_equipo_pais_idx` (`pais`),
  KEY `fk_equipo_ciudad_idx` (`ciudad`),
  CONSTRAINT `fk_equipo_ciudad` FOREIGN KEY (`ciudad`) REFERENCES `ciudad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_pais` FOREIGN KEY (`pais`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Información básica de un equipo de fútbol';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadio`
--

DROP TABLE IF EXISTS `estadio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadio` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del estadio',
  `ciudad` int(11) NOT NULL COMMENT 'Identificador de la ciudad donde queda el estadio',
  `nombre` varchar(200) NOT NULL COMMENT 'Nombre del estadio',
  `capacidad` int(11) NOT NULL COMMENT 'Capacidad de espectadores del estadio',
  PRIMARY KEY (`id`),
  KEY `fk_estadio_ciudad_idx` (`ciudad`),
  CONSTRAINT `fk_estadio_ciudad` FOREIGN KEY (`ciudad`) REFERENCES `ciudad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Información básica de un estadio';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadio`
--

LOCK TABLES `estadio` WRITE;
/*!40000 ALTER TABLE `estadio` DISABLE KEYS */;
/*!40000 ALTER TABLE `estadio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcador`
--

DROP TABLE IF EXISTS `marcador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcador` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del marcador',
  `usuario` varchar(15) NOT NULL COMMENT 'Usuario que ingresa el marcador',
  `partido` int(11) NOT NULL COMMENT 'Partido al que pertenece el marcador',
  `equipo_local` int(11) NOT NULL COMMENT 'Identificador del equipo local',
  `equipo_visitante` int(11) NOT NULL COMMENT 'Identificador del equipo visitante',
  `goles_equipo_local` tinyint(3) NOT NULL COMMENT 'goles del equipo local',
  `goles_equipo_visitante` tinyint(3) NOT NULL COMMENT 'goles del equipo local',
  `tipo` tinyint(1) NOT NULL COMMENT 'Tipo de marcador. 1 - oficial, 2 - normal, 3 - bonificación',
  `fecha_ingreso` date NOT NULL COMMENT 'Fecha de ingreso del marcador',
  `hora_ingreso` time NOT NULL COMMENT 'Hora de ingreso del marcador',
  `fecha_modificacion` date DEFAULT NULL COMMENT 'Fecha de modificación del marcador',
  `hora_modificacion` time DEFAULT NULL COMMENT 'Hora de modificación del marcador',
  PRIMARY KEY (`id`),
  KEY `fk_marcador_equipo_local_idx` (`equipo_local`),
  KEY `fk_marcador_equipo_visitante_idx` (`equipo_visitante`),
  KEY `fk_marcador_usuario_idx` (`usuario`),
  KEY `fk_marcador_partido_idx` (`partido`),
  CONSTRAINT `fk_marcador_equipo_local` FOREIGN KEY (`equipo_local`) REFERENCES `equipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_marcador_equipo_visitante` FOREIGN KEY (`equipo_visitante`) REFERENCES `equipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_marcador_partido` FOREIGN KEY (`partido`) REFERENCES `partido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_marcador_usuario` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Marcadores ingresados por los jugadores o el administrador';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcador`
--

LOCK TABLES `marcador` WRITE;
/*!40000 ALTER TABLE `marcador` DISABLE KEYS */;
/*!40000 ALTER TABLE `marcador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del menú',
  `padre` int(11) DEFAULT NULL COMMENT 'Identificador del menú padre al que pertenece éste item. Si es un padre este valor es null',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del menú',
  `outcome` varchar(100) DEFAULT NULL COMMENT 'Outcome del menú, requerido para la navegación en JSF',
  `descripcion` varchar(500) DEFAULT NULL COMMENT 'Descripción del menú. Se indica qué se puede hacer al ingresar a la funcionalidad de éste item',
  `icono` varchar(50) DEFAULT NULL COMMENT 'Ícono para mostrar en el menú',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='configuración de los menús de la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,NULL,'Administración',NULL,'Menú para las operaciones de administración de la app','fa fa-cog'),(2,1,'Agregar Equipos','agregarEquipos','Operación en la que se adicionan los equipos','fa fa-group'),(3,1,'Agregar Estadios','agregarEstadios','Agregar estadios al torneo','fa fa-university'),(4,1,'Agregar Parámetros','parametrizar','Agregar parámetros a la aplicación','fa fa-cog');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_rol`
--

DROP TABLE IF EXISTS `menu_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_rol` (
  `menu` int(11) NOT NULL COMMENT 'Identificador del menú',
  `rol` int(11) NOT NULL COMMENT 'Identificador del rol',
  UNIQUE KEY `unique_idx` (`menu`,`rol`),
  KEY `fk_menu_rol_menu_idx` (`menu`),
  KEY `fk_menu_rol_rol_idx` (`rol`),
  CONSTRAINT `fk_menu_rol_menu` FOREIGN KEY (`menu`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_rol_rol` FOREIGN KEY (`rol`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de relación entre los menús y los roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_rol`
--

LOCK TABLES `menu_rol` WRITE;
/*!40000 ALTER TABLE `menu_rol` DISABLE KEYS */;
INSERT INTO `menu_rol` VALUES (1,1),(2,1),(3,1),(4,1);
/*!40000 ALTER TABLE `menu_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del país',
  `nombre` varchar(100) NOT NULL COMMENT 'nombre del país',
  `bandera` varchar(300) NOT NULL COMMENT 'Ruta con la imagen de la bandera del país',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla con los paises que serán utilizados en la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partido`
--

DROP TABLE IF EXISTS `partido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partido` (
  `id` int(11) NOT NULL COMMENT 'Número del partido',
  `fecha` date NOT NULL COMMENT 'Fecha del partido',
  `hora` varchar(45) NOT NULL COMMENT 'Hora del partido',
  `equipo_local` int(11) NOT NULL COMMENT 'Identificador del equipo local',
  `equipo_visitante` int(11) NOT NULL COMMENT 'Identificador del equipo visitante',
  `estadio` int(11) NOT NULL COMMENT 'Identificador del estadio donde se jugará el partido',
  PRIMARY KEY (`id`),
  KEY `fk_partido_equipo_local_idx` (`equipo_local`),
  KEY `fk_partido_equipo_visitante_idx` (`equipo_visitante`),
  KEY `fk_partido_estadio_idx` (`estadio`),
  CONSTRAINT `fk_partido_equipo_local` FOREIGN KEY (`equipo_local`) REFERENCES `equipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_equipo_visitante` FOREIGN KEY (`equipo_visitante`) REFERENCES `equipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_estadio` FOREIGN KEY (`estadio`) REFERENCES `estadio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Información básica de un partido';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partido`
--

LOCK TABLES `partido` WRITE;
/*!40000 ALTER TABLE `partido` DISABLE KEYS */;
/*!40000 ALTER TABLE `partido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del rol',
  `nombre` varchar(45) NOT NULL COMMENT 'Nombre del rol',
  `descripcion` varchar(300) DEFAULT NULL COMMENT 'DEscripcion de lo que puede hacer este rol',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Roles de la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Administrador','Usuario encargado de realizar las tareas de configuración de la aplicación');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` varchar(15) NOT NULL COMMENT 'Cédula del jugador',
  `nombre` varchar(200) NOT NULL COMMENT 'Nombre completo del jugador',
  `correo` varchar(300) NOT NULL COMMENT 'Correo del jugador',
  `celular` varchar(15) NOT NULL COMMENT 'Número celular del jugador',
  `pago` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si el jugador pagó o no. Este campo decide si puede o no ingresar a la aplicación. 0 - no ha pagado, 1 - ya pagó',
  `clave` varchar(200) NOT NULL COMMENT 'Clave de ingreso a la aplicación. Está hasheada.',
  `rol` int(11) NOT NULL COMMENT 'Identificador del rol que tiene el usuario',
  `fecha_pago` date DEFAULT NULL COMMENT 'Fecha del pago de la inscripción',
  `tipo_pago` tinyint(1) DEFAULT NULL COMMENT 'Tipo del pago realizado. 1 - Efectivo, 2 - Consignación, 3 - Otro',
  `referencia_pago` varchar(45) DEFAULT NULL COMMENT 'Número de referencia del pago. Número de consignación o número que identifique un pago.',
  PRIMARY KEY (`id`),
  KEY `fk_usuario_rol_idx` (`rol`),
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`rol`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Datos básicos de los usuarios de la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('123','123','123','123',0,'123',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pronosticador_rusia_2018'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-18 16:24:51
