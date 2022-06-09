CREATE DATABASE  IF NOT EXISTS `buyme` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buyme`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: buyme
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `user_email` varchar(100) NOT NULL,
  `type` enum('shirts','pants','shoes') NOT NULL,
  PRIMARY KEY (`user_email`,`type`),
  KEY `user_email_idx` (`user_email`),
  CONSTRAINT `user_email` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES ('user1@gmail.com','shirts'),('user1@gmail.com','pants'),('user1@gmail.com','shoes');
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction_posts`
--

DROP TABLE IF EXISTS `auction_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction_posts` (
  `aID` int NOT NULL,
  `close_time` time NOT NULL,
  `close_date` date NOT NULL,
  `increment` double NOT NULL,
  `initial_price` double NOT NULL,
  `current_price` double NOT NULL,
  `reserve_price` double DEFAULT NULL,
  `buyer_email` varchar(100) DEFAULT NULL,
  `seller_email` varchar(100) NOT NULL,
  `closed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`aID`),
  KEY `buyer_email, seller_email_idx` (`buyer_email`),
  KEY `seller_email_idx` (`seller_email`),
  CONSTRAINT `buyer_email` FOREIGN KEY (`buyer_email`) REFERENCES `user` (`email`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `seller_email` FOREIGN KEY (`seller_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction_posts`
--

LOCK TABLES `auction_posts` WRITE;
/*!40000 ALTER TABLE `auction_posts` DISABLE KEYS */;
INSERT INTO `auction_posts` VALUES (0,'08:00:00','2022-05-05',5,100,130,120,'user2@gmail.com','user1@gmail.com',1),(1,'08:00:00','2021-05-05',10,20,200,NULL,'user3@gmail.com','user1@gmail.com',1),(2,'09:00:00','2023-04-23',10,50,250,100,'user1@gmail.com','user2@gmail.com',NULL),(3,'17:55:00','2022-05-05',10,80,100,150,'user2@gmail.com','user2@gmail.com',0),(4,'18:05:00','2022-05-10',10,80,80,NULL,NULL,'user1@gmail.com',0),(5,'18:12:00','2022-05-10',5,90,90,150,NULL,'user2@gmail.com',0);
/*!40000 ALTER TABLE `auction_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `email` varchar(100) NOT NULL,
  `aID` int NOT NULL,
  `bidID` int NOT NULL,
  `maximum_bid` double DEFAULT NULL,
  `current_bid` double DEFAULT NULL,
  `starting_bid` double DEFAULT NULL,
  `increment` double DEFAULT NULL,
  `is_autobid` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`email`,`aID`,`bidID`),
  KEY `bid_ibfk_2` (`aID`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`aID`) REFERENCES `auction_posts` (`aID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES ('user1@gmail.com',2,73,500,230,NULL,NULL,NULL),('user1@gmail.com',2,47469,NULL,250,NULL,NULL,0),('user2@gmail.com',0,0,200,13,NULL,NULL,NULL),('user2@gmail.com',1,1,100,30,NULL,NULL,NULL),('user2@gmail.com',3,72542,NULL,100,NULL,NULL,0),('user3@gmail.com',1,10,100,50,0,0,0);
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `itemID` int NOT NULL,
  `aID` int NOT NULL,
  `item_name` varchar(20) NOT NULL,
  `item_type` enum('shirts','pants','shoes') NOT NULL,
  PRIMARY KEY (`itemID`,`aID`),
  KEY `aID_idx` (`aID`),
  CONSTRAINT `aID` FOREIGN KEY (`aID`) REFERENCES `auction_posts` (`aID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (0,0,'Levi Jeans','pants'),(1,1,'Rincon 2','shoes'),(2,2,'Air Jordan 1','shoes'),(3,3,'Polo','shirts'),(4,4,'Nikes','shoes'),(5,5,'Sweatpants','pants');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `qID` int NOT NULL,
  `question` varchar(200) NOT NULL,
  `answer` varchar(200) DEFAULT NULL,
  `user` varchar(20) NOT NULL,
  PRIMARY KEY (`qID`),
  KEY `question_poster_idx` (`user`),
  CONSTRAINT `question_poster` FOREIGN KEY (`user`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (0,'When will my order deliver?','2-4 weeks','user1@gmail.com'),(1,'Can I make a return?','null','user2@gmail.com');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffID` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `isAdmin` tinyint(1) DEFAULT '0',
  `isCR` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`staffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'admin@gmail.com','password','admin',1,0),(2,'staff1@gmail.com','password','staff1',0,1),(3,'staff2@gmail.com','password','staff2',0,1),(4,'abc','ghi','def',0,1);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `email` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('user1@gmail.com','user1','1234'),('user2@gmail.com','user2','1234'),('user3@gmail.com','user3','user3pass');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-08 17:41:44
