-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_gift
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
-- Table structure for table `gift`
--

DROP TABLE IF EXISTS `gift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `gift_type` int DEFAULT NULL COMMENT '礼物类别-1:横幅礼物; 2:全屏礼物',
  `is_vip` int NOT NULL DEFAULT '0' COMMENT '是否vip礼物：0-否; 1-是',
  `vip_level_limit` int NOT NULL DEFAULT '0' COMMENT 'vip等级限制',
  `gift_id` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '礼物ID',
  `gift_name` varchar(12) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '礼物名称',
  `gift_price` int DEFAULT NULL COMMENT '礼物单价(鹰币)',
  `default_graph_url` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '默认图',
  `dynamic_graph_url` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '动态图(预览效果)',
  `play_effect_url` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '播放效果',
  `double_hit` int DEFAULT NULL COMMENT '能否连击-1:能；2:否 默认为1',
  `floating_status` int DEFAULT NULL COMMENT '启用飘屏-1:启用; 2:不启用 默认为2',
  `floating_type` int DEFAULT NULL COMMENT '飘屏类别-1：全平台 2：本房间 3：足球品类 默认为1',
  `status` int DEFAULT NULL COMMENT '礼物状态-0:已上线 ; 1:已下线',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `lang` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_history`
--

DROP TABLE IF EXISTS `gift_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `gift_history_id` bigint NOT NULL DEFAULT '0' COMMENT '分布式ID',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户房间号',
  `nickname` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `anchor_id` bigint DEFAULT NULL COMMENT '主播ID',
  `anchor_room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播房间号',
  `anchor_nickname` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播昵称',
  `live_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '直播场次记录ID',
  `gift_id` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '礼物ID',
  `gift_name` varchar(12) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '礼物名称',
  `is_vip` int NOT NULL DEFAULT '0' COMMENT '是否vip礼物：0-否; 1-是',
  `vip_level_limit` int NOT NULL DEFAULT '0' COMMENT 'vip等级限制',
  `total` int DEFAULT NULL COMMENT '送礼总数',
  `total_amount` bigint DEFAULT NULL COMMENT '送礼总鹰币',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `hold_time` varchar(12) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '按天统计时间',
  PRIMARY KEY (`id`),
  KEY `idx_gift_history_anchor_id` (`anchor_id`),
  KEY `idx_gift_history_live_id` (`live_id`),
  KEY `idx_gift_history_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=688698 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_report`
--

DROP TABLE IF EXISTS `gift_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_report` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `time_frame` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '送出时间',
  `gift_id` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '礼物ID',
  `gift_name` varchar(12) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '礼物名称',
  `is_vip` int NOT NULL DEFAULT '0' COMMENT '是否vip礼物：0-否; 1-是',
  `vip_level_limit` int NOT NULL DEFAULT '0' COMMENT 'vip等级限制',
  `total` bigint DEFAULT NULL COMMENT '送出个数',
  `total_amount` bigint DEFAULT NULL COMMENT '送出价值(鹰币/万个)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_strategy`
--

DROP TABLE IF EXISTS `gift_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_strategy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `strategy_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '策略名称',
  `gift_ids` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '下发礼物ID(礼物列表)',
  `strategy_type` int DEFAULT NULL COMMENT '下发类型-1：全平台  2：直播间  3：聊天室',
  `strategy_scope` int DEFAULT NULL COMMENT '下发范围  1：频道  2：指定房间',
  `strategy_channel` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '指定频道',
  `strategy_room` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '指定房间号',
  `start_time` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生效时间',
  `end_time` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '失效时间',
  `status` int DEFAULT NULL COMMENT '状态 1：待生效  2：生效中  3：已下线',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `lang` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_strategy_room`
--

DROP TABLE IF EXISTS `gift_strategy_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_strategy_room` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `strategy_id` bigint DEFAULT NULL COMMENT 'strategy_id',
  `room_no` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'room_no',
  `room_type` int DEFAULT '2' COMMENT '房间类型：2：直播间;3：聊天室',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_transaction_msg`
--

DROP TABLE IF EXISTS `gift_transaction_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_transaction_msg` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '事物消息编号',
  `message_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '消息编号',
  `message_status` int NOT NULL DEFAULT '1' COMMENT '消息状态 1-commit,2-unknown,3-rollback',
  `body` mediumtext COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息内容',
  `param` mediumtext COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息参数',
  `handler_flag` int NOT NULL DEFAULT '0' COMMENT '处理标识 0-无需处理 1-待处理（仅有unknown状态的消息初始化时为1，待处理后需更改为已处理2）2-已处理',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_transaction_id` (`transaction_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=688948 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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
