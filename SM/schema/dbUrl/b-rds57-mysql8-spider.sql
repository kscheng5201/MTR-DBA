-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: spider
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `aiqiyi_img`
--

DROP TABLE IF EXISTS `aiqiyi_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aiqiyi_img` (
  `video_url` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `time_length` varchar(20) DEFAULT NULL,
  `video_img` varchar(255) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `video_cloud_url` varchar(255) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `img_cloud_url` varchar(255) DEFAULT NULL,
  `img_path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`video_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bilibili_video`
--

DROP TABLE IF EXISTS `bilibili_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bilibili_video` (
  `video_url` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `summery` varchar(300) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `time_length` varchar(20) DEFAULT NULL,
  `video_img` varchar(255) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `video_cloud_url` varchar(255) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `img_cloud_url` varchar(255) DEFAULT NULL,
  `img_path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`video_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `douban_img`
--

DROP TABLE IF EXISTS `douban_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `douban_img` (
  `user_name` varchar(255) NOT NULL,
  `user_head_pic` varchar(255) DEFAULT NULL,
  `img_path` varchar(255) DEFAULT NULL,
  `tag` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hupu_sports`
--

DROP TABLE IF EXISTS `hupu_sports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hupu_sports` (
  `detailUrl` varchar(255) NOT NULL,
  `columnLabel` varchar(100) DEFAULT NULL,
  `insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`detailUrl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_football`
--

DROP TABLE IF EXISTS `youtube_football`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `youtube_football` (
  `video_url` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `time_length` varchar(20) DEFAULT NULL,
  `video_img` varchar(255) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `video_cloud_url` varchar(255) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `img_cloud_url` varchar(255) DEFAULT NULL,
  `img_path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`video_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zhibo8`
--

DROP TABLE IF EXISTS `zhibo8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zhibo8` (
  `video_url` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `time_length` varchar(20) DEFAULT NULL,
  `video_size` varchar(50) DEFAULT NULL,
  `column_label` varchar(100) DEFAULT NULL,
  `video_img` varchar(255) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `video_cloud_url` varchar(255) DEFAULT NULL,
  `insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tag` varchar(50) DEFAULT NULL,
  `img_cloud_url` varchar(255) DEFAULT NULL,
  `img_path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`video_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-14 14:34:23
