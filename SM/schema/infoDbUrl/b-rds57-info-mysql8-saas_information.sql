-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-info-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_information
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
-- Table structure for table `content_tag_relation`
--

DROP TABLE IF EXISTS `content_tag_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_tag_relation` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `content_info_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '资讯 ID',
  `parent_tag_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '一级标签 ID',
  `tag_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '二级标签 ID',
  `status` int DEFAULT '0' COMMENT '0-启用 1-禁用,-1,逻辑删除',
  `info_type` int NOT NULL DEFAULT '0' COMMENT '信息类型，0，资讯 1，视频',
  `creator_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_content_info_type` (`content_info_id`,`info_type`,`tag_id`) USING BTREE,
  KEY `index_content_info_id` (`content_info_id`) USING BTREE,
  KEY `index_parent_tag_id` (`parent_tag_id`,`tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='资讯-标签-关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crawler`
--

DROP TABLE IF EXISTS `crawler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crawler` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `source_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '来源 ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `author` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '作者',
  `summery` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '摘要',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '正文',
  `cover_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面图',
  `pgc_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '详情图',
  `detail_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详情链接地址',
  `channel_type` int DEFAULT '1' COMMENT '渠道类型：1 爬取；2 赛事中心；3 原创；默认为 1',
  `source_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资讯来源 网站名称/平台运营人员/主播名称',
  `source_detail_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '具体来源',
  `info_type` int NOT NULL DEFAULT '0' COMMENT '信息类型，0，资讯 1，视频',
  `video_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '默认视频地址',
  `is_finish` int NOT NULL DEFAULT '0' COMMENT '是否完成',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用,-1,逻辑删除',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `column_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `audit_status` int DEFAULT '3' COMMENT '审核状态 0-未审核,2-审核失败,3-审核通过,4-拒绝,5-退回',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `publish_status` int DEFAULT '0' COMMENT '发布状态 0-未发布 1-已发布',
  `publish_status_change_time` datetime DEFAULT NULL COMMENT '发布状态变更时间',
  `keyword` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '关键字',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '(资讯)1-足球 2-篮球 (短视频)1-前瞻 2-精华 3-娱乐',
  `lang` char(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_create_time` (`create_time`) USING BTREE,
  KEY `index_source_id` (`source_id`) USING BTREE,
  KEY `index_detail_url` (`detail_url`) USING BTREE,
  KEY `index_channel_type` (`channel_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_content_config`
--

DROP TABLE IF EXISTS `merchant_content_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_content_config` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `merchant_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `content_info_type` int DEFAULT '3' COMMENT '分配内容形式，0，图文/资讯; 1，视频; 2. 全部；3. 无内容',
  `is_tactic` int DEFAULT '0' COMMENT '是否分配锦囊 0否 1是',
  `distribution_range` int DEFAULT NULL COMMENT '分配内容范围，1 全部内容；2.按标签分配',
  `is_not_tag` int DEFAULT NULL COMMENT '是否分配无标签内容，`1.是；0.否',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用,-1,逻辑删除',
  `distribution_status` int DEFAULT '0' COMMENT '定时任务分配状态：0 未执行；1 已执行',
  `pre_distribution_status` int DEFAULT '0' COMMENT '定时任务预分配状态：0 未执行；1 已执行',
  `is_alternative_operate` int NOT NULL DEFAULT '0' COMMENT '是否代运营：0-否 1-是',
  `is_distribution_original` int NOT NULL DEFAULT '0' COMMENT '是否分配原创内容：0-否 1-是',
  `is_distribution_tag` int NOT NULL DEFAULT '0' COMMENT '是否分配全部有标签内容：0-否 1-是',
  `creator_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_merchant_status` (`merchant_id`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商户-资讯-配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_content_config_detail`
--

DROP TABLE IF EXISTS `merchant_content_config_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_content_config_detail` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `config_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应 merchant_content_config 中的 ID',
  `parent_tag_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '一级标签 ID',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-正常 -1,逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_config_tag` (`config_id`,`parent_tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商户-资讯-配置标签明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_content_distribution`
--

DROP TABLE IF EXISTS `merchant_content_distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_content_distribution` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `content_info_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容 ID',
  `info_type` int NOT NULL DEFAULT '0' COMMENT '信息类型，0，资讯 1，视频',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用,-1,逻辑删除',
  `creator_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_merchant_content_info_type` (`merchant_id`,`content_info_id`,`info_type`) USING BTREE,
  KEY `index_content_info_id_info_type` (`content_info_id`,`info_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商户-资讯-分配表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `merchant_content_statistics`
--

DROP TABLE IF EXISTS `merchant_content_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_content_statistics` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户id',
  `merchant_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `content_info_type` int NOT NULL COMMENT '分配内容形式，0，图文/资讯; 1，视频;',
  `distribution_num` int DEFAULT '0' COMMENT '分配量',
  `public_num` int DEFAULT '0' COMMENT '发布量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `statistics_time` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '统计时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_merchant_info_type_statistics_time_status` (`merchant_id`,`content_info_type`,`statistics_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商户-资讯-分配/发布-统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pgc`
--

DROP TABLE IF EXISTS `pgc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pgc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `info_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '资讯id',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `author` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '作者',
  `summery` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '摘要',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '正文',
  `cover_url` varchar(510) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '封面图',
  `source_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '资讯来源 网站名称/平台运营人员/主播名称',
  `pgc_type` int NOT NULL DEFAULT '1' COMMENT '资讯分类 1-草稿 2-发布',
  `publish_status` int NOT NULL DEFAULT '0' COMMENT '发布状态 0-未发布 1-已发布 2-已下架',
  `video_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '视频地址',
  `info_type` int NOT NULL DEFAULT '0' COMMENT '// 爬取数据类型0，资讯1，短视频',
  `status` int NOT NULL DEFAULT '0' COMMENT '1-禁用 0-启用',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `crawler_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源id',
  `is_top` int DEFAULT '0' COMMENT '是否置顶：0-否；1-是',
  `top_sort` int DEFAULT '0' COMMENT '置顶排序：越小越靠前',
  `top_time` datetime DEFAULT NULL COMMENT '置顶时间',
  `cancel_top_time` datetime DEFAULT NULL COMMENT '取消置顶时间(默认 NULL 为了兼容旧数据)',
  `keyword` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '关键字',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '(资讯)1-足球 2-篮球 (短视频)1-前瞻 2-精华 3-娱乐',
  `lang` char(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'zh' COMMENT '语言(zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_pgc_crawler_id` (`crawler_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `source_crawler`
--

DROP TABLE IF EXISTS `source_crawler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source_crawler` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `source_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '来源 ID',
  `title` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `author` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '作者',
  `summery` varchar(512) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '摘要',
  `content` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '正文',
  `cover_url` varchar(510) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '封面图',
  `pgc_url` varchar(510) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '详情图',
  `detail_url` varchar(510) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '详情链接地址',
  `channel_type` int DEFAULT '1' COMMENT '渠道类型：1 爬取；2 赛事中心；3 原创；默认为 1',
  `source_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '资讯来源 网站名称/平台运营人员/主播名称',
  `source_detail_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '具体来源',
  `info_type` int NOT NULL DEFAULT '0' COMMENT '信息类型，0，资讯 1，视频',
  `video_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '默认视频地址',
  `is_finish` int NOT NULL DEFAULT '0' COMMENT '是否完成',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用,-1,逻辑删除',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `remark` varchar(500) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `column_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_create_time` (`create_time`) USING BTREE,
  KEY `index_source_id` (`source_id`) USING BTREE,
  KEY `index_detail_url` (`detail_url`) USING BTREE,
  KEY `index_channel_type` (`channel_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='源爬虫表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(22) COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签名称',
  `parent_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '父级 ID',
  `level` int DEFAULT '2' COMMENT '层级: 1.一级标签   2.二级标签',
  `sort` int DEFAULT '1' COMMENT '优先排序：数值越小越靠前',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-启用 1-禁用,-1,逻辑删除',
  `creator_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name_level` (`name`,`level`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='资讯标签-基础表';
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

-- Dump completed on 2024-06-14 14:34:58
