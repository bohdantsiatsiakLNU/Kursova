create database if not exists flight_control;

use flight_control;

CREATE TABLE IF NOT EXISTS `invoice` (
	`invoice_id` int AUTO_INCREMENT NOT NULL,
	`passenger_id` int NOT NULL,
	`billing_date` datetime NOT NULL,
	`i_status` ENUM('Оплачено', 'Очікує') NOT NULL,
	PRIMARY KEY (`invoice_id`)
);

CREATE TABLE IF NOT EXISTS `flight` (
	`flight_number` varchar(10) NOT NULL,
	`airline_iata` varchar(3) NOT NULL,
	`departure_airport` varchar(3) NOT NULL,
	`arrival_airport` varchar(3) NOT NULL,
	`departure_time` time NOT NULL,
	`departure_date` date NOT NULL,
	`arrival_time` time NOT NULL,
	`arrival_date` date NOT NULL,
	`duration` varchar(20) NOT NULL,
	`f_status` varchar(20) NOT NULL,
	PRIMARY KEY (`flight_number`)
);

CREATE TABLE IF NOT EXISTS `airport` (
	`airport_iata` varchar(3) NOT NULL,
	`airport_icao` varchar(4) NOT NULL,
	`name` int NOT NULL,
	`country` varchar(100) NOT NULL,
	`city` varchar(100) NOT NULL,
	PRIMARY KEY (`airport_iata`)
);

CREATE TABLE IF NOT EXISTS `ticket` (
	`ticket_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`flight_number` varchar(10) NOT NULL,
	`invoice_id` int,
	`seat` varchar(10),
	`price` float NOT NULL,
	`t_class` varchar(11) NOT NULL,
	`t_status` varchar(20),
	`first_name_en` varchar(255),
	`last_name_en` varchar(255),
	`phone` int,
	PRIMARY KEY (`ticket_id`)
);

CREATE TABLE IF NOT EXISTS `passenger` (
	`passenger_id` int AUTO_INCREMENT NOT NULL,
	`first_name_ua` varchar(30) NOT NULL,
	`last_name_ua` varchar(30) NOT NULL,
	`email` varchar(100) NOT NULL,
	`password` varchar(255) NOT NULL,
	PRIMARY KEY (`passenger_id`)
);

CREATE TABLE IF NOT EXISTS `airline` (
	`airline_iata` varchar(3) NOT NULL,
	`name` varchar(100) NOT NULL,
	`icao_code` varchar(3) NOT NULL,
	PRIMARY KEY (`airline_iata`)
);

ALTER TABLE `invoice` ADD CONSTRAINT `invoice_fk1` FOREIGN KEY (`passenger_id`) REFERENCES `passenger`(`passenger_id`);
ALTER TABLE `flight` ADD CONSTRAINT `flight_fk1` FOREIGN KEY (`airline_iata`) REFERENCES `airline`(`airline_iata`);

ALTER TABLE `flight` ADD CONSTRAINT `flight_fk2` FOREIGN KEY (`departure_airport`) REFERENCES `airport`(`airport_iata`);

ALTER TABLE `flight` ADD CONSTRAINT `flight_fk3` FOREIGN KEY (`arrival_airport`) REFERENCES `airport`(`airport_iata`);

ALTER TABLE `ticket` ADD CONSTRAINT `ticket_fk1` FOREIGN KEY (`flight_number`) REFERENCES `flight`(`flight_number`);

ALTER TABLE `ticket` ADD CONSTRAINT `ticket_fk2` FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`invoice_id`);

