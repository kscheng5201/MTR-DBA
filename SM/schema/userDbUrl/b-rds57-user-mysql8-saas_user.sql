-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-user-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_user
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
-- Table structure for table `anchor_config`
--

DROP TABLE IF EXISTS `anchor_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `room_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `shadow_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'shadow id',
  `marquee_switch` int NOT NULL DEFAULT '1' COMMENT '跑马灯开关 0-关；1-开',
  `marquee_content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '跑马灯内容',
  `room_password` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '房间密码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_room_no` (`room_no`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='主播设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anchor_experience_record`
--

DROP TABLE IF EXISTS `anchor_experience_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_experience_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `experience_value` int NOT NULL DEFAULT '0' COMMENT '主播添加的经验值',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '来源类型',
  `source_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '来源id',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `anchor_experience_record_source_type_index` (`source_type`) USING BTREE,
  KEY `anchor_experience_record_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1663641 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anchor_info_approved_record`
--

DROP TABLE IF EXISTS `anchor_info_approved_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_info_approved_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint DEFAULT NULL COMMENT 'UID',
  `anchor_info_before` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改前主播信息',
  `anchor_info_after` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改后主播信息',
  `create_by` bigint DEFAULT NULL COMMENT '申请人',
  `create_time` datetime DEFAULT NULL COMMENT '申请时间',
  `approved_by` bigint DEFAULT NULL COMMENT '审批人',
  `approved_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approved_state` int DEFAULT NULL COMMENT '审批状态（1：待审批 2：通过 3：拒绝 4：撤销）',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `str1` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备用字段1',
  `str2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备用字段2',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否删除（1：是0：否）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anchor_level_config`
--

DROP TABLE IF EXISTS `anchor_level_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_level_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家ID',
  `name` varchar(8) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '等级名称',
  `experience_value` int NOT NULL DEFAULT '0' COMMENT '达到等级的经验值',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anchor_master_account`
--

DROP TABLE IF EXISTS `anchor_master_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_master_account` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `master_user_id` bigint NOT NULL DEFAULT '0' COMMENT '主帐号用户id',
  `master_room_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '主帐号房间号',
  `master_shadow_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '主帐号shadow id',
  `slave_user_id` bigint NOT NULL DEFAULT '0' COMMENT '子帐号用户id',
  `slave_room_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '子帐号房间号',
  `slave_shadow_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '子帐号shadow id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_master_room_no` (`master_room_no`) USING BTREE,
  UNIQUE KEY `idx_slave_room_no` (`slave_room_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='主播关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anchor_notice_info`
--

DROP TABLE IF EXISTS `anchor_notice_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_notice_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户ID',
  `shadow_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'shadowId',
  `user_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户id',
  `type` int NOT NULL DEFAULT '1' COMMENT '公告类型(默认1): 1-正常公告; 2-iOS上架版公告',
  `qq_group_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'QQ群',
  `wechat_group_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信群',
  `wechat_account_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '微信公众号',
  `platforms` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '展示平台：0-移动端 1-PC端，多项使用,拼接',
  `notice_config` varchar(2048) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公告配置',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='主播公告信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anchor_stream`
--

DROP TABLE IF EXISTS `anchor_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anchor_stream` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `anchor_stream_user_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事主播id',
  `origin_room_no` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '外部房间号',
  `room_no` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '内部房间号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用，1-禁用',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_anchor_stream_user_id` (`anchor_stream_user_id`) USING BTREE,
  KEY `idx_room_no` (`origin_room_no`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_logger`
--

DROP TABLE IF EXISTS `audit_logger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logger` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户ID',
  `audit_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核人id',
  `user_id` bigint unsigned NOT NULL COMMENT '用户id',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态 0待审核 1审核通过 2审核拒绝',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `reason` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '原因，不通过时填写',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户审核记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_access`
--

DROP TABLE IF EXISTS `user_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_access` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `room_no` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '房间号',
  `user_id` bigint DEFAULT '0' COMMENT '用户id',
  `ip` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'ip地址',
  `platform_code` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '访问入口',
  `last_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次访问时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`merchant_id`,`user_id`) USING BTREE,
  KEY `idx_room_no` (`merchant_id`,`room_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=317165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户访问信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `golden_coin` bigint unsigned NOT NULL DEFAULT '0' COMMENT '金币,单位：个',
  `income_coin` bigint NOT NULL DEFAULT '0' COMMENT '收益，单位：个， 目前只计算主播得到礼物的收益',
  `tactic_coin` bigint NOT NULL DEFAULT '0' COMMENT '收益，单位：个， 主播专家推单的收益',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_account_user_id_index` (`user_id`) USING BTREE,
  KEY `idx_golden_coin` (`golden_coin`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE,
  KEY `idx_merchant_user` (`merchant_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=981855 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_account_backup_20221101`
--

DROP TABLE IF EXISTS `user_account_backup_20221101`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account_backup_20221101` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `golden_coin` bigint unsigned NOT NULL DEFAULT '0' COMMENT '金币,单位：个',
  `income_coin` bigint NOT NULL DEFAULT '0' COMMENT '收益，单位：个， 目前只计算主播得到礼物的收益',
  `tactic_coin` bigint NOT NULL DEFAULT '0' COMMENT '收益，单位：个， 主播专家推单的收益',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_account_copy`
--

DROP TABLE IF EXISTS `user_account_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account_copy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `golden_coin` bigint unsigned NOT NULL DEFAULT '0' COMMENT '金币,单位：个',
  `income_coin` bigint NOT NULL DEFAULT '0' COMMENT '收益，单位：个， 目前只计算主播得到礼物的收益',
  `tactic_coin` bigint NOT NULL DEFAULT '0' COMMENT '收益，单位：个， 主播专家推单的收益',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_account_user_id_index` (`user_id`) USING BTREE,
  KEY `idx_golden_coin` (`golden_coin`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE,
  KEY `idx_merchant_user` (`merchant_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_account_detail`
--

DROP TABLE IF EXISTS `user_account_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '来源类型 0-充值鹰币，1-送礼，2-参与预言，3-参与预言收益的鹰币，4-参与预言胜利后退回的本金，5-主播直播收益，6-主播收礼得到的收益，7-主播竞猜收益，8-活动赠送，9-后台奖励所得收益（针对主播），10-后台惩罚亏损的鹰币（针对主播），11-购买锦囊，12-锦囊退款，13-锦囊收获的鹰翅，14-红包送出，15-红包领取，16-红包退还，17-参与预言流局退还，18-主播结算账单扣款，19-红包雨奖励',
  `source_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '来源id',
  `biz_code` int NOT NULL DEFAULT '0' COMMENT '业务类型0-鹰币 1-羽毛 2-鱼翅',
  `amount` bigint NOT NULL DEFAULT '0' COMMENT '数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_source_type` (`merchant_id`,`user_id`,`source_type`) USING BTREE,
  KEY `user_account_detail_create_time_index` (`create_time`) USING BTREE,
  KEY `user_account_detail_source_id_index` (`source_id`) USING BTREE,
  KEY `user_account_detail_source_type_index` (`source_type`) USING BTREE,
  KEY `user_account_detail_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10072427 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_address`
--

DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_address` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `username` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货人名称',
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `shadow_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '第三方id',
  `country` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '国家',
  `province_code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '行政区域表的省ID',
  `province_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city_code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '行政区域表的市ID',
  `city_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `county_code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '行政区域表的区县ID',
  `county_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区县',
  `address_detail` varchar(512) COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细收货地址',
  `area_code` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地区编码',
  `postal_code` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮政编码',
  `is_default` int DEFAULT '0' COMMENT '是否默认地址 0-否 1-是',
  `status` int DEFAULT '0' COMMENT '0-正常 1-禁用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='收货地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_authorize`
--

DROP TABLE IF EXISTS `user_authorize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_authorize` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint unsigned NOT NULL COMMENT 'c端用户id',
  `real_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `id_card` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证号码',
  `id_card_front` varchar(500) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证正面照',
  `id_card_back` varchar(500) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '身份证反面照',
  `id_card_hand` varchar(500) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手持证件照',
  `sport_type` int NOT NULL DEFAULT '0' COMMENT '体育类型 0-足球',
  `audit_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '审核人id',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态 0待审核 1审核通过 2审核拒绝 3:禁播 4:解禁',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_authorize_create_time` (`create_time`) USING BTREE,
  KEY `idx_user_authorize_user_audit_status` (`audit_status`) USING BTREE,
  KEY `idx_user_authorize_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170687 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='c端用户认证表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_black_ip`
--

DROP TABLE IF EXISTS `user_black_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_black_ip` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `room_no` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '房间号',
  `user_id` bigint DEFAULT '0' COMMENT '用户id',
  `ip` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'ip地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_ip` (`merchant_id`,`ip`) USING BTREE,
  KEY `idx_room_no` (`merchant_id`,`room_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='黑名单ip';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_channel`
--

DROP TABLE IF EXISTS `user_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_channel` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `channel_recommend` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道推荐列表',
  `channel_self` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '频道自身列表',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_device_push`
--

DROP TABLE IF EXISTS `user_device_push`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_device_push` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户号',
  `tf_pkg` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'tf包名',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `registration_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_merchant_id` (`user_id`,`merchant_id`) USING BTREE,
  KEY `idx_registration_id` (`merchant_id`,`registration_id`) USING BTREE,
  KEY `idx_merchant_registration_id` (`registration_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168333 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_experience_record`
--

DROP TABLE IF EXISTS `user_experience_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_experience_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `experience_value` int NOT NULL DEFAULT '0' COMMENT '用户添加的经验值',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '来源类型',
  `source_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '来源id',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_experience_record_source_type_index` (`source_type`) USING BTREE,
  KEY `user_experience_record_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2221873 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `shadow_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '影子id 对应user_shadow.client_id',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '房间号 对应user_profile.room_no',
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `country_code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '86' COMMENT '国家码',
  `salt` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '盐',
  `nick_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `introduce` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '介绍',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '用户来源',
  `is_white` int NOT NULL DEFAULT '0' COMMENT '是否是白名单用户 0-否 1-是（白名单用户不校验手机号）',
  `last_login_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用，1-禁用',
  `platform_control_status` int unsigned NOT NULL DEFAULT '0' COMMENT '总台对用户封禁状态 0-启用，1-禁用\r\n如果总台对用户已经封禁了，必须已总台为准。总台没有封禁，再以商户的为准',
  `register_ip` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户注册ip',
  `register_referer` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户注册地址',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`(20)) USING BTREE,
  KEY `idx_nick_name` (`merchant_id`,`nick_name`) USING BTREE,
  KEY `user_info_mobile_index` (`mobile`) USING BTREE,
  KEY `user_info_room_no_index` (`room_no`) USING BTREE,
  KEY `user_info_shadow_id_index` (`shadow_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=983878 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invit_code`
--

DROP TABLE IF EXISTS `user_invit_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_invit_code` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `invite_user_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邀请人uid',
  `invite_nickname` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邀请人昵称',
  `invite_reward` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邀请人奖励派发  1：已派发  2：未派发',
  `invite_reward_time` timestamp NULL DEFAULT NULL COMMENT '邀请人奖励派发时间',
  `invited_user_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '被邀请人uid',
  `invited_nickname` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '被邀请人昵称',
  `invited_reward` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '被邀请人奖励派发 1：已派发 2：未派发',
  `invited_reward_time` timestamp NULL DEFAULT NULL COMMENT '被邀请人奖励派发时间',
  `invited_register_time` timestamp NULL DEFAULT NULL COMMENT '被邀请人注册时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_userid` (`invite_user_id`,`invited_user_id`) USING BTREE,
  KEY `idx_userName` (`invite_nickname`,`invited_nickname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invite`
--

DROP TABLE IF EXISTS `user_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_invite` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `invite_user_id` bigint NOT NULL DEFAULT '0' COMMENT '邀请人用户id',
  `invite_room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邀请人房间号',
  `invite_shadow_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邀请人shadow_id',
  `invite_nickname` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邀请人昵称',
  `invite_reward` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邀请人奖励',
  `invite_reward_type` int NOT NULL DEFAULT '0' COMMENT '邀请人奖励类型：0-金币',
  `invited_user_id` bigint NOT NULL DEFAULT '0' COMMENT '被邀请人用户id',
  `invited_room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '被邀请人房间号',
  `invited_shadow_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '被邀请人shadow_id',
  `invited_nickname` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '被邀请人昵称',
  `invited_reward_type` int NOT NULL DEFAULT '0' COMMENT '被邀请人奖励类型：0-金币',
  `invited_reward` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '被邀请人奖励',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_invite_user_id` (`invite_user_id`) USING BTREE,
  KEY `idx_invited_user_id` (`invited_user_id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户邀请记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_level_config`
--

DROP TABLE IF EXISTS `user_level_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_level_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家ID',
  `name` varchar(8) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '等级名称',
  `experience_value` int NOT NULL DEFAULT '0' COMMENT '达到等级的经验值',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3041 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_login_log`
--

DROP TABLE IF EXISTS `user_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `login_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '登录类型 0：APP，1：PC，2：H5，3：WEBAPP',
  `login_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `login_time` timestamp NULL DEFAULT NULL COMMENT '登录时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_login_time` (`login_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户登录记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_match_book`
--

DROP TABLE IF EXISTS `user_match_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_match_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint DEFAULT NULL COMMENT '用户编号',
  `source` int NOT NULL DEFAULT '0' COMMENT '预约来源（1：主播预约 2：普通预约）',
  `is_anchor` int NOT NULL DEFAULT '0' COMMENT '是否是主播（0：否 1：是）',
  `match_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `status` int DEFAULT NULL COMMENT '预约状态(1:取消预约,2=预约,3=已结束)',
  `sports_type` int DEFAULT '1' COMMENT '运动类型（1：足球 2：篮球 99：其他）',
  `push_status` int DEFAULT NULL COMMENT 'push状态(0:未推送 1:已推送)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `subscribe_status` int DEFAULT '0' COMMENT '预约提醒前端推送状态(0:未推送，1:已推送)',
  `room_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预约赛事提醒主播id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_match_book_match_id_index` (`match_id`) USING BTREE,
  KEY `user_match_book_user_id_index` (`user_id`) USING BTREE,
  KEY `idx_is_anchor` (`merchant_id`,`is_anchor`,`status`,`source`,`sports_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=341081 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_notify`
--

DROP TABLE IF EXISTS `user_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_notify` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` int NOT NULL DEFAULT '0' COMMENT '类型：0-vip等级变动; 1-金币到账',
  `source_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '来源id：vip等级变动时为变动记录id; 金币到账时为增发记录id',
  `val` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类型对应值：vip等级变动时为空; 金币到账时为到账金额',
  `is_notify` int NOT NULL DEFAULT '0' COMMENT '是否已通知：0-否; 1-是',
  `notify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '通知时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id_source_id` (`user_id`,`source_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=413223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户通知';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_opinion`
--

DROP TABLE IF EXISTS `user_opinion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_opinion` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户号',
  `platform` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源平台 PC APP',
  `feedback_type` int DEFAULT NULL COMMENT '反馈类型',
  `text` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '详情描述 50字',
  `img_list` text COLLATE utf8mb4_general_ci COMMENT '图片url 用,号分隔',
  `contact` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系方式',
  `is_reply` int NOT NULL DEFAULT '0' COMMENT '是否已回复: 0-未回复，1-已回复',
  `reply_content` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '回复内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户意见表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `union_code` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '工会编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `province` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '城市',
  `gender` int NOT NULL DEFAULT '0' COMMENT '0保密；1男；2女',
  `birth` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生日',
  `is_expert` int NOT NULL DEFAULT '0' COMMENT '0-不是专家 1-是专家',
  `is_anchor` int NOT NULL DEFAULT '0' COMMENT '是否是主播：0，否；1，是',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '房间号',
  `invite_room_no` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邀请人房间号',
  `original_id` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '原始ID',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '用户来源：0-app用户 1-影子用户 2-机器人 3-官方主播 4-openApi注册 5-主播流注册',
  `invite_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '邀请码',
  `user_level` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '用户等级',
  `anchor_level` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主播等级',
  `vip_level` int NOT NULL DEFAULT '0' COMMENT 'vip等级：其中0表示非vip;',
  `third_game_user_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '第三方游戏用户id',
  `user_experience` int NOT NULL DEFAULT '0' COMMENT '用户经验值',
  `anchor_experience` int NOT NULL DEFAULT '0' COMMENT '主播经验值',
  `ratio` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '主播分成比例',
  `salary` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '主播底薪',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_invite_code` (`merchant_id`,`invite_code`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`(20)) USING BTREE,
  KEY `user_profile_is_anchor_index` (`is_anchor`) USING BTREE,
  KEY `user_profile_room_no_index` (`room_no`) USING BTREE,
  KEY `user_profile_source_type_index` (`source_type`) USING BTREE,
  KEY `user_profile_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=983858 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_profile_bak`
--

DROP TABLE IF EXISTS `user_profile_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile_bak` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '主键',
  `merchant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `union_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '工会编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `province` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '城市',
  `gender` int NOT NULL DEFAULT '0' COMMENT '0保密；1男；2女',
  `birth` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生日',
  `is_expert` int NOT NULL DEFAULT '0' COMMENT '0-不是专家 1-是专家',
  `is_anchor` int NOT NULL DEFAULT '0' COMMENT '是否是主播：0，否；1，是',
  `room_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '房间号',
  `invite_room_no` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邀请人房间号',
  `original_id` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '原始ID',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '用户来源：0-app用户 1-影子用户 2-机器人 3-官方主播 4-openApi注册 5-主播流注册',
  `invite_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '邀请码',
  `user_level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '用户等级',
  `anchor_level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主播等级',
  `vip_level` int NOT NULL DEFAULT '0' COMMENT 'vip等级：其中0表示非vip;',
  `third_game_user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '第三方游戏用户id',
  `user_experience` int NOT NULL DEFAULT '0' COMMENT '用户经验值',
  `anchor_experience` int NOT NULL DEFAULT '0' COMMENT '主播经验值',
  `ratio` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '主播分成比例',
  `salary` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '主播底薪',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_reward`
--

DROP TABLE IF EXISTS `user_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reward` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_source` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源 1：支付宝  2：微信  3：QQ',
  `account` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '账号',
  `user_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户uid',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `user_uid` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户的uid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='邀请码收款账号保存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_shadow`
--

DROP TABLE IF EXISTS `user_shadow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_shadow` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `client_uid` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '第三方用户id',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `nick_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用，1-禁用',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=983857 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_shadow_bak`
--

DROP TABLE IF EXISTS `user_shadow_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_shadow_bak` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '主键',
  `merchant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `client_uid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '第三方用户id',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT 'uid',
  `nick_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用，1-禁用'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sms`
--

DROP TABLE IF EXISTS `user_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sms` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `send_type` int DEFAULT '1' COMMENT '发送类型(1:平台用户 2:指定用户)',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `send_status` int DEFAULT '1' COMMENT '发送状态(1:未发送 2:已发送 3:取消)',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户营销短信表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sms_record`
--

DROP TABLE IF EXISTS `user_sms_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sms_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_sms_id` bigint NOT NULL DEFAULT '0' COMMENT '批次主键',
  `country_code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '86' COMMENT '国家码',
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `shadow_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '影子id 对应user_shadow.client_id',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '房间号 对应user_profile.room_no',
  `nickname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '昵称',
  `message_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '消息id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_sms_user_id` (`user_sms_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户消息发送记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_third_part`
--

DROP TABLE IF EXISTS `user_third_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_third_part` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商家ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `third_part_id` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '第三方绑定id',
  `third_type` int NOT NULL DEFAULT '0' COMMENT '绑定类型0:QQ ,1:微信,2:appId',
  `third_nick_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '第三方昵称',
  `third_gender` varchar(8) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `third_avatar` varchar(500) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-解封 1-封禁',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`(20)) USING BTREE,
  KEY `user_third_part_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='c端用户第三方绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_uid`
--

DROP TABLE IF EXISTS `user_uid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_uid` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `uid` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生成的uid',
  `is_used` int NOT NULL DEFAULT '0' COMMENT '0-未使用，1-使用',
  `is_pretty_number` int NOT NULL DEFAULT '0' COMMENT '0-不是靓号，1-是靓号',
  `batch` int NOT NULL DEFAULT '1' COMMENT '批次',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_used` (`is_pretty_number`,`is_used`) USING BTREE,
  KEY `idx_uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3401241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='规则生成uid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_uid_1_5`
--

DROP TABLE IF EXISTS `user_uid_1_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_uid_1_5` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `uid` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生成的uid',
  `is_used` int NOT NULL DEFAULT '0' COMMENT '0-未使用，1-使用',
  `is_pretty_number` int NOT NULL DEFAULT '0' COMMENT '0-不是靓号，1-是靓号',
  `batch` int NOT NULL DEFAULT '1' COMMENT '批次',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_used` (`is_pretty_number`,`is_used`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2400039 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='规则生成uid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_uid_1_5_2`
--

DROP TABLE IF EXISTS `user_uid_1_5_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_uid_1_5_2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `uid` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生成的uid',
  `is_used` int NOT NULL DEFAULT '0' COMMENT '0-未使用，1-使用',
  `is_pretty_number` int NOT NULL DEFAULT '0' COMMENT '0-不是靓号，1-是靓号',
  `batch` int NOT NULL DEFAULT '1' COMMENT '批次',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_used` (`is_pretty_number`,`is_used`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2501241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='规则生成uid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_uid_copy1`
--

DROP TABLE IF EXISTS `user_uid_copy1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_uid_copy1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `uid` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生成的uid',
  `is_used` int NOT NULL DEFAULT '0' COMMENT '0-未使用，1-使用',
  `is_pretty_number` int NOT NULL DEFAULT '0' COMMENT '0-不是靓号，1-是靓号',
  `batch` int NOT NULL DEFAULT '1' COMMENT '批次',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_used` (`is_pretty_number`,`is_used`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2300039 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='规则生成uid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vip_user_import_log`
--

DROP TABLE IF EXISTS `vip_user_import_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vip_user_import_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `batch_no` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '批次',
  `encrypt_mobile` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加密手机号',
  `decrypt_mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '解密手机号',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `vip_level` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `third_game_user_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '第三方游戏用户id',
  `remark` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `result` int NOT NULL DEFAULT '0' COMMENT '结果：0 成功；1 失败',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49805 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='vip用户导入日志';
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

-- Dump completed on 2024-06-14 14:35:27
