-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-game-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_game
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
-- Table structure for table `egg_activity_info`
--

DROP TABLE IF EXISTS `egg_activity_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `egg_activity_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `activity_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '活动名称',
  `app_banner_cover` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'app背景图',
  `app_title_cover` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'app标题图',
  `pc_banner_cover` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'pc背景图',
  `pc_title_cover` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'pc标题图',
  `play_explan` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '玩法说明',
  `status` int DEFAULT '0' COMMENT '金蛋开关1:开0:关',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='金蛋活动信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家编号',
  `good_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `conver_url` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '缩略图',
  `good_type` int NOT NULL DEFAULT '0' COMMENT '是否需配送：1 是；0 否',
  `golden_coin` bigint NOT NULL DEFAULT '0' COMMENT '金币,单位：个',
  `sale_price` int NOT NULL DEFAULT '0' COMMENT '销售价(原价)',
  `deduct_price` int NOT NULL DEFAULT '0' COMMENT '金币抵扣后价格',
  `stock` int NOT NULL DEFAULT '0' COMMENT '库存',
  `exchange_num` int NOT NULL DEFAULT '0' COMMENT '兑换数',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：1: 下架; 2: 上架',
  `publish_time` datetime DEFAULT NULL COMMENT '上架时间',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序，越小越靠前；0 表示无排序',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否删除，0-否，1-是',
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_name` (`good_name`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `goods_order_detail`
--

DROP TABLE IF EXISTS `goods_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_order_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家编号',
  `order_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `user_id` bigint unsigned NOT NULL COMMENT '用户id',
  `shadow_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '影子id 对应user_shadow.client_id',
  `nick_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `good_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '商品 ID',
  `good_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `good_type` int NOT NULL DEFAULT '1' COMMENT '商品大类：1 虚拟；2 实物',
  `good_golden_coin` bigint NOT NULL DEFAULT '0' COMMENT '商品单价',
  `good_num` bigint NOT NULL DEFAULT '1' COMMENT '交易量',
  `order_status` int NOT NULL DEFAULT '1' COMMENT '状态：1: 成功; 0: 不成功',
  `conver_url` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '缩略图',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '收货人名称',
  `mobile` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号码',
  `address_detail` varchar(512) COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细收货地址',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建/交易时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_order_code` (`order_code`),
  KEY `idx_shadow_id` (`shadow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商品交易明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lottery_account`
--

DROP TABLE IF EXISTS `lottery_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lottery_account` (
  `id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `user_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户ID',
  `shadow_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '影子ID',
  `activity_id` int DEFAULT NULL COMMENT '活动ID',
  `lottery_type` int DEFAULT NULL COMMENT '奖券类型',
  `account_number` int DEFAULT NULL COMMENT '剩余数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='奖券账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lottery_give_record`
--

DROP TABLE IF EXISTS `lottery_give_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lottery_give_record` (
  `id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `user_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户ID',
  `shadow_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '影子ID',
  `lottery_type` int DEFAULT NULL COMMENT '奖券类型',
  `give_number` int DEFAULT NULL COMMENT '发放数量',
  `give_reason` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发放原因',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='抽奖券发放记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lottery_info`
--

DROP TABLE IF EXISTS `lottery_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lottery_info` (
  `id` int NOT NULL COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `activity_id` int DEFAULT NULL COMMENT '活动ID',
  `lottery_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '奖券名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='奖券信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pk_record`
--

DROP TABLE IF EXISTS `pk_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pk_record` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `channel_id` bigint NOT NULL DEFAULT '0' COMMENT '渠道id',
  `channel_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '渠道名称',
  `match_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事id',
  `home_team` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队名称',
  `home_team_logo` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队徽标',
  `away_team` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队名称',
  `away_team_logo` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队徽标',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `nickname` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播昵称',
  `match_status` int NOT NULL DEFAULT '0' COMMENT '状态：1 已结束；2 进行中；3 未开始 4.推迟 5.取消',
  `result` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事结果集json串',
  `start_time` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1970-01-01 00:00' COMMENT '赛事开始时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：1 正常；0 无效；',
  PRIMARY KEY (`id`),
  KEY `idx_create_by` (`create_by`,`merchant_id`,`room_no`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=80136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='球队pk表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prize_pool_detail`
--

DROP TABLE IF EXISTS `prize_pool_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prize_pool_detail` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `pool_id` int DEFAULT NULL COMMENT '奖池ID',
  `prize_id` int DEFAULT NULL COMMENT '奖品ID',
  `prize_stock` int DEFAULT NULL COMMENT '奖品库存',
  `current_stock` int DEFAULT NULL COMMENT '当前库存',
  `prize_day_limit` int DEFAULT NULL COMMENT '单日上限',
  `prize_user_limit` int DEFAULT NULL COMMENT '单用户上限',
  `win_odds` int DEFAULT NULL COMMENT '中奖概率(万分)',
  `is_lantern` int DEFAULT NULL COMMENT '是否跑马灯1:是0:否',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1458 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='奖池明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prize_pool_info`
--

DROP TABLE IF EXISTS `prize_pool_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prize_pool_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `activity_id` int DEFAULT NULL COMMENT '活动ID',
  `pool_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '奖池名称',
  `pool_type` int DEFAULT NULL COMMENT '奖池类型(1:幸运奖池2:超级奖池)',
  `start_time` datetime DEFAULT NULL COMMENT '生效时间',
  `end_time` datetime DEFAULT NULL COMMENT '失效时间',
  `default_prize_id` int DEFAULT NULL COMMENT '默认奖品(兜底)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是 0:否',
  `activity_type` int DEFAULT '1' COMMENT '活动类型:1:转盘活动2:金蛋活动',
  `view_time` int DEFAULT '0' COMMENT '观看时长,单位min',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='奖池信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `red_packet`
--

DROP TABLE IF EXISTS `red_packet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `red_packet` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `packet_no` varchar(24) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '红包单号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '发送人id',
  `user_room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '发送人uid',
  `room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '发起房间号',
  `packet_type` int NOT NULL DEFAULT '0' COMMENT '红包类型: 1: 定时红包;2: 口令红包;',
  `scope` int NOT NULL DEFAULT '0' COMMENT '适用范围: 1: 全房间;2: 已关注发起人;3: 同一圈子;',
  `amount` bigint unsigned NOT NULL DEFAULT '0' COMMENT '红包总额',
  `quantity` int unsigned NOT NULL DEFAULT '0' COMMENT '红包份数',
  `expired` int NOT NULL DEFAULT '0' COMMENT '红包过期份数',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态: 0:未完成; 1:已完成',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93848 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='红包表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `red_packet_item`
--

DROP TABLE IF EXISTS `red_packet_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `red_packet_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `packet_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '红包id',
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '获得红包用户id',
  `amount` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户获得红包总额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=881876 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='红包明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `turntable_activity_info`
--

DROP TABLE IF EXISTS `turntable_activity_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turntable_activity_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `activity_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '活动名称',
  `activity_type` int NOT NULL DEFAULT '0' COMMENT '转盘类型: 1-日常转盘; 2-活动转盘; 3-运营转盘',
  `is_anon` int NOT NULL DEFAULT '0' COMMENT '是否匿名活动: 0-否，1-是，无须登录，不记录抽奖结果',
  `activity_start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `activity_end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `activity_rule` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '活动规则',
  `banner_cover` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `banner_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '跳转路径',
  `pool_info` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '使用奖池',
  `sign_in_threshold` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '签到奖励规则',
  `coin_cost` int NOT NULL DEFAULT '0' COMMENT '针对运营转盘: 转盘单次消耗金额',
  `daily_limit` int NOT NULL DEFAULT '0' COMMENT '针对运营转盘: 转盘每日次数上限',
  `source_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '针对运营转盘: 活动渠道: 0-app; 1-pc; 2-h5; 3-webapp; 所有渠道以","拼接且首尾额外追加",", 如app和pc时值为",0,1,"',
  `coin_image_url` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '针对运营转盘: 赚取金币引导图片',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  `lang` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'zh' COMMENT 'zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=499211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='转盘活动信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `turntable_prize_info`
--

DROP TABLE IF EXISTS `turntable_prize_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turntable_prize_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `prize_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '奖品名称',
  `prize_type` int DEFAULT NULL COMMENT '奖品类型(虚拟货币/实物奖励/抽奖券)',
  `prize_number` int DEFAULT NULL COMMENT '奖品数量',
  `prize_icon` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  `activity_type` int DEFAULT '1' COMMENT '活动类型:1:转盘活动2:金蛋活动',
  `status` int DEFAULT '1' COMMENT '是否启用 1:启用 0:禁用',
  `lang` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'zh' COMMENT 'zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='转盘抽奖奖品信息表';
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

-- Dump completed on 2024-06-14 14:34:50
