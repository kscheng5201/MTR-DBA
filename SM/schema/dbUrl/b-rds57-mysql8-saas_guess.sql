-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_guess
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
-- Table structure for table `guess_permission`
--

DROP TABLE IF EXISTS `guess_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guess_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `status` int NOT NULL DEFAULT '0' COMMENT '0 关闭；1 开启',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guess_record`
--

DROP TABLE IF EXISTS `guess_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guess_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `joiner_uid` bigint NOT NULL DEFAULT '0' COMMENT '参与人',
  `guess_topic_item_id` bigint NOT NULL DEFAULT '0' COMMENT '参与话题项',
  `amount` bigint NOT NULL DEFAULT '0' COMMENT '投注数量',
  `option_key` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '投注项',
  `num` bigint NOT NULL DEFAULT '0' COMMENT '赢或者输的鹰币数量',
  `result` int NOT NULL DEFAULT '0' COMMENT '参与预言结果0-输，1-赢 2-流局',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_guess_topic_item_id` (`guess_topic_item_id`),
  KEY `idx_joiner_uid` (`joiner_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=106106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guess_topic`
--

DROP TABLE IF EXISTS `guess_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guess_topic` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '发表人',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `status` int NOT NULL DEFAULT '0' COMMENT '0 未完成； 1 已完成',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_id2` (`merchant_id`,`user_id`) USING BTREE,
  KEY `idx_room_no2` (`merchant_id`,`room_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guess_topic_item`
--

DROP TABLE IF EXISTS `guess_topic_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guess_topic_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `guess_topic_id` bigint NOT NULL DEFAULT '0' COMMENT '话题ID',
  `topic_type` int NOT NULL DEFAULT '0' COMMENT '预言类型0-主播预言 1-全民预言',
  `title` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主题',
  `options` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '选项,json',
  `result` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '-' COMMENT '结果',
  `join_nums` int NOT NULL DEFAULT '0' COMMENT '参与人数',
  `platform_amount` int NOT NULL DEFAULT '0' COMMENT '平台收益',
  `anchor_amount` int NOT NULL DEFAULT '0' COMMENT '主播收益',
  `start_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '开始时间',
  `end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '结束时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '0 进行中；1 已暂停（停止投注）; 2 已结束',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_guess_topic_id` (`guess_topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7570 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guess_topic_item_template`
--

DROP TABLE IF EXISTS `guess_topic_item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guess_topic_item_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '发表人',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `topic_type` int NOT NULL DEFAULT '0' COMMENT '预言类型0-主播预言 1-全民预言',
  `title` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主题',
  `options` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '选项,json',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-正常',
  `delta_time` bigint NOT NULL DEFAULT '0' COMMENT '增量时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:19
