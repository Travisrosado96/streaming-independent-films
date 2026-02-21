-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Streaming_Service_for_independent_films
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Streaming_Service_for_independent_films
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Streaming_Service_for_independent_films` DEFAULT CHARACTER SET utf8 ;
USE `Streaming_Service_for_independent_films` ;

-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`filmmaker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`filmmaker` (
  `filmmaker_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `bio` TEXT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`filmmaker_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`film` (
  `film_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `description` TEXT NULL,
  `release_year` YEAR NULL,
  `filmmaker_id` INT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`film_id`),
  INDEX `filmmaker_id_idx` (`filmmaker_id` ASC) VISIBLE,
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `filmmaker_id`
    FOREIGN KEY (`filmmaker_id`)
    REFERENCES `Streaming_Service_for_independent_films`.`filmmaker` (`filmmaker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Streaming_Service_for_independent_films`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`subscription` (
  `subscription_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `plan_type` VARCHAR(50) NULL,
  `price` DECIMAL(6,2) NULL,
  PRIMARY KEY (`subscription_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_subscription_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `Streaming_Service_for_independent_films`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `amount` DECIMAL(6,2) NULL,
  `payment_date` DATE NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_payment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `Streaming_Service_for_independent_films`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming_Service_for_independent_films`.`ViewingHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming_Service_for_independent_films`.`ViewingHistory` (
  `history_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `film_id` INT NULL,
  `watch_date` DATETIME NULL,
  PRIMARY KEY (`history_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `film_id_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `FK_history_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `Streaming_Service_for_independent_films`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_history_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `Streaming_Service_for_independent_films`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
