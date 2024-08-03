-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_robot
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
-- Table structure for table `barrage`
--

DROP TABLE IF EXISTS `barrage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barrage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '弹幕内容',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `collect_id` bigint DEFAULT NULL COMMENT '弹幕库id',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barrage_collect`
--

DROP TABLE IF EXISTS `barrage_collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barrage_collect` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `barrage_collect_name` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '弹幕库名称',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1,有效，0，无效',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `弹幕库不可重复` (`barrage_collect_name`,`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barrage_tactics`
--

DROP TABLE IF EXISTS `barrage_tactics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barrage_tactics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tactics_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `send_type` int NOT NULL COMMENT '下发类型 1、全平台 2、直播间',
  `send_scope` int NOT NULL COMMENT '下发范围 sport_type 0:足球',
  `status` int NOT NULL COMMENT '状态分为：1待生效、2生效中、3已下线',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barrage_tactics_map`
--

DROP TABLE IF EXISTS `barrage_tactics_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barrage_tactics_map` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `barrage_collect_id` bigint NOT NULL,
  `barrage_tactics_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crawler_user_info`
--

DROP TABLE IF EXISTS `crawler_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crawler_user_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `用户唯一约束` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=92305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `robot_user`
--

DROP TABLE IF EXISTS `robot_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint NOT NULL,
  `merchant_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shadow_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `robot_type` int NOT NULL DEFAULT '0' COMMENT '0:普通机器人；1:官方主播',
  `origin_level` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '初始等级',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_robot_config`
--

DROP TABLE IF EXISTS `room_robot_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_robot_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '房间号',
  `status` int NOT NULL COMMENT '1，有效 2，无效',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `房价号不可重复` (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:21
