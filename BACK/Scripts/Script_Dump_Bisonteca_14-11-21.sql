-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: bisonteca
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentario` (
  `id_comentario` int(11) NOT NULL AUTO_INCREMENT,
  `id_curso` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `comentario` varchar(1000) NOT NULL,
  `valoracion` int(11) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comentario`),
  KEY `FK_comentario_curso` (`id_curso`),
  KEY `FK_comentario_usuario` (`id_usuario`),
  CONSTRAINT `FK_comentario_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`),
  CONSTRAINT `FK_comentario_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `subtitulo` varchar(250) NOT NULL,
  `descripcion` varchar(1000) DEFAULT NULL,
  `precio` decimal(18,2) NOT NULL,
  `activo` bit(1) NOT NULL DEFAULT b'1',
  `imagen` mediumblob,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_imagen` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `FK_usuario` (`id_usuario`),
  CONSTRAINT `FK_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `curso_categoria`
--

DROP TABLE IF EXISTS `curso_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_categoria` (
  `id_curso_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_curso` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_curso_categoria`),
  KEY `FK_curso_categoria_curso` (`id_curso`),
  KEY `FK_curso_categoria_categoria` (`id_categoria`),
  CONSTRAINT `FK_curso_categoria_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `FK_curso_categoria_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historial_usuario`
--

DROP TABLE IF EXISTS `historial_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_usuario` (
  `id_historial_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_nivel_curso` int(11) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historial_usuario`),
  KEY `FK_historial_usuario_nivel_curso` (`id_nivel_curso`),
  KEY `FK_historial_usuario_usuario` (`id_usuario`),
  CONSTRAINT `FK_historial_usuario_nivel_curso` FOREIGN KEY (`id_nivel_curso`) REFERENCES `nivel_curso` (`id_nivel_curso`),
  CONSTRAINT `FK_historial_usuario_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mensaje`
--

DROP TABLE IF EXISTS `mensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensaje` (
  `id_mensaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_rem` int(11) NOT NULL,
  `id_usuario_dest` int(11) NOT NULL,
  `mensaje` varchar(1000) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mensaje`),
  KEY `FK_mensaje_usuario_rem` (`id_usuario_rem`),
  KEY `FK_mensaje_usuario_dest` (`id_usuario_dest`),
  CONSTRAINT `FK_mensaje_usuario_dest` FOREIGN KEY (`id_usuario_dest`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `FK_mensaje_usuario_rem` FOREIGN KEY (`id_usuario_rem`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multimedia_nivel`
--

DROP TABLE IF EXISTS `multimedia_nivel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multimedia_nivel` (
  `id_multimedia_nivel` int(11) NOT NULL AUTO_INCREMENT,
  `id_nivel_curso` int(11) NOT NULL,
  `ruta` varchar(500) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `extension` varchar(25) NOT NULL,
  `tipo` varchar(250) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_multimedia_nivel`),
  KEY `FK_multimedia_nivel_nivel_curso` (`id_nivel_curso`),
  CONSTRAINT `FK_multimedia_nivel_nivel_curso` FOREIGN KEY (`id_nivel_curso`) REFERENCES `nivel_curso` (`id_nivel_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nivel_curso`
--

DROP TABLE IF EXISTS `nivel_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nivel_curso` (
  `id_nivel_curso` int(11) NOT NULL AUTO_INCREMENT,
  `id_curso` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `precio` decimal(18,2) DEFAULT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nivel_curso`),
  KEY `FK_nivel_curso_curso` (`id_curso`),
  CONSTRAINT `FK_nivel_curso_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametro`
--

DROP TABLE IF EXISTS `parametro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametro` (
  `id_parametro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `valor` varchar(1000) NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_parametro`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nick` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nombre` varchar(300) DEFAULT NULL,
  `ap_paterno` varchar(50) DEFAULT NULL,
  `ap_materno` varchar(50) DEFAULT NULL,
  `imagen` mediumblob,
  `tipo_imagen` varchar(25) DEFAULT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_rol_especial` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`),
  KEY `FK_usuario_usuario_rol` (`id_rol`),
  CONSTRAINT `FK_usuario_usuario_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_comentario`
--

DROP TABLE IF EXISTS `v_comentario`;
/*!50001 DROP VIEW IF EXISTS `v_comentario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_comentario` AS SELECT 
 1 AS `id_comentario`,
 1 AS `id_usuario`,
 1 AS `id_curso`,
 1 AS `comentario`,
 1 AS `valoracion`,
 1 AS `nick_usuario`,
 1 AS `nombre_usuario`,
 1 AS `imagen_usuario`,
 1 AS `tipo_imagen_usuario`,
 1 AS `fecha_alta`,
 1 AS `fecha_mod`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_curso_categoria`
--

DROP TABLE IF EXISTS `v_curso_categoria`;
/*!50001 DROP VIEW IF EXISTS `v_curso_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_curso_categoria` AS SELECT 
 1 AS `id_curso_categoria`,
 1 AS `id_curso`,
 1 AS `id_categoria`,
 1 AS `fecha_alta`,
 1 AS `fecha_mod`,
 1 AS `categoria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_cursos`
--

DROP TABLE IF EXISTS `v_cursos`;
/*!50001 DROP VIEW IF EXISTS `v_cursos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_cursos` AS SELECT 
 1 AS `id_curso`,
 1 AS `id_usuario`,
 1 AS `titulo`,
 1 AS `subtitulo`,
 1 AS `descripcion`,
 1 AS `precio`,
 1 AS `activo`,
 1 AS `imagen`,
 1 AS `fecha_alta`,
 1 AS `fecha_mod`,
 1 AS `tipo_imagen`,
 1 AS `nick_usuario`,
 1 AS `votos_positivos`,
 1 AS `votos_negativos`,
 1 AS `cantidad_ventas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_historial_usuario`
--

DROP TABLE IF EXISTS `v_historial_usuario`;
/*!50001 DROP VIEW IF EXISTS `v_historial_usuario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_historial_usuario` AS SELECT 
 1 AS `id_historial_usuario`,
 1 AS `id_usuario`,
 1 AS `id_curso`,
 1 AS `id_nivel_curso`,
 1 AS `nick_usuario`,
 1 AS `nombre_usuario`,
 1 AS `curso`,
 1 AS `nivel_curso`,
 1 AS `fecha_alta`,
 1 AS `fecha_mod`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_mensaje`
--

DROP TABLE IF EXISTS `v_mensaje`;
/*!50001 DROP VIEW IF EXISTS `v_mensaje`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_mensaje` AS SELECT 
 1 AS `id_mensaje`,
 1 AS `id_usuario_rem`,
 1 AS `id_usuario_dest`,
 1 AS `nick_usuario_rem`,
 1 AS `imagen_usuario_rem`,
 1 AS `tipo_imagen_usuario_rem`,
 1 AS `nick_usuario_dest`,
 1 AS `imagen_usuario_dest`,
 1 AS `tipo_imagen_usuario_dest`,
 1 AS `mensaje`,
 1 AS `fecha_alta`,
 1 AS `fecha_mod`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_venta`
--

DROP TABLE IF EXISTS `v_venta`;
/*!50001 DROP VIEW IF EXISTS `v_venta`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_venta` AS SELECT 
 1 AS `id_venta`,
 1 AS `id_usuario`,
 1 AS `id_curso`,
 1 AS `id_nivel_curso`,
 1 AS `forma_pago`,
 1 AS `monto_pago`,
 1 AS `fecha_finalizacion`,
 1 AS `nick_usuario`,
 1 AS `nombre_usuario`,
 1 AS `curso`,
 1 AS `nivel_curso`,
 1 AS `fecha_alta`,
 1 AS `fecha_mod`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `id_nivel_curso` int(11) DEFAULT NULL,
  `monto_pago` decimal(18,2) DEFAULT NULL,
  `forma_pago` int(11) NOT NULL,
  `fecha_finalizacion` datetime DEFAULT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_mod` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_venta`),
  KEY `FK_venta_curso` (`id_curso`),
  KEY `FK_venta_usuario` (`id_usuario`),
  CONSTRAINT `FK_venta_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`),
  CONSTRAINT `FK_venta_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'bisonteca'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_cantidad_ventas_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cantidad_ventas_curso`(
	id_curso 	INT
) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE Cantidad INT DEFAULT 0;
    SET Cantidad = 	(
						SELECT IFNULL((
							SELECT 	COUNT(v.id_venta)
							FROM	venta v
							WHERE	v.id_curso = id_curso
                            AND		(v.id_nivel_curso IS NULL OR v.id_nivel_curso <= 0)
						)
						, 0)
					);
    
	RETURN (Cantidad);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_cant_niveles_completados_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cant_niveles_completados_usuario`(
	id_curso 	INT,
    id_usuario	INT
) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE CantidadNivelesCompletados 	INT DEFAULT 0;
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES COMPLETADOS POR CURSO Y USUARIO
    SET CantidadNivelesCompletados =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_historial_usuario)
		FROM		historial_usuario h
		INNER JOIN	nivel_curso nc
					ON h.id_nivel_curso = nc.id_nivel_curso
		WHERE 		h.id_usuario = id_usuario
					AND nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_completados

	);
    
	RETURN (CantidadNivelesCompletados);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_cant_niveles_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cant_niveles_curso`(
	id_curso 	INT
) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE CantidadNiveles 			INT DEFAULT 0;
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES POR CURSO
    SET CantidadNiveles =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_nivel_curso)
		FROM		nivel_curso nc
		WHERE 		nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_curso

	);
    
	RETURN (CantidadNiveles);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_existe_archivo_nivel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_existe_archivo_nivel`(
	id_nivel_curso 	INT,
    nombre			VARCHAR(100)
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(SELECT EXISTS(
						SELECT 	id_multimedia_nivel
						FROM	multimedia_nivel mn
						WHERE	mn.nombre = nombre
                        AND		mn.id_nivel_curso = id_nivel_curso
					));
    
	RETURN (Existe);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_existe_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_existe_curso`(
	id_usuario 	INT,
    titulo		VARCHAR(100)
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(SELECT EXISTS(
						SELECT 	id_curso
						FROM	curso c
						WHERE	c.titulo = titulo
                        AND		c.id_usuario = id_usuario
					));
    
	RETURN (Existe);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_existe_nivel_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_existe_nivel_curso`(
	id_curso 	INT,
    titulo		VARCHAR(100)
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(SELECT EXISTS(
						SELECT 	id_nivel_curso
						FROM	nivel_curso nc
						WHERE	nc.titulo = titulo
                        AND		nc.id_curso = id_curso
					));
    
	RETURN (Existe);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_fecha_finalizacion_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_fecha_finalizacion_curso`(
	id_curso 	INT,
    id_usuario	INT
) RETURNS datetime
    DETERMINISTIC
BEGIN

	DECLARE CantidadNiveles 			INT DEFAULT 0;
	DECLARE CantidadNivelesCompletados 	INT DEFAULT 0;

	DECLARE FechaFinalizacion 			DATETIME DEFAULT NULL;
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES POR CURSO
    SET CantidadNiveles =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_nivel_curso)
		FROM		nivel_curso nc
		WHERE 		nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_curso

	);
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES COMPLETADOS POR CURSO Y USUARIO
    SET CantidadNivelesCompletados =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_historial_usuario)
		FROM		historial_usuario h
		INNER JOIN	nivel_curso nc
					ON h.id_nivel_curso = nc.id_nivel_curso
		WHERE 		h.id_usuario = id_usuario
					AND nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_completados

	);
        
    -- SI LA CANTIDAD ES IGUAL ENTONCES TERMINO EL CURSO
    IF CantidadNiveles = CantidadNivelesCompletados THEN
    
		-- OBTENEMOS LA FECHA DE FINALIZACION
		SET FechaFinalizacion =
		(
		
			SELECT IFNULL((
			
			SELECT		h.fecha_alta
			FROM		historial_usuario h
			INNER JOIN	nivel_curso nc
						ON h.id_nivel_curso = nc.id_nivel_curso
			WHERE 		h.id_usuario = id_usuario
						AND nc.id_curso = id_curso
			ORDER BY	h.fecha_alta DESC
			LIMIT		1
			
			), NULL) AS fecha_finalizacion

		);
    
    END IF;
    
	RETURN (FechaFinalizacion);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_precio_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_precio_curso`(
	tipo		INT,
	id		 	INT
) RETURNS decimal(18,2)
    DETERMINISTIC
BEGIN

	DECLARE Precio DECIMAL(18, 2) DEFAULT 0;
    
    -- si es 1 es el precio de un curso
    IF tipo = 1 THEN
		SET Precio = (IFNULL((SELECT c.precio FROM curso c WHERE c.id_curso = id), 0));
    ELSE
    -- si es cualquier otro es el precio de un nivel de curso
		SET Precio = (IFNULL((SELECT nc.precio FROM nivel_curso nc WHERE nc.id_nivel_curso = id ), 0));
    END IF;
    
    
	RETURN (Precio);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_votos_negativos_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_votos_negativos_curso`(
	id_curso 	INT
) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE Cantidad INT DEFAULT 0;
    SET Cantidad = 	(
						SELECT IFNULL((
							SELECT 	COUNT(c.id_comentario)
							FROM	comentario c
							WHERE	c.id_curso = id_curso
                            AND		c.valoracion = 0
						)
						, 0)
					);
    
	RETURN (Cantidad);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_votos_positivos_curso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_votos_positivos_curso`(
	id_curso 	INT
) RETURNS int(11)
    DETERMINISTIC
BEGIN

	DECLARE Cantidad INT DEFAULT 0;
    SET Cantidad = 	(
						SELECT IFNULL((
							SELECT 	COUNT(c.id_comentario)
							FROM	comentario c
							WHERE	c.id_curso = id_curso
                            AND		c.valoracion = 1
						)
						, 0)
					);
    
	RETURN (Cantidad);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_create`(
	IN p_nombre			VARCHAR(100)
)
BEGIN
		
		INSERT INTO 	categoria(nombre)
        VALUES			(
							p_nombre
						);
    
    SELECT IFNULL(MAX(id_categoria), 0) AS id FROM categoria;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_delete`(
	IN p_id_categoria	INT
)
BEGIN

	DELETE FROM	
						categoria
	WHERE
						id_categoria = p_id_categoria;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_existe`(
	IN p_nombre			VARCHAR(100)
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_categoria
							FROM		
									categoria
							WHERE
									nombre = p_nombre
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_select`(
	IN p_id_categoria	INT
)
BEGIN

	SELECT
						id_categoria,
						nombre,
						fecha_alta,
						fecha_mod
	FROM		
						categoria
	WHERE
						id_categoria = p_id_categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_selectall`(
)
BEGIN

	SELECT		
						id_categoria,
						nombre,
						fecha_alta,
						fecha_mod
	FROM		
						categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_selectByNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_selectByNombre`(
	IN p_nombre	VARCHAR(100)
)
BEGIN

	SELECT
						id_categoria,
						nombre,
						fecha_alta,
						fecha_mod
	FROM		
						categoria
	WHERE
						nombre = p_nombre;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_categoria_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_update`(
	IN p_id_categoria	INT,
	IN p_nombre			VARCHAR(100)
)
BEGIN

	UPDATE
						categoria
	SET
						nombre 		= p_nombre,
                        fecha_mod 	= NOW()
	WHERE
						id_categoria = p_id_categoria;
						
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_create`(
	IN p_id_curso		INT,
    IN p_id_usuario		INT,
    IN p_comentario		VARCHAR(1000),
    IN p_valoracion		INT
)
BEGIN
		
		INSERT INTO 	comentario(id_curso, id_usuario, comentario, valoracion)
        VALUES			(
							p_id_curso,
                            p_id_usuario,
                            p_comentario,
                            p_valoracion
						);
    
    SELECT IFNULL(MAX(id_comentario), 0) AS id FROM comentario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_delete`(
	IN p_id_comentario	INT
)
BEGIN

	DELETE FROM	
						comentario
	WHERE
						id_comentario = p_id_comentario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_existe`(
	IN p_id_usuario		INT,
    IN p_id_curso		INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_comentario
							FROM		
									comentario
							WHERE
									id_usuario = p_id_usuario
                                    AND id_curso = p_id_curso
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_select`(
	IN p_id_comentario	INT
)
BEGIN

	SELECT		
						id_comentario,
						id_usuario,
						id_curso,
						comentario,
                        valoracion,
                        nick_usuario,
                        nombre_usuario,
                        imagen_usuario,
                        tipo_imagen_usuario,
						fecha_alta,
						fecha_mod
	FROM		
						v_comentario
	WHERE
						id_comentario = p_id_comentario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_selectall`(
)
BEGIN

	SELECT		
						id_comentario,
						id_usuario,
						id_curso,
						comentario,
                        valoracion,
                        nick_usuario,
                        nombre_usuario,
                        imagen_usuario,
                        tipo_imagen_usuario,
						fecha_alta,
						fecha_mod
	FROM		
						v_comentario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_selectallByCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_selectallByCurso`(
	IN p_id_curso INT
)
BEGIN

	SELECT		
						id_comentario,
						id_usuario,
						id_curso,
						comentario,
                        valoracion,
                        nick_usuario,
                        nombre_usuario,
                        imagen_usuario,
                        tipo_imagen_usuario,
						fecha_alta,
						fecha_mod
	FROM		
						v_comentario
                        
	WHERE				id_curso = p_id_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comentario_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comentario_update`(
	IN p_id_comentario	INT,
    IN p_comentario		VARCHAR(1000),
    IN p_valoracion		INT
)
BEGIN

	UPDATE
						comentario
	SET
						comentario 		= p_comentario,
                        valoracion		= p_valoracion,
                        fecha_mod 		= NOW()
	WHERE
						id_comentario = p_id_comentario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_create`(
	IN p_id_curso		INT,
    IN p_id_categoria	INT
)
BEGIN
		
		INSERT INTO 	curso_categoria(id_curso, id_categoria)
        VALUES			(
							p_id_curso,
                            p_id_categoria
						);
    
    SELECT IFNULL(MAX(id_curso_categoria), 0) AS id FROM curso_categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_delete`(
	IN p_id_curso_categoria	INT
)
BEGIN

	DELETE FROM	
						curso_categoria
	WHERE
						id_curso_categoria = p_id_curso_categoria;
                        
	SELECT 				p_id_curso_categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_existe`(
	IN p_id_curso			INT,
    IN p_id_categoria		INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_curso_categoria
							FROM		
									curso_categoria
							WHERE
									id_curso = p_id_curso
                                    AND id_categoria = p_id_categoria
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_select`(
	IN p_id_curso_categoria	INT
)
BEGIN

	SELECT		
						id_curso_categoria,
						id_curso,
                        id_categoria,
						fecha_alta,
						fecha_mod
	FROM		
						curso_categoria
	WHERE
						id_curso_categoria = p_id_curso_categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_selectall`(
)
BEGIN

	SELECT		
						cc.id_curso_categoria,
						cc.id_curso,
                        cc.id_categoria,
						cc.fecha_alta,
						cc.fecha_mod,
						cc.categoria
	FROM		
						v_curso_categoria cc;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_selectallByCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_selectallByCurso`(
	IN p_id_curso	INT
)
BEGIN

	SELECT		
						cc.id_curso_categoria,
						cc.id_curso,
                        cc.id_categoria,
						cc.fecha_alta,
						cc.fecha_mod,
                        cc.categoria
	FROM		
						v_curso_categoria cc
                        
	WHERE				
						cc.id_curso = p_id_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_categoria_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_categoria_update`(
	IN p_id_curso_categoria	INT,
	IN p_id_curso		INT,
    IN p_id_categoria	INT
)
BEGIN

	UPDATE
						curso_categoria
	SET
						id_curso 		= p_id_curso,
                        id_categoria 	= p_id_categoria,
                        fecha_mod 		= NOW()
	WHERE
						id_curso_categoria = p_id_curso_categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_create`(
	IN p_id_usuario		INT,
	IN p_titulo			VARCHAR(100),
	IN p_subtitulo		VARCHAR(250),
	IN p_descripcion 	VARCHAR(1000),
	IN p_precio 		DECIMAL(18, 2)
)
BEGIN
		
		INSERT INTO 	curso(id_usuario, titulo, subtitulo, descripcion, precio)
        VALUES			(
							p_id_usuario,
                            p_titulo,
                            p_subtitulo,
                            p_descripcion,
                            p_precio
						);
    
    SELECT IFNULL(MAX(id_curso), 0) AS id FROM curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_delete`(
	IN p_id_curso		INT
)
BEGIN

	UPDATE
						curso
	SET
						Activo 		= 0
	WHERE
						id_curso = p_id_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_existe`(
	IN p_id_usuario		INT,
	IN p_titulo			VARCHAR(100)
)
BEGIN
    
	SELECT fn_existe_curso(p_id_usuario, p_titulo) AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_select`(
	IN p_id_curso		INT
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
	WHERE
						id_curso = p_id_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectall`(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectallAdquiridoByUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectallAdquiridoByUsuario`(
	IN p_id_usuario	INT
)
BEGIN

	SELECT		
						c.id_curso,
						c.id_usuario,
                        c.titulo,
                        c.subtitulo,
                        c.descripcion,
                        c.precio,
                        c.activo,
                        c.imagen,
						c.fecha_alta,
						c.fecha_mod,
                        c.tipo_imagen,
                        c.nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos c
                        
	INNER JOIN			venta v
						ON v.id_curso = c.id_curso
                        
	WHERE				v.id_usuario = p_id_usuario;
                        
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectallByIdUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectallByIdUsuario`(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
					
	WHERE
						id_usuario = p_id_usuario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectallFiltro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectallFiltro`(
	IN p_titulo				VARCHAR(100),
    IN p_id_categoria		INT,
    IN p_nick_autor			VARCHAR(100)
)
BEGIN

	SELECT	DISTINCT	v.id_curso,
						v.id_usuario,
                        v.titulo,
                        v.subtitulo,
                        v.descripcion,
                        v.precio,
                        v.activo,
                        v.imagen,
						v.fecha_alta,
						v.fecha_mod,
                        v.tipo_imagen,
                        v.nick_usuario,
                        v.votos_positivos,
                        v.votos_negativos,
                        v.cantidad_ventas
	FROM		
						v_cursos v
                        
	LEFT JOIN			curso_categoria cc
						ON v.id_curso = cc.id_curso
                        
	WHERE				
						(v.titulo LIKE CONCAT('%', p_titulo, '%')
                        AND v.nick_usuario LIKE CONCAT('%', p_nick_autor, '%'))
                        AND cc.id_categoria = p_id_categoria;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectallMasVendidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectallMasVendidos`(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
                        
	ORDER BY
						cantidad_ventas DESC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectallPopulares` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectallPopulares`(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
                        
	ORDER BY			votos_positivos DESC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_selectallRecientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_selectallRecientes`(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
                        
	ORDER BY			fecha_alta DESC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_update`(
	IN p_id_curso		INT,
	IN p_titulo			VARCHAR(100),
	IN p_subtitulo		VARCHAR(250),
	IN p_descripcion 	VARCHAR(1000),
	IN p_precio 		DECIMAL(18, 2)
)
BEGIN

	UPDATE
						curso
	SET
						titulo 		= p_titulo,
						subtitulo 	= p_subtitulo,
						descripcion = p_descripcion,
						precio		= p_precio,
                        fecha_mod 	= NOW()
	WHERE
						id_curso = p_id_curso;
		
	SELECT				p_id_curso;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_curso_updateimage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_curso_updateimage`(
	IN p_id_curso		INT,
	IN p_imagen			MEDIUMBLOB,
    IN p_tipo_imagen	VARCHAR(25)
)
BEGIN

	UPDATE			curso
    SET				imagen = p_imagen,
					tipo_imagen = p_tipo_imagen
	WHERE			id_curso = p_id_curso;
    
    SELECT 			p_id_curso;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_usuario_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_usuario_create`(
	IN p_id_usuario		INT,
    IN p_id_nivel_curso	INT
)
BEGIN
		
		INSERT INTO 	historial_usuario(id_usuario, id_nivel_curso)
        VALUES			(
							p_id_usuario,
                            p_id_nivel_curso
						);
    
    SELECT IFNULL(MAX(id_historial_usuario), 0) AS id FROM historial_usuario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_usuario_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_usuario_existe`(
	IN p_id_usuario		INT,
    IN p_id_nivel_curso INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_historial_usuario
							FROM		
									historial_usuario
							WHERE
									id_usuario = p_id_usuario
                                    AND id_nivel_curso = p_id_nivel_curso
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_usuario_reporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_usuario_reporte`(
	IN p_id_usuario	INT
)
BEGIN

	SELECT				h.id_usuario,
						h.id_curso,
						h.nick_usuario,
						h.nombre_usuario,
						h.curso,
						fn_cant_niveles_completados_usuario(h.id_curso, h.id_usuario) AS cant_niveles_completados,
                        fn_cant_niveles_curso(h.id_curso) AS cant_niveles_curso,
                        (fn_cant_niveles_completados_usuario(h.id_curso, h.id_usuario) / fn_cant_niveles_curso(h.id_curso)) * 100 AS porcentaje_completado,
                        fn_fecha_finalizacion_curso(h.id_curso, h.id_usuario) AS fecha_finalizacion
	FROM		
						v_historial_usuario h
	WHERE
						h.id_usuario = p_id_usuario
	
    GROUP BY			h.curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_usuario_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_usuario_select`(
	IN p_id_historial_usuario	INT
)
BEGIN

	SELECT		
						h.id_historial_usuario,
						h.id_usuario,
						h.id_curso,
						h.id_nivel_curso,
						h.nick_usuario,
						h.nombre_usuario,
						h.curso,
						h.nivel_curso,
						h.fecha_alta,
						h.fecha_mod
	FROM		
						v_historial_usuario h
	WHERE
						h.id_historial_usuario = p_id_historial_usuario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_usuario_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_usuario_selectall`(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		
						h.id_historial_usuario,
						h.id_usuario,
						h.id_curso,
						h.id_nivel_curso,
						h.nick_usuario,
						h.nombre_usuario,
						h.curso,
						h.nivel_curso,
						h.fecha_alta,
						h.fecha_mod
	FROM		
						v_historial_usuario h;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mensaje_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mensaje_create`(
	IN p_id_usuario_rem		INT,
    IN p_id_usuario_dest 	INT,
    IN p_mensaje			VARCHAR(1000)
)
BEGIN
		
		INSERT INTO 	mensaje(id_usuario_rem, id_usuario_dest, mensaje)
        VALUES			(
							p_id_usuario_rem,
                            p_id_usuario_dest,
							p_mensaje
						);
    
    SELECT IFNULL(MAX(id_mensaje), 0) AS id FROM mensaje;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mensaje_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mensaje_delete`(
	IN p_id_mensaje		INT
)
BEGIN

	DELETE FROM	
						mensaje
	WHERE
						id_mensaje = p_id_mensaje;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mensaje_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mensaje_existe`(
	IN p_id_mensaje 	INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_mensaje
							FROM		
									mensaje
							WHERE
									id_mensaje = p_id_mensaje
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mensaje_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mensaje_select`(
	IN p_id_mensaje 	INT
)
BEGIN

	SELECT		
				m.id_mensaje,
    
				m.id_usuario_rem,
				m.id_usuario_dest,
				
				m.nick_usuario_rem,
				m.imagen_usuario_rem,
				m.tipo_imagen_usuario_rem,
				
				m.nick_usuario_dest,
				m.imagen_usuario_dest,
				m.tipo_imagen_usuario_dest,
				
				m.mensaje,
				m.fecha_alta,
				m.fecha_mod
	FROM		
				v_mensaje m
	WHERE
						id_mensaje = p_id_mensaje;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mensaje_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mensaje_selectall`(
	IN p_id_usuario_dest	INT,
    IN p_id_usuario_rem		INT
)
BEGIN

	IF p_id_usuario_dest = p_id_usuario_rem THEN

		SELECT		
					m.id_mensaje,
		
					m.id_usuario_rem,
					m.id_usuario_dest,
					
					m.nick_usuario_rem,
					m.imagen_usuario_rem,
					m.tipo_imagen_usuario_rem,
					
					m.nick_usuario_dest,
					m.imagen_usuario_dest,
					m.tipo_imagen_usuario_dest,
					
					m.mensaje,
					m.fecha_alta,
					m.fecha_mod
		FROM		
					v_mensaje m
							
		WHERE
					id_usuario_rem IN (p_id_usuario_rem, p_id_usuario_dest)
                    OR id_usuario_dest IN (p_id_usuario_dest, p_id_usuario_rem)
			
		ORDER BY	m.fecha_alta ASC;
    
    ELSE

		SELECT		
					m.id_mensaje,
		
					m.id_usuario_rem,
					m.id_usuario_dest,
					
					m.nick_usuario_rem,
					m.imagen_usuario_rem,
					m.tipo_imagen_usuario_rem,
					
					m.nick_usuario_dest,
					m.imagen_usuario_dest,
					m.tipo_imagen_usuario_dest,
					
					m.mensaje,
					m.fecha_alta,
					m.fecha_mod
		FROM		
					v_mensaje m
							
		WHERE
					(id_usuario_rem = p_id_usuario_rem OR id_usuario_rem = p_id_usuario_dest)
					AND (id_usuario_dest = p_id_usuario_dest OR id_usuario_dest = p_id_usuario_rem)
			
		ORDER BY	m.fecha_alta ASC;
    
    END IF;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mensaje_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mensaje_update`(
	IN p_id_mensaje		INT,
    IN p_mensaje		VARCHAR(1000)
)
BEGIN

	UPDATE
						mensaje
	SET
                        mensaje		= p_mensaje,
                        fecha_mod 	= NOW()
	WHERE
						id_mensaje = p_id_mensaje;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_create`(
	IN p_id_nivel_curso		INT,
    IN p_ruta				VARCHAR(500),
    IN p_nombre				VARCHAR(100),
    IN p_extension			VARCHAR(25),
    IN p_tipo				VARCHAR(250)
)
BEGIN
		
		INSERT INTO 	multimedia_nivel(id_nivel_curso, ruta, nombre, extension, tipo)
        VALUES			(
							p_id_nivel_curso,
                            p_ruta,
                            p_nombre,
                            p_extension,
                            p_tipo
						);
    
    SELECT IFNULL(MAX(id_multimedia_nivel), 0) AS id FROM multimedia_nivel;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_delete`(
	IN p_id_multimedia_nivel INT
)
BEGIN

	DELETE FROM	
						multimedia_nivel
	WHERE
						id_multimedia_nivel = p_id_multimedia_nivel;
                        
	SELECT 				p_id_multimedia_nivel;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_existe`(
	IN p_id_nivel_curso	INT,
    IN p_nombre			VARCHAR(100)
)
BEGIN

	SELECT fn_existe_archivo_nivel(p_id_nivel_curso, p_nombre) AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_select`(
	IN p_id_multimedia_nivel	INT
)
BEGIN

	SELECT		
						id_multimedia_nivel,
						id_nivel_curso,
                        ruta,
                        nombre,
                        extension,
                        tipo,
						fecha_alta,
						fecha_mod
	FROM		
						multimedia_nivel
	WHERE				
						id_multimedia_nivel = p_id_multimedia_nivel;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_selectall`(
	IN p_id_nivel_curso INT
)
BEGIN

	SELECT		
						id_multimedia_nivel,
						id_nivel_curso,
                        ruta,
                        nombre,
                        extension,
                        tipo,
						fecha_alta,
						fecha_mod
	FROM		
						multimedia_nivel
                        
	WHERE				
						id_nivel_curso = p_id_nivel_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_selectFirstVideo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_selectFirstVideo`(
	IN p_id_nivel_curso	INT
)
BEGIN

	SELECT				id_multimedia_nivel,
						id_nivel_curso,
                        ruta,
                        nombre,
                        extension,
                        tipo,
						fecha_alta,
						fecha_mod
	FROM		
						multimedia_nivel
	WHERE				
						id_nivel_curso = p_id_nivel_curso
						AND tipo IN ('video/mp4', 'ogv', 'webm', 'flv')
                        
	ORDER BY			fecha_alta ASC
    
    LIMIT				1;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_multimedia_nivel_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_multimedia_nivel_update`(
	IN p_id_multimedia_nivel INT,
    IN p_ruta				VARCHAR(500),
    IN p_nombre				VARCHAR(100),
    IN p_extension			VARCHAR(25),
    IN p_tipo				VARCHAR(50)
)
BEGIN

	UPDATE
						multimedia_nivel
	SET
						ruta 		= p_ruta,
                        nombre 		= p_nombre,
                        extension 	= p_extension,
                        tipo		= p_tipo,
                        fecha_mod 	= NOW()
	WHERE
						id_multimedia_nivel = p_id_multimedia_nivel;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nivel_curso_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_curso_create`(
	IN p_id_curso		INT,
    IN p_orden			INT,
    IN p_precio			DECIMAL(18,2),
    IN p_titulo			VARCHAR(100),
    IN p_descripcion	VARCHAR(1000)
)
BEGIN
		
		INSERT INTO 	nivel_curso(id_curso, orden, precio, titulo, descripcion)
        VALUES			(
							p_id_curso,
                            p_orden,
                            p_precio,
                            p_titulo,
                            p_descripcion
						);
    
    SELECT IFNULL(MAX(id_nivel_curso), 0) AS id FROM nivel_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nivel_curso_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_curso_delete`(
	IN p_id_nivel_curso	INT
)
BEGIN

	DELETE FROM	
						nivel_curso
	WHERE
						id_nivel_curso = p_id_nivel_curso;
                        
	SELECT				p_id_nivel_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nivel_curso_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_curso_existe`(
	IN p_id_curso	INT,
    IN p_titulo		VARCHAR(100)	
)
BEGIN

	SELECT fn_existe_nivel_curso(p_id_curso, p_titulo) AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nivel_curso_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_curso_select`(
	IN p_id_nivel_curso	INT
)
BEGIN

	SELECT		
						id_nivel_curso,
						id_curso,
						orden,
                        precio,
                        titulo,
                        descripcion,
						fecha_alta,
						fecha_mod
	FROM		
						nivel_curso
	WHERE				
						id_nivel_curso = p_id_nivel_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nivel_curso_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_curso_selectall`(
	IN p_id_curso INT
)
BEGIN

	SELECT		
						id_nivel_curso,
						id_curso,
						orden,
                        precio,
                        titulo,
                        descripcion,
						fecha_alta,
						fecha_mod
	FROM		
						nivel_curso
	WHERE				
						id_curso = p_id_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nivel_curso_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nivel_curso_update`(
	IN p_id_nivel_curso	INT,
    IN p_orden			INT,
    IN p_precio			DECIMAL(18,2),
    IN p_titulo			VARCHAR(100),
    IN p_descripcion	VARCHAR(1000)
)
BEGIN

	UPDATE
						nivel_curso
	SET
						orden		= p_orden,
                        precio 		= p_precio,
                        titulo		= p_titulo,
                        descripcion = p_descripcion,
                        fecha_mod 	= NOW()
	WHERE
						id_nivel_curso = p_id_nivel_curso;
                        
	SELECT				p_id_nivel_curso;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rol_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol_create`(
	IN p_nombre			VARCHAR(50)
)
BEGIN

		INSERT INTO 	rol(nombre)
        VALUES			(
							p_nombre
						);
    
    SELECT IFNULL(MAX(id_rol), 0) AS id FROM rol;
                        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rol_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol_delete`(
	IN p_id_rol			INT
)
BEGIN

	DELETE FROM	
						rol
	WHERE
						id_rol = p_id_rol;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rol_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol_existe`(
	IN p_nombre			VARCHAR(50)
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT		
									id_rol
							FROM		
									rol
							WHERE				
									id_rol = p_id_rol
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rol_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol_select`(
	IN p_id_rol			INT
)
BEGIN

	SELECT		
						id_rol,
						nombre
	FROM		
						rol
	WHERE				
						id_rol = p_id_rol;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rol_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol_selectall`(
)
BEGIN

	SELECT		
						id_rol,
						nombre
	FROM		
						rol;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rol_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rol_update`(
	IN p_id_rol			INT,
	IN p_nombre			VARCHAR(50)
)
BEGIN

	UPDATE
						rol
	SET
						nombre 		= p_nombre
	WHERE
						id_rol = p_id_rol;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_create`(
	IN p_id_rol		INT,
    IN p_nick		VARCHAR(50),
    IN p_password	VARCHAR(50),
    IN p_email		VARCHAR(100)
)
BEGIN

	INSERT INTO usuario (id_rol, 		nick, 		password, 		email) 
	VALUES 				(p_id_rol,		p_nick,		p_password,		p_email);
    
    SELECT IFNULL(MAX(id_usuario), 0) AS id FROM usuario;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_passwordrepetida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_passwordrepetida`(
	IN p_id_usuario		INT,
    IN p_password 		VARCHAR(50)
)
BEGIN

	DECLARE Repetida BIT DEFAULT 0;
    SET Repetida = (SELECT EXISTS(SELECT id_usuario FROM usuario WHERE p_id_usuario = p_id_usuario AND password = p_password));
    
	SELECT Repetida AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_select`(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		id_usuario = p_id_usuario;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_selectall`(
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen,
                u.id_rol_especial
    FROM		usuario as u;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_selectByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_selectByEmail`(
	IN p_email		VARCHAR(100)
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		email = p_email;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_selectByNick` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_selectByNick`(
	IN p_nick		VARCHAR(50)
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		nick = p_nick;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_updateIdRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_updateIdRol`(
	IN p_id_usuario	INT,
	IN p_id_rol 	INT
)
BEGIN

	UPDATE	usuario
    SET		id_rol = p_id_rol
    WHERE	id_usuario = p_id_usuario;
    
    SELECT 	p_id_usuario;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_updateimage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_updateimage`(
	IN p_id_usuario		INT,
	IN p_imagen			MEDIUMBLOB,
    IN p_tipo_imagen	VARCHAR(25)
)
BEGIN

	UPDATE			usuario
    SET				imagen = p_imagen,
					tipo_imagen = p_tipo_imagen
	WHERE			id_usuario = p_id_usuario;
    
    SELECT 			p_id_usuario;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_updatenombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_updatenombre`(
	IN p_id_usuario		INT,
    IN p_nombre			VARCHAR(300),
    IN p_ap_paterno		VARCHAR(50),
    IN p_ap_materno		VARCHAR(50)
)
BEGIN

	UPDATE			usuario
    SET				nombre = p_nombre,
					ap_paterno = p_ap_paterno,
                    ap_materno = p_ap_materno
	WHERE			id_usuario = p_id_usuario;
    
    SELECT 			p_id_usuario;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_updatepassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_updatepassword`(
	IN p_id_usuario		INT,
    IN p_password		VARCHAR(50)
)
BEGIN

	UPDATE			usuario
    SET				password = p_password
	WHERE			id_usuario = p_id_usuario;
    
    SELECT 			p_id_usuario;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_validate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_validate`(
	IN p_nick		VARCHAR(50),
    IN p_password	VARCHAR(50)
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen,
                u.id_rol_especial
    FROM		usuario AS u
    WHERE		u.nick = p_nick
				AND u.password = p_password;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_create`(
	IN p_id_curso		INT,
	IN p_id_nivel_curso	INT,
    IN p_id_usuario		INT,
    IN p_forma_pago		INT
)
BEGIN

	IF p_id_nivel_curso <= 0 THEN
		
		INSERT INTO 	venta(id_curso, id_nivel_curso, id_usuario, forma_pago, monto_pago)
        VALUES			(
							p_id_curso,
                            p_id_nivel_curso,
                            p_id_usuario,
                            p_forma_pago,
                            fn_precio_curso(1, p_id_curso)
						);
    ELSE
		
		INSERT INTO 	venta(id_curso, id_nivel_curso, id_usuario, forma_pago, monto_pago)
        VALUES			(
							p_id_curso,
                            p_id_nivel_curso,
                            p_id_usuario,
                            p_forma_pago,
                            fn_precio_curso(2, p_id_nivel_curso)
						);
                        
    END IF;
    
    SELECT IFNULL(MAX(id_venta), 0) AS id FROM venta;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_delete`(
)
BEGIN
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_existe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_existe`(
	IN p_id_usuario		INT,
    IN p_id_curso		INT,
    IN p_id_nivel_curso	INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_venta
							FROM		
									venta
							WHERE
									id_usuario = p_id_usuario
									AND ((id_curso > 0 AND id_curso = p_id_curso) OR (id_nivel_curso > 0 AND id_nivel_curso = p_id_nivel_curso))
                        )
					);
    
	SELECT Existe AS Resultado;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_ganancia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_ganancia`(
	IN p_id_usuario		INT
)
BEGIN

	SELECT				IFNULL(SUM(v.monto_pago), 0) AS ganancia
	FROM		
						v_venta v
                        
	LEFT JOIN			curso c
						ON c.id_curso = v.id_curso
                        
	WHERE				c.id_usuario = p_id_usuario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_reporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_reporte`(
	IN p_id_usuario		INT
)
BEGIN

	SELECT				v.curso,
                        COUNT(v.id_usuario) AS cantidad_alumnos,
                        COUNT(v.id_curso) 	AS cantidad_ventas,
                        SUM(v.monto_pago) 	AS total_curso
	FROM		
						v_venta v
                        
	LEFT JOIN			curso c
						ON c.id_curso = v.id_curso
                        
	WHERE				c.id_usuario = p_id_usuario
                        
	GROUP BY			v.curso
    
    ORDER BY			v.fecha_alta DESC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_select`(
	IN p_id_venta		INT
)
BEGIN

	SELECT		
						v.id_venta,
						v.id_usuario,
						v.id_curso,
						v.id_nivel_curso,
						v.forma_pago,
						v.monto_pago,
						v.fecha_finalizacion,
						v.nick_usuario,
						v.nombre_usuario,
						v.curso,
						v.nivel_curso,
						v.fecha_alta,
						v.fecha_mod
	FROM		
						v_venta v
	WHERE				
						id_venta = p_id_venta;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_selectall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_selectall`(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		
						v.id_venta,
						v.id_usuario,
						v.id_curso,
						v.id_nivel_curso,
						v.forma_pago,
						v.monto_pago,
						v.fecha_finalizacion,
						v.nick_usuario,
						v.nombre_usuario,
						v.curso,
						v.nivel_curso,
						v.fecha_alta,
						v.fecha_mod
	FROM		
						v_venta v
                        
	LEFT JOIN			curso c
						ON c.id_curso = v.id_curso
                        
	WHERE				c.id_usuario = p_id_usuario
    
    ORDER BY			V.fecha_alta DESC;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_venta_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_update`(
	IN p_id_venta			INT,
    IN p_id_usuario			INT,
    IN p_fecha_finalizacion	DATETIME
)
BEGIN

	UPDATE
						venta
	SET
                        fecha_finalizacion 	= p_fecha_finalizacion,
                        fecha_mod 			= NOW()
	WHERE
						id_venta = p_id_venta
                        AND id_usuario = p_id_usuario;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_comentario`
--

/*!50001 DROP VIEW IF EXISTS `v_comentario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_comentario` AS select `c`.`id_comentario` AS `id_comentario`,`c`.`id_usuario` AS `id_usuario`,`c`.`id_curso` AS `id_curso`,`c`.`comentario` AS `comentario`,`c`.`valoracion` AS `valoracion`,`u`.`nick` AS `nick_usuario`,rtrim(concat(`u`.`nombre`,' ',`u`.`ap_paterno`,' ',`u`.`ap_materno`)) AS `nombre_usuario`,`u`.`imagen` AS `imagen_usuario`,`u`.`tipo_imagen` AS `tipo_imagen_usuario`,`c`.`fecha_alta` AS `fecha_alta`,`c`.`fecha_mod` AS `fecha_mod` from (`comentario` `c` join `usuario` `u` on((`c`.`id_usuario` = `u`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_curso_categoria`
--

/*!50001 DROP VIEW IF EXISTS `v_curso_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_curso_categoria` AS select `cc`.`id_curso_categoria` AS `id_curso_categoria`,`cc`.`id_curso` AS `id_curso`,`cc`.`id_categoria` AS `id_categoria`,`cc`.`fecha_alta` AS `fecha_alta`,`cc`.`fecha_mod` AS `fecha_mod`,`c`.`nombre` AS `categoria` from (`curso_categoria` `cc` join `categoria` `c` on((`cc`.`id_categoria` = `c`.`id_categoria`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_cursos`
--

/*!50001 DROP VIEW IF EXISTS `v_cursos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_cursos` AS select `c`.`id_curso` AS `id_curso`,`c`.`id_usuario` AS `id_usuario`,`c`.`titulo` AS `titulo`,`c`.`subtitulo` AS `subtitulo`,`c`.`descripcion` AS `descripcion`,`c`.`precio` AS `precio`,`c`.`activo` AS `activo`,`c`.`imagen` AS `imagen`,`c`.`fecha_alta` AS `fecha_alta`,`c`.`fecha_mod` AS `fecha_mod`,`c`.`tipo_imagen` AS `tipo_imagen`,`u`.`nick` AS `nick_usuario`,`fn_votos_positivos_curso`(`c`.`id_curso`) AS `votos_positivos`,`fn_votos_negativos_curso`(`c`.`id_curso`) AS `votos_negativos`,`fn_cantidad_ventas_curso`(`c`.`id_curso`) AS `cantidad_ventas` from (`curso` `c` join `usuario` `u` on((`c`.`id_usuario` = `u`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_historial_usuario`
--

/*!50001 DROP VIEW IF EXISTS `v_historial_usuario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_historial_usuario` AS select `h`.`id_historial_usuario` AS `id_historial_usuario`,`h`.`id_usuario` AS `id_usuario`,`c`.`id_curso` AS `id_curso`,`h`.`id_nivel_curso` AS `id_nivel_curso`,`u`.`nick` AS `nick_usuario`,rtrim(concat(`u`.`nombre`,' ',`u`.`ap_paterno`,' ',`u`.`ap_materno`)) AS `nombre_usuario`,`c`.`titulo` AS `curso`,`nc`.`titulo` AS `nivel_curso`,`h`.`fecha_alta` AS `fecha_alta`,`h`.`fecha_mod` AS `fecha_mod` from (((`historial_usuario` `h` join `usuario` `u` on((`h`.`id_usuario` = `u`.`id_usuario`))) join `nivel_curso` `nc` on((`h`.`id_nivel_curso` = `nc`.`id_nivel_curso`))) join `curso` `c` on((`nc`.`id_curso` = `c`.`id_curso`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mensaje`
--

/*!50001 DROP VIEW IF EXISTS `v_mensaje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_mensaje` AS select `m`.`id_mensaje` AS `id_mensaje`,`m`.`id_usuario_rem` AS `id_usuario_rem`,`m`.`id_usuario_dest` AS `id_usuario_dest`,`u_rem`.`nick` AS `nick_usuario_rem`,`u_rem`.`imagen` AS `imagen_usuario_rem`,`u_rem`.`tipo_imagen` AS `tipo_imagen_usuario_rem`,`u_dest`.`nick` AS `nick_usuario_dest`,`u_dest`.`imagen` AS `imagen_usuario_dest`,`u_dest`.`tipo_imagen` AS `tipo_imagen_usuario_dest`,`m`.`mensaje` AS `mensaje`,`m`.`fecha_alta` AS `fecha_alta`,`m`.`fecha_mod` AS `fecha_mod` from ((`mensaje` `m` join `usuario` `u_rem` on((`m`.`id_usuario_rem` = `u_rem`.`id_usuario`))) join `usuario` `u_dest` on((`m`.`id_usuario_dest` = `u_dest`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_venta`
--

/*!50001 DROP VIEW IF EXISTS `v_venta`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_venta` AS select `v`.`id_venta` AS `id_venta`,`v`.`id_usuario` AS `id_usuario`,`v`.`id_curso` AS `id_curso`,`v`.`id_nivel_curso` AS `id_nivel_curso`,`v`.`forma_pago` AS `forma_pago`,`v`.`monto_pago` AS `monto_pago`,`fn_fecha_finalizacion_curso`(`v`.`id_curso`,`v`.`id_usuario`) AS `fecha_finalizacion`,`u`.`nick` AS `nick_usuario`,rtrim(concat(`u`.`nombre`,' ',`u`.`ap_paterno`,' ',`u`.`ap_materno`)) AS `nombre_usuario`,`c`.`titulo` AS `curso`,`nc`.`titulo` AS `nivel_curso`,`v`.`fecha_alta` AS `fecha_alta`,`v`.`fecha_mod` AS `fecha_mod` from (((`venta` `v` join `usuario` `u` on((`v`.`id_usuario` = `u`.`id_usuario`))) left join `nivel_curso` `nc` on((`v`.`id_nivel_curso` = `nc`.`id_nivel_curso`))) left join `curso` `c` on((`v`.`id_curso` = `c`.`id_curso`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-14 18:50:00
