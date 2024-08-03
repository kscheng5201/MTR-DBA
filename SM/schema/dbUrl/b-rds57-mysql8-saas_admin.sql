-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_admin
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
-- Table structure for table `audit_config`
--

DROP TABLE IF EXISTS `audit_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `apply_id` bigint NOT NULL DEFAULT '0' COMMENT '审核人',
  `code` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '审核code 1001:主播列表修改所在公会,1002:主播列表修改底薪、分成比例,1003:结算账单审核,1004:货币增发审核',
  `scene` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '审核场景',
  `page` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '审核页面',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coin_issue`
--

DROP TABLE IF EXISTS `coin_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coin_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `coin` bigint NOT NULL DEFAULT '0' COMMENT '增发鹰币数额',
  `exp` bigint NOT NULL DEFAULT '0' COMMENT '经验值增发',
  `operator_id` bigint NOT NULL DEFAULT '0' COMMENT '操作人id',
  `audit_id` bigint DEFAULT NULL COMMENT '审核人id',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态:0 待审核，1 已审核 2 已拒绝',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11460 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_monetary_record`
--

DROP TABLE IF EXISTS `report_monetary_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_monetary_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `total_consume` bigint NOT NULL DEFAULT '0' COMMENT '当天总消耗数（鹰币）',
  `total_recharge` bigint NOT NULL DEFAULT '0' COMMENT '当天总充值数（人民币）',
  `num` int NOT NULL DEFAULT '0' COMMENT '当天充值人数',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_settle_bill`
--

DROP TABLE IF EXISTS `report_settle_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_settle_bill` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `cycle_time` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '2020-04-01 00:00:00至2020-04-30 23:59:59' COMMENT '结算周期',
  `union_code` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '工会code',
  `union_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '工会名称',
  `anchor_id` bigint NOT NULL DEFAULT '0' COMMENT '主播id',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播房间号',
  `nickname` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播昵称',
  `real_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播真实姓名',
  `living_income` bigint NOT NULL DEFAULT '0' COMMENT '直播间收益（单位：羽毛）',
  `valid_income` bigint NOT NULL DEFAULT '0' COMMENT '可结算收益（单位：元）',
  `total_income` bigint NOT NULL DEFAULT '0' COMMENT '总收益（单位：元）',
  `extra_income` bigint NOT NULL DEFAULT '0' COMMENT '奖惩收益',
  `extra_type` int NOT NULL DEFAULT '0' COMMENT '奖惩类型0-奖励1-惩罚',
  `ratio` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播分成比例',
  `salary` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '主播底薪',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态:0-未发起审核 1-已发起审核 2-已同意 3-已拒绝',
  `reason` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '奖惩原因',
  `audit_by` bigint NOT NULL DEFAULT '0' COMMENT '审核人',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '发起人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_permission`
--

DROP TABLE IF EXISTS `sys_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `role_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '角色编号',
  `resource_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '资源编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14689 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_resource`
--

DROP TABLE IF EXISTS `sys_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '展示名称',
  `parent_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `path` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路径',
  `permission` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限标识',
  `component` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件',
  `hidden` int NOT NULL DEFAULT '0' COMMENT '是否显示',
  `redirect` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '点击跳转,父级菜单为空',
  `always_show` int NOT NULL DEFAULT '1' COMMENT '菜单是否一直显示',
  `icon` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` int NOT NULL DEFAULT '0' COMMENT '0-目录 1-菜单 2-按钮',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `role_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `type` int NOT NULL DEFAULT '2' COMMENT '角色类型 0-超级管理员 1-代理管理员 2-普通角色',
  `description` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色描述',
  `create_by` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `username` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `real_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '盐',
  `token` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户登录凭证',
  `pwd_reset_time` timestamp NULL DEFAULT NULL COMMENT '密码重置时间',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最近登录时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '创建人',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=365 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户编号',
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户编号',
  `role_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '角色编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vip_coin_issue`
--

DROP TABLE IF EXISTS `vip_coin_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vip_coin_issue` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商户编号',
  `vip_level` int NOT NULL DEFAULT '0' COMMENT 'vip等级',
  `coin` bigint NOT NULL DEFAULT '0' COMMENT '增发鹰币数额',
  `operator_id` bigint NOT NULL DEFAULT '0' COMMENT '操作人id',
  `audit_id` bigint DEFAULT NULL COMMENT '审核人id',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态:0 待审核，1 已审核 2 已拒绝',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='vip货币增发';
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

-- Dump completed on 2024-06-14 14:34:16
