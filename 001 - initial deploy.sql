-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_design_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_design_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_design_1` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema warehouse
-- -----------------------------------------------------
USE `db_design_1` ;

-- -----------------------------------------------------
-- Table `db_design_1`.`ref_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_design_1`.`ref_currency` ;

CREATE TABLE IF NOT EXISTS `db_design_1`.`ref_currency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_design_1`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_design_1`.`user` ;

CREATE TABLE IF NOT EXISTS `db_design_1`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_design_1`.`ref_order_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_design_1`.`ref_order_status` ;

CREATE TABLE IF NOT EXISTS `db_design_1`.`ref_order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_design_1`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_design_1`.`order` ;

CREATE TABLE IF NOT EXISTS `db_design_1`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `currency_id` INT NOT NULL DEFAULT -1,
  `order_status_id` INT NOT NULL DEFAULT -1,
  `selling_price` DECIMAL(12,2) NOT NULL,
  `booking_dt` DATETIME NOT NULL,
  `pos` VARCHAR(5) NOT NULL,
  `reference_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_currency_idx` (`currency_id` ASC),
  INDEX `fk_order_user_idx` (`user_id` ASC),
  INDEX `order_pos_idx` (`pos` ASC),
  UNIQUE INDEX `order_reference_code_idx` (`reference_code` ASC),
  INDEX `fk_order_order_status_idx` (`order_status_id` ASC),
  CONSTRAINT `fk_order_currency`
    FOREIGN KEY (`currency_id`)
    REFERENCES `db_design_1`.`ref_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_design_1`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_order_status`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `db_design_1`.`ref_order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_design_1`.`fx_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_design_1`.`fx_rate` ;

CREATE TABLE IF NOT EXISTS `db_design_1`.`fx_rate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `primary_currency_id` INT NOT NULL,
  `secondary_currency_id` INT NOT NULL,
  `date` DATE NULL,
  `rate` DECIMAL(10,5) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fx_rate_currency1_idx` (`primary_currency_id` ASC),
  INDEX `fk_fx_rate_currency2_idx` (`secondary_currency_id` ASC),
  UNIQUE INDEX `ak_fx_rate` (`primary_currency_id` ASC, `secondary_currency_id` ASC, `date` ASC),
  CONSTRAINT `fk_fx_rate_currency1`
    FOREIGN KEY (`primary_currency_id`)
    REFERENCES `db_design_1`.`ref_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fx_rate_currency2`
    FOREIGN KEY (`secondary_currency_id`)
    REFERENCES `db_design_1`.`ref_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `db_design_1`.`ref_currency`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_design_1`;
INSERT INTO `db_design_1`.`ref_currency` (`id`, `code`, `name`, `description`) VALUES (-1, 'N/A', 'N/A', NULL);
INSERT INTO `db_design_1`.`ref_currency` (`id`, `code`, `name`, `description`) VALUES (1, 'USD', 'United States Dollar', NULL);
INSERT INTO `db_design_1`.`ref_currency` (`id`, `code`, `name`, `description`) VALUES (2, 'EUR', 'Euro', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_design_1`.`ref_order_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_design_1`;
INSERT INTO `db_design_1`.`ref_order_status` (`id`, `code`, `name`) VALUES (-1, 'N/A', 'N/A');
INSERT INTO `db_design_1`.`ref_order_status` (`id`, `code`, `name`) VALUES (1, 'ACTIVE', 'Active order');
INSERT INTO `db_design_1`.`ref_order_status` (`id`, `code`, `name`) VALUES (2, 'CANCELLED', 'Cancelled order');

COMMIT;

