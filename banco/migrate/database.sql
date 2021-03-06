-- MySQL Script generated by MySQL Workbench
-- Wed Jun 28 01:39:28 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema CRICKET
-- -----------------------------------------------------
-- The database of the Cricket A
-- pplication

-- -----------------------------------------------------
-- Schema CRICKET
--
-- The database of the Cricket A
-- pplication
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CRICKET` ;
USE `CRICKET` ;

-- -----------------------------------------------------
-- Table `CRICKET`.`MODULE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`MODULE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL COMMENT 'The name of the module',
  `DESCRIPTION` VARCHAR(45) NULL COMMENT 'The short description of the module',
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`USER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL COMMENT 'The name of the user',
  `EMAIL` VARCHAR(100) NULL COMMENT 'The email of the user',
  `USERNAME` VARCHAR(60) NOT NULL COMMENT 'The username of the user',
  `PASSWORD` VARCHAR(64) NOT NULL COMMENT 'The password of the user',
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  `LAST_PASSOWRD_CHANGE` TIMESTAMP NULL,
  `LAST_LOGIN` TIMESTAMP NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `UN_USER_USERNAME` (`USERNAME` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`PAPER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`PAPER` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL COMMENT 'The name of the paper',
  `MODULE_ID` INT NOT NULL COMMENT 'The id of the module',
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  INDEX `IDX_PAPER` (`MODULE_ID` ASC),
  CONSTRAINT `FK_PAPER_MODULE`
    FOREIGN KEY (`MODULE_ID`)
    REFERENCES `CRICKET`.`MODULE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`ACTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`ACTION` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL COMMENT 'The name of the Action',
  `MODULE_ID` INT NOT NULL COMMENT 'The id of the module',
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  INDEX `IDX_ACTION` (`MODULE_ID` ASC),
  CONSTRAINT `FK_ACTION_MODULE`
    FOREIGN KEY (`MODULE_ID`)
    REFERENCES `CRICKET`.`MODULE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`RESOURCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`RESOURCE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `MODULE_ID` INT NOT NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  INDEX `IDX_RESOURCE` (`MODULE_ID` ASC),
  CONSTRAINT `FK_RESOURCE_MODULE`
    FOREIGN KEY (`MODULE_ID`)
    REFERENCES `CRICKET`.`MODULE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`RESOURCE_ACTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`RESOURCE_ACTION` (
  `ID_RESOURCE` INT NOT NULL,
  `ID_ACTION` INT NOT NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_RESOURCE`, `ID_ACTION`),
  INDEX `IDX_RESOURCE_ACTION` (),
  INDEX `FK_RESOURCE_ACTION_ACTION_idx` (`ID_ACTION` ASC),
  CONSTRAINT `FK_RESOURCE_ACTION_RESOURCE`
    FOREIGN KEY (`ID_RESOURCE`)
    REFERENCES `CRICKET`.`RESOURCE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RESOURCE_ACTION_ACTION`
    FOREIGN KEY (`ID_ACTION`)
    REFERENCES `CRICKET`.`ACTION` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`USER_PAPER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`USER_PAPER` (
  `ID_USER` INT NOT NULL,
  `ID_PAPER` INT NOT NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_USER`, `ID_PAPER`),
  INDEX `FK_USER_PAPER_PAPER_idx` (`ID_PAPER` ASC),
  CONSTRAINT `FK_USER_PAPER_USER`
    FOREIGN KEY (`ID_USER`)
    REFERENCES `CRICKET`.`USER` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USER_PAPER_PAPER`
    FOREIGN KEY (`ID_PAPER`)
    REFERENCES `CRICKET`.`PAPER` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`EVENT_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`EVENT_TYPE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `UN_EVENT_TYPE_NAME` (`NAME` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`AUDITORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`AUDITORY` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `MODULE_ID` INT NOT NULL,
  `USER_ID` INT NOT NULL,
  `EVENT_TYPE_ID` INT NOT NULL,
  `EVENT` TEXT NOT NULL,
  `OLD_VALUE` VARCHAR(255) NULL,
  `NEW_VALUE` VARCHAR(255) NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  INDEX `FK_AUDITORY_EVENT_TYPE_idx` (`EVENT_TYPE_ID` ASC),
  INDEX `FK_AUDITORY_USER_idx` (`USER_ID` ASC),
  INDEX `FK_AUDITORY_MODULE_idx` (`MODULE_ID` ASC),
  CONSTRAINT `FK_AUDITORY_EVENT_TYPE`
    FOREIGN KEY (`EVENT_TYPE_ID`)
    REFERENCES `CRICKET`.`EVENT_TYPE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_AUDITORY_USER`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `CRICKET`.`USER` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_AUDITORY_MODULE`
    FOREIGN KEY (`MODULE_ID`)
    REFERENCES `CRICKET`.`MODULE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`PERMISSION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`PERMISSION` (
  `ID` INT NOT NULL,
  `ID_RESOURCE` INT NOT NULL,
  `ID_ACTION` INT NOT NULL,
  `ALLOWED` TINYINT NOT NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  INDEX `IDX_PERMISSION` (),
  INDEX `FK_PERMISSION_RESOURCE_idx` (`ID_RESOURCE` ASC),
  INDEX `FK_PERMISSION_ACTION_idx` (`ID_ACTION` ASC),
  CONSTRAINT `FK_PERMISSION_RESOURCE`
    FOREIGN KEY (`ID_RESOURCE`)
    REFERENCES `CRICKET`.`RESOURCE` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PERMISSION_ACTION`
    FOREIGN KEY (`ID_ACTION`)
    REFERENCES `CRICKET`.`ACTION` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`PAPER_PERMISSION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`PAPER_PERMISSION` (
  `ID_PAPER` INT NOT NULL,
  `ID_PERMISSION` INT NOT NULL,
  `CREATED_AT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_AT` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_PAPER`, `ID_PERMISSION`),
  INDEX `IDX_PAPER_PERMISSION` (`ID_PERMISSION` ASC),
  CONSTRAINT `FK_PAPER_PERMISSION_PAPER`
    FOREIGN KEY (`ID_PAPER`)
    REFERENCES `CRICKET`.`PAPER` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PAPER_PERMISSION_PERMISSION`
    FOREIGN KEY (`ID_PERMISSION`)
    REFERENCES `CRICKET`.`PERMISSION` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CRICKET`.`USER_PERMISSION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CRICKET`.`USER_PERMISSION` (
  `ID_USER` INT NOT NULL,
  `ID_PERMISSION` INT NOT NULL,
  PRIMARY KEY (`ID_USER`, `ID_PERMISSION`),
  INDEX `IDX_USER_PERMISSION` (`ID_PERMISSION` ASC),
  CONSTRAINT `FK_USER_PERMISSION_USER`
    FOREIGN KEY (`ID_USER`)
    REFERENCES `CRICKET`.`USER` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USER_PERMISSION_PERMISSION`
    FOREIGN KEY (`ID_PERMISSION`)
    REFERENCES `CRICKET`.`PERMISSION` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
