-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_tactic
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
-- Table structure for table `expert`
--

DROP TABLE IF EXISTS `expert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expert` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '专家表id',
  `user_id` bigint unsigned NOT NULL COMMENT '用户id',
  `merchant_id` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '商户编号',
  `plan_count` int NOT NULL DEFAULT '0' COMMENT '方案数量',
  `sale_count` int NOT NULL DEFAULT '0' COMMENT '售卖人数',
  `total` bigint NOT NULL DEFAULT '0' COMMENT '累计总收益',
  `settlement` bigint NOT NULL DEFAULT '0' COMMENT '可结算收益',
  `sale_solution` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '2888,5888,8888' COMMENT '默认方案价格组合 例： 2888,5888,8888',
  `roi` int NOT NULL DEFAULT '0' COMMENT '近10场回报率',
  `hit_rate` int NOT NULL DEFAULT '0' COMMENT '命中率',
  `combo` int NOT NULL DEFAULT '0' COMMENT '近期连红',
  `status` int NOT NULL DEFAULT '0' COMMENT '可用状态 0正常 1禁用',
  `create_by` bigint NOT NULL COMMENT '创建者id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` int DEFAULT '0' COMMENT '专家类型 0用户 1导入',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='专家表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expert_plan`
--

DROP TABLE IF EXISTS `expert_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expert_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT ' 计划表id',
  `expert_id` bigint NOT NULL COMMENT '专家id',
  `merchant_id` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '商户编号',
  `match_id` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '比赛id',
  `event_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '赛事名称',
  `title` varchar(40) COLLATE utf8mb4_bin NOT NULL COMMENT '标题 4-40个字',
  `analysis_text` varchar(2000) COLLATE utf8mb4_bin NOT NULL COMMENT '解析 100-2000个字',
  `play_type` int NOT NULL COMMENT '竞猜玩法类型id ',
  `recommend` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '推荐选择 (根据不同玩法来解析字符串)',
  `snapshot` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '对应指数快照',
  `result` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '比赛结果',
  `price` bigint NOT NULL COMMENT '售价',
  `enable` int NOT NULL DEFAULT '1' COMMENT '是否开启 0下架 1开启',
  `guess_hit` int DEFAULT NULL COMMENT '是否命中 0否 1是 2走盘',
  `settlement_finish` int NOT NULL DEFAULT '0' COMMENT '是否完成结算 0否 1是',
  `status` int NOT NULL DEFAULT '0' COMMENT '计划状态 0售卖中 1截单 2比赛结束 3异常',
  `sale_stop_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '截单时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `plan_big_type` int DEFAULT '0' COMMENT '玩法大类型 0让球胜平负 1亚指 2大小球 3欧赔',
  `top_sort` int DEFAULT '999999' COMMENT '置顶顺序',
  `top_end_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '置顶结束时间',
  PRIMARY KEY (`id`),
  KEY `idx_expert_id` (`merchant_id`,`expert_id`,`create_time`) USING BTREE,
  KEY `idx_top_end_time` (`merchant_id`,`top_end_time`) USING BTREE,
  KEY `idx_top_end_time2` (`top_end_time`) USING BTREE,
  KEY `idx_expert_id2` (`expert_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_sale_stop_time` (`sale_stop_time`) USING BTREE,
  KEY `idx_match_id` (`merchant_id`,`match_id`) USING BTREE,
  KEY `idx_match_id2` (`match_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='方案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `play_type`
--

DROP TABLE IF EXISTS `play_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `play_type` (
  `id` int NOT NULL COMMENT '玩法类型id',
  `game_code` varchar(80) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '体育项目 football basketball',
  `type` varchar(80) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '玩法类型说明 rqspf让球胜平负',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='竞猜玩法表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sale_record`
--

DROP TABLE IF EXISTS `sale_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '商户号',
  `expert_id` bigint NOT NULL COMMENT '发布者专家id',
  `plan_id` bigint NOT NULL COMMENT '计划id',
  `user_id` bigint NOT NULL COMMENT '购买者用户id',
  `order_no` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '订单号',
  `event_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '赛事名称',
  `coin` bigint NOT NULL COMMENT '金额（鹰币）',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0购买成功',
  `settlement_finish` int NOT NULL DEFAULT '0' COMMENT '是否完成结算 0否 1是',
  `settlement_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结算时间 ',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_plan_id` (`plan_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=205499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='交易记录表';
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
