-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_voice
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
-- Table structure for table `voice_category`
--

DROP TABLE IF EXISTS `voice_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voice_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家编号',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序字段',
  `active` int NOT NULL DEFAULT '1' COMMENT '状态是否有效 1-有效 0-无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='语聊室分类标签';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voice_image_audit`
--

DROP TABLE IF EXISTS `voice_image_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voice_image_audit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `room_no` varchar(32) CHARACTER SET utf8mb3 NOT NULL DEFAULT '',
  `item_type` int NOT NULL DEFAULT '0' COMMENT '关联业务类型 1-voice_item',
  `item_id` bigint NOT NULL DEFAULT '0' COMMENT '关联业务编号',
  `value` varchar(512) CHARACTER SET utf8mb3 NOT NULL DEFAULT '' COMMENT '审核的内容',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态 0-待审核 1-审核通过 2-审核未通过',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0-无效 1-有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voice_item`
--

DROP TABLE IF EXISTS `voice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voice_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `room_no` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `owner_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '房主',
  `title` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `cover_image` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '封面',
  `notice` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公告',
  `background_image` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '背景图',
  `hot_num` bigint NOT NULL DEFAULT '0' COMMENT '开播最大热力值',
  `welcome` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '欢迎语',
  `close_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '关播时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 关闭；1 开播中；',
  `topic_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '话题编号',
  `category_id` bigint NOT NULL DEFAULT '0' COMMENT '分类编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voice_music`
--

DROP TABLE IF EXISTS `voice_music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voice_music` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家编号',
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '歌曲名称',
  `author` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '作者',
  `icon` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '歌曲icon',
  `url` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '播放地址',
  `size` bigint NOT NULL DEFAULT '0' COMMENT '大小 byte',
  `play_count` bigint NOT NULL DEFAULT '0' COMMENT '播放次数',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-下架 1-上架',
  `upload_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '上传时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voice_recommendation`
--

DROP TABLE IF EXISTS `voice_recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voice_recommendation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家编号',
  `shadow_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '影子编号',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `position` int NOT NULL DEFAULT '0' COMMENT '位置 1-横向列表 2-瀑布流',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:22
