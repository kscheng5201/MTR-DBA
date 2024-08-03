-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-box-match-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: box_match
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
-- Table structure for table `api_invoke_log`
--

DROP TABLE IF EXISTS `api_invoke_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_invoke_log` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '供应商code',
  `api_desc` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '接口描述',
  `url` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '接口地址',
  `request` text COLLATE utf8mb4_bin COMMENT '请求参数',
  `response` longtext COLLATE utf8mb4_bin COMMENT '响应',
  `response_time` bigint DEFAULT NULL COMMENT '响应时间',
  `message` tinytext COLLATE utf8mb4_bin COMMENT '异常信息',
  `request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '请求时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_anchor_stream`
--

DROP TABLE IF EXISTS `base_anchor_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_anchor_stream` (
  `id` varchar(20) NOT NULL COMMENT '主键、流编号',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '联赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方赛事id',
  `anchor_name` varchar(200) DEFAULT NULL COMMENT '主播名称',
  `nickname` varchar(200) DEFAULT NULL COMMENT '主播昵称',
  `anchor_avatar` varchar(512) DEFAULT NULL COMMENT '主播头像',
  `info` varchar(200) DEFAULT NULL COMMENT '简介',
  `room_num` varchar(200) NOT NULL COMMENT '直播间房号',
  `cover` varchar(255) DEFAULT NULL COMMENT '节目封面',
  `preview` varchar(255) DEFAULT NULL COMMENT '赛事串流截图',
  `status` int NOT NULL COMMENT '0，不能播放；1，能播放',
  `stream_flv_url` varchar(255) DEFAULT '' COMMENT '流地址or动画地址',
  `stream_browser_url` varchar(255) DEFAULT NULL COMMENT '赛事串流网址.瀏覽器版本',
  `stream_m3u8_url` varchar(255) DEFAULT NULL,
  `stream_rtmp_url` varchar(255) DEFAULT NULL,
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_smss` (`source_code`,`sport_code`,`match_id`,`room_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='主播赛事流';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_event`
--

DROP TABLE IF EXISTS `base_basketball_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_event_i18n`
--

DROP TABLE IF EXISTS `base_basketball_event_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_event_i18n` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方联赛id',
  `merge_event_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '合并联赛id',
  `name_th` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '泰国',
  `name_vi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '越南',
  `name_ko` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '韩国',
  `name_br` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '巴西',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1552 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='篮球联赛多语言表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_event_mapping`
--

DROP TABLE IF EXISTS `base_basketball_event_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_event_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方篮球赛事ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛事表映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_match`
--

DROP TABLE IF EXISTS `base_basketball_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球联赛ID',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球客队ID',
  `season_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛季id',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-第一节、3-第一节完、4-第二节、5-第二节完、6-第三节、7-第三节完、8-第四节、9-加时、10-完场、11-中断、12-取消、13-延期、14-腰斩 15-待定',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_final_score` int DEFAULT '0' COMMENT '主队得分',
  `away_final_score` int DEFAULT '0' COMMENT '客队全场得分',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_match_mapping`
--

DROP TABLE IF EXISTS `base_basketball_match_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_match_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方篮球赛程ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛程映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_player`
--

DROP TABLE IF EXISTS `base_basketball_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_player` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_player_mapping`
--

DROP TABLE IF EXISTS `base_basketball_player_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_player_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisportfeijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方篮球球员ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`merge_id`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球员映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_season`
--

DROP TABLE IF EXISTS `base_basketball_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_season` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方赛事ID',
  `year` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '年度',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛季表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_season_mapping`
--

DROP TABLE IF EXISTS `base_basketball_season_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_season_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisportfeijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方篮球赛季ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛季映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_team`
--

DROP TABLE IF EXISTS `base_basketball_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方赛事ID',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_team_i18n`
--

DROP TABLE IF EXISTS `base_basketball_team_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_team_i18n` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三方球队id',
  `merge_team_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '合并球队id',
  `name_th` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '泰国',
  `name_vi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '越南',
  `name_ko` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '韩国',
  `name_br` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '巴西',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8735196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='篮球球队多语言表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_team_mapping`
--

DROP TABLE IF EXISTS `base_basketball_team_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_team_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方篮球球队ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `new_third_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '转换的第三方id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球队映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_basketball_team_skill_analysis`
--

DROP TABLE IF EXISTS `base_basketball_team_skill_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_basketball_team_skill_analysis` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方篮球联赛ID',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方比赛id',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方篮球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方篮球客队ID',
  `skill_analysis_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方技术统计类型编号',
  `home_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队值',
  `away_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队值',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ehas` (`source_code`,`event_id`,`match_id`,`home_team_id`,`away_team_id`,`skill_analysis_code`),
  KEY `idx_match_id` (`match_id`,`source_code`,`skill_analysis_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球队技术统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_category`
--

DROP TABLE IF EXISTS `base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_category` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际中文名称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际英文名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='洲际类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_category_mapping`
--

DROP TABLE IF EXISTS `base_category_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_category_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方洲际类别ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='洲际映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_country`
--

DROP TABLE IF EXISTS `base_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_country` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `category_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分类id',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家中文名称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家英文名称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `base_country_ibfk_1` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='国家表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_country_mapping`
--

DROP TABLE IF EXISTS `base_country_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_country_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方国家ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='国家映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_csgo_event`
--

DROP TABLE IF EXISTS `base_csgo_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_csgo_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='csgo联赛表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_csgo_match`
--

DROP TABLE IF EXISTS `base_csgo_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_csgo_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `h_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队ID',
  `a_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队ID',
  `location` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办地',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `status` varchar(1) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛事状态 (0:未开赛 1:进行中 2:完赛 3:延期 4:取消)',
  `bo` int DEFAULT '0' COMMENT '赛制/局数BO',
  `is_forfeit` int DEFAULT '0' COMMENT '是否弃权 0:否  1:是',
  `live_battle_index` int DEFAULT NULL COMMENT '实时比赛的局数',
  `map_bp` json DEFAULT NULL COMMENT '地图ban pick',
  `battle_ids` json DEFAULT NULL COMMENT '小局对战ID',
  `h_team_score` int DEFAULT NULL COMMENT '主队得分',
  `a_team_score` int DEFAULT NULL COMMENT '客队得分',
  `data_update_time` bigint DEFAULT '0' COMMENT '更新数据时间',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_kog_match` (`source_code`,`match_time`,`event_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='csgo赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_csgo_stream`
--

DROP TABLE IF EXISTS `base_csgo_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_csgo_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stream` (`source_code`,`sport_code`,`match_id`,`stream_tag`),
  KEY `idx_csgo_stream` (`source_code`,`match_id`,`stream_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='csgo赛事信号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_csgo_team`
--

DROP TABLE IF EXISTS `base_csgo_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_csgo_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='csgo队伍表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_dict`
--

DROP TABLE IF EXISTS `base_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_dict` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型code',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '来源code',
  `local_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '技术统计类型编号',
  `third_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '技术统计类型编号',
  `dict_type` int NOT NULL COMMENT '字典类型：0，技术指标 1，赛事事件',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '技术统计类型名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sl` (`sport_code`,`local_code`,`dict_type`),
  UNIQUE KEY `uk_st` (`sport_code`,`third_code`,`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='三方字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_dota2_event`
--

DROP TABLE IF EXISTS `base_dota2_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_dota2_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='dota2联赛表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_dota2_match`
--

DROP TABLE IF EXISTS `base_dota2_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_dota2_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `h_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队ID',
  `a_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队ID',
  `organizer` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办方',
  `organizer_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办方英文',
  `location` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办地',
  `location_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办地英文',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `status` varchar(1) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛事状态 (0:未开赛 1:进行中 2:完赛 3:延期 4:取消)',
  `round` int DEFAULT NULL COMMENT '轮次',
  `round_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '轮次名称',
  `round_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '轮次英文名称',
  `round_session` int DEFAULT '0' COMMENT '轮次排序。例如第一轮的第3个',
  `round_type` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '轮次类型。win胜者组、lose败者组、final最终',
  `bo` int DEFAULT '0' COMMENT '赛制/局数BO',
  `battle_ids` json DEFAULT NULL COMMENT '小局对战ID',
  `h_team_score` int DEFAULT NULL COMMENT '主队得分',
  `a_team_score` int DEFAULT NULL COMMENT '客队得分',
  `data_update_time` bigint DEFAULT '0' COMMENT '更新数据时间',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_dota2_match` (`source_code`,`match_time`,`event_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='dota2赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_dota2_stream`
--

DROP TABLE IF EXISTS `base_dota2_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_dota2_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stream` (`source_code`,`sport_code`,`match_id`,`stream_tag`),
  KEY `idx_dota2_stream` (`source_code`,`match_id`,`stream_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='dota2赛事信号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_dota2_team`
--

DROP TABLE IF EXISTS `base_dota2_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_dota2_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='dota2队伍表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_event`
--

DROP TABLE IF EXISTS `base_football_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `category_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际ID(base_category表id)',
  `country_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家ID(base_country表id)',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文繁体简称',
  `name_en` varchar(126) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `type` int DEFAULT '0' COMMENT '类型',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_event_i18n`
--

DROP TABLE IF EXISTS `base_football_event_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_event_i18n` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` int DEFAULT NULL COMMENT '第三方联赛id',
  `merge_event_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并联赛id',
  `name_th` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '泰国',
  `name_vi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '越南',
  `name_ko` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '韩国',
  `name_br` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '巴西',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7478 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛事表（国际）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_event_mapping`
--

DROP TABLE IF EXISTS `base_football_event_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_event_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球赛事ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛事表映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_formation`
--

DROP TABLE IF EXISTS `base_football_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_formation` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方比赛ID',
  `home_formation` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队阵型',
  `away_formation` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队阵型',
  `confirmed` int DEFAULT NULL COMMENT '0 否 1 是:是否确认是正式阵容，否则是预测阵容',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阵型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_formation_mapping`
--

DROP TABLE IF EXISTS `base_football_formation_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_formation_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球阵型ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阵型映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_0`
--

DROP TABLE IF EXISTS `base_football_incident_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_0` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_1`
--

DROP TABLE IF EXISTS `base_football_incident_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_1` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_10`
--

DROP TABLE IF EXISTS `base_football_incident_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_10` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_11`
--

DROP TABLE IF EXISTS `base_football_incident_11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_11` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_12`
--

DROP TABLE IF EXISTS `base_football_incident_12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_12` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_13`
--

DROP TABLE IF EXISTS `base_football_incident_13`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_13` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_14`
--

DROP TABLE IF EXISTS `base_football_incident_14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_14` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_15`
--

DROP TABLE IF EXISTS `base_football_incident_15`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_15` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_16`
--

DROP TABLE IF EXISTS `base_football_incident_16`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_16` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_17`
--

DROP TABLE IF EXISTS `base_football_incident_17`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_17` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_18`
--

DROP TABLE IF EXISTS `base_football_incident_18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_18` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_19`
--

DROP TABLE IF EXISTS `base_football_incident_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_19` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_2`
--

DROP TABLE IF EXISTS `base_football_incident_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_2` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_20`
--

DROP TABLE IF EXISTS `base_football_incident_20`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_20` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_21`
--

DROP TABLE IF EXISTS `base_football_incident_21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_21` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_22`
--

DROP TABLE IF EXISTS `base_football_incident_22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_22` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_23`
--

DROP TABLE IF EXISTS `base_football_incident_23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_23` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_24`
--

DROP TABLE IF EXISTS `base_football_incident_24`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_24` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_25`
--

DROP TABLE IF EXISTS `base_football_incident_25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_25` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_26`
--

DROP TABLE IF EXISTS `base_football_incident_26`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_26` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_27`
--

DROP TABLE IF EXISTS `base_football_incident_27`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_27` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_28`
--

DROP TABLE IF EXISTS `base_football_incident_28`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_28` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_29`
--

DROP TABLE IF EXISTS `base_football_incident_29`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_29` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_3`
--

DROP TABLE IF EXISTS `base_football_incident_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_3` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_30`
--

DROP TABLE IF EXISTS `base_football_incident_30`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_30` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_31`
--

DROP TABLE IF EXISTS `base_football_incident_31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_31` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_4`
--

DROP TABLE IF EXISTS `base_football_incident_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_4` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_5`
--

DROP TABLE IF EXISTS `base_football_incident_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_5` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_6`
--

DROP TABLE IF EXISTS `base_football_incident_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_6` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_7`
--

DROP TABLE IF EXISTS `base_football_incident_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_7` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_8`
--

DROP TABLE IF EXISTS `base_football_incident_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_8` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_9`
--

DROP TABLE IF EXISTS `base_football_incident_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_9` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `events` json DEFAULT NULL COMMENT '球队事件数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_incident_mapping`
--

DROP TABLE IF EXISTS `base_football_incident_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_incident_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球事件ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球事件映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_lineup`
--

DROP TABLE IF EXISTS `base_football_lineup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_lineup` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方比赛ID',
  `player_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方球员id',
  `first` int DEFAULT NULL COMMENT '是否首发',
  `position` varchar(5) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球员位置，F前锋 M中锋 D后卫 G守门员,其他为未知',
  `x` int DEFAULT NULL COMMENT '阵容x坐标 总共100',
  `y` int DEFAULT NULL COMMENT '阵容y坐标 总共100',
  `rating` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '评分',
  `belong` int DEFAULT NULL COMMENT '''发生方 0-中立,1-主队,2-客队''',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阵容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_lineup_mapping`
--

DROP TABLE IF EXISTS `base_football_lineup_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_lineup_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球阵容ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阵容映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_manager`
--

DROP TABLE IF EXISTS `base_football_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_manager` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球教练简体全称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球教练英文全称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球教练表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_manager_mapping`
--

DROP TABLE IF EXISTS `base_football_manager_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_manager_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球球队ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球教练映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_match`
--

DROP TABLE IF EXISTS `base_football_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方足球联赛ID',
  `season_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方赛季ID',
  `stage_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方阶段ID',
  `round_num` bigint DEFAULT '0' COMMENT '轮次',
  `group_num` varchar(20) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '组',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方足球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方足球客队ID',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_final_score` int DEFAULT '0' COMMENT '主队得分',
  `away_final_score` int DEFAULT '0' COMMENT '客队全场得分',
  `neutral` int DEFAULT '0' COMMENT '中立',
  `note` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '标注',
  `home_position` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队排名',
  `away_position` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队排名',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_match_mapping`
--

DROP TABLE IF EXISTS `base_football_match_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_match_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球赛程ID 关联base表id',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID ',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id 关联merge 表id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`),
  KEY `idx_third_id` (`third_id`),
  KEY `idx_mergeid_sourcecode_thirdid` (`merge_id`,`source_code`,`third_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛程映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_match_mapping-bak`
--

DROP TABLE IF EXISTS `base_football_match_mapping-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_match_mapping-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球赛程ID 关联base表id',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID ',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id 关联merge 表id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`),
  KEY `idx_third_id` (`third_id`),
  KEY `idx_mergeid_sourcecode_thirdid` (`merge_id`,`source_code`,`third_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛程映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_player`
--

DROP TABLE IF EXISTS `base_football_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_player` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `country_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方国家ID',
  `team_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方球队ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文繁体简称',
  `name_en` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `birthday` int DEFAULT '0' COMMENT '生日',
  `weight` int DEFAULT '0' COMMENT '体重',
  `height` int DEFAULT '0' COMMENT '身高',
  `nationality` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国籍',
  `market_value` int DEFAULT '0' COMMENT '身价',
  `market_value_currency` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '币别',
  `contract_until` int DEFAULT '0' COMMENT '合约到期时间',
  `position` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '位置',
  `positions` json DEFAULT NULL COMMENT '候补位置',
  `preferred_foot` int DEFAULT '0' COMMENT '首发替换、这块不清楚、文档未描述、后期补',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_player_mapping`
--

DROP TABLE IF EXISTS `base_football_player_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_player_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球球员ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`,`merge_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球员映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_season`
--

DROP TABLE IF EXISTS `base_football_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_season` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方赛事ID',
  `year` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '年度',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛季表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_season_mapping`
--

DROP TABLE IF EXISTS `base_football_season_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_season_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球赛季ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛季映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_stage`
--

DROP TABLE IF EXISTS `base_football_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_stage` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `season_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方赛季ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段中文名称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段英文名称',
  `mode` int NOT NULL DEFAULT '0' COMMENT '比赛模式',
  `group_count` int NOT NULL DEFAULT '0' COMMENT '总组数',
  `round_count` int NOT NULL DEFAULT '0' COMMENT '总轮数',
  `order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阶段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_stage_mapping`
--

DROP TABLE IF EXISTS `base_football_stage_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_stage_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球阶段ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阶段映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_team`
--

DROP TABLE IF EXISTS `base_football_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `manager_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方足球教练ID',
  `venue_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方足球场馆ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `national` int DEFAULT '0' COMMENT '是否国家队 1-是 0-否',
  `foundation_time` int DEFAULT '0' COMMENT '成立时间',
  `website` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队官网',
  `market_value` int DEFAULT '0' COMMENT '市值',
  `market_value_currency` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '币别',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_team_i18n`
--

DROP TABLE IF EXISTS `base_football_team_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_team_i18n` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `team_id` int DEFAULT NULL COMMENT '第三方球队id',
  `merge_team_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并球队id',
  `name_th` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '泰国',
  `name_vi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '越南',
  `name_ko` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '韩国',
  `name_br` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '巴西',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135666 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队表（国际）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_team_mapping`
--

DROP TABLE IF EXISTS `base_football_team_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_team_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球球队ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `new_third_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '新第三方id',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_team_skill_analysis`
--

DROP TABLE IF EXISTS `base_football_team_skill_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_team_skill_analysis` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方足球联赛ID',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方比赛id',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方足球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方足球客队ID',
  `skill_analysis_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方技术统计类型编号',
  `home_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队值',
  `away_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队值',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ehas` (`source_code`,`event_id`,`match_id`,`home_team_id`,`away_team_id`,`skill_analysis_code`),
  KEY `idx_match_id` (`match_id`,`source_code`,`skill_analysis_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队技术统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_venue`
--

DROP TABLE IF EXISTS `base_football_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_venue` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆中文名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆英文名称',
  `capacity` int DEFAULT '0' COMMENT '容量',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球场馆表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_football_venue_mapping`
--

DROP TABLE IF EXISTS `base_football_venue_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_football_venue_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球场馆ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球场馆映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_kog_event`
--

DROP TABLE IF EXISTS `base_kog_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_kog_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='王者荣耀联赛表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_kog_match`
--

DROP TABLE IF EXISTS `base_kog_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_kog_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `h_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队ID',
  `a_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队ID',
  `location` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办地',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `status` varchar(1) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛事状态 (0:未开赛 1:进行中 2:完赛 3:延期 4:取消)',
  `round_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '轮次名称',
  `round_son_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '子轮次名称',
  `bo` int DEFAULT '0' COMMENT '赛制/局数BO',
  `battle_ids` json DEFAULT NULL COMMENT '小局对战ID',
  `h_team_score` int DEFAULT NULL COMMENT '主队得分',
  `a_team_score` int DEFAULT NULL COMMENT '客队得分',
  `data_update_time` bigint DEFAULT '0' COMMENT '更新数据时间',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_kog_match` (`source_code`,`match_time`,`event_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='王者荣耀赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_kog_stream`
--

DROP TABLE IF EXISTS `base_kog_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_kog_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stream` (`source_code`,`sport_code`,`match_id`,`stream_tag`),
  KEY `idx_kog_stream` (`source_code`,`match_id`,`stream_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='王者荣耀赛事信号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_kog_team`
--

DROP TABLE IF EXISTS `base_kog_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_kog_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='王者荣耀队伍表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_lineup_zan`
--

DROP TABLE IF EXISTS `base_lineup_zan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lineup_zan` (
  `id` varchar(20) NOT NULL COMMENT '主键、流编号',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '联赛类型（运动类别）',
  `match_id` varchar(20) NOT NULL COMMENT 'zan端-赛事id',
  `event_id` varchar(20) NOT NULL COMMENT 'zan端-联赛id',
  `h_team_id` varchar(50) DEFAULT '' COMMENT '主队球队id',
  `h_formation` varchar(20) NOT NULL DEFAULT '' COMMENT '主队阵行 ex.4-4-2、4-2-3-1等',
  `h_lineup` json NOT NULL COMMENT '主队先发阵容',
  `h_bench` json NOT NULL COMMENT '主队板凳阵容',
  `a_team_id` varchar(50) NOT NULL DEFAULT '' COMMENT '客队球队ID',
  `a_formation` varchar(20) NOT NULL DEFAULT '' COMMENT '客队阵行 ex.4-4-2、4-2-3-1等',
  `a_lineup` json NOT NULL COMMENT '客队先发阵容',
  `a_bench` json NOT NULL COMMENT '客队板凳阵容',
  `is_lock` int DEFAULT '0' COMMENT '是否锁定 0否 1是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='球队阵容表-zan';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_lol_event`
--

DROP TABLE IF EXISTS `base_lol_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lol_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='lol联赛表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_lol_match`
--

DROP TABLE IF EXISTS `base_lol_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lol_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `h_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队ID',
  `a_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队ID',
  `location` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举办地',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `status` varchar(1) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛事状态 (0:未开赛 1:进行中 2:完赛 3:延期 4:取消)',
  `round_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '轮次名称',
  `round_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '轮次英文名称',
  `round_son_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '子轮次名称',
  `bo` int DEFAULT '0' COMMENT '赛制/局数BO',
  `battle_ids` json DEFAULT NULL COMMENT '小局对战ID',
  `h_team_score` int DEFAULT NULL COMMENT '主队得分',
  `a_team_score` int DEFAULT NULL COMMENT '客队得分',
  `data_update_time` bigint DEFAULT '0' COMMENT '更新数据时间',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_lol_match` (`source_code`,`match_time`,`event_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='lol赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_lol_stream`
--

DROP TABLE IF EXISTS `base_lol_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lol_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stream` (`source_code`,`sport_code`,`match_id`,`stream_tag`),
  KEY `idx_lol_stream` (`source_code`,`match_id`,`stream_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='lol赛事信号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_lol_team`
--

DROP TABLE IF EXISTS `base_lol_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lol_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛ID',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '队伍logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='lol队伍表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_match_stream`
--

DROP TABLE IF EXISTS `base_match_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_match_stream` (
  `id` varchar(20) NOT NULL COMMENT '主键、流编号',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '联赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方赛事id',
  `league_name` varchar(255) NOT NULL DEFAULT '' COMMENT '联赛名称',
  `home_team_name` varchar(255) NOT NULL DEFAULT '' COMMENT '主队名称',
  `away_team_name` varchar(255) NOT NULL DEFAULT '' COMMENT '客队名称',
  `match_time` varchar(255) DEFAULT '' COMMENT '比赛时间',
  `preview` varchar(255) DEFAULT NULL COMMENT '赛事串流截图',
  `status` int NOT NULL COMMENT '0，不能播放；1，能播放',
  `stream_source` varchar(100) DEFAULT '' COMMENT '流来源：stream/streamAmAli/streamNa-live/streamNa-liveali/streamNa-anim',
  `stream_flv_url` varchar(255) DEFAULT '' COMMENT '流地址or动画地址',
  `stream_anim_url` varchar(255) DEFAULT NULL,
  `stream_m3u8_url` varchar(255) DEFAULT NULL,
  `stream_rtmp_url` varchar(255) DEFAULT NULL,
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_smss` (`source_code`,`match_id`,`sport_code`,`stream_source`) USING BTREE,
  KEY `nk_match_id` (`match_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='赛事流';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_match_stream_log`
--

DROP TABLE IF EXISTS `base_match_stream_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_match_stream_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) DEFAULT NULL COMMENT '联赛类型',
  `match_id` varchar(20) DEFAULT NULL COMMENT '三方赛事id',
  `stream_type` int DEFAULT NULL COMMENT '流类型:0，清理；1，主播流',
  `preview` varchar(255) DEFAULT NULL COMMENT '赛事串流截图',
  `status` int DEFAULT NULL COMMENT '0，不能播放；1，能播放',
  `stream_source` varchar(100) DEFAULT '' COMMENT '流来源：stream/streamAmAli/streamNa-live/streamNa-liveali/streamNa-anim',
  `stream_flv_url` varchar(255) DEFAULT '' COMMENT '流地址or动画地址',
  `stream_anim_url` varchar(255) DEFAULT NULL,
  `stream_m3u8_url` varchar(255) DEFAULT NULL,
  `stream_rtmp_url` varchar(255) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_match_id` (`match_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26396595 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='赛事流';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_0`
--

DROP TABLE IF EXISTS `base_odds_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_0` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id mapping表里的thrid_id ',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_1`
--

DROP TABLE IF EXISTS `base_odds_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_1` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_10`
--

DROP TABLE IF EXISTS `base_odds_10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_10` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_11`
--

DROP TABLE IF EXISTS `base_odds_11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_11` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_12`
--

DROP TABLE IF EXISTS `base_odds_12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_12` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_13`
--

DROP TABLE IF EXISTS `base_odds_13`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_13` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_14`
--

DROP TABLE IF EXISTS `base_odds_14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_14` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_15`
--

DROP TABLE IF EXISTS `base_odds_15`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_15` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_16`
--

DROP TABLE IF EXISTS `base_odds_16`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_16` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_17`
--

DROP TABLE IF EXISTS `base_odds_17`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_17` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_18`
--

DROP TABLE IF EXISTS `base_odds_18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_18` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_19`
--

DROP TABLE IF EXISTS `base_odds_19`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_19` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_2`
--

DROP TABLE IF EXISTS `base_odds_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_2` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_20`
--

DROP TABLE IF EXISTS `base_odds_20`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_20` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_21`
--

DROP TABLE IF EXISTS `base_odds_21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_21` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_22`
--

DROP TABLE IF EXISTS `base_odds_22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_22` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_23`
--

DROP TABLE IF EXISTS `base_odds_23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_23` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_24`
--

DROP TABLE IF EXISTS `base_odds_24`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_24` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_25`
--

DROP TABLE IF EXISTS `base_odds_25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_25` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_26`
--

DROP TABLE IF EXISTS `base_odds_26`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_26` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_27`
--

DROP TABLE IF EXISTS `base_odds_27`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_27` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_28`
--

DROP TABLE IF EXISTS `base_odds_28`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_28` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_29`
--

DROP TABLE IF EXISTS `base_odds_29`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_29` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_3`
--

DROP TABLE IF EXISTS `base_odds_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_3` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_30`
--

DROP TABLE IF EXISTS `base_odds_30`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_30` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_31`
--

DROP TABLE IF EXISTS `base_odds_31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_31` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_4`
--

DROP TABLE IF EXISTS `base_odds_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_4` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_5`
--

DROP TABLE IF EXISTS `base_odds_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_5` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_6`
--

DROP TABLE IF EXISTS `base_odds_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_6` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_7`
--

DROP TABLE IF EXISTS `base_odds_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_7` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_8`
--

DROP TABLE IF EXISTS `base_odds_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_8` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_9`
--

DROP TABLE IF EXISTS `base_odds_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_9` (
  `id` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `odds` json DEFAULT NULL COMMENT '指数数据',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`,`sport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='第三方指数数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_company`
--

DROP TABLE IF EXISTS `base_odds_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_company` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '赔率公司中文名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赔率公司英文名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='赔率公司表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_odds_company_mapping`
--

DROP TABLE IF EXISTS `base_odds_company_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_odds_company_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方赔率公司ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='赔率公司映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_event`
--

DROP TABLE IF EXISTS `base_other_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_id` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '体育类型',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事英文简称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `uk` (`source_code`,`sport_id`,`name_zh`,`short_name_zh`,`name_zht`,`short_name_zht`,`name_en`,`short_name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='其他赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_event_mapping`
--

DROP TABLE IF EXISTS `base_other_event_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_event_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方赛事ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '本地体育类型',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛事表映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_match`
--

DROP TABLE IF EXISTS `base_other_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方其他联赛ID',
  `sport_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方体育类型',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方其他主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方其他客队ID',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-比赛中、3-已结束',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_score` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队得分',
  `away_score` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队得分',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_eha` (`source_code`,`event_id`,`home_team_id`,`away_team_id`,`match_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='其他赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_match_mapping`
--

DROP TABLE IF EXISTS `base_other_match_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_match_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '本地体育类型',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方赛程ID',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`),
  KEY `nk_third_id` (`third_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='综合赛程映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_player`
--

DROP TABLE IF EXISTS `base_other_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_player` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_id` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '体育类型',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文繁体简称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员英文全称',
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`source_code`,`sport_id`,`name_zh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='运动员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_player_mapping`
--

DROP TABLE IF EXISTS `base_other_player_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_player_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisportfeijing',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '本地体育类型',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我方运动员ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球员映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_team`
--

DROP TABLE IF EXISTS `base_other_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '数据来源code',
  `sport_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '三方赛事ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文繁体简称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队英文全称',
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='团队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_other_team_mapping`
--

DROP TABLE IF EXISTS `base_other_team_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_other_team_mapping` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'leisu' COMMENT 'zan/leisu/188/hg/aisport/feijing',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '本地体育类型',
  `our_id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '我队ID',
  `merge_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合并id，默认为本地数据id',
  `third_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方ID',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_third_id` (`source_code`,`third_id`),
  KEY `idx_merge_id` (`merge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球队映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_source`
--

DROP TABLE IF EXISTS `base_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_source` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '来源编号',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '来源名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='数据来源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `base_spider_match_live_stream`
--

DROP TABLE IF EXISTS `base_spider_match_live_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_spider_match_live_stream` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '数据来源code qh、tx、aqy、pp',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型 对应sport表code码',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `match_type_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛类型ID',
  `match_type_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛类型名称',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛id',
  `event_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛名称',
  `home_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队id',
  `home_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队名称',
  `away_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队id',
  `away_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队名称',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间-时间戳',
  `element` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '爬虫扩展信息元素',
  `flv_url` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'flv流地址',
  `flv_url_exentd` json DEFAULT NULL COMMENT 'rtmp流地址扩展',
  `m3u8_url` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'm3u8流地址',
  `m3u8_url_exentd` json DEFAULT NULL COMMENT 'rtmp流地址扩展',
  `rtmp_url` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'rtmp流地址',
  `rtmp_url_extend` json DEFAULT NULL COMMENT 'rtmp流地址扩展',
  `status` int NOT NULL DEFAULT '0' COMMENT '比赛状态 0 未开始 1 进行中 2结束',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='比赛爬虫流地址信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_csgo_stream`
--

DROP TABLE IF EXISTS `log_csgo_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_csgo_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='csgo赛事信号日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_dota2_stream`
--

DROP TABLE IF EXISTS `log_dota2_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_dota2_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='dota2赛事信号日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_kog_stream`
--

DROP TABLE IF EXISTS `log_kog_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_kog_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='王者荣耀赛事信号日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_lol_stream`
--

DROP TABLE IF EXISTS `log_lol_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_lol_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '比赛类型',
  `match_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '三方比赛id',
  `stream_tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频标签',
  `stream_vid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频编号',
  `preview` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频截图(url)',
  `stream_rtmp_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(rtmp)',
  `stream_flv_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(flv)',
  `stream_m3u8_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频网址(m3u8)',
  `status` int DEFAULT '0' COMMENT '0，不能播放；1，能播放',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='lol赛事信号日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_spider_match_live_stream`
--

DROP TABLE IF EXISTS `log_spider_match_live_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_spider_match_live_stream` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '数据来源code qh、tx、aqy、pp',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型 对应sport表code码',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方比赛id',
  `match_type_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛类型ID',
  `match_type_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛类型名称',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛id',
  `event_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛名称',
  `home_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队id',
  `home_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队名称',
  `away_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队id',
  `away_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队名称',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='比赛爬虫流地址信息日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_anchor_stream`
--

DROP TABLE IF EXISTS `merge_anchor_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_anchor_stream` (
  `id` varchar(20) NOT NULL COMMENT '主键、流编号',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '联赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '本地赛事id',
  `anchor_name` varchar(200) DEFAULT NULL COMMENT '主播名称',
  `nickname` varchar(200) DEFAULT NULL COMMENT '主播昵称',
  `anchor_avatar` varchar(512) DEFAULT NULL COMMENT '主播头像',
  `info` varchar(200) DEFAULT NULL COMMENT '简介',
  `cover` varchar(255) DEFAULT NULL COMMENT '节目封面',
  `room_num` varchar(200) NOT NULL COMMENT '直播间房号',
  `preview` varchar(255) DEFAULT NULL COMMENT '赛事串流截图',
  `status` int NOT NULL COMMENT '0，不能播放；1，能播放',
  `stream_flv_url` varchar(255) DEFAULT '' COMMENT '流地址or动画地址',
  `stream_browser_url` varchar(255) DEFAULT NULL COMMENT '赛事串流网址.瀏覽器版本',
  `stream_m3u8_url` varchar(255) DEFAULT NULL,
  `stream_rtmp_url` varchar(255) DEFAULT NULL,
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_smss` (`sport_code`,`match_id`,`room_num`),
  KEY `idx_match_id` (`match_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='主播赛事流';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_basketball_event`
--

DROP TABLE IF EXISTS `merge_basketball_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_basketball_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `my_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义名称',
  `my_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `name_th` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事泰语',
  `name_vi` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事越南语',
  `name_ko` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事韩语',
  `name_br` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球赛事巴西语',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_basketball_match`
--

DROP TABLE IF EXISTS `merge_basketball_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_basketball_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方篮球联赛ID',
  `home_team_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方篮球主队ID',
  `away_team_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方篮球客队ID',
  `season_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛季id',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-第一节、3-第一节完、4-第二节、5-第二节完、6-第三节、7-第三节完、8-第四节、9-加时、10-完场、11-中断、12-取消、13-延期、14-腰斩 15-待定',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_final_score` int DEFAULT '0' COMMENT '主队得分',
  `away_final_score` int DEFAULT '0' COMMENT '客队全场得分',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `my_event_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义联赛名称',
  `my_event_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义联赛logo',
  `my_home_team_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队名称',
  `my_home_team_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队logo',
  `my_away_team_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队名称',
  `my_away_team_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队logo',
  `my_status_id` int DEFAULT NULL COMMENT '自定义比赛状态 1-未开赛、2-第一节、3-第一节完、4-第二节、5-第二节完、6-第三节、7-第三节完、8-第四节、9-加时、10-完场、11-中断、12-取消、13-延期、14-腰斩 15-待定',
  `my_status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义比赛状态(中文描述)',
  `my_match_time` bigint DEFAULT NULL COMMENT '自定义比赛时间',
  `my_match_endtime` bigint DEFAULT NULL COMMENT '自定义赛事结束时间(预计)',
  `my_home_final_score` int DEFAULT NULL COMMENT '自定义主队得分',
  `my_away_final_score` int DEFAULT NULL COMMENT '自定义客队全场得分',
  `is_my` int NOT NULL DEFAULT '0' COMMENT '是否自建 0 否 1 是',
  `is_hidden` int NOT NULL DEFAULT '0' COMMENT '是否隐藏 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `status_id_lock` int NOT NULL DEFAULT '0' COMMENT '比赛状态修改状态锁(1:有锁 0:无锁)',
  `match_time_lock` int NOT NULL DEFAULT '0' COMMENT '时间修改状态锁(1:有锁 0:无锁)',
  `final_score_lock` int NOT NULL DEFAULT '0' COMMENT '得分修改状态锁(1:有锁 0:无锁)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_eha` (`event_id`,`home_team_id`,`away_team_id`,`match_time`),
  KEY `idx_id` (`id`),
  KEY `idx_match_time` (`match_time`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `idx_update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_basketball_player`
--

DROP TABLE IF EXISTS `merge_basketball_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_basketball_player` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球员英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`source_code`,`name_zh`,`short_name_zh`,`name_en`,`short_name_en`) USING BTREE,
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_basketball_season`
--

DROP TABLE IF EXISTS `merge_basketball_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_basketball_season` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `year` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '年度',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_year` (`event_id`,`year`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球赛季表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_basketball_team`
--

DROP TABLE IF EXISTS `merge_basketball_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_basketball_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文简称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文繁体全称',
  `short_name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `my_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义名称',
  `my_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `name_th` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队泰语',
  `name_vi` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队越南语',
  `name_ko` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队韩语',
  `name_br` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '篮球球队巴西语',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_basketball_team_skill_analysis`
--

DROP TABLE IF EXISTS `merge_basketball_team_skill_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_basketball_team_skill_analysis` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '我方篮球联赛ID',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方比赛id',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '我方篮球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '我方篮球客队ID',
  `skill_analysis_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方技术统计类型编号',
  `home_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队值',
  `away_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队值',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ehas` (`source_code`,`event_id`,`match_id`,`home_team_id`,`away_team_id`,`skill_analysis_code`),
  KEY `idx_match_id` (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='篮球球队技术统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_category`
--

DROP TABLE IF EXISTS `merge_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_category` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际中文名称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际英文名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`name_zh`,`source_code`) USING BTREE,
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='洲际类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_category-bak`
--

DROP TABLE IF EXISTS `merge_category-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_category-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际中文名称',
  `name_zht` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '洲际英文名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`name_zh`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='洲际类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_country`
--

DROP TABLE IF EXISTS `merge_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_country` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `category_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分类id(merge_category表id字段)',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家中文名称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家英文名称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`category_id`,`name_zh`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='国家表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_country-bak`
--

DROP TABLE IF EXISTS `merge_country-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_country-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `category_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分类id(merge_category表id字段)',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家中文名称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家英文名称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国家logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`category_id`,`name_zh`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='国家表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_dict`
--

DROP TABLE IF EXISTS `merge_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_dict` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型code',
  `code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '技术统计类型编号',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '技术统计类型名称',
  `dict_type` int NOT NULL COMMENT '0,技术指标；1，赛事事件',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sport_code` (`sport_code`,`code`,`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='技术统计类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_event`
--

DROP TABLE IF EXISTS `merge_football_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `category_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方洲际ID',
  `country_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方国家ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文繁体简称',
  `name_en` varchar(126) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `my_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义名称',
  `my_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义logo',
  `type` int DEFAULT '0' COMMENT '类型',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `name_th` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事泰语',
  `name_vi` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事越南语',
  `name_ko` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事韩语',
  `name_br` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事巴西语',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`category_id`,`country_id`,`name_zh`,`short_name_zh`,`name_en`,`short_name_en`),
  KEY `idx_name_zh` (`name_zht`),
  KEY `idx_short_name_zh` (`short_name_zh`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `merge_football_event_ibfk_2` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_event-bak`
--

DROP TABLE IF EXISTS `merge_football_event-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_event-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `category_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方洲际ID',
  `country_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方国家ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事中文繁体简称',
  `name_en` varchar(126) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事英文全称',
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球赛事英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `my_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义名称',
  `my_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义logo',
  `type` int DEFAULT '0' COMMENT '类型',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`category_id`,`country_id`,`name_zh`,`short_name_zh`,`name_en`,`short_name_en`),
  KEY `idx_name_zh` (`name_zht`),
  KEY `idx_short_name_zh` (`short_name_zh`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `merge_football_event_ibfk_2` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_formation`
--

DROP TABLE IF EXISTS `merge_football_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_formation` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方比赛ID',
  `home_formation` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队阵型',
  `away_formation` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队阵型',
  `confirmed` int DEFAULT NULL COMMENT '0 否 1 是:是否确认是正式阵容，否则是预测阵容',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_m` (`match_id`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阵型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_incident`
--

DROP TABLE IF EXISTS `merge_football_incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_incident` (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `match_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '我方比赛ID',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '事件类型',
  `time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '事件发生时间（含加时时间）',
  `minute` int DEFAULT NULL COMMENT '事件发生时比赛分钟数',
  `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '加时时间（eg:中场时间伤停两分钟 time:45+2 minute:45 addtime:2）',
  `belong` int DEFAULT NULL COMMENT '发生方 0-中立,1-主队,2-客队',
  `player` json DEFAULT NULL COMMENT '球员信息:[球员id,球员id,球员id]',
  `text` text COLLATE utf8mb4_general_ci COMMENT '文本描述',
  `home_score` int DEFAULT NULL COMMENT '主队比分',
  `away_score` int DEFAULT NULL COMMENT '客队比分',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='足球事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_lineup`
--

DROP TABLE IF EXISTS `merge_football_lineup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_lineup` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方比赛ID',
  `player_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方球员id',
  `first` int DEFAULT NULL COMMENT '是否首发',
  `position` varchar(5) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球员位置，F前锋 M中锋 D后卫 G守门员,其他为未知',
  `x` int DEFAULT NULL COMMENT '阵容x坐标 总共100',
  `y` int DEFAULT NULL COMMENT '阵容y坐标 总共100',
  `rating` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '评分',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `belong` int DEFAULT NULL COMMENT '''发生方 0-中立,1-主队,2-客队''',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_smp` (`match_id`,`player_id`,`belong`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阵容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_manager`
--

DROP TABLE IF EXISTS `merge_football_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_manager` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球教练简体全称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球教练英文全称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `name_zh` (`name_zh`,`name_en`,`logo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球教练表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_match`
--

DROP TABLE IF EXISTS `merge_football_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球联赛ID',
  `season_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛季ID',
  `stage_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方阶段ID',
  `round_num` bigint DEFAULT '0' COMMENT '轮次',
  `group_num` bigint DEFAULT '0' COMMENT '组',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球客队ID',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_final_score` int DEFAULT '0' COMMENT '主队得分',
  `away_final_score` int DEFAULT '0' COMMENT '客队全场得分',
  `neutral` int DEFAULT '0' COMMENT '中立',
  `note` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '标注',
  `home_position` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队排名',
  `away_position` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队排名',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `my_event_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义联赛名称',
  `my_event_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义联赛logo',
  `my_home_team_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队名称',
  `my_home_team_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队logo',
  `my_away_team_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队名称',
  `my_away_team_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队logo',
  `my_status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `my_status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义比赛状态(中文描述)',
  `my_match_time` bigint DEFAULT NULL COMMENT '自定义比赛时间',
  `my_match_endtime` bigint DEFAULT NULL COMMENT '自定义赛事结束时间(预计)',
  `my_home_final_score` int DEFAULT NULL COMMENT '自定义主队得分',
  `my_away_final_score` int DEFAULT NULL COMMENT '自定义客队全场得分',
  `is_my` int NOT NULL DEFAULT '0' COMMENT '是否自建 0 否 1 是',
  `is_hidden` int NOT NULL DEFAULT '0' COMMENT '是否隐藏 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `round_num_lock` int NOT NULL DEFAULT '0' COMMENT '修改比赛轮次状态锁(1:有锁 0:无锁)',
  `status_id_lock` int NOT NULL DEFAULT '0' COMMENT '比赛状态修改状态锁(1:有锁 0:无锁)',
  `match_time_lock` int NOT NULL DEFAULT '0' COMMENT '时间修改状态锁(1:有锁 0:无锁)',
  `final_score_lock` int NOT NULL DEFAULT '0' COMMENT '得分修改状态锁(1:有锁 0:无锁)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_eha` (`event_id`,`season_id`,`stage_id`,`home_team_id`,`away_team_id`,`match_time`) USING BTREE,
  KEY `idx_id` (`id`) USING BTREE,
  KEY `idx_match_time` (`match_time`) USING BTREE,
  KEY `idx_match_time_2` (`match_time`,`is_del`,`source_code`) USING BTREE,
  KEY `idx_unique_md5` (`unique_key_md5`) USING BTREE,
  KEY `idx_update_time` (`update_time`) USING BTREE,
  KEY `idx_isdel_matchtime_statusid` (`is_del`,`match_time`,`status_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_match-bak`
--

DROP TABLE IF EXISTS `merge_football_match-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_match-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球联赛ID',
  `season_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛季ID',
  `stage_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方阶段ID',
  `round_num` bigint DEFAULT '0' COMMENT '轮次',
  `group_num` bigint DEFAULT '0' COMMENT '组',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球客队ID',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_final_score` int DEFAULT '0' COMMENT '主队得分',
  `away_final_score` int DEFAULT '0' COMMENT '客队全场得分',
  `neutral` int DEFAULT '0' COMMENT '中立',
  `note` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '标注',
  `home_position` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队排名',
  `away_position` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队排名',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `my_event_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义联赛名称',
  `my_event_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义联赛logo',
  `my_home_team_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队名称',
  `my_home_team_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队logo',
  `my_away_team_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队名称',
  `my_away_team_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义主队logo',
  `my_status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-上半场、3-中场、4-下半场、5-加时赛、7-点球决战、8-完场、9-推迟、10-中断、11-腰斩、12-取消、13-待定',
  `my_status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义比赛状态(中文描述)',
  `my_match_time` bigint DEFAULT NULL COMMENT '自定义比赛时间',
  `my_match_endtime` bigint DEFAULT NULL COMMENT '自定义赛事结束时间(预计)',
  `my_home_final_score` int DEFAULT NULL COMMENT '自定义主队得分',
  `my_away_final_score` int DEFAULT NULL COMMENT '自定义客队全场得分',
  `is_my` int NOT NULL DEFAULT '0' COMMENT '是否自建 0 否 1 是',
  `is_hidden` int NOT NULL DEFAULT '0' COMMENT '是否隐藏 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `round_num_lock` int NOT NULL DEFAULT '0' COMMENT '修改比赛轮次状态锁(1:有锁 0:无锁)',
  `status_id_lock` int NOT NULL DEFAULT '0' COMMENT '比赛状态修改状态锁(1:有锁 0:无锁)',
  `match_time_lock` int NOT NULL DEFAULT '0' COMMENT '时间修改状态锁(1:有锁 0:无锁)',
  `final_score_lock` int NOT NULL DEFAULT '0' COMMENT '得分修改状态锁(1:有锁 0:无锁)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_eha` (`event_id`,`season_id`,`stage_id`,`home_team_id`,`away_team_id`,`match_time`),
  KEY `idx_id` (`id`),
  KEY `idx_match_time` (`match_time`),
  KEY `idx_match_time_2` (`match_time`,`is_del`,`source_code`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `idx_update_time` (`update_time`),
  KEY `idx_isdel_matchtime_statusid` (`is_del`,`match_time`,`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_player`
--

DROP TABLE IF EXISTS `merge_football_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_player` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `country_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方国家ID',
  `team_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方球队ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员中文繁体简称',
  `name_en` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球员英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `birthday` int DEFAULT '0' COMMENT '生日',
  `weight` int DEFAULT '0' COMMENT '体重',
  `height` int DEFAULT '0' COMMENT '身高',
  `nationality` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国籍',
  `market_value` int DEFAULT '0' COMMENT '身价',
  `market_value_currency` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '币别',
  `contract_until` int DEFAULT '0' COMMENT '合约到期时间',
  `position` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '位置',
  `positions` json DEFAULT NULL COMMENT '候补位置',
  `preferred_foot` int DEFAULT '0' COMMENT '首发替换、这块不清楚、文档未描述、后期补',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`country_id`,`team_id`,`name_zh`,`name_en`,`nationality`,`birthday`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_season`
--

DROP TABLE IF EXISTS `merge_football_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_season` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `year` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '年度',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_year` (`source_code`,`event_id`,`year`) USING BTREE,
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛季表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_season-bak`
--

DROP TABLE IF EXISTS `merge_football_season-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_season-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `year` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '年度',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_year` (`event_id`,`year`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球赛季表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_stage`
--

DROP TABLE IF EXISTS `merge_football_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_stage` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `season_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '我方赛季ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '阶段中文名称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段英文名称',
  `mode` int NOT NULL DEFAULT '0' COMMENT '比赛模式',
  `group_count` int NOT NULL DEFAULT '0' COMMENT '总组数',
  `round_count` int NOT NULL DEFAULT '0' COMMENT '总轮数',
  `order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `season_id` (`source_code`,`season_id`,`name_zh`,`name_en`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阶段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_stage-bak`
--

DROP TABLE IF EXISTS `merge_football_stage-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_stage-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `season_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '我方赛季ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '阶段中文名称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段繁体名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段英文名称',
  `mode` int NOT NULL DEFAULT '0' COMMENT '比赛模式',
  `group_count` int NOT NULL DEFAULT '0' COMMENT '总组数',
  `round_count` int NOT NULL DEFAULT '0' COMMENT '总轮数',
  `order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`),
  KEY `season_id` (`season_id`,`name_zh`,`name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球阶段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_team`
--

DROP TABLE IF EXISTS `merge_football_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `manager_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球教练ID',
  `venue_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球场馆ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `my_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义名称',
  `my_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义logo',
  `national` int DEFAULT '0' COMMENT '是否国家队 1-是 0-否',
  `foundation_time` int DEFAULT '0' COMMENT '成立时间',
  `website` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队官网',
  `market_value` int DEFAULT '0' COMMENT '市值',
  `market_value_currency` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '币别',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  `name_th` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队泰语',
  `name_vi` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队越南语',
  `name_ko` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队韩语',
  `name_br` varchar(126) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队巴西语',
  PRIMARY KEY (`id`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_team-bak`
--

DROP TABLE IF EXISTS `merge_football_team-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_team-bak` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方赛事ID',
  `manager_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球教练ID',
  `venue_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方足球场馆ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队中文繁体简称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队英文全称',
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '足球球队英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `my_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义名称',
  `my_logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '自定义logo',
  `national` int DEFAULT '0' COMMENT '是否国家队 1-是 0-否',
  `foundation_time` int DEFAULT '0' COMMENT '成立时间',
  `website` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队官网',
  `market_value` int DEFAULT '0' COMMENT '市值',
  `market_value_currency` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '币别',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`event_id`,`name_zh`,`name_en`,`short_name_zh`,`short_name_en`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_team_skill_analysis`
--

DROP TABLE IF EXISTS `merge_football_team_skill_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_team_skill_analysis` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '我方足球联赛ID',
  `match_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '我方比赛id',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '我方足球主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '我方足球客队ID',
  `skill_analysis_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '三方技术统计类型编号',
  `home_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队值',
  `away_value` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队值',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ehas` (`source_code`,`event_id`,`match_id`,`home_team_id`,`away_team_id`,`skill_analysis_code`),
  KEY `idx_match_id` (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球球队技术统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_football_venue`
--

DROP TABLE IF EXISTS `merge_football_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_football_venue` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆中文名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆英文名称',
  `capacity` int DEFAULT '0' COMMENT '容量',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `unique_key_md5` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '唯一约束的md5值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_esn` (`name_zh`,`name_en`),
  KEY `idx_unique_md5` (`unique_key_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='足球场馆表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_lineup_zan`
--

DROP TABLE IF EXISTS `merge_lineup_zan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_lineup_zan` (
  `id` varchar(20) NOT NULL COMMENT '主键、流编号',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '联赛类型（运动类别）',
  `match_id` varchar(20) NOT NULL COMMENT 'zan端-赛事id',
  `event_id` varchar(20) NOT NULL COMMENT 'zan端-联赛id',
  `h_team_id` varchar(50) NOT NULL DEFAULT '' COMMENT '主队球队id',
  `h_formation` varchar(20) NOT NULL DEFAULT '' COMMENT '主队阵行 ex.4-4-2、4-2-3-1等',
  `h_lineup` json NOT NULL COMMENT '主队先发阵容',
  `h_bench` json NOT NULL COMMENT '主队板凳阵容',
  `a_team_id` varchar(50) NOT NULL DEFAULT '' COMMENT '客队球队id',
  `a_formation` varchar(20) NOT NULL DEFAULT '' COMMENT '客队阵行 ex.4-4-2、4-2-3-1等',
  `a_lineup` json NOT NULL COMMENT '客队先发阵容',
  `a_bench` json NOT NULL COMMENT '客队板凳阵容',
  `is_lock` int DEFAULT '0' COMMENT '是否锁定 0否 1是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='球队阵容表-zan';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_match_news`
--

DROP TABLE IF EXISTS `merge_match_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_match_news` (
  `id` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `new_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '新闻id',
  `sport_code` int DEFAULT '0' COMMENT '体育索引 1-足球 2-篮球',
  `title` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '标题',
  `imageUrl` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '标题图',
  `content` longtext COLLATE utf8mb4_bin COMMENT '内文(含新闻图连结)',
  `datetime` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '新闻发布时间(yyyy-MM-dd HH:mm:ss)',
  `labels` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '关键字',
  `leagueName` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛名称',
  `is_video` int DEFAULT '0' COMMENT '0-新闻 1-小视频',
  `video_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '小视频url(.mp4)',
  `original_video_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '原始url',
  `video_time` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '小视频时间长度(mm:ss)',
  `video_width` int DEFAULT '0' COMMENT '小视频解析度(宽)',
  `video_height` int DEFAULT '0' COMMENT '小视频解析度(高)',
  `status` int DEFAULT '0' COMMENT '状态 0-未落地 1-落地中 2-已落地',
  `sourceId` int DEFAULT '0' COMMENT '资料来源 1-自建 2-懂球帝',
  `enabled` int DEFAULT '0' COMMENT '1=存在、0=已删除',
  `updated_at` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队得分',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_new_id` (`new_id`),
  KEY `idx_datetime` (`datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='新闻表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_match_stream`
--

DROP TABLE IF EXISTS `merge_match_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_match_stream` (
  `id` varchar(20) NOT NULL COMMENT '主键、流编号',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(20) NOT NULL COMMENT '联赛类型',
  `match_id` varchar(20) NOT NULL COMMENT '我方赛事id',
  `league_name` varchar(255) NOT NULL DEFAULT '' COMMENT '联赛名称',
  `home_team_name` varchar(255) NOT NULL DEFAULT '' COMMENT '主队名称',
  `away_team_name` varchar(255) NOT NULL DEFAULT '' COMMENT '客队名称',
  `match_time` varchar(255) DEFAULT '' COMMENT '比赛时间',
  `preview` varchar(255) DEFAULT NULL COMMENT '赛事串流截图',
  `status` int NOT NULL COMMENT '0，不能播放；1，能播放',
  `stream_source` varchar(100) DEFAULT '' COMMENT '流来源：stream/streamAmAli/streamNa-live/streamNa-liveali/streamNa-anim',
  `stream_flv_url` varchar(255) DEFAULT '' COMMENT '流地址or动画地址',
  `stream_anim_url` varchar(255) DEFAULT NULL,
  `stream_m3u8_url` varchar(255) DEFAULT NULL,
  `stream_rtmp_url` varchar(255) DEFAULT NULL,
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_smss` (`sport_code`,`match_id`,`stream_source`),
  KEY `idx_match_id` (`match_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='赛事流';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_odds_company`
--

DROP TABLE IF EXISTS `merge_odds_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_odds_company` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `name_zh` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '赔率公司中文名称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赔率公司英文名称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`name_zh`,`source_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='赔率公司表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_other_event`
--

DROP TABLE IF EXISTS `merge_other_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_other_event` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '体育类型',
  `name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文简体全称',
  `short_name_zh` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事中文繁体简称',
  `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事英文全称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他赛事英文简称',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `uk` (`sport_code`,`name_zh`,`name_zht`,`name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='其他赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_other_match`
--

DROP TABLE IF EXISTS `merge_other_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_other_match` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `event_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他联赛ID',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型',
  `home_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他主队ID',
  `away_team_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他客队ID',
  `status_id` int DEFAULT NULL COMMENT '比赛状态 1-未开赛、2-比赛中、3-已结束',
  `status_type` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛状态(中文描述)',
  `match_time` bigint DEFAULT '0' COMMENT '比赛时间',
  `match_endtime` bigint DEFAULT NULL COMMENT '赛事结束时间(预计)',
  `home_score` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队得分',
  `away_score` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队得分',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_eha` (`event_id`,`home_team_id`,`away_team_id`,`match_time`,`sport_code`),
  KEY `idx_id` (`id`),
  KEY `idx_match_time` (`match_time`),
  KEY `idx_update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='其他赛程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_other_player`
--

DROP TABLE IF EXISTS `merge_other_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_other_player` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'zan' COMMENT '体育类型',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员中文繁体简称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员英文全称',
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运动员英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_zh` (`sport_code`,`name_zh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='运动员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merge_other_team`
--

DROP TABLE IF EXISTS `merge_other_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merge_other_team` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `source_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '数据来源code',
  `sport_code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类型',
  `event_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '赛事ID',
  `name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文简体全称',
  `short_name_zh` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文简称',
  `name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文繁体全称',
  `short_name_zht` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队中文繁体简称',
  `name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队英文全称',
  `short_name_en` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '团队英文简称',
  `logo` varchar(510) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队logo',
  `is_lock` int NOT NULL DEFAULT '0' COMMENT '是否锁定 0 否 1 是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `uk-sensn` (`sport_code`,`event_id`,`name_zh`,`short_name_zh`,`name_en`,`short_name_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='团队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sport`
--

DROP TABLE IF EXISTS `sport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sport` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `code` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '体育类别编号',
  `short_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '体育类别中文简称',
  `short_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '体育类别英文简称',
  `full_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '体育类别中文全称',
  `full_name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '体育类别英文全称',
  `default_team_logo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '默认球队logo',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='体育类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sporttery`
--

DROP TABLE IF EXISTS `sporttery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sporttery` (
  `id` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT 'id',
  `match_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛编号\r\n',
  `third_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方matchid',
  `lottery_type` int DEFAULT NULL COMMENT '盘口类型(1胜平负2让球胜平负3比分4总进球5半全场)',
  `issue_no` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '期号',
  `event_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联赛名称',
  `match_time` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛时间',
  `home_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主队名称',
  `away_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客队名称',
  `sell_status` int DEFAULT NULL COMMENT '是否开售(1:开售 0:停售)',
  `lottery_date` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '开盘日期',
  `score` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比分',
  `md5_key` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'md5加密key',
  `is_del` int DEFAULT NULL COMMENT '是否取消(0 否 1 是)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_match_id` (`match_id`),
  KEY `idx_third_id` (`third_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='竞彩网数据-足球数据分析';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sporttery_odd`
--

DROP TABLE IF EXISTS `sporttery_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sporttery_odd` (
  `id` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '唯一标识',
  `sporttery_id` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '竞彩网id',
  `victory` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '胜',
  `equal` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '平',
  `negative` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '负',
  `tag` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '初/即',
  `add_ball` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '让球盘口',
  `lottery_result` int DEFAULT NULL COMMENT '赛果(3胜1平0负)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_sporttery_id` (`sporttery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_log`
--

DROP TABLE IF EXISTS `team_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `original_team_id` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `team_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_original_team_id` (`original_team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:34
