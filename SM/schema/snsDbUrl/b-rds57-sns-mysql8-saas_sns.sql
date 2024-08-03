-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-sns-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_sns
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
-- Table structure for table `circle_authorized`
--

DROP TABLE IF EXISTS `circle_authorized`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_authorized` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0/加入 1/退出',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_id` (`merchant_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='群主授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_detail`
--

DROP TABLE IF EXISTS `circle_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `circle_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '圈子ID',
  `is_private` int NOT NULL DEFAULT '0' COMMENT '是否私密: 0-否，1-是',
  `is_mute` int NOT NULL DEFAULT '0' COMMENT '是否禁言: 0-否，1-是',
  `is_official` int NOT NULL DEFAULT '0' COMMENT '是否官方: 0-否，1-是',
  `logo_url` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '圈子头像url',
  `background_url` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '圈子背景图url',
  `introduce` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '介绍',
  `person_limit` bigint NOT NULL DEFAULT '50' COMMENT '群员上限',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  `admin_user_id` bigint DEFAULT NULL COMMENT '操作人马甲用户id',
  `console_user_id` bigint DEFAULT NULL COMMENT '操作人控台用户id',
  `console_remark` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '控台操作备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_id` (`circle_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='圈子明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_master`
--

DROP TABLE IF EXISTS `circle_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_master` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `circle_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '圈子ID',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户ID',
  `name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '圈子名称',
  `master_user_id` bigint NOT NULL COMMENT '群主用户ID',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-正常，1-解散',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_id` (`circle_id`) USING BTREE,
  UNIQUE KEY `uk_name` (`merchant_id`,`name`) USING BTREE,
  KEY `idx_master_user_id` (`master_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='圈子主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_notice`
--

DROP TABLE IF EXISTS `circle_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `circle_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '圈子id',
  `config` json DEFAULT NULL COMMENT '公告配置',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_circle_id` (`circle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='圈子公告配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_resource`
--

DROP TABLE IF EXISTS `circle_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_resource` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `circle_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '圈子ID',
  `resource_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源ID',
  `status` int NOT NULL DEFAULT '0' COMMENT '0-待审核 1-上架 2-下架 3-拒绝 4-删除',
  `shelves_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '资源上架时间',
  `publish_user_id` bigint NOT NULL COMMENT '发布者ID',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_resource_id` (`resource_id`) USING BTREE,
  KEY `idx_circle_id` (`circle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4676 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='圈子资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_tags`
--

DROP TABLE IF EXISTS `circle_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `tag_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  `tag_type` int NOT NULL DEFAULT '0' COMMENT '标签类型：0 圈子标签 1 运营标签',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_user`
--

DROP TABLE IF EXISTS `circle_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `circle_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '圈子ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `nickname` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `is_admin` int NOT NULL DEFAULT '0' COMMENT '是否管理员: 0-普通人 1-群主 2-管理员',
  `is_quiet` int NOT NULL DEFAULT '0' COMMENT '消息是否免打扰: 0-否，1-是',
  `is_top` int NOT NULL DEFAULT '0' COMMENT '列表中是否置顶: 0-否，1-是',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0/加入 1/退出',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  `is_console_op` int NOT NULL DEFAULT '0' COMMENT '是否转化控台操作：0-否; 1-是',
  `admin_user_id` bigint DEFAULT NULL COMMENT '转化控台操作人马甲用户id',
  `console_user_id` bigint DEFAULT NULL COMMENT '转化控台操作人用户id',
  `console_remark` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '转化控台操作备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_merhcant_circle_user` (`merchant_id`,`circle_id`,`user_id`) USING BTREE,
  KEY `idx_circle_id` (`circle_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_update_time` (`update_time`)
) ENGINE=InnoDB AUTO_INCREMENT=418539 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='圈子用户关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_user_log`
--

DROP TABLE IF EXISTS `circle_user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `circle_user_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `change_type` int NOT NULL DEFAULT '0' COMMENT '变更类型：0-加入圈子; 1-退出圈子; 2-变更圈子',
  `circle_id_before` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变更前圈子id',
  `circle_id_after` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变更后圈子id',
  `reason` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变更原因',
  `admin_user_id` bigint NOT NULL DEFAULT '0' COMMENT 'c端管理员用户id',
  `console_user_id` bigint NOT NULL DEFAULT '0' COMMENT '商户端用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`),
  KEY `idx_circle_id_before` (`circle_id_before`),
  KEY `idx_circle_id_after` (`circle_id_after`)
) ENGINE=InnoDB AUTO_INCREMENT=430109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='圈子用户变更记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dynamics_read_log`
--

DROP TABLE IF EXISTS `dynamics_read_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dynamics_read_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `read_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '读取最新动态时间',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户读取广场动态最新时间记录表-';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invitation_info`
--

DROP TABLE IF EXISTS `invitation_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invitation_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `invitation_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '帖子ID',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `topic_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '话题ID',
  `background_url` text COLLATE utf8mb4_general_ci COMMENT '图片url',
  `content` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文字内容',
  `video_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频url',
  `video_cover_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频封面url',
  `publish_user_id` bigint NOT NULL COMMENT '发布者ID',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0/上架 1/下架',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_invitation_id` (`invitation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='帖子主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recommend_info`
--

DROP TABLE IF EXISTS `recommend_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommend_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `recommend_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '推荐信息ID',
  `content` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '内容',
  `cover_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '封面图片',
  `create_user` bigint DEFAULT NULL COMMENT '创建人用户ID',
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '推荐数据类型（CHAT_ROOM：聊天室）',
  `heat_number` bigint DEFAULT NULL COMMENT '热力值',
  `merchant_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `extend` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展字段（type=CHAT_ROOM：开播编号）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `topic_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '话题ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_detail`
--

DROP TABLE IF EXISTS `resource_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `circle_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '圈子ID',
  `resource_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源ID',
  `background_url` text COLLATE utf8mb4_general_ci COMMENT '图片url',
  `content` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文字内容',
  `video_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频url',
  `video_cover_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '视频封面url',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  `topic_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '话题ID',
  `resource_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'CIRCLE_RESOURCE' COMMENT '资源类型（CIRCLE_RESOURCE：圈子动态，INVITATION：普通帖子）',
  `status` int DEFAULT '0' COMMENT '状态 0/上架 1/下架',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_resource_id` (`resource_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7890 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='圈子投稿资源详细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_view`
--

DROP TABLE IF EXISTS `resource_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource_view` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户ID',
  `resource_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '资源ID',
  `resource_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '资源类型',
  `view_total` bigint DEFAULT '0' COMMENT '浏览统计',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_resource_id` (`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='资源浏览统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_master`
--

DROP TABLE IF EXISTS `topic_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic_master` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户ID',
  `topic_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '话题ID',
  `content` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '话题内容',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态 0/上架 1/下架',
  `create_by` bigint NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint NOT NULL DEFAULT '0' COMMENT '更新人ID',
  `thumbnail_url` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '缩略图',
  `background_url` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '背景图',
  `synopsis` text COLLATE utf8mb4_general_ci COMMENT '描述说明',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_topic_id` (`topic_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='话题主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_recommend`
--

DROP TABLE IF EXISTS `topic_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic_recommend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '话题推荐ID',
  `topic_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '话题ID',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_comment`
--

DROP TABLE IF EXISTS `user_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `comment_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '品论类型',
  `parent_id` bigint DEFAULT NULL COMMENT '品论父节点',
  `comment_id` bigint DEFAULT NULL COMMENT '品论内容ID',
  `comment` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '评论内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_comment_comment_id_index` (`comment_id`) USING BTREE,
  KEY `user_comment_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=183170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_favorite`
--

DROP TABLE IF EXISTS `user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `store_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '收藏类型',
  `store_id` bigint DEFAULT NULL COMMENT '收藏内容ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_favorite_store_id_index` (`store_id`) USING BTREE,
  KEY `user_favorite_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_follow`
--

DROP TABLE IF EXISTS `user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `follow_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '关注类型',
  `follow_id` bigint DEFAULT NULL COMMENT '关注内容ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_follow_follow_id_index` (`follow_id`) USING BTREE,
  KEY `user_follow_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=309777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_like`
--

DROP TABLE IF EXISTS `user_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_like` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `like_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '点赞类型',
  `like_id` bigint DEFAULT NULL COMMENT '点赞内容ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_like_like_id_index` (`like_id`) USING BTREE,
  KEY `user_like_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144529 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_report`
--

DROP TABLE IF EXISTS `user_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_report` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `room_no` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主播房间号(UID)',
  `nick_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主播昵称',
  `reported_id` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '被举报人UID',
  `report_source` int DEFAULT NULL COMMENT '举报来源（房间类型）1:liveRoom 2:chatRoom',
  `report_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '举报类型',
  `reason` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '举报原因',
  `reporter_nick_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '举报人昵称',
  `status` int DEFAULT NULL COMMENT '状态 0:在线;1:不在线',
  `report_reply` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '举报回复',
  `create_by` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '举报人房间号(UID)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2345 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:35:08
