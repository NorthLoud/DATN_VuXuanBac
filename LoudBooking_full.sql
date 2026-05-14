CREATE DATABASE  IF NOT EXISTS `loud_hotel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `loud_hotel`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: loud_hotel
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Table structure for table `bill_details`
--

DROP TABLE IF EXISTS `bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_details` (
  `bill_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `guest_count` int DEFAULT NULL,
  `nights` int DEFAULT NULL,
  `price_at_booking` double DEFAULT NULL,
  `bill_id` bigint NOT NULL,
  `type_id` bigint NOT NULL,
  PRIMARY KEY (`bill_detail_id`),
  KEY `FKfwm4sko9p82ndh6belyxx12bj` (`bill_id`),
  KEY `FK4cvcod50iedw3lu7kuh000pht` (`type_id`),
  CONSTRAINT `FK4cvcod50iedw3lu7kuh000pht` FOREIGN KEY (`type_id`) REFERENCES `room_types` (`type_id`),
  CONSTRAINT `FKfwm4sko9p82ndh6belyxx12bj` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_details`
--

LOCK TABLES `bill_details` WRITE;
/*!40000 ALTER TABLE `bill_details` DISABLE KEYS */;
INSERT INTO `bill_details` VALUES (1,1,1,800000,1,47),(2,2,1,800000,1,47),(3,3,1,1800000,1,44),(4,4,1,1800000,2,44),(5,1,1,800000,2,47),(6,2,1,800000,2,47),(7,2,1,1800000,3,44),(8,2,1,800000,3,47),(9,1,1,800000,4,47),(10,1,2,1000000,5,1),(11,1,2,1000000,5,1),(12,1,2,1800000,5,2);
/*!40000 ALTER TABLE `bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_extra_fees`
--

DROP TABLE IF EXISTS `bill_extra_fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_extra_fees` (
  `extra_fee_id` bigint NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_paid` bit(1) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `bill_id` bigint NOT NULL,
  PRIMARY KEY (`extra_fee_id`),
  KEY `FK23o4nten0ovgbrrfi1b7y3lp7` (`bill_id`),
  CONSTRAINT `FK23o4nten0ovgbrrfi1b7y3lp7` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_extra_fees`
--

LOCK TABLES `bill_extra_fees` WRITE;
/*!40000 ALTER TABLE `bill_extra_fees` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_extra_fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `bill_id` bigint NOT NULL AUTO_INCREMENT,
  `actual_check_in_time` datetime(6) DEFAULT NULL,
  `actual_check_out_time` datetime(6) DEFAULT NULL,
  `bill_code` varchar(255) NOT NULL,
  `bill_status` enum('PENDING','PAID','CANCELED') DEFAULT NULL,
  `cancel_reason` enum('USER_CANCEL','HOTEL_CANCEL','NO_SHOW','VNPAY_CANCEL') DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id_card_code` varchar(255) DEFAULT NULL,
  `order_email` varchar(255) DEFAULT NULL,
  `order_name` varchar(255) DEFAULT NULL,
  `order_phone` varchar(255) DEFAULT NULL,
  `payment_method` enum('VNPAY','CASH') DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `vnp_transaction_no` varchar(255) DEFAULT NULL,
  `vnp_txn_ref` varchar(255) DEFAULT NULL,
  `hotel_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`bill_id`),
  UNIQUE KEY `UK_8li8r7cktrea79tpv6ewf9oc9` (`bill_code`),
  KEY `FK4hx4n4l70fxpftolai9gqi0wa` (`hotel_id`),
  KEY `FKk8vs7ac9xknv5xp18pdiehpp1` (`user_id`),
  CONSTRAINT `FK4hx4n4l70fxpftolai9gqi0wa` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`),
  CONSTRAINT `FKk8vs7ac9xknv5xp18pdiehpp1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,'2026-05-12 10:05:33.340076',NULL,'BLB2026051271467','PAID',NULL,'2026-05-12','2026-05-13','2026-05-12 10:02:35.613706','034204007199','bacvx@gmail.com','bac','0336500251','VNPAY',3400000,'2026-05-12 10:05:33.340076','15534302','32458bd1f31a4bb2b8eae8752a62f70e',8,12),(2,'2026-05-12 10:06:16.502858',NULL,'BLB2026051263450','PAID',NULL,'2026-05-12','2026-05-13','2026-05-12 10:04:47.349914','034204007199','bacvx@gmail.com','bac','0336500251','VNPAY',3400000,'2026-05-12 10:06:16.502858','15534311','6971181fb1894fc68a1201571e8073fb',8,12),(3,NULL,NULL,'BLB2026051252345','CANCELED','VNPAY_CANCEL','2026-05-12','2026-05-13','2026-05-12 10:07:00.647355','034204007199','bacvx@gmail.com','bac','0336500251','VNPAY',2600000,'2026-05-12 10:08:04.994369',NULL,'d13760972d9046bfbb9e9489704ae4e7',8,12),(4,NULL,NULL,'BLB2026051245985','PAID',NULL,'2026-05-12','2026-05-13','2026-05-12 10:10:22.813972','034204007199','bacvx@gmail.com','bac','0336500251','VNPAY',800000,'2026-05-12 10:11:11.480641','15534339','9cec0620a36249a898bb77d2cf76bdcc',8,12),(5,NULL,NULL,'BLB2026051222452','PAID',NULL,'2026-05-15','2026-05-17','2026-05-12 10:41:42.376031','034204007199','bacvx@gmail.com','bac','0336500251','VNPAY',7600000,'2026-05-12 10:42:06.642976','15534397','dba979a2c61b48c98dd775448ed22970',1,12);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_images`
--

DROP TABLE IF EXISTS `chat_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_images` (
  `image_id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `chat_id` bigint NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `FK5ylie1y7p0lnpgyfd0j0es3fw` (`chat_id`),
  CONSTRAINT `FK5ylie1y7p0lnpgyfd0j0es3fw` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_images`
--

LOCK TABLES `chat_images` WRITE;
/*!40000 ALTER TABLE `chat_images` DISABLE KEYS */;
INSERT INTO `chat_images` VALUES (1,'/images/chat/1778252264518_bida.jpg',3),(2,'/images/chat/1778252264525_gym1.jpg',3),(3,'/images/chat/1778252264527_h1.jpg',3),(4,'/images/chat/1778252264528_h1-1.jpg',3),(5,'/images/chat/1778252264530_h1-2.jpg',3);
/*!40000 ALTER TABLE `chat_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `chat_id` bigint NOT NULL AUTO_INCREMENT,
  `content_text` text,
  `created_at` datetime(6) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `is_edited` bit(1) DEFAULT NULL,
  `is_read` bit(1) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `recipient_id` bigint NOT NULL,
  `reply_to_id` bigint DEFAULT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `FK9usi9ip09s0x0km7gvcw6sarg` (`hotel_id`),
  KEY `FK66qywv3f3xheb6sk2vxu6vftb` (`recipient_id`),
  KEY `FK2eqcur5inlkv6fy4bjli9g46e` (`reply_to_id`),
  KEY `FKla7peq6fislsxok7a4wxv5p36` (`sender_id`),
  CONSTRAINT `FK2eqcur5inlkv6fy4bjli9g46e` FOREIGN KEY (`reply_to_id`) REFERENCES `chats` (`chat_id`),
  CONSTRAINT `FK66qywv3f3xheb6sk2vxu6vftb` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK9usi9ip09s0x0km7gvcw6sarg` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`),
  CONSTRAINT `FKla7peq6fislsxok7a4wxv5p36` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,'xin chào','2026-05-08 21:54:26.662497',_binary '\0',_binary '\0',_binary '','2026-05-08 21:58:17.398864',1,2,NULL,12),(2,'xin chào bạn','2026-05-08 21:54:45.515891',_binary '\0',_binary '\0',_binary '\0','2026-05-08 21:54:45.515891',2,3,NULL,12),(3,'','2026-05-08 21:57:44.541750',_binary '\0',_binary '\0',_binary '','2026-05-08 21:58:17.402874',1,2,NULL,12),(4,'ok bạn','2026-05-08 21:58:54.273892',_binary '\0',_binary '\0',_binary '','2026-05-08 21:58:58.712225',1,12,NULL,2),(5,'ok','2026-05-08 21:59:10.401085',_binary '\0',_binary '\0',_binary '','2026-05-08 21:59:26.762636',1,2,NULL,12);
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_images`
--

DROP TABLE IF EXISTS `hotel_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_images` (
  `image_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_main` bit(1) DEFAULT NULL,
  `hotel_id` bigint NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `FKrj3n45f8oqy1yr996g14j757i` (`hotel_id`),
  CONSTRAINT `FKrj3n45f8oqy1yr996g14j757i` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_images`
--

LOCK TABLES `hotel_images` WRITE;
/*!40000 ALTER TABLE `hotel_images` DISABLE KEYS */;
INSERT INTO `hotel_images` VALUES (1,'2026-05-08 09:49:07.206247','/images/hotels/863fd797-e4eb-4005-9d21-c7c3ad0096ec.jpg',_binary '',1),(2,'2026-05-08 09:49:07.214579','/images/hotels/29163775-a589-4319-96be-dbb2cd97e3a4.jpg',_binary '\0',1),(3,'2026-05-08 09:49:07.219645','/images/hotels/83eb939c-c4b1-40ed-b05c-0e491d57fc62.jpg',_binary '\0',1),(4,'2026-05-08 09:49:07.224631','/images/hotels/ae203ffb-c72d-47cb-8641-2e853591fd24.jpg',_binary '\0',1),(5,'2026-05-08 09:49:07.230031','/images/hotels/bc7e1b3d-4229-46c1-bb0f-be4bc283cb62.jpg',_binary '\0',1),(6,'2026-05-08 09:49:07.234890','/images/hotels/d053d25e-180e-4fc7-ad8e-ccdf122c0dc6.jpg',_binary '\0',1),(7,'2026-05-08 09:49:07.240372','/images/hotels/5a470522-3b8e-4ac8-ae87-4a33f818ff03.jpg',_binary '\0',1),(8,'2026-05-08 09:49:07.243871','/images/hotels/69dea639-c9dc-42d4-81f3-28330d286c75.jpg',_binary '\0',1),(9,'2026-05-08 09:49:07.249539','/images/hotels/5d5b365d-e3c3-4b20-9859-a22d8da6b4ed.jpg',_binary '\0',1),(10,'2026-05-08 09:49:07.254555','/images/hotels/f08f3225-0621-419e-ad6b-71d67c342695.jpg',_binary '\0',1),(11,'2026-05-08 09:49:07.258683','/images/hotels/2151542d-0420-46d8-955a-a039c5e35e96.jpg',_binary '\0',1),(12,'2026-05-08 09:49:07.264503','/images/hotels/33f654fe-6bcc-4615-9534-8110e4db0fdc.jpg',_binary '\0',1),(13,'2026-05-08 09:49:07.269054','/images/hotels/44c52060-8d83-4783-8848-c4adb7609bc4.jpg',_binary '\0',1),(14,'2026-05-08 09:49:07.274061','/images/hotels/f6968a82-dfce-43a1-bb8f-5c9cff253fa6.jpg',_binary '\0',1),(15,'2026-05-08 09:49:07.280050','/images/hotels/c8d307b5-4b2c-4f8e-bb39-7fdb822745cf.jpg',_binary '\0',1),(16,'2026-05-08 09:49:07.285221','/images/hotels/471c7a8e-21a7-40f6-9af3-540d893cd8b3.jpg',_binary '\0',1),(17,'2026-05-08 10:06:01.677773','/images/hotels/491eb5e9-07af-406e-8c56-8f15e8fc71a2.jpg',_binary '\0',2),(18,'2026-05-08 10:06:01.682280','/images/hotels/207d1282-8492-4a95-ba3f-24d573ac0bd5.jpg',_binary '\0',2),(19,'2026-05-08 10:06:01.686943','/images/hotels/44ea051f-73dc-4b15-8e6a-ccba2fadf21c.jpg',_binary '',2),(20,'2026-05-08 10:06:01.690778','/images/hotels/6259c5af-eb7c-4266-8d93-fe38979e916a.jpg',_binary '\0',2),(21,'2026-05-08 10:06:01.696245','/images/hotels/2dee32e1-d6ac-4677-bb19-aeb07b89c6bc.jpg',_binary '\0',2),(22,'2026-05-08 10:06:01.700466','/images/hotels/24941491-0ddc-47ea-bcf1-e56b8447e922.jpg',_binary '\0',2),(23,'2026-05-08 10:06:01.704758','/images/hotels/53509f5c-5870-44cd-9d75-4b2e9d6ae593.jpg',_binary '\0',2),(40,'2026-05-08 10:26:45.741750','/images/hotels/bc98395b-7671-471f-928f-f6e61ce300e5.jpg',_binary '',4),(41,'2026-05-08 10:26:45.746741','/images/hotels/83d56fec-f78c-40f2-9104-d0f9f43dddad.jpg',_binary '\0',4),(42,'2026-05-08 10:26:45.751382','/images/hotels/247257ac-d82b-47ba-8349-291a6f2e7b06.jpg',_binary '\0',4),(43,'2026-05-08 10:26:45.756189','/images/hotels/0ac98fed-5fca-47ed-96d7-45b81b18d9d6.jpg',_binary '\0',4),(44,'2026-05-08 10:26:45.759761','/images/hotels/902072c0-0626-4d97-96df-a6df6c1ca503.jpg',_binary '\0',4),(45,'2026-05-08 10:26:45.764506','/images/hotels/9b422beb-60d8-4f37-b53e-edb3aa4f5170.jpg',_binary '\0',4),(46,'2026-05-08 10:26:45.769240','/images/hotels/3784aeea-71f8-4394-bc97-62fc19fdbbc9.jpg',_binary '\0',4),(47,'2026-05-08 10:26:45.773434','/images/hotels/573e3073-b39d-47a3-954d-bedcf5eec14a.jpg',_binary '\0',4),(48,'2026-05-08 10:26:45.779802','/images/hotels/52a3b3e6-ba30-4d4f-a8cb-98d560393e10.jpg',_binary '\0',4),(49,'2026-05-08 10:26:45.783453','/images/hotels/01548eae-491e-49ab-a8a9-752c2f3833c4.jpg',_binary '\0',4),(50,'2026-05-08 10:26:45.787864','/images/hotels/e4293cf7-9010-464e-b655-1b367abbbb6b.jpg',_binary '\0',4),(51,'2026-05-08 10:26:45.791883','/images/hotels/a52d353e-3295-4d89-bffd-53034ecda846.jpg',_binary '\0',4),(52,'2026-05-08 10:26:45.796744','/images/hotels/b0b66877-f73a-47b1-883a-82e911005b76.jpg',_binary '\0',4),(53,'2026-05-08 10:26:45.800674','/images/hotels/fa4c6fdc-7cc4-452f-8bb5-428a1304260b.jpg',_binary '\0',4),(54,'2026-05-08 10:36:52.128485','/images/hotels/79989278-a86d-430d-9748-b548557b1822.jpg',_binary '',5),(55,'2026-05-08 10:36:52.132925','/images/hotels/093f8892-75b9-4a34-9c6c-839d6b9f1e60.jpg',_binary '\0',5),(56,'2026-05-08 10:36:52.137214','/images/hotels/44c0e73e-d947-4a0a-8556-c207a77a8f12.jpg',_binary '\0',5),(57,'2026-05-08 10:36:52.141106','/images/hotels/1e8c0990-2cf2-460f-9aed-145f9109662b.jpg',_binary '\0',5),(58,'2026-05-08 10:36:52.144734','/images/hotels/215358b3-64f8-4225-85c5-eeea5d1d2fa3.jpg',_binary '\0',5),(59,'2026-05-08 10:36:52.148054','/images/hotels/63e00247-c418-49c5-ae45-5963dc15074e.jpg',_binary '\0',5),(60,'2026-05-08 10:36:52.151785','/images/hotels/a13bfa23-3f46-440e-a8c4-13ade5968d8d.jpg',_binary '\0',5),(61,'2026-05-08 10:36:52.156202','/images/hotels/9edb3191-01a7-4c04-bb97-d60a37951e50.jpg',_binary '\0',5),(62,'2026-05-08 10:36:52.159493','/images/hotels/1d638dbe-01c6-43ad-82c0-1eb6828c897c.jpg',_binary '\0',5),(63,'2026-05-08 10:36:52.163458','/images/hotels/1aacdda0-3952-4eb5-aaa7-be453f599ffa.jpg',_binary '\0',5),(64,'2026-05-08 10:36:52.167025','/images/hotels/8e2789d4-6eeb-4d54-a816-3b9b86567441.jpg',_binary '\0',5),(65,'2026-05-08 10:36:52.169993','/images/hotels/0b73b920-d981-40b5-bf71-0610095acdf3.jpg',_binary '\0',5),(66,'2026-05-08 10:36:52.173449','/images/hotels/f41b1342-a954-4549-91f3-e3a86544255e.jpg',_binary '\0',5),(67,'2026-05-08 10:38:17.072894','/images/hotels/ae0fdef0-ae06-48a6-a698-720fc0f7567b.jpg',_binary '\0',2),(68,'2026-05-08 10:38:17.077434','/images/hotels/adb08e4a-328c-4822-9341-a76f5749019b.jpg',_binary '\0',2),(69,'2026-05-08 10:38:17.081315','/images/hotels/9a805dd9-adcf-4d1e-94c3-c75bebb4cf9d.jpg',_binary '\0',2),(70,'2026-05-08 10:38:17.085195','/images/hotels/6ea4e702-6146-4c37-ba4a-c70d185cc852.jpg',_binary '\0',2),(86,'2026-05-08 11:56:01.406766','/images/hotels/2fed683d-0b2c-4f85-90de-7d7479dd749d.jpg',_binary '',7),(87,'2026-05-08 11:56:01.413463','/images/hotels/cc2ff98e-7497-456b-a661-75479420f7ae.jpg',_binary '\0',7),(88,'2026-05-08 11:56:01.418611','/images/hotels/2043cdcb-3ee9-4fd8-95d3-d64b08bd3814.jpg',_binary '\0',7),(89,'2026-05-08 11:56:01.423757','/images/hotels/b976a078-53d7-4ff8-9ee1-aef772e1fe0f.jpg',_binary '\0',7),(90,'2026-05-08 11:56:01.428224','/images/hotels/9d0c498d-ab95-4773-bdac-fd9205f3082e.jpg',_binary '\0',7),(91,'2026-05-08 11:56:01.432786','/images/hotels/3b762447-df9c-4a15-ad32-6532a627b81c.jpg',_binary '\0',7),(92,'2026-05-08 11:56:01.437960','/images/hotels/aaab6587-53e9-42c2-8cb1-81e8930718c1.jpg',_binary '\0',7),(93,'2026-05-08 11:56:01.442306','/images/hotels/888d58b8-0524-4c81-bc4d-f92b0050ed69.jpg',_binary '\0',7),(94,'2026-05-08 11:56:01.445919','/images/hotels/888c133e-d54e-4cfc-a632-c36a5ce965d1.jpg',_binary '\0',7),(95,'2026-05-08 11:56:01.451130','/images/hotels/83fedbe1-f827-4d60-b270-50d62974642f.jpg',_binary '\0',7),(96,'2026-05-08 11:56:01.454846','/images/hotels/4bc26eda-cd8b-485e-a39a-f355072f1ac6.jpg',_binary '\0',7),(97,'2026-05-08 11:56:01.459680','/images/hotels/8458658f-b5bb-4249-bf43-45e6fb49bf26.jpg',_binary '\0',7),(98,'2026-05-08 11:56:01.464775','/images/hotels/e5b66b1c-3e45-4942-9715-b59965acff4b.jpg',_binary '\0',7),(101,'2026-05-08 12:11:35.530726','/images/hotels/5f4e4720-0a78-44dd-81e7-b8e75e1f09f5.jpg',_binary '\0',8),(103,'2026-05-08 12:11:35.540615','/images/hotels/8766ce14-f5e2-4098-971f-7df8eb140b84.jpg',_binary '\0',8),(104,'2026-05-08 12:11:35.545033','/images/hotels/5a02bb02-e40d-438c-99a6-15ec6cf77bfe.jpg',_binary '\0',8),(105,'2026-05-08 12:11:35.549787','/images/hotels/0eff9ea3-bb0d-4342-86c6-cf2091a0767d.jpg',_binary '\0',8),(106,'2026-05-08 12:11:35.552828','/images/hotels/89c8e723-1082-4703-86a3-2dc83b4ed9e7.jpg',_binary '\0',8),(107,'2026-05-08 12:11:35.557225','/images/hotels/6c2cf933-f3e1-48ec-86a3-2299d6f34f0d.jpg',_binary '\0',8),(108,'2026-05-08 12:11:35.561839','/images/hotels/a5706545-a1bf-4ac6-8ff2-d393a7540a27.jpg',_binary '\0',8),(109,'2026-05-08 12:11:35.565850','/images/hotels/bf8f05cc-4493-40c4-8e3f-3fd1b692b7cd.jpg',_binary '\0',8),(110,'2026-05-08 12:11:35.569893','/images/hotels/8f8cc96a-56f2-4b7a-8ed3-476e70415d31.jpg',_binary '\0',8),(111,'2026-05-08 12:11:35.574642','/images/hotels/a64a4c6c-adc2-4817-b221-53a442d86354.jpg',_binary '\0',8),(112,'2026-05-08 12:11:35.578536','/images/hotels/33bc4f0b-ff4b-43ad-832e-6682f6f48233.jpg',_binary '\0',8),(113,'2026-05-08 13:42:06.394628','/images/hotels/2891cada-eacc-4983-983f-245c9c103319.jpg',_binary '',9),(114,'2026-05-08 13:42:06.399369','/images/hotels/ea457783-10ec-4878-9203-9d995ac85d09.jpg',_binary '\0',9),(115,'2026-05-08 13:42:06.404192','/images/hotels/8c405c5a-cf07-4165-8c57-909bea07527d.jpg',_binary '\0',9),(116,'2026-05-08 13:42:06.409694','/images/hotels/05eab8db-cbb1-43ea-96be-a1d56537f02d.jpg',_binary '\0',9),(117,'2026-05-08 13:42:06.414621','/images/hotels/ab76b540-dfac-49b8-8368-434391ff7b7c.jpg',_binary '\0',9),(118,'2026-05-08 13:42:06.418531','/images/hotels/e257a6f7-9541-4491-bda8-504de514cf63.jpg',_binary '\0',9),(119,'2026-05-08 13:42:06.422184','/images/hotels/e649950c-5a3c-440d-ac88-4f27a550ce1a.jpg',_binary '\0',9),(120,'2026-05-08 13:42:06.426645','/images/hotels/3db63704-034d-43a4-a704-7979aaf29ea8.jpg',_binary '\0',9),(121,'2026-05-08 13:42:06.431683','/images/hotels/6d25642d-ce79-4215-919c-b3bf4f765163.jpg',_binary '\0',9),(122,'2026-05-08 13:42:06.436104','/images/hotels/575fa26c-ff33-4fb8-aefb-c080f942c0e7.jpg',_binary '\0',9),(123,'2026-05-08 13:42:06.441086','/images/hotels/618899bf-08a7-4a81-ab29-2de14f271969.jpg',_binary '\0',9),(124,'2026-05-08 13:42:06.445159','/images/hotels/74b652b5-98b4-4921-8d84-4f6fe94d05a0.jpg',_binary '\0',9),(125,'2026-05-08 13:42:06.448105','/images/hotels/37ec176a-b5d2-496a-9240-76c726ec9023.jpg',_binary '\0',9),(126,'2026-05-08 13:52:22.528964','/images/hotels/b98e0afa-9d68-48ca-88f0-40d0b8261756.jpg',_binary '',10),(127,'2026-05-08 13:52:22.533831','/images/hotels/06a08e1d-96c4-4c38-86e6-36ec89a751b5.jpg',_binary '\0',10),(128,'2026-05-08 13:52:22.536854','/images/hotels/a83e6035-fbcd-439c-8de5-1fa2041a25ca.jpg',_binary '\0',10),(129,'2026-05-08 13:52:22.541381','/images/hotels/1d885a91-42a5-4f67-8d1f-4d4de83f42d3.jpg',_binary '\0',10),(130,'2026-05-08 13:52:22.545071','/images/hotels/b5af9dd2-d03c-4c21-af52-0602d998dd0b.jpg',_binary '\0',10),(131,'2026-05-08 13:52:22.548285','/images/hotels/23e194e2-e80f-4380-a2f1-5c1e03e6ca8e.jpg',_binary '\0',10),(132,'2026-05-08 13:52:22.552663','/images/hotels/73e996ae-2346-45b2-ae3d-f8d36bde6a01.jpg',_binary '\0',10),(133,'2026-05-08 13:52:22.556151','/images/hotels/e9bc9c84-7245-4390-bf7a-f6ad56f592b8.jpg',_binary '\0',10),(134,'2026-05-08 13:52:22.559745','/images/hotels/aeb48f6d-d409-46bc-9898-4160135ea6de.jpg',_binary '\0',10),(135,'2026-05-08 13:52:22.563870','/images/hotels/46c6c23e-b486-4040-b20f-cb30dd6a5673.jpg',_binary '\0',10),(136,'2026-05-08 13:52:22.567872','/images/hotels/1eb45028-303f-4481-8b12-c993959c0a41.jpg',_binary '\0',10),(137,'2026-05-08 13:52:22.571557','/images/hotels/d33a14ad-5819-4add-9bc6-08fa1d9ba920.jpg',_binary '\0',10),(138,'2026-05-09 11:24:16.574831','/images/hotels/a3bd8732-524c-4d4c-9290-5a71209ae974.jpg',_binary '\0',8),(139,'2026-05-09 11:24:16.580306','/images/hotels/5814d03d-3049-4d17-bb26-0ec5964b9220.jpg',_binary '',8),(140,'2026-05-09 11:24:16.584352','/images/hotels/bc1d2b69-5d68-423f-9fad-fc497a92ed8d.jpg',_binary '\0',8),(141,'2026-05-09 11:24:16.589791','/images/hotels/8b79c281-663b-4827-b96d-1cd7f40b5f7d.jpg',_binary '\0',8),(143,'2026-05-10 18:00:08.556962','/images/hotels/b239e39f-5ac2-40e1-9ac8-fc4c7c3ceed2.jpg',_binary '',3),(144,'2026-05-10 18:00:08.563422','/images/hotels/495a5116-a77c-42ae-932d-532b3cc0a537.jpg',_binary '\0',3),(145,'2026-05-10 18:00:08.567460','/images/hotels/a6ab72dd-819d-4201-b2f9-ef7d2a4d9152.jpg',_binary '\0',3),(146,'2026-05-10 18:00:08.570853','/images/hotels/2f1bd6ff-50f7-4822-a3b9-f07ce84486fe.jpg',_binary '\0',3),(147,'2026-05-10 18:00:08.576228','/images/hotels/39f7e4bc-3ce9-4aae-82fc-a728d63de17e.jpg',_binary '\0',3),(148,'2026-05-10 18:00:08.579732','/images/hotels/f88aa22f-9f83-4fb5-b6f9-0d521c9e3716.jpg',_binary '\0',3),(149,'2026-05-10 18:00:08.584117','/images/hotels/f8ab8369-e6d3-4030-a2e7-9d177f7eb3d6.jpg',_binary '\0',3),(150,'2026-05-10 18:00:08.588654','/images/hotels/851d833c-4187-4f98-aea5-126efb96a42e.jpg',_binary '\0',3),(151,'2026-05-10 18:00:08.592141','/images/hotels/49c1bdb3-092b-4043-8a39-123a2456b716.jpg',_binary '\0',3),(152,'2026-05-10 18:00:08.596597','/images/hotels/51ffc6a0-95a2-4703-88b5-2270bdcfbaab.jpg',_binary '\0',3),(153,'2026-05-10 18:00:08.600581','/images/hotels/f1cf2052-3bcc-47a3-9b72-37739de3e0be.jpg',_binary '\0',3),(154,'2026-05-10 18:00:08.604583','/images/hotels/1acd0450-dbea-43c2-8513-2832c8986bfd.jpg',_binary '\0',3),(155,'2026-05-10 18:00:08.608865','/images/hotels/3e43ff1f-a33e-432c-a493-ebbef07717e0.jpg',_binary '\0',3),(156,'2026-05-10 18:01:14.077243','/images/hotels/9d8485ad-5eb9-4c7d-bfd7-2794ef5256e5.jpg',_binary '',6),(157,'2026-05-10 18:01:14.081834','/images/hotels/9a18948f-5062-4a85-8131-20327b3db591.jpg',_binary '\0',6),(158,'2026-05-10 18:01:14.086572','/images/hotels/5c5d0746-bcab-4ce7-a078-b5ad4a254493.jpg',_binary '\0',6),(159,'2026-05-10 18:01:14.089847','/images/hotels/137fbac3-cb46-4adf-bdba-ed1bb299de12.jpg',_binary '\0',6),(160,'2026-05-10 18:01:14.095147','/images/hotels/21c35042-f1fb-4f50-8344-8afd19f97b92.jpg',_binary '\0',6),(161,'2026-05-10 18:01:14.100704','/images/hotels/e1f82aa9-8994-4f38-b3f9-300496678a0a.jpg',_binary '\0',6),(162,'2026-05-10 18:01:14.105080','/images/hotels/aaef6f55-bff7-4347-96fe-44ec2147c594.jpg',_binary '\0',6),(163,'2026-05-10 18:01:14.109110','/images/hotels/4bb1c847-0285-4c9b-a263-1223eee4b158.jpg',_binary '\0',6),(164,'2026-05-10 18:01:14.112747','/images/hotels/88818beb-c662-4b11-8e19-e8093fec65ed.jpg',_binary '\0',6),(165,'2026-05-10 18:01:14.117749','/images/hotels/9f51861e-e805-4e67-8811-801414e5b3f3.jpg',_binary '\0',6),(166,'2026-05-10 18:01:14.123337','/images/hotels/71b2febe-a9ea-491e-9137-4c55bc33e2c2.jpg',_binary '\0',6),(167,'2026-05-10 18:01:14.127401','/images/hotels/47c81ff5-faa4-4155-bade-71e061c4ed95.jpg',_binary '\0',6),(168,'2026-05-10 18:01:14.131645','/images/hotels/d7240b7a-0980-430d-898b-69021d87a38b.jpg',_binary '\0',6),(169,'2026-05-11 16:40:44.639626','/images/hotels/4016d10f-b438-48e9-8705-24d29cc89380.jpg',_binary '\0',2),(170,'2026-05-11 16:40:44.657002','/images/hotels/fd4d88a9-7ef8-4bfb-b2f5-e2cc82f9e803.jpg',_binary '\0',2),(171,'2026-05-11 21:31:21.968738','/images/hotels/bfa19e0e-95b3-4af7-bcd1-7f5322de0ff7.jpg',_binary '',11),(172,'2026-05-11 21:31:21.974566','/images/hotels/9a71f9d7-c848-4f89-bf5a-2d351b276bb0.jpg',_binary '\0',11),(173,'2026-05-11 21:31:21.979271','/images/hotels/43347aea-14ce-4483-b446-1b616bc6aec5.jpg',_binary '\0',11);
/*!40000 ALTER TABLE `hotel_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `hotel_id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `average_rating` double DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `hotel_name` varchar(255) NOT NULL,
  `hotel_status` enum('ACTIVE','INACTIVE','MAINTENANCE') NOT NULL,
  `introduction` text,
  `is_deleted` bit(1) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `manager_id` bigint NOT NULL,
  PRIMARY KEY (`hotel_id`),
  KEY `FKaq04sfgwojtl4faui62h7my9n` (`manager_id`),
  CONSTRAINT `FKaq04sfgwojtl4faui62h7my9n` FOREIGN KEY (`manager_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,'16 P. Hàng Da, phường Hoàn Kiếm, Hà Nội, Việt Nam',10,'2026-05-08 09:49:07.100351','Loud Luxury Hotel Hà Nội','ACTIVE','Khách sạn tọa lạc trong khu vực nội đô hoặc gần các trục đường chính, giúp du khách dễ dàng kết nối đến nhiều địa điểm quan trọng trong thành phố. Mặc dù không gần biển, nhưng khách sạn lại nổi bật với không gian yên tĩnh, sạch sẽ và mức giá hợp lý. Các phòng được thiết kế tối giản nhưng tinh tế, đảm bảo đầy đủ tiện nghi phục vụ nhu cầu nghỉ ngơi và làm việc. Ngoài ra, khách sạn còn có nhà hàng phục vụ ăn sáng, phòng hội nghị nhỏ và dịch vụ giặt ủi, phù hợp cho khách công tác dài ngày hoặc du lịch tiết kiệm.',_binary '\0','2026-05-12 10:30:33.166069',2),(2,'32–34 Trần Phú, phường Nha Trang, Khánh Hòa, Việt Nam',NULL,'2026-05-08 10:06:01.645722','Loud Grand Hotel Khánh Hòa','ACTIVE','Khách sạn tọa lạc ngay khu vực ven biển, chỉ mất vài phút đi bộ để ra đến bãi cát trắng và làn nước trong xanh. Đây là lựa chọn lý tưởng cho những du khách muốn tận hưởng trọn vẹn không khí biển trong lành, thư giãn cùng tiếng sóng vỗ và gió biển mát rượi. Các phòng nghỉ được thiết kế hiện đại, nhiều phòng có cửa sổ lớn hoặc ban công hướng trực tiếp ra biển, giúp du khách dễ dàng ngắm bình minh và hoàng hôn tuyệt đẹp. Ngoài ra, khách sạn còn cung cấp các tiện ích như hồ bơi ngoài trời, nhà hàng hải sản, quầy bar ven biển và dịch vụ tour tham quan đảo, mang đến trải nghiệm nghỉ dưỡng trọn vẹn và thoải mái.',_binary '\0','2026-05-12 10:29:12.526440',3),(3,'36 Bạch Đằng, phường Hải Châu, Đà Nẵng, Việt Nam',NULL,'2026-05-08 10:17:52.292539','Loud Luxury Hotel Đà Nẵng','ACTIVE','Khách sạn tọa lạc ngay khu vực ven biển, chỉ mất vài phút đi bộ để ra đến bãi cát trắng và làn nước trong xanh. Đây là lựa chọn lý tưởng cho những du khách muốn tận hưởng trọn vẹn không khí biển trong lành, thư giãn cùng tiếng sóng vỗ và gió biển mát rượi. Các phòng nghỉ được thiết kế hiện đại, nhiều phòng có cửa sổ lớn hoặc ban công hướng trực tiếp ra biển, giúp du khách dễ dàng ngắm bình minh và hoàng hôn tuyệt đẹp. Ngoài ra, khách sạn còn cung cấp các tiện ích như hồ bơi ngoài trời, nhà hàng hải sản, quầy bar ven biển và dịch vụ tour tham quan đảo, mang đến trải nghiệm nghỉ dưỡng trọn vẹn và thoải mái.',_binary '\0','2026-05-12 10:30:07.109718',4),(4,'Ấp Hồ Tràm, xã Phước Thuận, TP. Hồ Chí Minh, Việt Nam',NULL,'2026-05-08 10:26:45.696931','Loud Grand Hotel TP.Hồ Chí Minh','ACTIVE','Khách sạn tọa lạc ngay khu vực ven biển, chỉ mất vài phút đi bộ để ra đến bãi cát trắng và làn nước trong xanh. Đây là lựa chọn lý tưởng cho những du khách muốn tận hưởng trọn vẹn không khí biển trong lành, thư giãn cùng tiếng sóng vỗ và gió biển mát rượi. Các phòng nghỉ được thiết kế hiện đại, nhiều phòng có cửa sổ lớn hoặc ban công hướng trực tiếp ra biển, giúp du khách dễ dàng ngắm bình minh và hoàng hôn tuyệt đẹp. Ngoài ra, khách sạn còn cung cấp các tiện ích như hồ bơi ngoài trời, nhà hàng hải sản, quầy bar ven biển và dịch vụ tour tham quan đảo, mang đến trải nghiệm nghỉ dưỡng trọn vẹn và thoải mái.',_binary '\0','2026-05-12 10:29:30.750393',5),(5,'300 Võ Nguyên Giáp, phường Mỹ An, Đà Nẵng, Việt Nam',NULL,'2026-05-08 10:36:52.091490','Loud Luxury Hotel Đà Nẵng','ACTIVE','Khách sạn tọa lạc ngay khu vực ven biển, chỉ mất vài phút đi bộ để ra đến bãi cát trắng và làn nước trong xanh. Đây là lựa chọn lý tưởng cho những du khách muốn tận hưởng trọn vẹn không khí biển trong lành, thư giãn cùng tiếng sóng vỗ và gió biển mát rượi. Các phòng nghỉ được thiết kế hiện đại, nhiều phòng có cửa sổ lớn hoặc ban công hướng trực tiếp ra biển, giúp du khách dễ dàng ngắm bình minh và hoàng hôn tuyệt đẹp. Ngoài ra, khách sạn còn cung cấp các tiện ích như hồ bơi ngoài trời, nhà hàng hải sản, quầy bar ven biển và dịch vụ tour tham quan đảo, mang đến trải nghiệm nghỉ dưỡng trọn vẹn và thoải mái.',_binary '\0','2026-05-12 10:29:22.848009',6),(6,'88 Đồng Khởi, phường Sài Gòn, TP. Hồ Chí Minh, Việt Nam',NULL,'2026-05-08 10:44:04.661532','Loud Grand Hotel TP. Hồ Chí Minh','ACTIVE','ok',_binary '\0','2026-05-10 18:01:32.388153',7),(7,'D8 Giảng Võ, phường Giảng Võ, Hà Nội, Việt Nam',NULL,'2026-05-08 11:56:01.311886','Loud Grand Hotel Hà Nội','ACTIVE','ok',_binary '\0','2026-05-08 11:56:01.311886',8),(8,'40 Điện Biên Phủ, phường Hồng Bàng, Hải Phòng, Việt Nam',NULL,'2026-05-08 12:11:35.467660','Loud Luxury Hotel Hải Phòng','ACTIVE','ok',_binary '\0','2026-05-10 16:57:20.693898',9),(9,'Khu phố 14, phường Mũi Né, tỉnh Lâm Đồng, Việt Nam',NULL,'2026-05-08 13:42:06.349434','Loud Luxury Hotel Lâm Đồng','ACTIVE','ok',_binary '\0','2026-05-08 13:42:06.349434',10),(10,'12 Lạch Tray, phường Lê Chân, Hải Phòng, Việt Nam',NULL,'2026-05-08 13:52:22.491466','Loud Grand Hotel Hải Phòng','ACTIVE','ok',_binary '\0','2026-05-08 13:54:21.395768',11),(11,'Xóm 9, thôn Hữu Đô Kỳ, xã Thần Khê, Hưng Yên, Việt Nam',NULL,'2026-05-11 21:31:21.894758','Loud Luxury Hotel Test','ACTIVE','ok',_binary '\0','2026-05-11 21:31:21.894758',16);
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` bigint NOT NULL AUTO_INCREMENT,
  `comment` text,
  `created_at` datetime(6) DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `status` enum('ACTIVE','HIDDEN','PENDING_HIDE') NOT NULL,
  `hotel_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `UK8o406x2md9iq7711vni73g261` (`user_id`,`hotel_id`),
  KEY `FKb9igk5exfb4knqklcvka6cdhx` (`hotel_id`),
  CONSTRAINT `FKb9igk5exfb4knqklcvka6cdhx` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`),
  CONSTRAINT `FKcgy7qjc1r99dp117y9en6lxye` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'Chỗ nghỉ tuyệt vời\n','2026-05-08 13:47:05.182247',10,'ACTIVE',1,12);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_assignments`
--

DROP TABLE IF EXISTS `room_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_assignments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assigned_at` datetime(6) DEFAULT NULL,
  `bill_detail_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqda3men7fayroc33jet371fci` (`bill_detail_id`),
  KEY `FKt96wkyclodjlrg52xftxyve1h` (`room_id`),
  CONSTRAINT `FKqda3men7fayroc33jet371fci` FOREIGN KEY (`bill_detail_id`) REFERENCES `bill_details` (`bill_detail_id`),
  CONSTRAINT `FKt96wkyclodjlrg52xftxyve1h` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_assignments`
--

LOCK TABLES `room_assignments` WRITE;
/*!40000 ALTER TABLE `room_assignments` DISABLE KEYS */;
INSERT INTO `room_assignments` VALUES (1,'2026-05-12 10:05:33.319688',1,466),(2,'2026-05-12 10:05:33.326953',2,469),(3,'2026-05-12 10:05:33.333182',3,506),(4,'2026-05-12 10:06:16.484653',4,507),(5,'2026-05-12 10:06:16.490994',5,470),(6,'2026-05-12 10:06:16.496800',6,471);
/*!40000 ALTER TABLE `room_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type_images`
--

DROP TABLE IF EXISTS `room_type_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type_images` (
  `image_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_main` bit(1) DEFAULT NULL,
  `type_id` bigint NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `FKh5ppjdpf1hbet7xr9kqu74l2y` (`type_id`),
  CONSTRAINT `FKh5ppjdpf1hbet7xr9kqu74l2y` FOREIGN KEY (`type_id`) REFERENCES `room_types` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type_images`
--

LOCK TABLES `room_type_images` WRITE;
/*!40000 ALTER TABLE `room_type_images` DISABLE KEYS */;
INSERT INTO `room_type_images` VALUES (3,'2026-05-09 23:22:49.130864','/images/room-types/d310d582-e462-46e3-a2e9-adf4213df48c.jpg',_binary '\0',43),(4,'2026-05-09 23:22:49.146335','/images/room-types/0d9a6cd8-d296-4ddc-b18e-fd8d58667486.jpg',_binary '\0',43),(5,'2026-05-09 23:22:49.147688','/images/room-types/04b37add-7997-4d85-ab99-15827f95c729.jpg',_binary '',43),(6,'2026-05-09 23:22:49.154306','/images/room-types/d903e6cc-ccaf-452b-8c95-dbeb3a9e0efd.jpg',_binary '\0',43),(7,'2026-05-09 23:22:49.160236','/images/room-types/ae27b2aa-4cb3-4b33-8f53-fe24e8547ac3.jpg',_binary '\0',43),(8,'2026-05-11 22:26:37.687697','/images/room-types/d1fd0bd7-4176-4a02-80a4-42fdee2d0f47.jpg',_binary '',61),(9,'2026-05-11 22:26:37.693967','/images/room-types/68d4553f-8767-4010-bdf7-fe15befee0a5.jpg',_binary '\0',61),(10,'2026-05-11 22:31:58.749263','/images/room-types/8754ca71-36ed-45cb-83e1-34c41d4bcb8c.jpg',_binary '',62),(11,'2026-05-11 22:31:58.755083','/images/room-types/3d112aab-7f7b-413a-89ee-52119af965f7.jpg',_binary '\0',62),(12,'2026-05-11 23:04:37.008168','/images/room-types/af4f537c-07f4-4015-bf43-c0a138f77f8c.jpg',_binary '',63),(13,'2026-05-11 23:06:37.810486','/images/room-types/9a35695d-371d-42a0-9cd3-996d42a85cc0.jpg',_binary '',64);
/*!40000 ALTER TABLE `room_type_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_types` (
  `type_id` bigint NOT NULL AUTO_INCREMENT,
  `area` double DEFAULT NULL,
  `bed_count` int DEFAULT NULL,
  `bed_type` enum('SINGLE','DOUBLE','TWIN','QUEEN','KING') DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  KEY `FK42cc0t2sr43om89u1loqh7arj` (`hotel_id`),
  CONSTRAINT `FK42cc0t2sr43om89u1loqh7arj` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_types`
--

LOCK TABLES `room_types` WRITE;
/*!40000 ALTER TABLE `room_types` DISABLE KEYS */;
INSERT INTO `room_types` VALUES (1,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',1000000,'Suite Room','2026-05-11 22:18:42.625476',1),(2,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',1),(3,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',1),(4,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',1),(5,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',1),(6,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',700000,'Standard Single Room','2026-05-10 17:00:23.077601',1),(7,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',1500000,'Suite Room','2026-05-08 14:15:27.095855',2),(8,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',5000000,'Family Room','2026-05-08 14:15:48.573726',2),(9,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',3000000,'Deluxe Room','2026-05-08 14:15:58.013946',2),(10,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',2),(11,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',2),(12,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',2),(13,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',3),(14,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',3),(15,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',3),(16,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',3),(17,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',3),(18,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',3),(19,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',4),(20,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',4),(21,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',4),(22,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',4),(23,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',4),(24,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',4),(25,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',5),(26,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',5),(27,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',5),(28,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',5),(29,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',5),(30,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',5),(31,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',6),(32,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',6),(33,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',6),(34,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',6),(35,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',6),(36,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',6),(37,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',7),(38,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',7),(39,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',7),(40,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',7),(41,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',7),(42,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',7),(43,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',8),(44,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',8),(45,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',8),(46,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',8),(47,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',8),(48,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',700000,'Standard Single Room','2026-05-10 17:02:06.732774',8),(49,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',9),(50,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',9),(51,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',9),(52,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',9),(53,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',9),(54,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',9),(55,60,1,'KING',2,'2026-05-08 14:14:03.000000','Luxury suite room with premium facilities.',_binary '\0',2500000,'Suite Room','2026-05-08 14:14:03.000000',10),(56,45,2,'QUEEN',4,'2026-05-08 14:14:03.000000','Family room suitable for groups and families.',_binary '\0',1800000,'Family Room','2026-05-08 14:14:03.000000',10),(57,35,1,'QUEEN',2,'2026-05-08 14:14:03.000000','Spacious deluxe room with modern interior.',_binary '\0',1200000,'Deluxe Room','2026-05-08 14:14:03.000000',10),(58,30,2,'SINGLE',2,'2026-05-08 14:14:03.000000','Room with 2 single beds for friends or business travelers.',_binary '\0',900000,'Twin Room','2026-05-08 14:14:03.000000',10),(59,28,1,'DOUBLE',2,'2026-05-08 14:14:03.000000','Standard room with 1 double bed suitable for couples.',_binary '\0',800000,'Standard Double Room','2026-05-08 14:14:03.000000',10),(60,20,1,'SINGLE',1,'2026-05-08 14:14:03.000000','Standard room for 1 guest with basic amenities.',_binary '\0',500000,'Standard Single Room','2026-05-08 14:14:03.000000',10),(61,1,1,'SINGLE',1,'2026-05-11 22:26:37.605756','1',_binary '\0',1000000,'Test room 1','2026-05-11 23:07:15.183869',11),(62,45,1,'KING',2,'2026-05-11 22:31:58.723999','ok',_binary '\0',3000000,'3','2026-05-11 23:07:06.071945',11),(63,40,2,'SINGLE',2,'2026-05-11 23:04:36.983961','ok',_binary '\0',2000000,'Test room 2','2026-05-11 23:04:36.983961',11),(64,45,2,'QUEEN',4,'2026-05-11 23:06:37.790591','ok',_binary '\0',4000000,'4','2026-05-11 23:06:37.790591',11),(65,50,2,'KING',4,'2026-05-11 23:14:53.617119','',_binary '\0',7000000,'Test 2','2026-05-11 23:14:53.617119',11);
/*!40000 ALTER TABLE `room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `room_number` int DEFAULT NULL,
  `room_status` enum('ACTIVE','MAINTENANCE','INACTIVE') NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `type_id` bigint NOT NULL,
  PRIMARY KEY (`room_id`),
  KEY `FKp5lufxy0ghq53ugm93hdc941k` (`hotel_id`),
  KEY `FK36pnbgx5yxaalc346d0astj9s` (`type_id`),
  CONSTRAINT `FK36pnbgx5yxaalc346d0astj9s` FOREIGN KEY (`type_id`) REFERENCES `room_types` (`type_id`),
  CONSTRAINT `FKp5lufxy0ghq53ugm93hdc941k` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=652 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(2,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-10 08:36:17.397432',1,6),(3,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(4,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(5,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(6,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(7,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(8,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(9,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(10,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',1,6),(11,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(12,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(13,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(14,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(15,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(16,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(17,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(18,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(19,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(20,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(21,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(22,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(23,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(24,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(25,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(26,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(27,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(28,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',1,5),(29,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(30,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(31,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(32,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(33,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(34,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(35,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(36,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(37,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(38,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',1,4),(39,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(40,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(41,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(42,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(43,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(44,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(45,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(46,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(47,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(48,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(49,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(50,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',1,3),(51,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(52,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(53,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(54,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(55,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(56,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(57,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(58,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(59,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(60,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',1,2),(61,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',1,1),(62,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',1,1),(63,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',1,1),(64,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',1,1),(65,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',1,1),(66,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(67,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(68,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(69,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(70,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(71,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(72,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(73,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(74,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(75,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',2,12),(76,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(77,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(78,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(79,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(80,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(81,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(82,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(83,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(84,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(85,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(86,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(87,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(88,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(89,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(90,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(91,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(92,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(93,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',2,11),(94,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(95,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(96,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(97,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(98,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(99,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(100,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(101,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(102,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(103,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',2,10),(104,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(105,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(106,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(107,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(108,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(109,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(110,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(111,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(112,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(113,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(114,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(115,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',2,9),(116,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(117,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(118,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(119,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(120,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(121,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(122,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(123,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(124,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(125,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',2,8),(126,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',2,7),(127,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',2,7),(128,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',2,7),(129,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',2,7),(130,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',2,7),(131,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(132,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(133,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(134,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(135,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(136,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(137,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(138,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(139,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(140,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',3,18),(141,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(142,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(143,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(144,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(145,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(146,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(147,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(148,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(149,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(150,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(151,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(152,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(153,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(154,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(155,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(156,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(157,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(158,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',3,17),(159,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(160,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(161,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(162,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(163,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(164,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(165,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(166,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(167,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(168,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',3,16),(169,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(170,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(171,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(172,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(173,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(174,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(175,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(176,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(177,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(178,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(179,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(180,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',3,15),(181,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(182,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(183,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(184,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(185,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(186,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(187,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(188,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(189,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(190,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',3,14),(191,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',3,13),(192,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',3,13),(193,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',3,13),(194,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',3,13),(195,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',3,13),(196,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(197,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(198,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(199,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(200,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(201,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(202,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(203,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(204,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(205,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',4,24),(206,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(207,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(208,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(209,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(210,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(211,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(212,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(213,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(214,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(215,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(216,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(217,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(218,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(219,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(220,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(221,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(222,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(223,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',4,23),(224,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(225,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(226,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(227,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(228,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(229,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(230,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(231,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(232,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(233,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',4,22),(234,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(235,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(236,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(237,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(238,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(239,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(240,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(241,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(242,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(243,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(244,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(245,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',4,21),(246,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(247,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(248,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(249,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(250,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(251,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(252,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(253,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(254,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(255,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',4,20),(256,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',4,19),(257,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',4,19),(258,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',4,19),(259,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',4,19),(260,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',4,19),(261,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(262,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(263,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(264,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(265,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(266,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(267,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(268,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(269,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(270,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',5,30),(271,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(272,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(273,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(274,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(275,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(276,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(277,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(278,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(279,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(280,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(281,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(282,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(283,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(284,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(285,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(286,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(287,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(288,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',5,29),(289,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(290,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(291,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(292,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(293,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(294,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(295,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(296,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(297,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(298,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',5,28),(299,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(300,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(301,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(302,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(303,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(304,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(305,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(306,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(307,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(308,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(309,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(310,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',5,27),(311,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(312,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(313,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(314,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(315,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(316,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(317,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(318,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(319,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(320,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',5,26),(321,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',5,25),(322,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',5,25),(323,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',5,25),(324,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',5,25),(325,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',5,25),(326,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(327,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(328,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(329,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(330,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(331,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(332,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(333,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(334,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(335,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',6,36),(336,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(337,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(338,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(339,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(340,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(341,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(342,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(343,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(344,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(345,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(346,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(347,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(348,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(349,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(350,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(351,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(352,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(353,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',6,35),(354,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(355,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(356,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(357,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(358,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(359,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(360,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(361,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(362,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(363,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',6,34),(364,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(365,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(366,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(367,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(368,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(369,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(370,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(371,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(372,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(373,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(374,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(375,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',6,33),(376,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(377,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(378,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(379,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(380,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(381,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(382,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(383,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(384,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(385,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',6,32),(386,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',6,31),(387,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',6,31),(388,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',6,31),(389,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',6,31),(390,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',6,31),(391,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(392,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(393,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(394,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(395,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(396,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(397,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(398,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(399,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(400,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',7,42),(401,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(402,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(403,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(404,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(405,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(406,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(407,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(408,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(409,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(410,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(411,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(412,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(413,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(414,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(415,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(416,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(417,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(418,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',7,41),(419,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(420,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(421,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(422,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(423,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(424,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(425,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(426,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(427,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(428,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',7,40),(429,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(430,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(431,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(432,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(433,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(434,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(435,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(436,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(437,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(438,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(439,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(440,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',7,39),(441,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(442,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(443,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(444,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(445,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(446,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(447,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(448,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(449,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(450,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',7,38),(451,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',7,37),(452,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',7,37),(453,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',7,37),(454,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',7,37),(455,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',7,37),(456,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(457,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-11 09:12:56.085202',8,48),(458,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-11 09:12:59.082828',8,48),(459,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(460,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(461,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(462,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(463,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(464,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(465,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',8,48),(466,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(467,'2026-05-08 15:23:52.000000',_binary '\0',302,'MAINTENANCE','2026-05-11 09:13:08.522736',8,47),(468,'2026-05-08 15:23:52.000000',_binary '\0',303,'INACTIVE','2026-05-11 09:13:15.282876',8,47),(469,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(470,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(471,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(472,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(473,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(474,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(475,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(476,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(477,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(478,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(479,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(480,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(481,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(482,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(483,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',8,47),(484,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(485,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(486,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(487,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(488,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(489,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(490,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(491,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(492,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(493,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',8,46),(494,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(495,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(496,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(497,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(498,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(499,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(500,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(501,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(502,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(503,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(504,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(505,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',8,45),(506,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(507,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(508,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(509,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(510,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(511,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(512,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(513,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(514,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(515,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',8,44),(516,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',8,43),(517,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',8,43),(518,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',8,43),(519,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',8,43),(520,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',8,43),(521,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(522,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(523,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(524,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(525,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(526,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(527,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(528,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(529,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(530,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',9,54),(531,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(532,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(533,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(534,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(535,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(536,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(537,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(538,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(539,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(540,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(541,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(542,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(543,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(544,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(545,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(546,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(547,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(548,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',9,53),(549,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(550,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(551,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(552,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(553,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(554,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(555,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(556,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(557,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(558,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',9,52),(559,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(560,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(561,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(562,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(563,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(564,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(565,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(566,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(567,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(568,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(569,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(570,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',9,51),(571,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(572,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(573,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(574,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(575,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(576,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(577,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(578,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(579,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(580,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',9,50),(581,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',9,49),(582,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',9,49),(583,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',9,49),(584,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',9,49),(585,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',9,49),(586,'2026-05-08 15:23:52.000000',_binary '\0',201,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(587,'2026-05-08 15:23:52.000000',_binary '\0',202,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(588,'2026-05-08 15:23:52.000000',_binary '\0',203,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(589,'2026-05-08 15:23:52.000000',_binary '\0',204,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(590,'2026-05-08 15:23:52.000000',_binary '\0',205,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(591,'2026-05-08 15:23:52.000000',_binary '\0',206,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(592,'2026-05-08 15:23:52.000000',_binary '\0',207,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(593,'2026-05-08 15:23:52.000000',_binary '\0',208,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(594,'2026-05-08 15:23:52.000000',_binary '\0',209,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(595,'2026-05-08 15:23:52.000000',_binary '\0',210,'ACTIVE','2026-05-08 15:23:52.000000',10,60),(596,'2026-05-08 15:23:52.000000',_binary '\0',301,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(597,'2026-05-08 15:23:52.000000',_binary '\0',302,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(598,'2026-05-08 15:23:52.000000',_binary '\0',303,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(599,'2026-05-08 15:23:52.000000',_binary '\0',304,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(600,'2026-05-08 15:23:52.000000',_binary '\0',305,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(601,'2026-05-08 15:23:52.000000',_binary '\0',306,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(602,'2026-05-08 15:23:52.000000',_binary '\0',401,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(603,'2026-05-08 15:23:52.000000',_binary '\0',402,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(604,'2026-05-08 15:23:52.000000',_binary '\0',403,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(605,'2026-05-08 15:23:52.000000',_binary '\0',404,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(606,'2026-05-08 15:23:52.000000',_binary '\0',405,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(607,'2026-05-08 15:23:52.000000',_binary '\0',406,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(608,'2026-05-08 15:23:52.000000',_binary '\0',501,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(609,'2026-05-08 15:23:52.000000',_binary '\0',502,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(610,'2026-05-08 15:23:52.000000',_binary '\0',503,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(611,'2026-05-08 15:23:52.000000',_binary '\0',504,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(612,'2026-05-08 15:23:52.000000',_binary '\0',505,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(613,'2026-05-08 15:23:52.000000',_binary '\0',506,'ACTIVE','2026-05-08 15:23:52.000000',10,59),(614,'2026-05-08 15:23:52.000000',_binary '\0',601,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(615,'2026-05-08 15:23:52.000000',_binary '\0',602,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(616,'2026-05-08 15:23:52.000000',_binary '\0',603,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(617,'2026-05-08 15:23:52.000000',_binary '\0',604,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(618,'2026-05-08 15:23:52.000000',_binary '\0',605,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(619,'2026-05-08 15:23:52.000000',_binary '\0',701,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(620,'2026-05-08 15:23:52.000000',_binary '\0',702,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(621,'2026-05-08 15:23:52.000000',_binary '\0',703,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(622,'2026-05-08 15:23:52.000000',_binary '\0',704,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(623,'2026-05-08 15:23:52.000000',_binary '\0',705,'ACTIVE','2026-05-08 15:23:52.000000',10,58),(624,'2026-05-08 15:23:52.000000',_binary '\0',801,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(625,'2026-05-08 15:23:52.000000',_binary '\0',802,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(626,'2026-05-08 15:23:52.000000',_binary '\0',803,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(627,'2026-05-08 15:23:52.000000',_binary '\0',804,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(628,'2026-05-08 15:23:52.000000',_binary '\0',805,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(629,'2026-05-08 15:23:52.000000',_binary '\0',806,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(630,'2026-05-08 15:23:52.000000',_binary '\0',901,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(631,'2026-05-08 15:23:52.000000',_binary '\0',902,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(632,'2026-05-08 15:23:52.000000',_binary '\0',903,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(633,'2026-05-08 15:23:52.000000',_binary '\0',904,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(634,'2026-05-08 15:23:52.000000',_binary '\0',905,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(635,'2026-05-08 15:23:52.000000',_binary '\0',906,'ACTIVE','2026-05-08 15:23:52.000000',10,57),(636,'2026-05-08 15:23:52.000000',_binary '\0',1001,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(637,'2026-05-08 15:23:52.000000',_binary '\0',1002,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(638,'2026-05-08 15:23:52.000000',_binary '\0',1003,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(639,'2026-05-08 15:23:52.000000',_binary '\0',1004,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(640,'2026-05-08 15:23:52.000000',_binary '\0',1005,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(641,'2026-05-08 15:23:52.000000',_binary '\0',1101,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(642,'2026-05-08 15:23:52.000000',_binary '\0',1102,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(643,'2026-05-08 15:23:52.000000',_binary '\0',1103,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(644,'2026-05-08 15:23:52.000000',_binary '\0',1104,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(645,'2026-05-08 15:23:52.000000',_binary '\0',1105,'ACTIVE','2026-05-08 15:23:52.000000',10,56),(646,'2026-05-08 15:23:52.000000',_binary '\0',1201,'ACTIVE','2026-05-08 15:23:52.000000',10,55),(647,'2026-05-08 15:23:52.000000',_binary '\0',1202,'ACTIVE','2026-05-08 15:23:52.000000',10,55),(648,'2026-05-08 15:23:52.000000',_binary '\0',1203,'ACTIVE','2026-05-08 15:23:52.000000',10,55),(649,'2026-05-08 15:23:52.000000',_binary '\0',1204,'ACTIVE','2026-05-08 15:23:52.000000',10,55),(650,'2026-05-08 15:23:52.000000',_binary '\0',1205,'ACTIVE','2026-05-08 15:23:52.000000',10,55),(651,'2026-05-11 22:28:51.922343',_binary '\0',101,'ACTIVE','2026-05-11 22:28:51.922343',NULL,61);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `refresh_token` text,
  `role` enum('ADMIN','MANAGER','USER') NOT NULL,
  `status` enum('ACTIVE','BLOCKED') NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UK_du5v5sr43g5bfnji4vb8hg5s3` (`phone`),
  UNIQUE KEY `UK_r43af9ap4edm43mmtq01oddj6` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-05-08 09:08:30.267296',NULL,'admin@gmail.com',NULL,_binary '\0',NULL,'$2a$10$.Low.DsyDN95tZsU6tWimOVXZ7CJJFcGt9K6PSNi4BPxSnp0Va1Vu','0000000000','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJpYXQiOjE3Nzg1NTYyNjcsImV4cCI6MTc3OTE2MTA2N30.t1C4QO-Oh7bOYYKcMAj1agz0lB6KozN0wd_rY7n6ty4','ADMIN','ACTIVE','2026-05-12 10:24:27.277718','admin'),(2,'2026-05-08 09:20:15.499645',NULL,'bacmanager@gmail.com','Bắc',_binary '\0','Vũ Xuân','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500258','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWNtYW5hZ2VyQGdtYWlsLmNvbSIsImlhdCI6MTc3ODM4MjI2NSwiZXhwIjoxNzc4OTg3MDY1fQ.hshaY_9y9eKctorZoh2KkRHvuBiz9Wsbofrax6GK9vs','MANAGER','ACTIVE','2026-05-11 11:15:35.035816','bacmanager'),(3,'2026-05-08 09:21:06.517026',NULL,'bachmanager@gmail.com','Bách',_binary '\0','Nguyễn Như','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500250','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWNobWFuYWdlckBnbWFpbC5jb20iLCJpYXQiOjE3NzgyMjM3MzQsImV4cCI6MTc3ODgyODUzNH0.vhyO7aPcEgIiemttNto5FqXswUE0_uRDMIumKsUx5CI','MANAGER','ACTIVE','2026-05-08 14:02:14.073956','bachmanager'),(4,'2026-05-08 09:22:27.386525',NULL,'anhmanager@gmail.com','Anh',_binary '\0','Nguyễn Tiến','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500251',NULL,'MANAGER','ACTIVE','2026-05-08 09:22:27.386525','anhmanager'),(5,'2026-05-08 09:24:09.601536',NULL,'tungmanager@gmail.com','Tùng',_binary '\0','Phạm Văn','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500253',NULL,'MANAGER','ACTIVE','2026-05-08 09:24:09.601536','tungmanager'),(6,'2026-05-08 09:25:12.619009',NULL,'vinhmanager@gmail.com','Vinh',_binary '\0','Trần Lê Khánh','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500254',NULL,'MANAGER','ACTIVE','2026-05-08 09:25:12.619009','vinhmanager'),(7,'2026-05-08 09:25:59.752231',NULL,'tuanmanager@gmail.com','Tuấn',_binary '\0','Nguyễn Anh','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500255',NULL,'MANAGER','ACTIVE','2026-05-08 09:25:59.752231','tuanmanager'),(8,'2026-05-08 09:26:47.337369',NULL,'tumanager@gmail.com','Tú',_binary '\0','Nguyễn Hữu','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500256',NULL,'MANAGER','ACTIVE','2026-05-08 09:26:47.337369','tumanager'),(9,'2026-05-08 09:27:24.297377',NULL,'hieumanager@gmail.com','Hiếu',_binary '\0','Vũ Lê','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500257','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJoaWV1bWFuYWdlckBnbWFpbC5jb20iLCJpYXQiOjE3Nzg1NTQ1MjcsImV4cCI6MTc3OTE1OTMyN30.QDdbtgYOHs7ih84xtrNT9PW-kBjTR7YhIZksY0CD1YE','MANAGER','ACTIVE','2026-05-12 09:55:27.301994','hieumanager'),(10,'2026-05-08 09:28:31.753827',NULL,'binhmanager@gmail.com','Bình',_binary '\0','Vũ Xuân','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500259',NULL,'MANAGER','ACTIVE','2026-05-08 09:28:31.753827','binhmanager'),(11,'2026-05-08 09:30:00.378274',NULL,'bichmanager@gmail.com','Bích',_binary '\0','Lê Thị','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500252',NULL,'MANAGER','ACTIVE','2026-05-08 09:30:00.378274','bich@gmail.com'),(12,'2026-05-08 09:30:56.369700',NULL,'bacvx@gmail.com','Bắc',_binary '\0','Vũ Xuân','$2a$10$mk3oAI6DQqV0LFq3qqec2eoMHYCEEPsCqOeteewaTULjdMovACoE2','0336500201','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWN2eEBnbWFpbC5jb20iLCJpYXQiOjE3Nzg1NTA5NjAsImV4cCI6MTc3OTE1NTc2MH0.gYgTJuyhrNKMGdnzibtfhKgzK4lmGQ5fuCcy8Oqpk38','USER','ACTIVE','2026-05-12 08:56:01.005035','bacvx'),(13,'2026-05-08 09:32:43.154751',NULL,'anhnt@gmail.com','Anh',_binary '\0','Nguyễn Thị','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500202',NULL,'USER','ACTIVE','2026-05-08 09:32:43.154751','anhnt'),(14,'2026-05-08 09:33:17.559192',NULL,'binhtv@gmail.com','Bình',_binary '\0','Trần Văn','$2a$10$OpqytUduK93MylB241jeguY/CqCuJd2mGVoEfQgASVFLSD4j5osY6','0336500203',NULL,'USER','ACTIVE','2026-05-08 09:33:17.559192','binhtv'),(15,'2026-05-08 16:43:34.266619',NULL,'chilb@gmail.com','Chi',_binary '\0','Lê Bá','$2a$10$5wD3y/A6yR6IA1zsWi.UW.xydOrfbnzRQ6I9cCJrBx769ScbApAkW','0336500003',NULL,'USER','ACTIVE','2026-05-08 16:43:34.266619','chilb'),(16,'2026-05-11 21:20:44.788995',NULL,'vxbmanager@gmail.com','Bắc',_binary '\0','Vũ','$2a$10$HKB6P.FoxD0YNXSUiEXrf.GUVAUT/iEizIDppyG/kyr2Q5NJeP74.','0336500230','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2eGJtYW5hZ2VyQGdtYWlsLmNvbSIsImlhdCI6MTc3ODU1MjE4MCwiZXhwIjoxNzc5MTU2OTgwfQ.-vbAzMuV3nnzmtPXI05sdxUeuxSO5Tld1McPeCXNi3Y','MANAGER','ACTIVE','2026-05-12 09:16:20.216582','vxbmanager');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilities`
--

DROP TABLE IF EXISTS `utilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilities` (
  `utilities_id` bigint NOT NULL AUTO_INCREMENT,
  `utilities_name` varchar(255) NOT NULL,
  `utility_type` enum('ROOM','HOTEL') DEFAULT NULL,
  PRIMARY KEY (`utilities_id`),
  UNIQUE KEY `UK_so6ey20dm25han1b9ei93e330` (`utilities_name`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilities`
--

LOCK TABLES `utilities` WRITE;
/*!40000 ALTER TABLE `utilities` DISABLE KEYS */;
INSERT INTO `utilities` VALUES (1,'Wifi miễn phí','ROOM'),(2,'Điều hòa','ROOM'),(3,'TV màn hình phẳng','ROOM'),(4,'Smart TV','ROOM'),(5,'Minibar','ROOM'),(6,'Két an toàn','ROOM'),(7,'Máy sấy tóc','ROOM'),(8,'Bàn làm việc','ROOM'),(9,'Tủ quần áo','ROOM'),(10,'Phòng tắm riêng','ROOM'),(11,'Bồn tắm','ROOM'),(12,'Vòi sen','ROOM'),(13,'Đồ vệ sinh cá nhân','ROOM'),(14,'Áo choàng tắm','ROOM'),(15,'Dép đi trong phòng','ROOM'),(16,'Ấm đun nước','ROOM'),(17,'Máy pha cà phê','ROOM'),(18,'Bộ trà','ROOM'),(19,'Tủ lạnh','ROOM'),(20,'Lò vi sóng','ROOM'),(21,'Bàn ủi','ROOM'),(22,'Cầu là','ROOM'),(23,'Điện thoại bàn','ROOM'),(24,'Đồng hồ báo thức','ROOM'),(25,'Ban công','ROOM'),(26,'View thành phố','ROOM'),(27,'View biển','ROOM'),(28,'View núi','ROOM'),(29,'Cách âm','ROOM'),(30,'Phòng thông nhau','ROOM'),(31,'Hồ bơi','HOTEL'),(32,'Hồ bơi trong nhà','HOTEL'),(33,'Hồ bơi ngoài trời','HOTEL'),(34,'Phòng gym','HOTEL'),(35,'Spa','HOTEL'),(36,'Xông hơi','HOTEL'),(37,'Dịch vụ massage','HOTEL'),(38,'Nhà hàng','HOTEL'),(39,'Quầy bar','HOTEL'),(40,'Quán cà phê','HOTEL'),(41,'Buffet sáng','HOTEL'),(42,'Bãi đỗ xe','HOTEL'),(43,'Dịch vụ valet parking','HOTEL'),(44,'Lễ tân 24/7','HOTEL'),(45,'Dịch vụ phòng','HOTEL'),(46,'Giặt là','HOTEL'),(47,'Giặt khô','HOTEL'),(48,'Thang máy','HOTEL'),(49,'Phòng hội nghị','HOTEL'),(50,'Trung tâm doanh nhân','HOTEL'),(51,'Đưa đón sân bay','HOTEL'),(52,'Thuê xe','HOTEL'),(53,'Khu vui chơi trẻ em','HOTEL'),(54,'Cho phép thú cưng','HOTEL'),(55,'Giữ hành lý','HOTEL'),(56,'Đổi ngoại tệ','HOTEL'),(57,'Phòng bida','HOTEL');
/*!40000 ALTER TABLE `utilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilities_hotel`
--

DROP TABLE IF EXISTS `utilities_hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilities_hotel` (
  `hotel_id` bigint NOT NULL,
  `utilities_id` bigint NOT NULL,
  PRIMARY KEY (`hotel_id`,`utilities_id`),
  KEY `FKid1c7j06eybmri8rvmmvmo2ou` (`utilities_id`),
  CONSTRAINT `FKid1c7j06eybmri8rvmmvmo2ou` FOREIGN KEY (`utilities_id`) REFERENCES `utilities` (`utilities_id`),
  CONSTRAINT `FKik4htptkq4ip3ymbdh7biqyqp` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilities_hotel`
--

LOCK TABLES `utilities_hotel` WRITE;
/*!40000 ALTER TABLE `utilities_hotel` DISABLE KEYS */;
INSERT INTO `utilities_hotel` VALUES (1,31),(2,31),(3,31),(4,31),(5,31),(6,31),(7,31),(8,31),(9,31),(10,31),(1,34),(2,34),(3,34),(4,34),(5,34),(6,34),(8,34),(9,34),(10,34),(1,35),(2,35),(3,35),(4,35),(7,35),(8,35),(9,35),(10,35),(2,36),(9,36),(1,37),(2,37),(8,37),(2,38),(4,38),(5,38),(6,38),(7,38),(10,38),(3,39),(4,39),(5,39),(7,39),(8,39),(9,39),(10,39),(2,40),(3,40),(4,40),(5,40),(9,40),(10,40),(1,42),(8,42),(2,44),(3,44),(4,44),(5,44),(6,44),(7,44),(8,44),(9,44),(10,44),(1,53),(5,53),(6,53),(7,53),(8,53),(9,53),(10,53),(5,54),(3,56),(5,56),(8,56),(3,57),(7,57);
/*!40000 ALTER TABLE `utilities_hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilities_room_type`
--

DROP TABLE IF EXISTS `utilities_room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilities_room_type` (
  `type_id` bigint NOT NULL,
  `utilities_id` bigint NOT NULL,
  PRIMARY KEY (`type_id`,`utilities_id`),
  KEY `FKogl81qs1gt6xsen801p1c98lc` (`utilities_id`),
  CONSTRAINT `FKb536eehs9ggu72nijnieunh5f` FOREIGN KEY (`type_id`) REFERENCES `room_types` (`type_id`),
  CONSTRAINT `FKogl81qs1gt6xsen801p1c98lc` FOREIGN KEY (`utilities_id`) REFERENCES `utilities` (`utilities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilities_room_type`
--

LOCK TABLES `utilities_room_type` WRITE;
/*!40000 ALTER TABLE `utilities_room_type` DISABLE KEYS */;
INSERT INTO `utilities_room_type` VALUES (43,2),(43,6),(1,8),(7,8),(43,8),(44,8),(43,11),(44,11),(1,16),(1,18),(44,18),(43,20),(1,25),(7,25),(44,25);
/*!40000 ALTER TABLE `utilities_room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'loud_hotel'
--

--
-- Dumping routines for database 'loud_hotel'
--
/*!50003 DROP PROCEDURE IF EXISTS `generate_rooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_rooms`()
BEGIN
    DECLARE h INT DEFAULT 1;
    DECLARE base_type INT;

    WHILE h <= 10 DO

        -- type đầu tiên của hotel hiện tại
        SET base_type = ((h - 1) * 6) + 1;


        INSERT INTO rooms(room_number, room_status, hotel_id, type_id)

        VALUES

        /* Standard Single */
        (201,'ACTIVE',h,base_type+5),
        (202,'ACTIVE',h,base_type+5),
        (203,'ACTIVE',h,base_type+5),
        (204,'ACTIVE',h,base_type+5),
        (205,'ACTIVE',h,base_type+5),
        (206,'ACTIVE',h,base_type+5),
        (207,'ACTIVE',h,base_type+5),
        (208,'ACTIVE',h,base_type+5),
        (209,'ACTIVE',h,base_type+5),
        (210,'ACTIVE',h,base_type+5),

        /* Standard Double */
        (301,'ACTIVE',h,base_type+4),
        (302,'ACTIVE',h,base_type+4),
        (303,'ACTIVE',h,base_type+4),
        (304,'ACTIVE',h,base_type+4),
        (305,'ACTIVE',h,base_type+4),
        (306,'ACTIVE',h,base_type+4),
        
        (401,'ACTIVE',h,base_type+4),
        (402,'ACTIVE',h,base_type+4),
        (403,'ACTIVE',h,base_type+4),
        (404,'ACTIVE',h,base_type+4),
        (405,'ACTIVE',h,base_type+4),
        (406,'ACTIVE',h,base_type+4),

        (501,'ACTIVE',h,base_type+4),
        (502,'ACTIVE',h,base_type+4),
        (503,'ACTIVE',h,base_type+4),
        (504,'ACTIVE',h,base_type+4),
        (505,'ACTIVE',h,base_type+4),
        (506,'ACTIVE',h,base_type+4),

        
        /* Twin */
        (601,'ACTIVE',h,base_type+3),
        (602,'ACTIVE',h,base_type+3),
        (603,'ACTIVE',h,base_type+3),
        (604,'ACTIVE',h,base_type+3),
        (605,'ACTIVE',h,base_type+3),
        
        (701,'ACTIVE',h,base_type+3),
        (702,'ACTIVE',h,base_type+3),
        (703,'ACTIVE',h,base_type+3),
        (704,'ACTIVE',h,base_type+3),
        (705,'ACTIVE',h,base_type+3),
        
        /* Deluxe */
        (801,'ACTIVE',h,base_type+2),
        (802,'ACTIVE',h,base_type+2),
        (803,'ACTIVE',h,base_type+2),
        (804,'ACTIVE',h,base_type+2),
        (805,'ACTIVE',h,base_type+2),
        (806,'ACTIVE',h,base_type+2),

        (901,'ACTIVE',h,base_type+2),
        (902,'ACTIVE',h,base_type+2),
        (903,'ACTIVE',h,base_type+2),
        (904,'ACTIVE',h,base_type+2),
        (905,'ACTIVE',h,base_type+2),
        (906,'ACTIVE',h,base_type+2),

        /* Family */
        (1001,'ACTIVE',h,base_type+1),
        (1002,'ACTIVE',h,base_type+1),
        (1003,'ACTIVE',h,base_type+1),
        (1004,'ACTIVE',h,base_type+1),
        (1005,'ACTIVE',h,base_type+1),

        (1101,'ACTIVE',h,base_type+1),
        (1102,'ACTIVE',h,base_type+1),
        (1103,'ACTIVE',h,base_type+1),
        (1104,'ACTIVE',h,base_type+1),
        (1105,'ACTIVE',h,base_type+1),

        /* Suite */
        (1201,'ACTIVE',h,base_type),
        (1202,'ACTIVE',h,base_type),
        (1203,'ACTIVE',h,base_type),
        (1204,'ACTIVE',h,base_type),
        (1205,'ACTIVE',h,base_type);

        SET h = h + 1;

    END WHILE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-14 15:24:20
