-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_catalina
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
-- Table structure for table `activity_aggregation_config`
--

DROP TABLE IF EXISTS `activity_aggregation_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_aggregation_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '活动主标题',
  `subtitle` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '活动副标题',
  `pc_thumbnail` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'PC缩略图',
  `pc_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'PC跳转链接',
  `pc_jumpadress` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'pc静态页面跳转地址',
  `app_thumbnail` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'APP缩略图',
  `app_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'APP跳转链接',
  `app_jumpadress` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'APP静态页面跳转地址',
  `h5_thumbnail` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'H5缩略图',
  `h5_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'H5跳转链接',
  `h5_jumpadress` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'H5静态页面跳转地址',
  `effective_type` int NOT NULL DEFAULT '0' COMMENT '生效类型: 0-有时间限制 1-长期活动',
  `open_in_browser` int NOT NULL DEFAULT '0' COMMENT '是否浏览器打开 0-否 1-是',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `is_handoff` int NOT NULL DEFAULT '0' COMMENT '是否手工下架：0-否 1-是',
  `is_top` int NOT NULL DEFAULT '0' COMMENT '是否置顶：0-否 1-是',
  `top_order` int DEFAULT NULL COMMENT '置顶顺序',
  `status` int NOT NULL DEFAULT '0' COMMENT '活动状态：0-未开始 1-进行中 2-已结束',
  `is_delete` int DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `static_page_icon` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '静态页面跳转按钮图片地址',
  `project` int NOT NULL DEFAULT '0' COMMENT '平台标识0-sm 1-ak',
  `lang` char(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='活动聚合配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_popup_config`
--

DROP TABLE IF EXISTS `activity_popup_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_popup_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `thumbnail` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '缩略图',
  `platform_type` int NOT NULL DEFAULT '0' COMMENT '平台类型: 0-app 1-pc 2-h5',
  `redirect_type` int NOT NULL DEFAULT '0' COMMENT '跳转类型: 0-页面 1-直播间 2-资讯详情 3-聊天室 4-锦囊详情 5-不跳转',
  `redirect_content` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '跳转内容',
  `open_in_browser` int NOT NULL DEFAULT '0' COMMENT '是否浏览器打开 0-否 1-是',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0-待生效 1-生效中 2-已下线',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `project` int NOT NULL DEFAULT '0' COMMENT '平台标识0-sm1-ak',
  `lang` char(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='活动弹窗配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_config`
--

DROP TABLE IF EXISTS `ad_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `ad_channel` int NOT NULL DEFAULT '0' COMMENT '端类型: 0-App 1-PC 2-H5 3-iOS-Store',
  `ad_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '广告名称',
  `ad_position` int NOT NULL DEFAULT '0' COMMENT '资源位（0:首页Banner，1:聊天室Banner，2:开屏广告Banner，3:直播间Banner，4:广场推荐banner，5:积分首页Banner，6:直播页Banner）',
  `ad_type` int NOT NULL DEFAULT '0' COMMENT '0,普通广告；1，贴片广告',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '0,图片；1，视频；',
  `open_in_browser` int NOT NULL DEFAULT '0' COMMENT '是否浏览器打开 0-否 1-是',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `redirect_type` int DEFAULT '0' COMMENT '跳转类型: ()',
  `type_value` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '参数值',
  `thumbnail` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '预览图',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 待生效；1 生效中；2 已下线',
  `project` int NOT NULL DEFAULT '0' COMMENT '平台标识0-sm 1-ak',
  `lang` char(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100669 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_download_config`
--

DROP TABLE IF EXISTS `ad_download_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_download_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '活动名称',
  `h5_image` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'h5图片',
  `btn_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '按钮链接',
  `btn_text` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '按钮文案',
  `btn_color` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '按钮颜色',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 待生效；1 生效中；2 已下线',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='广告下载页配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement`
--

DROP TABLE IF EXISTS `agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agreement` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agreement_no` int DEFAULT NULL,
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `agreement_type` int DEFAULT NULL COMMENT '协议类型',
  `agreement_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '协议名称',
  `agreement_content` longtext COLLATE utf8mb4_general_ci COMMENT '协议内容',
  `release_time` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发布日期',
  `status` int DEFAULT NULL COMMENT '1:未发布 2:已发布',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `lang` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_audit_config`
--

DROP TABLE IF EXISTS `app_audit_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_audit_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `app_version` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'app版本',
  `module_name` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '禁用的模块名称,多个用,隔开',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_update_config`
--

DROP TABLE IF EXISTS `app_update_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_update_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `app_version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'app版本',
  `tip_pkg` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '提示包',
  `os_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作系统：1：ios 2:android',
  `content` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '更新内容简介',
  `down_load_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '安卓下载地址',
  `upgrade_type` int NOT NULL DEFAULT '0' COMMENT '更新方式： 0：不用更新 1：可选更新 2：强制更新',
  `guide_map_url` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '引导图,数组形式',
  `rar_type` int NOT NULL DEFAULT '0' COMMENT '包类型：0-更新版本 1-TF更新',
  `remind_time` timestamp NULL DEFAULT NULL COMMENT '提醒日期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area` (
  `id` bigint NOT NULL,
  `area_code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `area_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '地区名',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父地区ID',
  `area_level` smallint NOT NULL DEFAULT '1' COMMENT '地区级别 1：省 2：市 3：区县',
  `sort` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0保留 1删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='地区表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_recommend`
--

DROP TABLE IF EXISTS `circle_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_recommend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `circles` text COLLATE utf8mb4_general_ci COMMENT '圈子信息，格式为[{circleId:""}]',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：1-生效中；2-已暂停；',
  `position` int NOT NULL DEFAULT '0' COMMENT '推荐类型 0-主播推荐; 1-首页专家推荐; 2-锦囊页热门专家推荐;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crawler_config`
--

DROP TABLE IF EXISTS `crawler_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crawler_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '源地址编号',
  `site_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网站名称',
  `site_url` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网站URL',
  `fetch_time_scope` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '时间段',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 正常；1 锁定；',
  `info_type` int NOT NULL DEFAULT '0' COMMENT '信息类型：0，资讯 1，短视频',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `default_img_config`
--

DROP TABLE IF EXISTS `default_img_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_img_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商家编号',
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `value` varchar(510) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '值',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `type` int NOT NULL DEFAULT '0' COMMENT '类型:0 聊天室背景库',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 已上架；1 已下架',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dict`
--

DROP TABLE IF EXISTS `dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `flag` int DEFAULT '0' COMMENT '是否有效,0:有效;1:无效',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `update_by` varchar(30) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `dict_code` varchar(40) NOT NULL COMMENT '字典编码',
  `dict_name` varchar(40) NOT NULL COMMENT '字典名称',
  `short_name` varchar(20) DEFAULT NULL COMMENT '名称简写',
  PRIMARY KEY (`id`),
  UNIQUE KEY `字典编号` (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='系统字典类别';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dict_detail`
--

DROP TABLE IF EXISTS `dict_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `flag` int DEFAULT '0' COMMENT '是否有效,0:有效;1:无效',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `update_by` varchar(30) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `detail_code` varchar(40) NOT NULL COMMENT '详情编码',
  `detail_name` varchar(40) NOT NULL COMMENT '详情名称',
  `dict_code` varchar(40) NOT NULL COMMENT '字典编码',
  `dict_name` varchar(40) NOT NULL COMMENT '字典名称',
  `order_num` int DEFAULT '0' COMMENT '顺序',
  `short_name` varchar(20) DEFAULT NULL COMMENT '名称简写',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='系统字典详情';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dict_relation`
--

DROP TABLE IF EXISTS `dict_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dict_relation` (
  `id` bigint NOT NULL,
  `dict_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `parent_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `type` int NOT NULL DEFAULT '0' COMMENT '1,模块与供应商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain_pool`
--

DROP TABLE IF EXISTS `domain_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domain_pool` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `domain_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `domain_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'url',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `type` int NOT NULL DEFAULT '0' COMMENT '类型：0-APP 1-H5',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：0 停用；1 启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `european_ad_config`
--

DROP TABLE IF EXISTS `european_ad_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `european_ad_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `ad_channel` int NOT NULL DEFAULT '0' COMMENT '端类型: 0-App 1-PC 2-H5 3-iOS-Store',
  `ad_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '广告名称',
  `ad_position` int NOT NULL DEFAULT '0' COMMENT '资源位（1:LD+MX数字货币，2:LD+MX三重大礼包，3:锦囊霸榜，4:欧洲杯IM签到，5:欧洲杯幸运转盘，6:欧洲杯预言活动，7:欧洲杯专属商城， 8:主播金榜我提名',
  `ad_type` int NOT NULL DEFAULT '0' COMMENT '0,普通广告；1，贴片广告',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '0,图片；1，视频；',
  `open_in_browser` int NOT NULL DEFAULT '0' COMMENT '是否浏览器打开 0-否 1-是',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `redirect_type` int DEFAULT '0' COMMENT '跳转类型',
  `type_value` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '参数值',
  `thumbnail` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '预览图',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 待生效；1 生效中；2 已下线',
  `project` int NOT NULL DEFAULT '0' COMMENT '平台标识0-sm 1-ak',
  `lang` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='欧洲杯-广告资源位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `general_dict`
--

DROP TABLE IF EXISTS `general_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `general_dict` (
  `id` bigint NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典code',
  `parent_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '父编码',
  `dict_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
  `short_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '简称',
  `flag` int NOT NULL DEFAULT '0' COMMENT '0:有效，1：无效',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `update_user` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_center`
--

DROP TABLE IF EXISTS `help_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_center` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `level_id` bigint DEFAULT '0' COMMENT '一级分类ID',
  `level_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '二级分类名称',
  `level_order` int DEFAULT NULL COMMENT '二级分类排序',
  `agreement_content` longtext COLLATE utf8mb4_general_ci COMMENT '协议内容',
  `release_time` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发布日期',
  `status` int DEFAULT NULL COMMENT '0:未发布 1:已发布',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_center_level`
--

DROP TABLE IF EXISTS `help_center_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_center_level` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户id',
  `level_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '一级分类名称',
  `level_order` int DEFAULT NULL COMMENT '一级分类排序',
  `lang` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hot_manager`
--

DROP TABLE IF EXISTS `hot_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hot_manager` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `nick_name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播昵称',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `user_id` bigint NOT NULL COMMENT '主播ID',
  `hot_rate` float NOT NULL COMMENT '热力值系数',
  `hot_init` bigint NOT NULL COMMENT '热力值初始值',
  `create_by` bigint NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `information_aggregation`
--

DROP TABLE IF EXISTS `information_aggregation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `information_aggregation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `info_type` int NOT NULL COMMENT '1-资讯 2-短视频 3-动态 4-锦囊',
  `info_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容原始id',
  `info_title` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `is_hidden` int NOT NULL DEFAULT '0' COMMENT '是否隐藏 0-否 1-是',
  `is_top` int NOT NULL DEFAULT '0' COMMENT '是否置顶 0-否 1-是',
  `top_until` timestamp NULL DEFAULT NULL COMMENT '置顶失效时间',
  `top_time` timestamp NULL DEFAULT NULL COMMENT '置顶设置时间',
  `top_order` int DEFAULT NULL COMMENT '置顶顺序',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `publish_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`),
  KEY `idx_information_aggregation_info_type` (`info_type`),
  KEY `idx_information_aggregation_info_id` (`info_id`),
  KEY `idx_information_aggregation_status` (`is_delete`,`is_hidden`),
  KEY `idx_information_aggregation_is_top` (`is_top`),
  KEY `idx_information_aggregation_publish_time` (`publish_time`),
  KEY `idx_publish_time` (`is_delete`,`merchant_id`,`is_top`,`is_hidden`,`publish_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ios_upper_version_config`
--

DROP TABLE IF EXISTS `ios_upper_version_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ios_upper_version_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `store_version` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商城版本号',
  `inner_version` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '内部接口版本号',
  `inner_version_sort` bigint NOT NULL DEFAULT '0' COMMENT '内部接口版本号排序辅助字段',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：1-审核状态; 2-运营状态',
  `remark` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`),
  KEY `idx_inner_version_sort` (`inner_version_sort`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ios 上架版本版本配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_award_config`
--

DROP TABLE IF EXISTS `login_award_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_award_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '主题',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '赠送渠道: 0-app; 1-pc; 2-h5; 3-webapp; 所有渠道以","拼接且首尾额外追加",", 如app和pc时值为",0,1,"',
  `coin_amount` int NOT NULL DEFAULT '0' COMMENT '赠送货币数量',
  `is_ext_coin_opened` int NOT NULL DEFAULT '0' COMMENT '是否开启额外赠送货币: 0-否; 1-是',
  `ext_coin_amount` int DEFAULT NULL COMMENT '额外赠送货币数量',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `status` int NOT NULL DEFAULT '0' COMMENT '活动状态：0-未开始 1-进行中 2-已结束',
  `is_delete` int DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='登录奖励活动配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_award_detail`
--

DROP TABLE IF EXISTS `login_award_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_award_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `config_id` bigint NOT NULL DEFAULT '0' COMMENT '登录奖励配置主键',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `coin_amount` int NOT NULL DEFAULT '0' COMMENT '赠送货币数量',
  `is_ext_coin_settled` int NOT NULL DEFAULT '0' COMMENT '额外赠送货币是否已结算: 0-否; 1-是',
  `ext_coin_amount` int NOT NULL DEFAULT '0' COMMENT '额外赠送货币数量',
  `ext_coin_settle_time` datetime DEFAULT NULL COMMENT '额外赠送货币发放时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_settled` int NOT NULL DEFAULT '0' COMMENT '是否结算: 0-否 1-是',
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_config_id` (`config_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1142370 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='登录奖励活动明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_website_config`
--

DROP TABLE IF EXISTS `navigation_website_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_website_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `site_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '站点名称',
  `site_url` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '站点url',
  `weight` bigint NOT NULL DEFAULT '0' COMMENT '站点权重',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='导航站点配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_anchor_config`
--

DROP TABLE IF EXISTS `pc_anchor_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pc_anchor_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `nickname` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主播昵称',
  `room_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '主播ID',
  `cover` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '推荐图',
  `status` int NOT NULL DEFAULT '1' COMMENT '0无效  1：有效',
  `order_no` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=713 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_banner_config`
--

DROP TABLE IF EXISTS `pc_banner_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pc_banner_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `resource_position` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '资源位置',
  `title` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `start_time` datetime DEFAULT NULL COMMENT '生效时间',
  `end_time` datetime DEFAULT NULL COMMENT '失效时间',
  `cover` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '推荐图',
  `redirect_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '跳转链接',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `banner_type` int NOT NULL DEFAULT '0' COMMENT '1 大推荐位  2小banner上  3小banner下  4滚动banner  5 横幅banner',
  `status` int NOT NULL DEFAULT '0' COMMENT '0无效  1：有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `popular_recommend`
--

DROP TABLE IF EXISTS `popular_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `popular_recommend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '房间号',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：0 已暂停；1 生效中；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recharge_config`
--

DROP TABLE IF EXISTS `recharge_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recharge_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `coin` bigint NOT NULL DEFAULT '0' COMMENT '人民币',
  `num` bigint NOT NULL DEFAULT '0' COMMENT '鹰币数量',
  `product_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '产品id(针对ios)',
  `platform` int NOT NULL DEFAULT '0' COMMENT '平台类型0-android 1-ios',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=517 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recommend`
--

DROP TABLE IF EXISTS `recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `resource_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '资源名称',
  `items` text COLLATE utf8mb4_general_ci COMMENT '资源配置情况，格式为[{uid:1000,cover:a.jpg}]',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 已暂停；1 生效中；',
  `recommend_type` int NOT NULL DEFAULT '0' COMMENT '推荐类型 0-主播推荐; 1-首页专家推荐; 2-锦囊页热门专家推荐;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `red_packet_grade_config`
--

DROP TABLE IF EXISTS `red_packet_grade_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `red_packet_grade_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `amount` bigint unsigned NOT NULL DEFAULT '0' COMMENT '红包总额',
  `quantity` int unsigned NOT NULL DEFAULT '0' COMMENT '红包份数',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态: 0 未生效; 1 已生效;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='红包档位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_refer_stat`
--

DROP TABLE IF EXISTS `site_refer_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_refer_stat` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `stat_date` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '统计日期： yyyy-MM-dd',
  `channel` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '渠道代码：PC/H5',
  `source_domain` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '来源域名',
  `assist_uv` bigint NOT NULL DEFAULT '0' COMMENT '小助手UV',
  `notice_uv` bigint NOT NULL DEFAULT '0' COMMENT '公告UV',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_stat_date` (`stat_date`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='前端来源统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `static_page_config`
--

DROP TABLE IF EXISTS `static_page_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_page_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '页面名称',
  `pc_images` json DEFAULT NULL COMMENT 'PC资源图',
  `h5_images` json DEFAULT NULL COMMENT 'H5资源图',
  `params` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0 待生效；1 生效中；2 已下线',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `jump_address` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` int NOT NULL DEFAULT '0' COMMENT '平台标识0-sm1-ak',
  `lang` char(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  `page_view_num` bigint unsigned NOT NULL DEFAULT '0' COMMENT '页面访问数',
  `click_num` bigint unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `register_num` bigint unsigned NOT NULL DEFAULT '0' COMMENT '透过按钮注册数',
  PRIMARY KEY (`id`),
  KEY `idx_params` (`params`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='静态页面配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典组',
  `dict_key` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典key',
  `dict_value` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典value',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父级id',
  `sort` int DEFAULT '0' COMMENT '顺序',
  `status` int DEFAULT '0' COMMENT '是否有效,0:有效;1:无效',
  `remark` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `lang` char(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_group_id_dict_key` (`group_id`,`dict_key`,`lang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=500055 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf_config`
--

DROP TABLE IF EXISTS `tf_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tf_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `user_account` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '开发者账号',
  `rar_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '包名',
  `down_load_url` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '下载地址',
  `effect_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生效日期',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '失效日期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_merchant_id_rar_name` (`merchant_id`,`rar_name`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='tf包创建表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vip_config`
--

DROP TABLE IF EXISTS `vip_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vip_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `vip_level` int NOT NULL DEFAULT '0' COMMENT 'vip等级：其中0表示非vip;',
  `app_bkg_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'app背景链接',
  `pc_bkg_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'pc背景链接',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='vip配置';
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
