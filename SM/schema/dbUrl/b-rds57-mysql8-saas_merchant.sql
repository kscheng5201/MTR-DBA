-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_merchant
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
-- Table structure for table `app_module_supplier`
--

DROP TABLE IF EXISTS `app_module_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_module_supplier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'appid',
  `merchant_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `module_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块code',
  `supplier_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商code',
  `config_key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `enable_tf_pkg` int NOT NULL DEFAULT '0' COMMENT '是否开启tf包配置',
  `config` text COLLATE utf8mb4_general_ci COMMENT '配置，json格式',
  `update_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=602 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_module_supplier_bak_10021`
--

DROP TABLE IF EXISTS `app_module_supplier_bak_10021`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_module_supplier_bak_10021` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'appid',
  `merchant_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `module_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块code',
  `supplier_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商code',
  `config_key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `enable_tf_pkg` int NOT NULL DEFAULT '0' COMMENT '是否开启tf包配置',
  `config` text COLLATE utf8mb4_general_ci COMMENT '配置，json格式',
  `update_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_module_supplier_tf`
--

DROP TABLE IF EXISTS `app_module_supplier_tf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_module_supplier_tf` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_module_supplier_id` bigint NOT NULL DEFAULT '0' COMMENT '供应商配置记录id',
  `tf_pkg_id` bigint NOT NULL DEFAULT '0' COMMENT 'tf包配置id',
  `config` text COLLATE utf8mb4_unicode_ci COMMENT '配置，json格式',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`),
  KEY `idx_app_module_supplier_id` (`app_module_supplier_id`),
  KEY `idx_tf_pkg_id` (`tf_pkg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1725 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='供应商tf配置关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant`
--

DROP TABLE IF EXISTS `merchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_id` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'app_id',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `secret_key` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '秘钥',
  `domain` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '域名',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用，1-禁用',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除，0-否，1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_app`
--

DROP TABLE IF EXISTS `merchant_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_app` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用id',
  `app_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用名称',
  `app_type` int NOT NULL DEFAULT '0' COMMENT '0,全量；1，sdk',
  `public_key` varchar(2048) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公钥',
  `private_key` varchar(2048) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '私钥',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  `update_user` bigint NOT NULL,
  `create_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_base_info`
--

DROP TABLE IF EXISTS `merchant_base_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_base_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id,当前表插入前生成，其它关联表使用该字段关联',
  `name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT '企业名称',
  `credit_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '社会统一信用代码',
  `id_card_no` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '法人身份证号',
  `license_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '营业执照照片',
  `contact_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系人，看需求设计，应该是不存在多个，所以没有单独一张表',
  `contact_mobile` varchar(11) COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人手机号',
  `contact_email` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人邮箱',
  `type_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户性质',
  `type_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户性质',
  `status` int NOT NULL DEFAULT '0' COMMENT '0 正常 1 封禁',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_by` bigint NOT NULL COMMENT '创建人',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `lang` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语种 zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;',
  `pc_url` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'pc域名',
  `h5_url` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'h5域名',
  `backstage_url` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '后台域名',
  `xzs_url` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '小助手域名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_merchant_id` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_uid`
--

DROP TABLE IF EXISTS `merchant_uid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_uid` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `uid` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '生成的uid',
  `is_used` int NOT NULL DEFAULT '0' COMMENT '0-未使用，1-使用',
  `batch` int NOT NULL DEFAULT '1' COMMENT '批次',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_merchant_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='规则生成uid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_union`
--

DROP TABLE IF EXISTS `merchant_union`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_union` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `union_code` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '工会编号',
  `union_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '工会名称',
  `contact` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系电话',
  `account_title` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '抬头',
  `bank_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '开户行',
  `bank_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '开户行卡号',
  `bank_branch_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支行名称',
  `remark` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用，1-禁用',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除，0-否，1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_user`
--

DROP TABLE IF EXISTS `merchant_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `user_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录名',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码',
  `is_admin` int NOT NULL DEFAULT '0' COMMENT '是否是超级管理员',
  `status` int NOT NULL DEFAULT '1' COMMENT '是否有效0否1 是',
  `is_del` int NOT NULL DEFAULT '0' COMMENT '是否删除0否1是',
  PRIMARY KEY (`id`)
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

-- Dump completed on 2024-06-14 14:34:21
