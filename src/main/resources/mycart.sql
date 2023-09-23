/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.0.21 : Database - mycart
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mycart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mycart`;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryDescription` varchar(255) DEFAULT NULL,
  `categoryTitle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `category` */

insert  into `category`(`categoryId`,`categoryDescription`,`categoryTitle`) values 
(1,'testpls','Pork'),
(5,'Laptop','Chicken'),
(6,'We\'ve travelled from Japan to Thailand, India to Indonesia, to find the best sweet recipes from all across the continent and bring it into our restaurant cuisine.','Dessert'),
(7,'Vegan options are now available! :) Our focus relies on plant-based ingredients such as seasonal exotic fruits and vegetables, nuts, seeds, and grains.','Vegan'),
(9,'TODO','Seafood'),
(12,'test','testcat');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `pId` int NOT NULL AUTO_INCREMENT,
  `pDesc` varchar(3000) DEFAULT NULL,
  `pDiscount` int NOT NULL,
  `pName` varchar(255) DEFAULT NULL,
  `pPhoto` varchar(255) DEFAULT NULL,
  `pPrice` int NOT NULL,
  `pQuantity` int NOT NULL,
  `category_categoryId` int DEFAULT NULL,
  PRIMARY KEY (`pId`),
  KEY `FK825v7lftk50hyta3jlxerywcb` (`category_categoryId`),
  CONSTRAINT `FK825v7lftk50hyta3jlxerywcb` FOREIGN KEY (`category_categoryId`) REFERENCES `category` (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `product` */

insert  into `product`(`pId`,`pDesc`,`pDiscount`,`pName`,`pPhoto`,`pPrice`,`pQuantity`,`category_categoryId`) values 
(9,'Ingredients: Mango, tapioca pearls, milk, pudding',0,'Thai desert','menu-food2.png',8,0,6),
(10,'Ingredients: Wheat pasta, chilli peppers, mushrooms, sesame seeds.',0,'Vegeterian pasta','menu-food.png',6,2,7),
(11,'Ingredients: Wheat pasta, eggs, tomatoes, condiments.',0,'Oriental Pasta','menu-food3.png',10,0,7),
(14,'Ingredients: Pork meat, cooked rice, cucumbers, sweet bbq sauce.',0,'Stir fried pork','menu-food1.png',10,12,1),
(15,'Ingredients: Chicken, sesame seeds, lime, green onions, sweet bbq sauce.',20,'Chicken BBQ','menu-food4.png',12,10,5),
(16,'Ingredients: Shrimp, wheat, salad, lime.\r\nIt\'s really tasty with rice.',5,'Shrimp dumplings','menu-food5.png',15,12,9),
(17,'Ingredients: Chicken, pineapple, bell peppers, garlic, sweet bbq sauce.',5,'Chinese Pineapple Chicken','chicken-pineapple.jpg',6,12,5),
(20,'Ingredients: sliced meat, cabbage, egg cooked in broth that is kept boiling.',30,'Hot pot','cabbage-with-egg.jpg',22,1,1),
(24,'a',0,'ay','food 3.png',1,1,12);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `user_address` varchar(1500) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_lastname` varchar(100) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_password` varchar(100) DEFAULT NULL,
  `user_phone` varchar(12) DEFAULT NULL,
  `user_pic` varchar(1500) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK_2q4p7v0ke69f4s36ueyb2pe2k` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`user_id`,`date_of_birth`,`user_address`,`user_email`,`user_lastname`,`user_name`,`user_password`,`user_phone`,`user_pic`,`user_type`) values 
(1,'2023-08-17','dasd','asdsad@gmail.com','he coming','oh lawd','d6a9450dc08555d6ecfaf7162e5267f401e6dd9a','23123','default.jpg','admin')

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
