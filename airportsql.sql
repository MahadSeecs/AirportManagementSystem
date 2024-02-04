-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AirportProject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AirportProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AirportProject` DEFAULT CHARACTER SET utf8 ;
USE `AirportProject` ;

-- -----------------------------------------------------
-- Table `AirportProject`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Airline` (
  `AirlineIATA` VARCHAR(10) NOT NULL,
  `AirlineName` VARCHAR(45) NULL,
  `BasedIn` VARCHAR(45) NULL,
  `Rating_10` FLOAT NULL,
  `DealsIn` VARCHAR(45) NULL,
  PRIMARY KEY (`AirlineIATA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Aircraft`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Aircraft` (
  `RegistrationNumber` VARCHAR(10) NOT NULL,
  `OwnerAirlineIATA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`RegistrationNumber`),
  INDEX `fk_Aircraft_Airline1_idx` (`OwnerAirlineIATA` ASC) VISIBLE,
  CONSTRAINT `fk_Aircraft_Airline1`
    FOREIGN KEY (`OwnerAirlineIATA`)
    REFERENCES `AirportProject`.`Airline` (`AirlineIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Flight` (
  `FlightID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`FlightID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`CabinCrew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`CabinCrew` (
  `CrewID` VARCHAR(10) NOT NULL,
  `WorksForAirlineIATA` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `DateOfBirth` VARCHAR(45) NULL,
  `Origin` VARCHAR(45) NULL,
  `Designation` VARCHAR(45) NULL,
  PRIMARY KEY (`CrewID`),
  INDEX `fk_CabinCrew_Airline1_idx` (`WorksForAirlineIATA` ASC) VISIBLE,
  CONSTRAINT `fk_CabinCrew_Airline1`
    FOREIGN KEY (`WorksForAirlineIATA`)
    REFERENCES `AirportProject`.`Airline` (`AirlineIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Pilots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Pilots` (
  `PilotID` VARCHAR(10) NOT NULL,
  `WorksInAirlineIATA` VARCHAR(10) NOT NULL,
  `PilotName` VARCHAR(45) NULL,
  `DateOfBirth` VARCHAR(45) NULL,
  `Origin` VARCHAR(45) NULL,
  `JoinedInDate` VARCHAR(45) NULL,
  `Desgination` VARCHAR(45) NULL,
  PRIMARY KEY (`PilotID`),
  INDEX `fk_Pilots_Airline1_idx` (`WorksInAirlineIATA` ASC) VISIBLE,
  CONSTRAINT `fk_Pilots_Airline1`
    FOREIGN KEY (`WorksInAirlineIATA`)
    REFERENCES `AirportProject`.`Airline` (`AirlineIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Passengers` (
  `PassportNumber` VARCHAR(25) NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `DateofBirth` VARCHAR(45) NULL,
  `Gender` VARCHAR(10) NULL,
  `OriginCity` VARCHAR(45) NULL,
  `OriginCountry` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `PhoneNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`PassportNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Ticket` (
  `TicketNumber` VARCHAR(10) NOT NULL,
  `FlightID` VARCHAR(10) NOT NULL,
  `PassportNumber` VARCHAR(25) NOT NULL,
  `Class` VARCHAR(20) NULL,
  `SeatNumber` VARCHAR(10) NULL,
  `Disability?` VARCHAR(10) NULL,
  PRIMARY KEY (`TicketNumber`),
  INDEX `fk_Ticket_Flight1_idx` (`FlightID` ASC) VISIBLE,
  INDEX `fk_Ticket_Passengers1_idx` (`PassportNumber` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_Flight1`
    FOREIGN KEY (`FlightID`)
    REFERENCES `AirportProject`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Passengers1`
    FOREIGN KEY (`PassportNumber`)
    REFERENCES `AirportProject`.`Passengers` (`PassportNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Luggage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Luggage` (
  `TicketNumber` VARCHAR(10) NOT NULL,
  `LuggagePieces` INT NULL,
  `TotalWeight` FLOAT NULL,
  `ExcessLuggageCost` FLOAT NULL,
  PRIMARY KEY (`TicketNumber`),
  CONSTRAINT `fk_Luggage_Ticket1`
    FOREIGN KEY (`TicketNumber`)
    REFERENCES `AirportProject`.`Ticket` (`TicketNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`AircraftHealthStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`AircraftHealthStatus` (
  `RegistrationNumber` VARCHAR(10) NOT NULL,
  `LeftEngineCondition` VARCHAR(20) NULL,
  `RightEngineCondition` VARCHAR(20) NULL,
  `FuselageCondition` VARCHAR(20) NULL,
  `LandingGearCondition` VARCHAR(20) NULL,
  `FlapCondition` VARCHAR(20) NULL,
  `OverallStatus` VARCHAR(20) NULL,
  PRIMARY KEY (`RegistrationNumber`),
  CONSTRAINT `fk_AircraftStatus&Info_Aircraft1`
    FOREIGN KEY (`RegistrationNumber`)
    REFERENCES `AirportProject`.`Aircraft` (`RegistrationNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`AircraftModel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`AircraftModel` (
  `ModelNameID` VARCHAR(10) NOT NULL,
  `RegistrationNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ModelNameID`),
  INDEX `fk_AircraftModel_Aircraft1_idx` (`RegistrationNumber` ASC) VISIBLE,
  CONSTRAINT `fk_AircraftModel_Aircraft1`
    FOREIGN KEY (`RegistrationNumber`)
    REFERENCES `AirportProject`.`Aircraft` (`RegistrationNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`AircraftModelInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`AircraftModelInformation` (
  `ModelNameID` VARCHAR(10) NOT NULL,
  `Manufacturer` VARCHAR(45) NULL,
  `Purpose` VARCHAR(45) NULL,
  `ManufacturedIn` VARCHAR(45) NULL,
  `SeatingCapacity` VARCHAR(45) NULL,
  `LuggageWeight` VARCHAR(45) NULL,
  `CrossSection` VARCHAR(45) NULL,
  `Price` VARCHAR(45) NULL,
  PRIMARY KEY (`ModelNameID`),
  CONSTRAINT `fk_AircraftModelInformation_AircraftModel1`
    FOREIGN KEY (`ModelNameID`)
    REFERENCES `AirportProject`.`AircraftModel` (`ModelNameID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Airport` (
  `AirportIATA` VARCHAR(10) NOT NULL,
  `BasedInCity` VARCHAR(45) NULL,
  `BasedInCountry` VARCHAR(45) NULL,
  `MaximumCapacity_People` VARCHAR(45) NULL,
  `MaximumCapacity_Planes` VARCHAR(45) NULL,
  `NumberOfRunways` VARCHAR(45) NULL,
  `AirportAuthority` VARCHAR(45) NULL,
  `DisabilityFriendly?` VARCHAR(3) NULL,
  `Rating_10` VARCHAR(45) NULL,
  PRIMARY KEY (`AirportIATA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Arrivals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Arrivals` (
  `FlightID` VARCHAR(10) NOT NULL,
  `AirlineIATA` VARCHAR(10) NOT NULL,
  `ArrivalTime` TIME NULL,
  `AirportIATA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`FlightID`, `AirlineIATA`, `AirportIATA`),
  INDEX `fk_Arrivals_Airline1_idx` (`AirlineIATA` ASC) VISIBLE,
  INDEX `fk_Arrivals_Airport1_idx` (`AirportIATA` ASC) VISIBLE,
  CONSTRAINT `fk_Arrivals_Flight1`
    FOREIGN KEY (`FlightID`)
    REFERENCES `AirportProject`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arrivals_Airline1`
    FOREIGN KEY (`AirlineIATA`)
    REFERENCES `AirportProject`.`Airline` (`AirlineIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arrivals_Airport1`
    FOREIGN KEY (`AirportIATA`)
    REFERENCES `AirportProject`.`Airport` (`AirportIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Departures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Departures` (
  `FlightID` VARCHAR(10) NOT NULL,
  `AirlineIATA` VARCHAR(10) NOT NULL,
  `DepartureTime` TIME NULL,
  `AirportIATA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`FlightID`, `AirlineIATA`, `AirportIATA`),
  INDEX `fk_Departures_Airline1_idx` (`AirlineIATA` ASC) VISIBLE,
  INDEX `fk_Departures_Airport1_idx` (`AirportIATA` ASC) VISIBLE,
  CONSTRAINT `fk_Departures_Flight1`
    FOREIGN KEY (`FlightID`)
    REFERENCES `AirportProject`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Departures_Airline1`
    FOREIGN KEY (`AirlineIATA`)
    REFERENCES `AirportProject`.`Airline` (`AirlineIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Departures_Airport1`
    FOREIGN KEY (`AirportIATA`)
    REFERENCES `AirportProject`.`Airport` (`AirportIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`FlightinPlanewithCrew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`FlightinPlanewithCrew` (
  `FlightID` VARCHAR(10) NOT NULL,
  `Aircraft_RegistrationNumber` VARCHAR(10) NOT NULL,
  `PilotID` VARCHAR(10) NOT NULL,
  `CoPilotID` VARCHAR(10) NOT NULL,
  `HeadHostID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`FlightID`),
  INDEX `fk_CrewFliesPlane_Flight1_idx` (`FlightID` ASC) VISIBLE,
  INDEX `fk_CrewFliesPlane_Pilots1_idx` (`CoPilotID` ASC) VISIBLE,
  INDEX `fk_FlightinPlanewithCrew_Aircraft1_idx` (`Aircraft_RegistrationNumber` ASC) VISIBLE,
  INDEX `fk_FlightinPlanewithCrew_CabinCrew1_idx` (`HeadHostID` ASC) VISIBLE,
  CONSTRAINT `fk_PilotFliesPlane_Pilots1`
    FOREIGN KEY (`PilotID`)
    REFERENCES `AirportProject`.`Pilots` (`PilotID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CrewFliesPlane_Flight1`
    FOREIGN KEY (`FlightID`)
    REFERENCES `AirportProject`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CrewFliesPlane_Pilots1`
    FOREIGN KEY (`CoPilotID`)
    REFERENCES `AirportProject`.`Pilots` (`PilotID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FlightinPlanewithCrew_Aircraft1`
    FOREIGN KEY (`Aircraft_RegistrationNumber`)
    REFERENCES `AirportProject`.`Aircraft` (`RegistrationNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FlightinPlanewithCrew_CabinCrew1`
    FOREIGN KEY (`HeadHostID`)
    REFERENCES `AirportProject`.`CabinCrew` (`CrewID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`CabinCrewOnFlight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`CabinCrewOnFlight` (
  `FlightID` VARCHAR(10) NOT NULL,
  `CrewID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`FlightID`, `CrewID`),
  INDEX `fk_CabinCrewOnFlight_CabinCrew1_idx` (`CrewID` ASC) VISIBLE,
  CONSTRAINT `fk_CabinCrewOnFlight_Flight1`
    FOREIGN KEY (`FlightID`)
    REFERENCES `AirportProject`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CabinCrewOnFlight_CabinCrew1`
    FOREIGN KEY (`CrewID`)
    REFERENCES `AirportProject`.`CabinCrew` (`CrewID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`MealInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`MealInfo` (
  `MealName` VARCHAR(45) NOT NULL,
  `FoodManufacturer` VARCHAR(45) NULL,
  `Halal?` VARCHAR(10) NULL,
  `Vegetarian?` VARCHAR(10) NULL,
  `MealWeight` FLOAT NULL,
  `PiecesAvailable` INT NULL,
  PRIMARY KEY (`MealName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`WeatherCondition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`WeatherCondition` (
  `WeatherCategory` VARCHAR(45) NOT NULL,
  `Temperature(°C)` FLOAT NULL,
  `Humidity(g/m^3)` FLOAT NULL,
  `WindSpeed(km/h)` FLOAT NULL,
  PRIMARY KEY (`WeatherCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`RunwayDesciption`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`RunwayDesciption` (
  `RunwayType` VARCHAR(20) NOT NULL,
  `RunwayLength` FLOAT NULL,
  `RunwayTexture` VARCHAR(20) NULL,
  `NumberOfPlanes` INT NULL,
  `UseForWeatherCategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RunwayType`),
  INDEX `fk_RunwayDesciption_WeatherCondition1_idx` (`UseForWeatherCategory` ASC) VISIBLE,
  CONSTRAINT `fk_RunwayDesciption_WeatherCondition1`
    FOREIGN KEY (`UseForWeatherCategory`)
    REFERENCES `AirportProject`.`WeatherCondition` (`WeatherCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`Runway`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`Runway` (
  `RunwayNumber` INT NOT NULL,
  `RunwayType` VARCHAR(20) NOT NULL,
  `AirportIATA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`RunwayNumber`),
  INDEX `fk_Runway_RunwayDesciption1_idx` (`RunwayType` ASC) VISIBLE,
  INDEX `fk_Runway_Airport1_idx` (`AirportIATA` ASC) VISIBLE,
  CONSTRAINT `fk_Runway_RunwayDesciption1`
    FOREIGN KEY (`RunwayType`)
    REFERENCES `AirportProject`.`RunwayDesciption` (`RunwayType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Runway_Airport1`
    FOREIGN KEY (`AirportIATA`)
    REFERENCES `AirportProject`.`Airport` (`AirportIATA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`RepairEngineers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`RepairEngineers` (
  `EngineerID` VARCHAR(10) NOT NULL,
  `EngineerName` VARCHAR(45) NULL,
  `DateOfBirth` VARCHAR(45) NULL,
  `Origin` VARCHAR(45) NULL,
  `Designation` VARCHAR(45) NULL,
  `Expertise` VARCHAR(45) NULL,
  PRIMARY KEY (`EngineerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`RepairWarehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`RepairWarehouse` (
  `WarehouseNumber` VARCHAR(10) NOT NULL,
  `SupervisingEngineerID` VARCHAR(10) NOT NULL,
  `Capacity_Engineers` INT NULL,
  `Capacity_Planes` INT NULL,
  PRIMARY KEY (`WarehouseNumber`),
  INDEX `fk_RepairWarehouse_RepairEngineers1_idx` (`SupervisingEngineerID` ASC) VISIBLE,
  CONSTRAINT `fk_RepairWarehouse_RepairEngineers1`
    FOREIGN KEY (`SupervisingEngineerID`)
    REFERENCES `AirportProject`.`RepairEngineers` (`EngineerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`PlaneRepairInWarehouseByEngineers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`PlaneRepairInWarehouseByEngineers` (
  `WarehouseNumber` VARCHAR(10) NOT NULL,
  `AircraftRegistrationNumber` VARCHAR(10) NOT NULL,
  `EngineerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`WarehouseNumber`, `AircraftRegistrationNumber`),
  INDEX `fk_PlaneRepairInWarehouseByEngineers_RepairEngineers1_idx` (`EngineerID` ASC) VISIBLE,
  INDEX `fk_PlaneRepairInWarehouseByEngineers_Aircraft1_idx` (`AircraftRegistrationNumber` ASC) VISIBLE,
  CONSTRAINT `fk_PlaneRepairInWarehouse_RepairWarehouse1`
    FOREIGN KEY (`WarehouseNumber`)
    REFERENCES `AirportProject`.`RepairWarehouse` (`WarehouseNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlaneRepairInWarehouseByEngineers_RepairEngineers1`
    FOREIGN KEY (`EngineerID`)
    REFERENCES `AirportProject`.`RepairEngineers` (`EngineerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlaneRepairInWarehouseByEngineers_Aircraft1`
    FOREIGN KEY (`AircraftRegistrationNumber`)
    REFERENCES `AirportProject`.`Aircraft` (`RegistrationNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`MealForTicket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`MealForTicket` (
  `TicketNumber` VARCHAR(10) NOT NULL,
  `MealName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TicketNumber`, `MealName`),
  INDEX `fk_MealForTicket_Ticket1_idx` (`TicketNumber` ASC) VISIBLE,
  INDEX `fk_MealForTicket_MealInfo1_idx` (`MealName` ASC) VISIBLE,
  CONSTRAINT `fk_MealForTicket_Ticket1`
    FOREIGN KEY (`TicketNumber`)
    REFERENCES `AirportProject`.`Ticket` (`TicketNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MealForTicket_MealInfo1`
    FOREIGN KEY (`MealName`)
    REFERENCES `AirportProject`.`MealInfo` (`MealName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AirportProject`.`PlaneUsingRunway`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AirportProject`.`PlaneUsingRunway` (
  `FlightID` VARCHAR(10) NOT NULL,
  `Aircraft_RegistrationNumber` VARCHAR(10) NOT NULL,
  `RunwayNumber` INT NOT NULL,
  `AtAirportIATA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`FlightID`, `Aircraft_RegistrationNumber`, `RunwayNumber`, `AtAirportIATA`),
  INDEX `fk_PlaneUsingRunway_Aircraft1_idx` (`Aircraft_RegistrationNumber` ASC) VISIBLE,
  INDEX `fk_PlaneUsingRunway_Runway1_idx` (`RunwayNumber` ASC, `AtAirportIATA` ASC) VISIBLE,
  CONSTRAINT `fk_PlaneUsingRunway_Aircraft1`
    FOREIGN KEY (`Aircraft_RegistrationNumber`)
    REFERENCES `AirportProject`.`Aircraft` (`RegistrationNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlaneUsingRunway_Runway1`
    FOREIGN KEY (`RunwayNumber`)
    REFERENCES `AirportProject`.`Runway` (`RunwayNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
