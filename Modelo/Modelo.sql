-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pronosticador_rusia_2018
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pronosticador_rusia_2018
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pronosticador_rusia_2018` DEFAULT CHARACTER SET utf8 ;
USE `pronosticador_rusia_2018` ;

-- -----------------------------------------------------
-- User pronosticador
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS 'pronosticador'@'localhost' IDENTIFIED BY 'Pr0n0st1c@d0r';
GRANT ALL PRIVILEGES ON pronosticador_rusia_2018.* TO 'pronosticador'@'localhost';


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`pais` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del país',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'nombre del país',
  `bandera` VARCHAR(300) NOT NULL COMMENT 'Ruta con la imagen de la bandera del país',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Tabla con los paises que serán utilizados en la aplicación';


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`ciudad` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico de la ciudad',
  `pais` INT(11) NULL DEFAULT NULL COMMENT 'Identificador numérico del país al que pertenece la ciudad',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre de la ciudad',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ciudad_pais`
    FOREIGN KEY (`pais`)
    REFERENCES `pronosticador_rusia_2018`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Tabla con las ciudades que serán utilizadas en la aplicación';

CREATE INDEX `fk_pais_ciudad_idx` ON `pronosticador_rusia_2018`.`ciudad` (`pais` ASC);


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`configuracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`configuracion` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `valor` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Parámetros de configuración global de la aplicación';


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`equipo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del equipo',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre del equipo para el caso de las selecciones nacionales es el nombre del país',
  `pais` INT(11) NOT NULL COMMENT 'País del equipo',
  `ciudad` INT(11) NULL DEFAULT NULL COMMENT 'ciudad del equipo',
  `tipo` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Tipo del equipo: 1 - Selecciones nacionales, 2 - Equipos profesionales',
  `escudo` VARCHAR(300) NULL DEFAULT NULL COMMENT 'ruta en donde se encuentra la imagen del escudo del equipo',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_equipo_ciudad`
    FOREIGN KEY (`ciudad`)
    REFERENCES `pronosticador_rusia_2018`.`ciudad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_pais`
    FOREIGN KEY (`pais`)
    REFERENCES `pronosticador_rusia_2018`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Información básica de un equipo de fútbol';

CREATE INDEX `fk_equipo_pais_idx` ON `pronosticador_rusia_2018`.`equipo` (`pais` ASC);

CREATE INDEX `fk_equipo_ciudad_idx` ON `pronosticador_rusia_2018`.`equipo` (`ciudad` ASC);


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`estadio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`estadio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del estadio',
  `ciudad` INT(11) NOT NULL COMMENT 'Identificador de la ciudad donde queda el estadio',
  `nombre` VARCHAR(200) NOT NULL COMMENT 'Nombre del estadio',
  `capacidad` INT(11) NOT NULL COMMENT 'Capacidad de espectadores del estadio',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_estadio_ciudad`
    FOREIGN KEY (`ciudad`)
    REFERENCES `pronosticador_rusia_2018`.`ciudad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Información básica de un estadio';

CREATE INDEX `fk_estadio_ciudad_idx` ON `pronosticador_rusia_2018`.`estadio` (`ciudad` ASC);


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`rol` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del rol',
  `nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre del rol',
  `descripcion` VARCHAR(300) NULL DEFAULT NULL COMMENT 'DEscripcion de lo que puede hacer este rol',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Roles de la aplicación';


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`usuario` (
  `id` VARCHAR(15) NOT NULL COMMENT 'Cédula del jugador',
  `nombre` VARCHAR(200) NOT NULL COMMENT 'Nombre completo del jugador',
  `correo` VARCHAR(300) NOT NULL COMMENT 'Correo del jugador',
  `celular` VARCHAR(15) NOT NULL COMMENT 'Número celular del jugador',
  `pago` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'Indica si el jugador pagó o no. Este campo decide si puede o no ingresar a la aplicación. 0 - no ha pagado, 1 - ya pagó',
  `clave` VARCHAR(200) NOT NULL COMMENT 'Clave de ingreso a la aplicación. Está hasheada.',
  `rol` INT(11) NOT NULL COMMENT 'Identificador del rol que tiene el usuario',
  `fecha_pago` DATE NULL DEFAULT NULL COMMENT 'Fecha del pago de la inscripción',
  `tipo_pago` TINYINT(1) NULL DEFAULT NULL COMMENT 'Tipo del pago realizado. 1 - Efectivo, 2 - Consignación, 3 - Otro',
  `referencia_pago` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Número de referencia del pago. Número de consignación o número que identifique un pago.',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`rol`)
    REFERENCES `pronosticador_rusia_2018`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Datos básicos de los usuarios de la aplicación';

CREATE INDEX `fk_usuario_rol_idx` ON `pronosticador_rusia_2018`.`usuario` (`rol` ASC);


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`marcador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`marcador` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador numérico del marcador',
  `usuario` VARCHAR(15) NOT NULL COMMENT 'Usuario que ingresa el marcador',
  `equipo_local` INT(11) NOT NULL COMMENT 'Identificador del equipo local',
  `equipo_visitante` INT(11) NOT NULL COMMENT 'Identificador del equipo visitante',
  `goles_equipo_local` TINYINT(3) NOT NULL COMMENT 'goles del equipo local',
  `goles_equipo_visitante` TINYINT(3) NOT NULL COMMENT 'goles del equipo local',
  `tipo` TINYINT(1) NOT NULL COMMENT 'Tipo de marcador. 1 - oficial, 2 - normal, 3 - bonificación',
  `fecha_ingreso` DATE NOT NULL COMMENT 'Fecha de ingreso del marcador',
  `hora_ingreso` TIME NOT NULL COMMENT 'Hora de ingreso del marcador',
  `fecha_modificacion` DATE NULL DEFAULT NULL COMMENT 'Fecha de modificación del marcador',
  `hora_modificacion` TIME NULL DEFAULT NULL COMMENT 'Hora de modificación del marcador',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_marcador_equipo_local`
    FOREIGN KEY (`equipo_local`)
    REFERENCES `pronosticador_rusia_2018`.`equipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_marcador_equipo_visitante`
    FOREIGN KEY (`equipo_visitante`)
    REFERENCES `pronosticador_rusia_2018`.`equipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_marcador_usuario`
    FOREIGN KEY (`usuario`)
    REFERENCES `pronosticador_rusia_2018`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Marcadores ingresados por los jugadores o el administrador';

CREATE INDEX `fk_marcador_equipo_local_idx` ON `pronosticador_rusia_2018`.`marcador` (`equipo_local` ASC);

CREATE INDEX `fk_marcador_equipo_visitante_idx` ON `pronosticador_rusia_2018`.`marcador` (`equipo_visitante` ASC);

CREATE INDEX `fk_marcador_usuario_idx` ON `pronosticador_rusia_2018`.`marcador` (`usuario` ASC);


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`menu` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del menú',
  `padre` INT(11) NULL DEFAULT NULL COMMENT 'Identificador del menú padre al que pertenece éste item. Si es un padre este valor es null',
  `nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre del menú',
  `outcome` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Outcome del menú, requerido para la navegación en JSF',
  `descripcion` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Descripción del menú. Se indica qué se puede hacer al ingresar a la funcionalidad de éste item',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'configuración de los menús de la aplicación';


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`menu_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`menu_rol` (
  `menu` INT(11) NOT NULL COMMENT 'Identificador del menú',
  `rol` INT(11) NOT NULL COMMENT 'Identificador del rol',
  CONSTRAINT `fk_menu_rol_menu`
    FOREIGN KEY (`menu`)
    REFERENCES `pronosticador_rusia_2018`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_rol_rol`
    FOREIGN KEY (`rol`)
    REFERENCES `pronosticador_rusia_2018`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Tabla de relación entre los menús y los roles';

CREATE UNIQUE INDEX `unique_idx` ON `pronosticador_rusia_2018`.`menu_rol` (`menu` ASC, `rol` ASC);

CREATE INDEX `fk_menu_rol_menu_idx` ON `pronosticador_rusia_2018`.`menu_rol` (`menu` ASC);

CREATE INDEX `fk_menu_rol_rol_idx` ON `pronosticador_rusia_2018`.`menu_rol` (`rol` ASC);


-- -----------------------------------------------------
-- Table `pronosticador_rusia_2018`.`partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pronosticador_rusia_2018`.`partido` (
  `id` INT(11) NOT NULL COMMENT 'Número del partido',
  `fecha` DATE NOT NULL COMMENT 'Fecha del partido',
  `hora` VARCHAR(45) NOT NULL COMMENT 'Hora del partido',
  `equipo_local` INT(11) NOT NULL COMMENT 'Identificador del equipo local',
  `equipo_visitante` INT(11) NOT NULL COMMENT 'Identificador del equipo visitante',
  `estadio` INT(11) NOT NULL COMMENT 'Identificador del estadio donde se jugará el partido',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_partido_equipo_local`
    FOREIGN KEY (`equipo_local`)
    REFERENCES `pronosticador_rusia_2018`.`equipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_equipo_visitante`
    FOREIGN KEY (`equipo_visitante`)
    REFERENCES `pronosticador_rusia_2018`.`equipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partido_estadio`
    FOREIGN KEY (`estadio`)
    REFERENCES `pronosticador_rusia_2018`.`estadio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Información básica de un partido';

CREATE INDEX `fk_partido_equipo_local_idx` ON `pronosticador_rusia_2018`.`partido` (`equipo_local` ASC);

CREATE INDEX `fk_partido_equipo_visitante_idx` ON `pronosticador_rusia_2018`.`partido` (`equipo_visitante` ASC);

CREATE INDEX `fk_partido_estadio_idx` ON `pronosticador_rusia_2018`.`partido` (`estadio` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
