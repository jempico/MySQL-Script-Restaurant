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
  `nom` varchar(25),
  `id_province` int
);

CREATE TABLE `province` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nom` varchar(25)
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

