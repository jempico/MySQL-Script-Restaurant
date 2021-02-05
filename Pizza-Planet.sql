DROP DATABASE IF EXISTS pizza_planet;

CREATE DATABASE pizza_planet;
USE pizza_planet;

CREATE TABLE `client` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `surnames` varchar(45),
  `address` varchar(100),
  `postal_code` varchar(9),
  `phone` varchar(12),
  `id_city` int
);

CREATE TABLE `order` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `registration_date` datetime,
  `type` enum('delivery', 'take-away'),
  `total_price` float,
  `id_client` int,
  `id_delivery_driver` int,
  `id_restaurant` int
);

CREATE TABLE `product` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(25),
  `description` varchar(255),
  `picture` varchar(255),
  `price` float,
  `id_product_type` int
);

CREATE TABLE `product_category` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(25)
);

CREATE TABLE `product_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` enum('pizza', 'burger', 'beverages'),
  `id_product_category` int DEFAULT null
);

CREATE TABLE `restaurant` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `address` varchar(100),
  `postal_code` varchar(9),
  `id_city` int
);

CREATE TABLE `employees` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(25),
  `surname1` varchar(25),
  `surname2` varchar(25),
  `nif` varchar(9),
  `telf` varchar(25),
  `role` enum('chef', 'driver'),
  `id_restaurant` int
);

CREATE TABLE `delivery_driver` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `delivery_date` datetime
);

CREATE TABLE `city` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25),
  `id_province` int
);


CREATE TABLE `province` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25)
);


CREATE TABLE `order_item` (
  `id_product` int NOT NULL AUTO_INCREMENT,
  `id_order` int,
  `quantity` int DEFAULT 1,
  `unit_price` float,
  PRIMARY KEY (`id_product`, `id_order`)
);

ALTER TABLE `order` ADD FOREIGN KEY (`id_client`) REFERENCES `client` (`id`);

ALTER TABLE `order` ADD FOREIGN KEY (`id_delivery_driver`) REFERENCES `delivery_driver` (`id`);

ALTER TABLE `order` ADD FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`);

ALTER TABLE `client` ADD FOREIGN KEY (`id_city`) REFERENCES `city` (`id`);

ALTER TABLE `city` ADD FOREIGN KEY (`id_province`) REFERENCES `province` (`id`);

ALTER TABLE `order_item` ADD FOREIGN KEY (`id_order`) REFERENCES `order` (`id`);

ALTER TABLE `order_item` ADD FOREIGN KEY (`id_product`) REFERENCES `product` (`id`);

ALTER TABLE `product` ADD FOREIGN KEY (`id_product_type`) REFERENCES `product_type` (`id`);

ALTER TABLE `product_type` ADD FOREIGN KEY (`id_product_category`) REFERENCES `product_category` (`id`);

ALTER TABLE `restaurant` ADD FOREIGN KEY (`id_city`) REFERENCES `city` (`id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`);

-- INSERTING DATA

INSERT INTO client(name, surnames, address, postal_code, phone) VALUES
('Michael', 'Scott', '123 Ventura Blvd', 21010, '1-3184892710' ),
('Dwight', 'Schrute', '398 Ridiculus Rd.', 96075, '1-9854426979' ),
('Pam', 'Beesley', 'Ap #234-5298 Feugiat St.', 42389, '1-9603313780' ),
('Kelly', 'Kapoor', 'P.O. Box 769, 8917 A Ave', 89039, '1-8761337240' ),
('Jim', 'Halpert', '1683 Natoque Av.', 86682, '1-7244767412' ),
('Andy', 'Bernard', '7011 Auctor St.', 48227, '1-9158269416' ),
('Stanley', 'Hudson', '2899 Pellentesque Street', 25454, '1-4752379086' );
 
INSERT INTO province(name) VALUES ('San Francisco'), ('Pensilvania');
INSERT INTO city(name, id_province) VALUES ('Sillicon Valey', 1), ('Scrancton', 2);
 
UPDATE client SET id_city=2;
UPDATE client SET id_city=1 WHERE id=1;

INSERT INTO restaurant(address, postal_code, id_city) VALUES('108-4905 Felis. Rd.', 98110, 1);
INSERT INTO restaurant(address, postal_code, id_city) VALUES('3064 Tincidunt Road', 26101, 2);

INSERT INTO EMPLOYEES(name, nif, telf, role, id_restaurant) VALUES
('Richard','3546785R', '1-6949094306', 'chef', 1),
('Dinesh', '3546785D','1-6949065306', 'driver', 1),
('Gilfoyle', '3546785G','1-6329065306', 'driver', 1),
('Jian-Yang', '3546785J','1-6323865306', 'driver', 2),
('Big Head', '3546785b','1-6329011106', 'chef', 2);
