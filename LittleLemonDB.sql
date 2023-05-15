-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customerdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customerdetails` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(255) NOT NULL,
  `contact_details` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `booking_id` INT NOT NULL,
  `booking_date` DATE NOT NULL,
  `table_number` INT NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `bookings_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `littlelemondb`.`customerdetails` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menu` (
  `item_id` INT NOT NULL,
  `item_name` VARCHAR(255) NOT NULL,
  `item_type` ENUM('cuisine', 'starter', 'course', 'drink', 'dessert') NOT NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `order_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `quantity` INT NOT NULL,
  `total_cost` DECIMAL(10,2) NOT NULL,
  `booking_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `booking_id` (`booking_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `littlelemondb`.`bookings` (`booking_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orderdeliverystatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orderdeliverystatus` (
  `order_id` INT NOT NULL,
  `delivery_date` DATE NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `orderdeliverystatus_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `littlelemondb`.`orders` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staffinformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staffinformation` (
  `staff_id` INT NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
