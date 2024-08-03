-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_cockpit
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
-- Table structure for table `merchant_app`
--

DROP TABLE IF EXISTS `merchant_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_app` (
  `id` int NOT NULL,
  `app_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用id',
  `app_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用名称',
  `app_type` int NOT NULL DEFAULT '0' COMMENT '0,全量；1，sdk',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  `create_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_app_theme`
--

DROP TABLE IF EXISTS `merchant_app_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_app_theme` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `merchant_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `app_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品代码',
  `app_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `app_channel_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道代码',
  `app_channel_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道名称',
  `theme_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主题代码',
  `theme_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主题名称',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_user` bigint NOT NULL,
  `create_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_base_resource`
--

DROP TABLE IF EXISTS `merchant_base_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_base_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件名称',
  `title` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '展示名称',
  `title_en` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '英文标题',
  `parent_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `path` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路径',
  `permission` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `is_merchant_show` int NOT NULL DEFAULT '1' COMMENT '是否在商户端展示 0 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=732 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商户菜单基准库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_sdk_manage`
--

DROP TABLE IF EXISTS `merchant_sdk_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_sdk_manage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `app_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'app_id',
  `sdk_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sdk代码',
  `sdk_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sdk名称',
  `sdk_permission` json DEFAULT NULL COMMENT 'sdk产品已授权明细 [{\r\n"code": "功能代码",\r\n  "name": "功能名称"\r\n}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_selection_resource`
--

DROP TABLE IF EXISTS `merchant_selection_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_selection_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `resource_id` bigint NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15726 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='给商户分配的菜单库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platform_sdk_manage`
--

DROP TABLE IF EXISTS `platform_sdk_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform_sdk_manage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sdk_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sdk名称',
  `sdk_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sdk代码',
  `status` int NOT NULL DEFAULT '1' COMMENT '是否有效 0 否 1 是',
  `sdk_detail` json DEFAULT NULL COMMENT 'sdk支持的功能详情，[{"code":"功能代码","name":"功能名称","is_open":"是否开放给商户，这个是否开放这个功能的意思，不是不需要权限"}]',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platform_theme_config`
--

DROP TABLE IF EXISTS `platform_theme_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform_theme_config` (
  `id` bigint NOT NULL,
  `app_code` enum('LIVE') COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品代码 LIVE 直播',
  `app_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `app_channel_code` enum('Android','IOS','PC','H5') COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用渠道代码',
  `app_channel_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用渠道名称',
  `theme_code` enum('Night','Whitey') COLLATE utf8mb4_general_ci NOT NULL COMMENT '主题代码',
  `theme_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主题名称',
  `config` json DEFAULT NULL COMMENT '配置内容',
  `example` json DEFAULT NULL COMMENT '样例内容 {"picUrl": ["", ""]}',
  `is_default` int NOT NULL DEFAULT '0' COMMENT '是否为默认主题0否1是,如果为默认主题，则在商户新建时初始化为1的主题',
  `is_disable` int NOT NULL DEFAULT '0' COMMENT '是否无效 0否1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='文档类型的配置内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_permission`
--

DROP TABLE IF EXISTS `sys_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '角色编号',
  `resource_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '资源编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_resource`
--

DROP TABLE IF EXISTS `sys_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件名称',
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
) ENGINE=InnoDB AUTO_INCREMENT=10011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `type` int NOT NULL DEFAULT '2' COMMENT '角色类型 0-超级管理员 1-代理管理员 2-普通角色',
  `description` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色描述',
  `create_by` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `real_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '盐',
  `token` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户登录凭证',
  `pwd_reset_time` timestamp NULL DEFAULT NULL COMMENT '密码重置时间',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最近登录时间',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户编号',
  `role_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '角色编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:18
