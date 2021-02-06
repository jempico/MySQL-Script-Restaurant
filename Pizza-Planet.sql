DROP DATABASE IF EXISTS pizza_planet;

CREATE DATABASE pizza_planet;
USE pizza_planet;

-- CREATING TABLES

-- Client Table
CREATE TABLE `client` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `surnames` varchar(45),
  `address` varchar(100),
  `postal_code` varchar(9),
  `phone` varchar(12),
  `id_city` int
);

-- Order Table
CREATE TABLE `order` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `registration_date`  DATETIME NOT NULL
                DEFAULT CURRENT_TIMESTAMP,
  `type` enum('delivery', 'take-away'),
  `total_price` float,
  `delivery_date` DATETIME NOT NULL
                DEFAULT CURRENT_TIMESTAMP, 
  `id_client` int,
  `id_restaurant` int,
`id_driver_license` varchar(10)
);

-- Product Table
CREATE TABLE `product` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(25),
  `description` varchar(255),
  `picture` varchar(255),
  `price` float,
  `id_product_type` int,
  `id_product_category` int
);

-- Product_category Table
CREATE TABLE `product_category` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(25)
);

-- Product_type Table
CREATE TABLE `product_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` enum('pizza', 'burger', 'beverages')
);

-- Restaurant Table
CREATE TABLE `restaurant` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `address` varchar(100),
  `postal_code` varchar(9),
  `id_city` int
);

-- Employees Table
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

-- Driver Table
CREATE TABLE `driver` (
  `license` varchar(10) PRIMARY KEY,
  `id_employee` int UNIQUE
);

-- City Table
CREATE TABLE `city` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25),
  `id_province` int
);

-- Province Table
CREATE TABLE `province` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25)
);

-- Order_item Table
CREATE TABLE `order_item` (
  `id_product` int NOT NULL,
  `id_order` int,
  `quantity` int DEFAULT 1,
  `unit_price` float,
  PRIMARY KEY (`id_product`, `id_order`)
);


-- ASSIGNING FOREING KEYS

ALTER TABLE `order` ADD FOREIGN KEY (`id_client`) REFERENCES `client` (`id`);

ALTER TABLE `order` ADD FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`);

ALTER TABLE `client` ADD FOREIGN KEY (`id_city`) REFERENCES `city` (`id`);

ALTER TABLE `city` ADD FOREIGN KEY (`id_province`) REFERENCES `province` (`id`);

ALTER TABLE `order_item` ADD FOREIGN KEY (`id_order`) REFERENCES `order` (`id`);

ALTER TABLE `order_item` ADD FOREIGN KEY (`id_product`) REFERENCES `product` (`id`);

ALTER TABLE `product` ADD FOREIGN KEY (`id_product_type`) REFERENCES `product_type` (`id`);

ALTER TABLE `product` ADD FOREIGN KEY (`id_product_category`) REFERENCES `product_category` (`id`);

ALTER TABLE `restaurant` ADD FOREIGN KEY (`id_city`) REFERENCES `city` (`id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`);

ALTER TABLE `driver` ADD FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id`);


-- INSERTING DATA

-- Province table
INSERT INTO province(name) VALUES ('San Francisco'), ('Pensilvania');

-- City table
INSERT INTO city(name, id_province) VALUES ('Sillicon Valey', 1), ('Scrancton', 2);

-- Restaurant table
INSERT INTO restaurant(address, postal_code, id_city) VALUES('108-4905 Felis. Rd.', 98110, 1),('3064 Tincidunt Road', 26101, 2);


-- Client table

INSERT INTO client(name, surnames, address, postal_code, phone, id_city) VALUES
('Michael', 'Scott', '123 Ventura Blvd', 21010, '1-3184892710', 1 ),
('Dwight', 'Schrute', '398 Ridiculus Rd.', 96075, '1-9854426979', 2 ),
('Pam', 'Beesley', 'Ap #234-5298 Feugiat St.', 42389, '1-9603313780', 2 ),
('Kelly', 'Kapoor', 'P.O. Box 769, 8917 A Ave', 89039, '1-8761337240', 2 ),
('Jim', 'Halpert', '1683 Natoque Av.', 86682, '1-7244767412', 2 ),
('Andy', 'Bernard', '7011 Auctor St.', 48227, '1-9158269416', 2 ),
('Stanley', 'Hudson', '2899 Pellentesque Street', 25454, '1-4752379086', 2 );
 
 
-- Employee table

INSERT INTO employees(name, nif, telf, role, id_restaurant) VALUES
('Richard','3546785R', '1-6949094306', 'chef', 1),
('Dinesh', '3546785D','1-6949065306', 'driver', 1),
('Gilfoyle', '3546785G','1-6329065306', 'driver', 1),
('Jian-Yang', '3546785J','1-6323865306', 'driver', 2),
('Big Head', '3546785b','1-6329011106', 'chef', 2);


-- Driver table
INSERT INTO driver(license, id_employee) VALUES('DRI001A', 2), ('DRI123B', 3), ('DRI456C', 4);

-- Product_category table
INSERT INTO product_category(name) VALUES ('Classic'), ('Veggies'), ('Custom');

-- Product_type table
INSERT INTO product_type (name) VALUES ('pizza'), ('burger'),('beverages');


-- Product table [inserting pizzas]

INSERT INTO product(name, description, picture, price, id_product_type, id_product_category) VALUES
('Hawaiian Chiken', 'Hawaiian Chicken PizzaSmoked', 'https://unsplash.com/photos/MqT0asuoIcU', 9.15, 1, 1),
('4 seasons', '4 ingredients of your own choice', 'https://unsplash.com/photos/Ae7jQFDTPk4', 12.15, 1, 3),
('Veggilicious', 'Red pepper, onion, kale and vegan cheese', 'https://unsplash.com/photos/UxRhrU8fPHQ', 9.15, 1, 2);


-- Product table [inserting other products]

INSERT INTO product(name, description, picture, price, id_product_type) 
VALUES ('Tonkatsu', 'Fried chiken, ruculla, red pepper and double cheese', 'https://unsplash.com/photos/SfGqLZ_GFXQ', 13.15, 2),
('Cheeseburger', 'Beef meat, cheese, lettuce and tomato', 'https://unsplash.com/photos/9G_oJBKwi1c', 11.15, 2),
('Zero Kombucha', 'Natural fermeted Kombucha', 'https://unsplash.com/photos/--Sg2CuaM2A', 5.25, 3);


-- ORDER #1

INSERT INTO pizza_planet.order(type, id_client, id_restaurant) VALUES ('delivery', 1, 1 );

INSERT INTO order_item(id_product, id_order, quantity, unit_price) VALUES
	(5, LAST_INSERT_ID(), 2, 11.15),
	(6, LAST_INSERT_ID(), 2, 5.25);

UPDATE pizza_planet.order SET total_price = 
		(SELECT SUM(unit_price * quantity) 
        FROM order_item
		WHERE id_order = LAST_INSERT_ID())
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET id_driver_license = 'DRI001A'
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET delivery_date = CURRENT_TIMESTAMP
WHERE id = LAST_INSERT_ID();


-- ORDER #2

INSERT INTO pizza_planet.order(type, id_client, id_restaurant) VALUES ('delivery', 3, 2 );

INSERT INTO order_item(id_product, id_order, quantity, unit_price) VALUES
	(1, LAST_INSERT_ID(), 2, 9.15),
	(2, LAST_INSERT_ID(), 2, 12.15);

UPDATE pizza_planet.order SET total_price = 
		(SELECT SUM(unit_price * quantity) 
        FROM order_item
		WHERE id_order = LAST_INSERT_ID())
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET id_driver_license = 'DRI123B'
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET delivery_date = CURRENT_TIMESTAMP
WHERE id = LAST_INSERT_ID();


-- ORDER #3

INSERT INTO pizza_planet.order(type, id_client, id_restaurant) VALUES ('delivery', 4, 2 );

INSERT INTO order_item(id_product, id_order, quantity, unit_price) VALUES
	(4, LAST_INSERT_ID(), 1, 13.15),
	(5, LAST_INSERT_ID(), 1, 11.15);

UPDATE pizza_planet.order SET total_price = 
		(SELECT SUM(unit_price * quantity) 
        FROM order_item
		WHERE id_order = LAST_INSERT_ID())
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET id_driver_license = 'DRI456C'
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET delivery_date = CURRENT_TIMESTAMP
WHERE id = LAST_INSERT_ID();


-- ORDER #4

INSERT INTO pizza_planet.order(type, id_client, id_restaurant) VALUES ('delivery', 5, 2 );

INSERT INTO order_item(id_product, id_order, quantity, unit_price) VALUES
	(4, LAST_INSERT_ID(), 1, 13.15);

UPDATE pizza_planet.order SET total_price = 
		(SELECT SUM(unit_price * quantity) 
        FROM order_item
		WHERE id_order = LAST_INSERT_ID())
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET id_driver_license = 'DRI456C'
WHERE id = LAST_INSERT_ID();

UPDATE pizza_planet.order SET delivery_date = CURRENT_TIMESTAMP
WHERE id = LAST_INSERT_ID();


-- ORDER #5

INSERT INTO pizza_planet.order(type, id_client, id_restaurant) VALUES ('take-away', 5, 2 );

INSERT INTO order_item(id_product, id_order, quantity, unit_price) VALUES
	(4, LAST_INSERT_ID(), 1, 13.15);

UPDATE pizza_planet.order SET total_price = 
		(SELECT SUM(unit_price * quantity) 
        FROM order_item
		WHERE id_order = LAST_INSERT_ID())
WHERE id = LAST_INSERT_ID();


SELECT * FROM pizza_planet.order;
