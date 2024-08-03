-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: yy_sport
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
-- Table structure for table `banned_to_post`
--

DROP TABLE IF EXISTS `banned_to_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banned_to_post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `anchor_id` bigint NOT NULL COMMENT '主播ID',
  `user_id` bigint NOT NULL COMMENT '被禁言用户ID',
  `time_long` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '禁言时长',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hot_degree`
--

DROP TABLE IF EXISTS `hot_degree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hot_degree` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `anchor_id` bigint NOT NULL DEFAULT '0' COMMENT '主播 id',
  `room_no` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '房间号',
  `live_record_id` bigint NOT NULL DEFAULT '0' COMMENT '直播记录 id',
  `hot_num` bigint NOT NULL DEFAULT '0' COMMENT '热力值',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态-0：关播;1：直播中',
  `channel_id` bigint DEFAULT NULL COMMENT '频道id',
  `match_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pk_status` int DEFAULT NULL COMMENT '是否pk状态-0：未pk;1：pk',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=380743 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='热力值';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_record_set`
--

DROP TABLE IF EXISTS `live_record_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_record_set` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户 id',
  `match_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` bigint NOT NULL DEFAULT '0' COMMENT '频道 id',
  `sub_channel_id` bigint DEFAULT '0' COMMENT '频道子id',
  `channel_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '频道名称',
  `home_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '主队名称',
  `away_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '客队名称',
  `room_no` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '房间号',
  `status` int NOT NULL DEFAULT '0' COMMENT '是否pk状态-0：未pk;1：pk',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sub_channel_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '频道子名称',
  PRIMARY KEY (`id`),
  KEY `idx_live_record_set_match_id` (`match_id`),
  KEY `idx_live_record_set_room_no` (`room_no`),
  KEY `idx_live_record_set_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170430 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='直播设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_manager`
--

DROP TABLE IF EXISTS `room_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_manager` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `anchor_id` bigint NOT NULL COMMENT '主播ID',
  `user_id` bigint NOT NULL COMMENT '房管用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_login_history`
--

DROP TABLE IF EXISTS `user_login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `login_startTime` timestamp NULL DEFAULT NULL COMMENT '登入时间',
  `login_endTime` timestamp NULL DEFAULT NULL COMMENT '登出时间',
  `source` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源，1:android 2：H5  3:ios 4:web_c ,0:其他',
  `user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户id',
  `status` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户登录状态 ，1:登入 2：登出',
  `merchant_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `client_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户的uid',
  `login_ip` varchar(45) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录ip',
  `register_ip` varchar(45) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '注册ip(客户需求，冗余显示)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_userIdStatus` (`user_id`,`source`,`status`,`merchant_id`) USING BTREE,
  KEY `idx_userIdTime` (`user_id`,`login_startTime`,`login_endTime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2623 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户登录历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_login_history11`
--

DROP TABLE IF EXISTS `user_login_history11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login_history11` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `login_startTime` timestamp NULL DEFAULT NULL COMMENT '登入时间',
  `login_endTime` timestamp NULL DEFAULT NULL COMMENT '登出时间',
  `source` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源，1:android 2：H5  3:ios 4:web_c ,0:其他',
  `user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户id',
  `status` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户登录状态 ，1:登入 2：登出',
  `merchant_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `client_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户的uid',
  PRIMARY KEY (`id`),
  KEY `idx_userIdStatus` (`user_id`,`source`,`status`,`merchant_id`) USING BTREE,
  KEY `idx_userIdTime` (`user_id`,`login_startTime`,`login_endTime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=682 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户登录历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_status`
--

DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户uid',
  `status` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '状态，1:登入 2：登出',
  `login_startTime` timestamp NULL DEFAULT NULL COMMENT '登录时间',
  `source` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源，1:android 2：H5  3:ios 4:web_c',
  `client_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户uid',
  `merchant_id` int DEFAULT NULL COMMENT '商户Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_userid` (`user_id`,`source`,`client_id`,`merchant_id`,`status`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户登录状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_status11`
--

DROP TABLE IF EXISTS `user_status11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status11` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户uid',
  `status` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '状态，1:登入 2：登出',
  `login_startTime` timestamp NULL DEFAULT NULL COMMENT '登录时间',
  `source` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源，1:android 2：H5  3:ios 4:web_c',
  `client_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户uid',
  `merchant_id` int DEFAULT NULL COMMENT '商户Id',
  PRIMARY KEY (`id`),
  KEY `idx_userid` (`user_id`,`source`,`client_id`,`merchant_id`,`status`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户登录状态表';
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

-- Dump completed on 2024-06-14 14:34:28
