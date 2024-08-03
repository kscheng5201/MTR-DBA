-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-dark-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_dark
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
-- Table structure for table `channel_info`
--

DROP TABLE IF EXISTS `channel_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sort` int DEFAULT NULL COMMENT '杯赛/联赛(1=联赛、2=杯赛)',
  `merchant_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `channel_id` varchar(3) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道ID',
  `channel_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道名称',
  `channel_image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道图片',
  `page_template` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '页面模板',
  `channel_type` int DEFAULT NULL COMMENT '频道类型 1:体育类 2：其他 3:娱乐类',
  `status` int DEFAULT NULL COMMENT '状态(0=无效 1=有效)',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `lang` char(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `channel_sport_bind`
--

DROP TABLE IF EXISTS `channel_sport_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_sport_bind` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `merchantId` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `sport_type` int NOT NULL COMMENT '1 足球 2 篮球 99 其它',
  `channel_id` int NOT NULL COMMENT '频道id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epgs`
--

DROP TABLE IF EXISTS `epgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epgs` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `leisu_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '雷速id',
  `inner_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '内部比赛id',
  `match_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方比赛id',
  `sport_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '球类id 0其它 1足球 2篮球',
  `continent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '洲',
  `country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '国家',
  `lname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联赛名称',
  `extradata_round` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '比赛轮次',
  `hname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主队',
  `aname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客队',
  `source_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源',
  `stream_rtmp` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址',
  `stream_mu38` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_flv` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_rtmp_pic` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址',
  `stream_rtmp_status` text COLLATE utf8mb4_general_ci COMMENT '可用状态： false true',
  `stream_am_ali_rtmp` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址AmAli',
  `stream_am_ali_mu38` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_am_ali_flv` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_am_ali_rtmp_pic` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址AmAli',
  `stream_am_ali_rtmp_status` text COLLATE utf8mb4_general_ci COMMENT '可用状态： false true',
  `stream_na_live_rtmp` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址Na live',
  `stream_na_live_mu38` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_na_live_flv` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_na_live_rtmp_pic` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址Na live',
  `stream_na_live_rtmp_status` text COLLATE utf8mb4_general_ci COMMENT '可用状态： false true',
  `stream_na_ali_rtmp` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址Na liveali',
  `stream_na_ali_mu38` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_na_ali_flv` text COLLATE utf8mb4_general_ci COMMENT '流地址',
  `stream_na_ali_rtmp_pic` text COLLATE utf8mb4_general_ci COMMENT '赛事串流网址Na liveali',
  `stream_na_ali_rtmp_status` text COLLATE utf8mb4_general_ci COMMENT '可用状态： false true',
  `stream_na_anim` text COLLATE utf8mb4_general_ci COMMENT '赛事串流Na 动画',
  `stream_na_anim_pic` text COLLATE utf8mb4_general_ci COMMENT '赛事串流Na 动画',
  `stream_na_anim_status` text COLLATE utf8mb4_general_ci COMMENT '可用状态： false true',
  `stream_epg_rtmp` text COLLATE utf8mb4_general_ci COMMENT '赛事 直推 网址数组JSONARR',
  `anim_check` int DEFAULT '0' COMMENT '是否有动画 0没有 1有',
  `stream_check` int DEFAULT '0' COMMENT '是否有流地址 0没有 1有',
  `game_progress` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '赛事进行中时间时间',
  `game_time` datetime DEFAULT NULL COMMENT '比赛开始时间',
  `game_end_time` datetime DEFAULT NULL COMMENT '比赛结束时间',
  `game_stage` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '足球: 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `game_stage_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '足球: 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status_check` int DEFAULT '0' COMMENT '是否有任意流可用 0没有 1至少有1条状态为可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `match_id` (`match_id`),
  KEY `epgs_status_check_index` (`status_check`),
  KEY `idx_end_time` (`game_end_time`),
  KEY `idx_epgs_anim_check` (`anim_check`),
  KEY `idx_time` (`game_time`,`game_end_time`,`sport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34642 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sporttery_info`
--

DROP TABLE IF EXISTS `sporttery_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sporttery_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `match_id` bigint DEFAULT NULL COMMENT '比赛编号',
  `away_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队名称',
  `away_logo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客队logo',
  `event_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事名称',
  `home_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队名称',
  `home_logo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主队logo',
  `issue_no` varchar(40) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '期号',
  `lottery_date` varchar(40) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '开盘日期',
  `match_time` varchar(40) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '比赛时间',
  `score` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '比分',
  `rqspf` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '让球盘-胜平负',
  `spf` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '让球盘-胜平负',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9547 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sporttery_info2`
--

DROP TABLE IF EXISTS `sporttery_info2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sporttery_info2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `match_id` bigint DEFAULT NULL COMMENT '比赛编号',
  `away_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队名称',
  `away_logo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客队logo',
  `event_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事名称',
  `home_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队名称',
  `home_logo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主队logo',
  `issue_no` varchar(40) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '期号',
  `lottery_date` varchar(40) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '开盘日期',
  `match_time` varchar(40) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '比赛时间',
  `score` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '比分',
  `rqspf` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '让球盘-胜平负',
  `spf` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '让球盘-胜平负',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7645 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_channel_info`
--

DROP TABLE IF EXISTS `sub_channel_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_channel_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `channel_id` bigint NOT NULL COMMENT '频道id',
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '子频道名称',
  `feature` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '特征集合，","分割',
  `sort` int NOT NULL DEFAULT '1' COMMENT '排序',
  `enabled` int NOT NULL DEFAULT '1' COMMENT '是否启用 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`),
  KEY `idx_sub_channel_info_channel_id` (`channel_id`),
  KEY `idx_sub_channel_info_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:43
