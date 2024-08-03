-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_match
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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL,
  `cn_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `continent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sport_id` int DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `channel_type` int DEFAULT NULL COMMENT '频道类型(1:直播内容 2：其他)',
  `status` int DEFAULT NULL COMMENT '状态(0=无效 1=有效)',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` bigint NOT NULL,
  `is_baijia` int DEFAULT NULL COMMENT '是否百家公司(1是0否)',
  `is_major` int DEFAULT NULL COMMENT '是否主流公司(1是0否)',
  `is_show` int DEFAULT NULL COMMENT '是否显示(1是0否)',
  `name_en` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '指数公司名称(英文)',
  `name_zh` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '指数公司名称(简体)',
  `name_zht` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '指数公司名称(繁体)',
  `sort` int DEFAULT NULL COMMENT '排序字段',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `cn_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `en_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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
  UNIQUE KEY `match_id` (`match_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28982 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epgs_log`
--

DROP TABLE IF EXISTS `epgs_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epgs_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求地址',
  `req` text COLLATE utf8mb4_general_ci COMMENT '请求报文',
  `res` mediumtext COLLATE utf8mb4_general_ci COMMENT '响应报文',
  `req_time` datetime DEFAULT NULL COMMENT '请求时间',
  `res_time` datetime DEFAULT NULL COMMENT '响应时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `match_info`
--

DROP TABLE IF EXISTS `match_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `match_id` bigint DEFAULT NULL COMMENT '比赛编号',
  `event_id` bigint DEFAULT NULL COMMENT '赛事编号',
  `event_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事名称',
  `event_type` int DEFAULT NULL COMMENT '杯赛/联赛(1=联赛、2=杯赛)',
  `category_id` bigint DEFAULT NULL COMMENT '所在洲编号',
  `category_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所在洲名称',
  `country_id` bigint DEFAULT NULL COMMENT '国家编号',
  `country_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '国家名称',
  `round_id` int DEFAULT NULL COMMENT '当前轮次',
  `home_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队名称',
  `home_logo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队logo',
  `home_score` int DEFAULT NULL COMMENT '主队比分',
  `away_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队名称',
  `away_logo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队logo',
  `away_score` int DEFAULT NULL COMMENT '客队比分',
  `match_status` int DEFAULT NULL COMMENT '比赛状态(0:比赛异常,1=未开赛,2=上半场,3=中场,4=下半场,5=加时赛,7=点球大战,8=完场,9=推迟,10=中断,12=取消,13=待定)',
  `match_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '比赛时间',
  `format_match_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '比赛时间格式化，冗余字段',
  `status` int DEFAULT NULL COMMENT '是否创建赛程(0=否，1=是)',
  `channel_id` bigint DEFAULT NULL COMMENT '渠道唯一标识',
  `channel_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '渠道名称',
  `first_half_start_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上半场开始时间',
  `next_half_start_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '下半场开始时间',
  `add_start_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '加时时间',
  `delete_status` int DEFAULT NULL COMMENT '删除状态:0未删除、1已删除',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_match_id` (`match_id`),
  KEY `index_match_time` (`match_time`),
  KEY `index_channel_id` (`channel_id`),
  KEY `index_format_time` (`format_match_time`),
  KEY `index_home_name` (`home_name`),
  KEY `index_match_status` (`match_status`),
  KEY `index_delete_status` (`delete_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `match_info_test`
--

DROP TABLE IF EXISTS `match_info_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_info_test` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `match_id` bigint DEFAULT NULL COMMENT '比赛编号',
  `event_id` bigint DEFAULT NULL COMMENT '赛事编号',
  `event_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事名称',
  `event_type` int DEFAULT NULL COMMENT '杯赛/联赛(1=联赛、2=杯赛)',
  `category_id` bigint DEFAULT NULL COMMENT '所在洲编号',
  `category_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所在洲名称',
  `country_id` bigint DEFAULT NULL COMMENT '国家编号',
  `country_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '国家名称',
  `round_id` int DEFAULT NULL COMMENT '当前轮次',
  `home_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队名称',
  `home_logo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队logo',
  `home_score` int DEFAULT NULL COMMENT '主队比分',
  `away_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队名称',
  `away_logo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队logo',
  `away_score` int DEFAULT NULL COMMENT '客队比分',
  `match_status` int DEFAULT NULL COMMENT '比赛状态(0:比赛异常,1=未开赛,2=上半场,3=中场,4=下半场,5=加时赛,7=点球大战,8=完场,9=推迟,10=中断,12=取消,13=待定)',
  `match_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '比赛时间',
  `format_match_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '比赛时间格式化，冗余字段',
  `status` int DEFAULT NULL COMMENT '是否创建赛程(0=否，1=是)',
  `channel_id` bigint DEFAULT NULL COMMENT '渠道唯一标识',
  `channel_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '渠道名称',
  `first_half_start_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上半场开始时间',
  `next_half_start_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '下半场开始时间',
  `add_start_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '加时时间',
  `delete_status` int DEFAULT NULL COMMENT '删除状态:0未删除、1已删除',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_match_id` (`match_id`),
  KEY `index_match_time` (`match_time`),
  KEY `index_channel_id` (`channel_id`),
  KEY `index_format_time` (`format_match_time`),
  KEY `index_home_name` (`home_name`),
  KEY `index_match_status` (`match_status`),
  KEY `index_delete_status` (`delete_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `match_merchant`
--

DROP TABLE IF EXISTS `match_merchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_merchant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `match_id` bigint DEFAULT NULL COMMENT '比赛编号',
  `status` int DEFAULT NULL COMMENT '是否创建赛程(0=否，1=是)',
  `channel_id` bigint DEFAULT NULL COMMENT '渠道唯一标识',
  `channel_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '渠道名称',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`),
  KEY `idx_merchant_id` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
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
) ENGINE=InnoDB AUTO_INCREMENT=734 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:20
