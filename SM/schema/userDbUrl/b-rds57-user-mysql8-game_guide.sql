-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-user-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: game_guide
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
-- Table structure for table `sys_admin`
--

DROP TABLE IF EXISTS `sys_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_admin` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '昵称名称',
  `username` varchar(50) NOT NULL COMMENT '登陆账号',
  `password` varchar(255) NOT NULL COMMENT '登陆密码',
  `super_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为超级管理员',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1=正常，-1=禁用',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_admin_permission`
--

DROP TABLE IF EXISTS `sys_admin_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_admin_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `admin_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '管理员id',
  `resource_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '资源编号',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_permission` (`admin_id`,`resource_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='角色权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key_type` varchar(100) NOT NULL COMMENT '类型（程序固定死的值）',
  `key_name` varchar(100) NOT NULL COMMENT '名称',
  `key_value` varchar(100) NOT NULL COMMENT '值',
  `key_desc` varchar(100) NOT NULL COMMENT '描述',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_resource`
--

DROP TABLE IF EXISTS `sys_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=目录,2=菜单,3=按钮',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '展示名称',
  `parent_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `path` varchar(64) NOT NULL DEFAULT '' COMMENT '路径',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `icon` varchar(64) NOT NULL DEFAULT '' COMMENT '图标',
  `hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否显示',
  `apis` text COMMENT '调用的接口地址，用“,”分割',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，0=未删除，1=已删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_app_user_info`
--

DROP TABLE IF EXISTS `tb_app_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_app_user_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint unsigned NOT NULL COMMENT '商户id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_user` (`merchant_id`,`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='app用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_area`
--

DROP TABLE IF EXISTS `tb_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_area` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_code` varchar(16) NOT NULL DEFAULT '' COMMENT '父级code',
  `code` varchar(16) NOT NULL DEFAULT '' COMMENT 'code',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '昵称',
  `level` int NOT NULL DEFAULT '0' COMMENT '层级',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_article_info`
--

DROP TABLE IF EXISTS `tb_article_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_article_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_img` text COMMENT '封面图片url',
  `uniq_article` char(32) GENERATED ALWAYS AS (md5(`article_title`)) STORED,
  `article_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `article_content` text COMMENT '内容',
  `article_source` varchar(255) DEFAULT NULL COMMENT '来源渠道',
  `tag_id` bigint DEFAULT NULL COMMENT '标签id',
  `article_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上架状态，1=上架，0=下架',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_title` (`uniq_article`,`tag_id`) USING BTREE,
  KEY `idx_tag` (`tag_id`) USING BTREE,
  KEY `idx_status` (`article_status`) USING BTREE,
  KEY `idx_title` (`article_title`(191)) USING BTREE,
  KEY `idx_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19800 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='新闻表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_banner_info`
--

DROP TABLE IF EXISTS `tb_banner_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_banner_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `img_url` text NOT NULL COMMENT '图片url',
  `link_url` text COMMENT '跳转链接',
  `img_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '图片类型 1-banner 2-下载二维码 3-加群弹窗 4-首页-广告图(上) 5-首页-广告图（下）6-推单详情页-广告图 7-专家页-广告图 8-专家主页-广告图 9-h5-首页banner  10-h5-加群弹窗 11-PC顶图 12-h5顶图',
  `img_title` varchar(255) DEFAULT NULL COMMENT '图片标题',
  `no_follow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否跟随 0-否 1-是',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant_id_img_type` (`merchant_id`,`img_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=427 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='图片配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_domain_site_config`
--

DROP TABLE IF EXISTS `tb_domain_site_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_domain_site_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `domain_id` bigint NOT NULL COMMENT '域名id',
  `site_type` tinyint(1) NOT NULL COMMENT '站点类型 1-百度',
  `site_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '站点密钥',
  `last_news_id` bigint DEFAULT NULL COMMENT '最新资讯id',
  `last_video_id` bigint DEFAULT NULL COMMENT '最新录像id',
  `last_game_id` bigint DEFAULT NULL COMMENT '最新赛事id',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_domain_site` (`domain_id`,`site_type`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='域名站点配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_domain_site_push_record`
--

DROP TABLE IF EXISTS `tb_domain_site_push_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_domain_site_push_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `domain_id` bigint NOT NULL COMMENT '域名id',
  `day_str` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '日期',
  `news_num` int NOT NULL DEFAULT '0' COMMENT '资讯数量',
  `video_num` int NOT NULL DEFAULT '0' COMMENT '录像数量',
  `game_num` int NOT NULL COMMENT '赛事数量',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_doamin_day` (`domain_id`,`day_str`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7559 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='域名站点推送统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_follow_team_info`
--

DROP TABLE IF EXISTS `tb_follow_team_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_follow_team_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_user_id` bigint unsigned NOT NULL COMMENT 'app用户id',
  `team_id` bigint DEFAULT NULL COMMENT '球队id',
  `game_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_user_follow_team` (`team_id`,`app_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='关注球队表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_friend_link`
--

DROP TABLE IF EXISTS `tb_friend_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_friend_link` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户号Id',
  `link_name` varchar(255) NOT NULL COMMENT '友链名称',
  `link_url` text COMMENT '跳转地址',
  `no_follow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否跟随',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商户友链配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_game_field`
--

DROP TABLE IF EXISTS `tb_game_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_game_field` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `field_type` tinyint(1) NOT NULL COMMENT '类型，1-首页/直播赛程页 2-次导航页',
  `field_name` varchar(128) NOT NULL COMMENT '字段名称',
  `link_url` text COMMENT '跳转链接',
  `no_follow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否跟随',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_merchant_id_field_name` (`merchant_id`,`field_name`,`field_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='赛事字段配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_game_info`
--

DROP TABLE IF EXISTS `tb_game_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_game_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `match_id` bigint unsigned NOT NULL COMMENT '第三方赛事id',
  `combined_id` bigint DEFAULT NULL COMMENT '合并后之三方赛事id',
  `game_time` datetime NOT NULL COMMENT '比赛时间',
  `game_end_time` datetime DEFAULT NULL COMMENT '比赛结束时间',
  `league_id` bigint unsigned NOT NULL COMMENT '第三方联赛id',
  `stage_id` bigint unsigned DEFAULT NULL COMMENT '第三方阶段id',
  `season_id` bigint unsigned DEFAULT NULL COMMENT '第三方赛季id',
  `game_key` varchar(100) NOT NULL COMMENT '联赛名称',
  `game_type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `v_team_id` bigint unsigned NOT NULL COMMENT '第三方主队id',
  `v_point` int unsigned DEFAULT NULL COMMENT '主队比分',
  `s_team_id` bigint unsigned NOT NULL COMMENT '第三方客队id',
  `s_point` int DEFAULT NULL COMMENT '客队比分',
  `game_status` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态，0-进行中，1-未开赛 2-已结束 3-已推迟 4-已取消 5-已中断 6-已腰斩 7-已延期 8-待定 9-异常',
  `game_stage` varchar(50) DEFAULT NULL COMMENT '赛事状态 (未开赛、赛程进行中、已结束、延期、中断...)',
  `game_stage_type` smallint DEFAULT NULL COMMENT '赛事状态代码\r\n0: 未开赛\r\n10: 上半场 11: 第一节 12: 第一节完 13: 第二节 14: 第二节完\r\n20: 中场\r\n30: 下半场 31: 第三节 32: 第三节完 33: 第四节\r\n40: 加时赛 41: 点球决战\r\n50: 完场\r\n60: 推迟 61: 中断 62: 腰斩 3: 延期 64: 取消\r\n99: 待定',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `live_num` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '上架的主播数量',
  `total_live_num` int DEFAULT '0' COMMENT '所有主播数量',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_match_id` (`match_id`) USING BTREE,
  KEY `idx_game_key` (`game_key`) USING BTREE,
  KEY `idx_league_id_game_time_status` (`league_id`,`game_time`,`game_status`) USING BTREE,
  KEY `idx_game_time_game_status` (`game_time`,`game_status`) USING BTREE,
  KEY `idx_game_type_game_time` (`game_type`,`game_time`) USING BTREE,
  KEY `idx_v_team_id_game_time` (`v_team_id`,`game_time`) USING BTREE,
  KEY `idx_league_id_game_time` (`league_id`,`game_time`) USING BTREE,
  KEY `idx_s_team_id_game_time` (`s_team_id`,`game_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2751371 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_game_list`
--

DROP TABLE IF EXISTS `tb_game_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_game_list` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `third_id` bigint unsigned NOT NULL COMMENT '三方id',
  `third_match_id` bigint unsigned NOT NULL COMMENT '三方赛事id',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_third_id` (`third_id`) USING BTREE,
  UNIQUE KEY `uniq_third_match_id` (`third_match_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115951 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='三方赛事记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_game_live`
--

DROP TABLE IF EXISTS `tb_game_live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_game_live` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `match_id` bigint unsigned NOT NULL COMMENT '赛事id',
  `live_id` bigint unsigned DEFAULT NULL COMMENT '主播id',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '主播昵称',
  `user_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '主播头像',
  `live_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '直播地址',
  `live_status` tinyint unsigned NOT NULL COMMENT '直播状态 1-直播中 2-已预约',
  `source_type` tinyint unsigned NOT NULL COMMENT '数据来源 1-第三方 2-自有',
  `sort_num` smallint unsigned NOT NULL DEFAULT '0' COMMENT '排序，越大的越靠后',
  `is_up` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否上架 0-否 1-是',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_game_id_live_id` (`match_id`,`live_id`,`source_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=190998 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='赛事直播信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_group_info`
--

DROP TABLE IF EXISTS `tb_group_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_group_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '小组名称',
  `group_name_en` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '小组英文名称',
  `game_type` tinyint(1) NOT NULL COMMENT '类型，1-足球 2-篮球',
  `group_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '简介',
  `group_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '封面图片',
  `nav_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '应用导航菜单标识',
  `group_status` tinyint(1) DEFAULT '0' COMMENT '上架状态，0-未上架 1-上架',
  `group_sort` int DEFAULT '0' COMMENT '排序值，倒序',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_group_name` (`merchant_id`,`group_name`,`game_type`) USING BTREE,
  KEY `idx_search_data` (`merchant_id`,`nav_flag`,`group_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='小组配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_group_tag`
--

DROP TABLE IF EXISTS `tb_group_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_group_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` bigint NOT NULL COMMENT '小组id',
  `tag_id` bigint NOT NULL COMMENT '标签id',
  `tag_name` varchar(255) NOT NULL COMMENT '标签名称',
  `tag_type` tinyint(1) DEFAULT NULL COMMENT '类型，1-联赛 2-新闻 3-录像',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_group_tag` (`group_id`,`tag_id`,`tag_type`) USING BTREE,
  KEY `idx_tag_id_tag_type` (`tag_id`,`tag_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=863 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小组关联标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_league_info`
--

DROP TABLE IF EXISTS `tb_league_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_league_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `league_id` bigint NOT NULL COMMENT '第三方联赛id',
  `combined_id` bigint DEFAULT NULL COMMENT '合并后之三方联赛id',
  `league_name` varchar(100) DEFAULT NULL COMMENT '赛事中文简称',
  `league_full_name` varchar(100) DEFAULT NULL COMMENT '赛事中文名称',
  `game_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `league_icon` text COMMENT '联赛图示',
  `cur_season_id` bigint DEFAULT NULL COMMENT '第三方当前赛季id',
  `cur_stage_id` bigint DEFAULT NULL COMMENT '第三方当前阶段id',
  `last_season_id` bigint DEFAULT NULL COMMENT '第三方上一个赛季id',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_league_id` (`league_id`) USING BTREE,
  KEY `idx_league_id_stage_id` (`league_id`,`cur_stage_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52706 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='联赛记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_league_team_info`
--

DROP TABLE IF EXISTS `tb_league_team_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_league_team_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint unsigned NOT NULL COMMENT '商户id',
  `league_id` bigint NOT NULL COMMENT '赛事id',
  `team_id` bigint DEFAULT NULL COMMENT '球队id',
  `game_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否热门 0-否 1-是',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_league_team` (`merchant_id`,`league_id`,`team_id`) USING BTREE,
  UNIQUE KEY `uniq_team` (`team_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='联赛球队配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_advert`
--

DROP TABLE IF EXISTS `tb_merchant_advert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_advert` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `adver_title` varchar(255) NOT NULL COMMENT '标题',
  `adver_img` text NOT NULL COMMENT '图片地址',
  `link_url` text COMMENT '跳转地址',
  `ad_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '广告类型 1-位置1 2-位置2',
  `no_follow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否跟随',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant_id_web_type` (`merchant_id`,`ad_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2290 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商户广告配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_agreement`
--

DROP TABLE IF EXISTS `tb_merchant_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_agreement` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `agr_type` tinyint(1) NOT NULL COMMENT '协议类型 1-用户协议 2-隐私政策 3-免责声明 4-关于我们',
  `agr_content` text NOT NULL COMMENT '内容',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_type` (`merchant_id`,`agr_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='app协议配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_content`
--

DROP TABLE IF EXISTS `tb_merchant_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_content` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `zz_name` varchar(50) NOT NULL COMMENT '站长Name',
  `zz_content` text NOT NULL COMMENT '站长Content',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_zz` (`merchant_id`,`zz_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商户站点配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_domain`
--

DROP TABLE IF EXISTS `tb_merchant_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_domain` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `domain` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '域名',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_domain` (`domain`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='商户域名表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_group`
--

DROP TABLE IF EXISTS `tb_merchant_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `group_type` tinyint(1) DEFAULT NULL COMMENT '类型，1-首页小组配置 2-新闻小组配置 3-录像小组配置 4-首页热门联赛配置',
  `group_id` bigint DEFAULT NULL COMMENT '小组id',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_group` (`merchant_id`,`group_type`,`group_id`) USING BTREE,
  KEY `idx_merchant` (`group_id`,`merchant_id`,`group_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商户小组配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_info`
--

DROP TABLE IF EXISTS `tb_merchant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(100) NOT NULL COMMENT '域名',
  `main_word` varchar(255) DEFAULT NULL COMMENT '主词',
  `web_logo` varchar(255) DEFAULT NULL COMMENT '网站logo',
  `web_no` text COMMENT '底部信息',
  `web_icon` varchar(255) DEFAULT NULL COMMENT 'icon',
  `baidu_code` text COMMENT '百度统计代码',
  `article_head` text COMMENT '新闻详情段头内容',
  `article_footer` text COMMENT '新闻详情段尾内容',
  `video_content` text COMMENT '录像详情内容',
  `video_img` varchar(255) DEFAULT NULL COMMENT '录像详情图片地址',
  `game_detail_desc` text COMMENT '赛事详情简介',
  `ad_index` varchar(255) DEFAULT NULL COMMENT '首页广告图',
  `ad_index_url` text COMMENT '首页广告图跳转地址',
  `ad_index_title` varchar(255) DEFAULT NULL COMMENT '首页广告图标题',
  `ad_index_no_follow` tinyint(1) DEFAULT '0' COMMENT '首页广告图链接是否跟随',
  `ad_match` varchar(255) DEFAULT NULL COMMENT '联赛页广告图',
  `ad_match_url` text COMMENT '联赛页广告图跳转地址',
  `ad_match_title` varchar(255) DEFAULT NULL COMMENT '联赛页广告图标题',
  `ad_match_no_follow` tinyint(1) DEFAULT '0' COMMENT '联赛广告图是否跟随',
  `enable_default_url` tinyint(1) DEFAULT '0' COMMENT '是否启用默认主播跳转地址',
  `anchor_redirect_url` text COMMENT '赛事主播跳转地址',
  `anchor_url_no_follow` tinyint(1) DEFAULT '0' COMMENT '赛事主播跳转地址是否跟随',
  `city` text COMMENT '不可访问城市列表',
  `game_source_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事源 1-lzmd 2-qxqsc',
  `html_url` varchar(255) DEFAULT NULL COMMENT '外部网页页面url',
  `app_user_name_prefix` varchar(20) DEFAULT NULL COMMENT 'app用户昵称前缀',
  `app_show_live` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'app是否显示直播 0-否 1-是',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商户基础配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_merchant_match`
--

DROP TABLE IF EXISTS `tb_merchant_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_merchant_match` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint unsigned NOT NULL COMMENT '商户id',
  `match_type` tinyint unsigned DEFAULT NULL COMMENT '类型，1-赛程热门联赛 2-足球积分榜联赛 3-篮球积分榜联赛',
  `league_id` bigint unsigned DEFAULT NULL COMMENT '第三方赛事id',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_match` (`merchant_id`,`match_type`,`league_id`) USING BTREE,
  KEY `idx_merchant` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商户热门联赛配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_player_board_info`
--

DROP TABLE IF EXISTS `tb_player_board_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_player_board_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `game_type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球',
  `player_id` bigint unsigned NOT NULL COMMENT '第三方球员id',
  `player_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球员名称',
  `scope_id` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '(有值)赛事阶段id 1-赛季 2-预选赛 3-小组赛 4-季前赛 5-常规赛 6-淘汰赛(季后赛)',
  `scope_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '赛事阶段',
  `goals` tinyint unsigned DEFAULT NULL COMMENT '进球',
  `team_id` bigint unsigned DEFAULT NULL COMMENT '第三方球队id',
  `matches` tinyint unsigned DEFAULT NULL COMMENT '比赛场次',
  `court` tinyint unsigned DEFAULT NULL COMMENT '上场场次',
  `rating` smallint unsigned DEFAULT NULL COMMENT '评分,10为满分,为了避免浮点数影响,X100倍存储为整数,eg:计算评分为(760/100=)7.60',
  `point` smallint unsigned DEFAULT NULL COMMENT '得分',
  `penalty` tinyint unsigned DEFAULT NULL COMMENT '点球',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_field_index` (`team_id`,`player_id`,`game_type`,`scope_id`) USING BTREE,
  KEY `idx_search_data` (`game_type`,`team_id`,`player_id`,`scope_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1511606 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球员排行榜记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_player_info`
--

DROP TABLE IF EXISTS `tb_player_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_player_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `team_id` bigint DEFAULT NULL COMMENT '第三方球队id',
  `player_id` bigint unsigned NOT NULL COMMENT '三方球员id',
  `game_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `birthday` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '生日(YYYY-MM-DD)',
  `weight` int unsigned DEFAULT '1' COMMENT '体重',
  `height` int DEFAULT NULL COMMENT '身高',
  `player_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '中文简称',
  `player_full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '中文名称',
  `name_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '英文简称',
  `fullname_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '英文名称',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '球员图示',
  `shirt_number` tinyint unsigned DEFAULT NULL COMMENT '球衣号',
  `nationality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国籍',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '介绍',
  `style` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '风格',
  `advantage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '优点',
  `inferiority` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '弱点',
  `market_value_currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '市值单位',
  `market_value` bigint DEFAULT NULL COMMENT '市值',
  `contract_until` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '合同截止时间 (YYYY-MM-DD)',
  `ability` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '能力评分',
  `strength` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '技术特点 (优点、强项)',
  `weakness` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '技术特点 (缺点、弱点)',
  `preferred_foot` tinyint(1) DEFAULT NULL COMMENT '惯用脚:\r\n1-左脚 2-右脚 3-左右脚',
  `preferred_position` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '擅长位置: 足球-\r\nF-前锋 M-中场 D-后卫 G-守门员 篮球-擅长位置:\r\nC-中锋 SF-小前锋 PF-大前锋 SG-得分后卫 PG-组织后卫 F-前锋 G-后卫',
  `main_position` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '主要位置:\r\nLW-左边锋 RW-右边锋 ST-前锋 AM-攻击型中 ML-左中场 MC-中路中场 MR-右中场 DM-防守型中 DL-左后卫 DC-中后卫 DR-右后卫 GK-守门员',
  `drafted` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '选秀顺位',
  `secondary_positions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '次要位置(同主要位置)',
  `league_career_age` int DEFAULT NULL COMMENT '联盟球龄',
  `school` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '毕业学校',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '城市',
  `salary` bigint DEFAULT NULL COMMENT '年薪',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_player` (`player_id`) USING BTREE,
  UNIQUE KEY `uniq_team_player` (`team_id`,`player_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=979934 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_pull_third_record`
--

DROP TABLE IF EXISTS `tb_pull_third_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pull_third_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_id` bigint unsigned NOT NULL COMMENT '最新id',
  `pull_type` tinyint unsigned NOT NULL COMMENT '拉取数据类型 1-球队 2-球员 3-比赛 4-联赛 5-赛季 6-阶段',
  `game_type` tinyint unsigned DEFAULT NULL COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_pull` (`pull_type`,`game_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='拉取三方数据记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_season_info`
--

DROP TABLE IF EXISTS `tb_season_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_season_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `s_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '赛季年份',
  `league_id` bigint unsigned DEFAULT NULL COMMENT '联赛id',
  `season_id` bigint unsigned NOT NULL COMMENT '赛季id',
  `game_type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '赛季开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '赛季结束时间',
  `has_player_stats` tinyint unsigned DEFAULT NULL COMMENT '是否有球员统计',
  `has_team_stats` tinyint unsigned DEFAULT NULL COMMENT '是否有队伍统计',
  `has_table` tinyint unsigned DEFAULT NULL COMMENT '是否有积分榜',
  `is_current` tinyint unsigned DEFAULT NULL COMMENT '是否最新赛季',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_season_id_game_type` (`season_id`,`game_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60403 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='赛季记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_seo_info`
--

DROP TABLE IF EXISTS `tb_seo_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_seo_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `title` text COMMENT '标题',
  `description` text COMMENT 'description',
  `keywords` text COMMENT 'keywords',
  `seo_type` tinyint(1) NOT NULL COMMENT '类型 1-首页 2-直播赛程 3-赛事详情 4-体育新闻 5-新闻详情 6-新闻标签页 7-录像视频 8-录像详情 9-录像标签页 10-次导航',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_merchant_id_seo_type` (`merchant_id`,`seo_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='seo配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_sms_code`
--

DROP TABLE IF EXISTS `tb_sms_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_sms_code` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint NOT NULL COMMENT '商户id',
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `code` varchar(10) NOT NULL COMMENT '验证码',
  `is_used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用 0-否 1-是',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uniq_zz` (`merchant_id`,`mobile`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='验证码发送表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_stage_info`
--

DROP TABLE IF EXISTS `tb_stage_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_stage_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stage_id` bigint unsigned NOT NULL COMMENT '第三方阶段id',
  `season_id` bigint unsigned NOT NULL COMMENT '第三方赛季id',
  `game_type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球',
  `stage_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段中文名称',
  `stage_mode` tinyint unsigned DEFAULT NULL COMMENT '比赛模式，1-积分赛、2-淘汰赛',
  `group_count` tinyint unsigned DEFAULT NULL COMMENT '总组数',
  `round_count` tinyint unsigned DEFAULT NULL COMMENT '总轮数',
  `order_index` tinyint unsigned DEFAULT NULL COMMENT '排序，阶段的先后顺序',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_stage_id` (`stage_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=113089 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='阶段记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_tag_info`
--

DROP TABLE IF EXISTS `tb_tag_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tag_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag_type` tinyint(1) DEFAULT NULL COMMENT '类型，2-新闻 3-录像',
  `tag_name` varchar(100) DEFAULT NULL COMMENT '标签名称',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`tag_type`,`tag_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_team_board_info`
--

DROP TABLE IF EXISTS `tb_team_board_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_team_board_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `game_type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `session_id` bigint unsigned NOT NULL COMMENT '第三方赛季id',
  `stage_id` bigint NOT NULL DEFAULT '-1' COMMENT '第三方阶段id',
  `stage_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '阶段中文名称',
  `scope` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '统计范围，1-赛季、2-预选赛、3-小组赛、4-季前赛、5-常规赛、6-淘汰赛(季后赛)、0-无',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '组别名称',
  `team_id` bigint unsigned NOT NULL COMMENT '第三方球队id',
  `position` tinyint unsigned DEFAULT NULL COMMENT '排名',
  `won` tinyint unsigned DEFAULT NULL COMMENT '胜的场次(主场胜+客场胜)',
  `loss` tinyint unsigned DEFAULT NULL COMMENT '负的场次(主场负+客场负)',
  `draw` tinyint unsigned DEFAULT NULL COMMENT '平的场次(主场平+客场平)',
  `points` int DEFAULT NULL COMMENT '积分',
  `win_rate` decimal(8,4) unsigned DEFAULT NULL COMMENT '胜率',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_field_index` (`team_id`,`game_type`,`group_name`,`session_id`,`scope`,`stage_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1082191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队排行榜记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_team_info`
--

DROP TABLE IF EXISTS `tb_team_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_team_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `third_team_id` bigint NOT NULL COMMENT '第三方球队id',
  `combined_id` bigint DEFAULT NULL COMMENT '合并后之三方球队id',
  `team_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '球队简称',
  `team_full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '球队名称',
  `team_name_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '英文简称',
  `team_full_name_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '英文全称',
  `foundation_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '成立时间(年)',
  `website` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '球队官网',
  `market_value` bigint DEFAULT NULL COMMENT '市值',
  `market_value_currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '市值单位',
  `national` tinyint(1) DEFAULT NULL COMMENT '是否国家队 1-是 0-否',
  `country_logo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '国家队图示 (为国家队时存在)',
  `total_players` int DEFAULT NULL COMMENT '球员总数',
  `foreign_players` int DEFAULT NULL COMMENT '外籍球员数',
  `national_players` int DEFAULT NULL COMMENT '国家队球员数',
  `manager_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '教练中文名称',
  `manager_name_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '教练英文名称',
  `manager_icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '教练图示',
  `venue_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆中文名称',
  `venue_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆英文名称',
  `venue_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆所在城市',
  `venue_capacity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场馆容量(人)',
  `team_logo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '球队logo',
  `game_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `league_id` bigint DEFAULT NULL COMMENT '联赛id',
  `updated_at` datetime DEFAULT NULL COMMENT '第三方更新时间',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_team_id` (`third_team_id`) USING BTREE,
  UNIQUE KEY `uniq_team_league` (`third_team_id`,`league_id`) USING BTREE,
  KEY `idx_league_id` (`league_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=886302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='球队信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_team_player_info`
--

DROP TABLE IF EXISTS `tb_team_player_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_team_player_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint unsigned NOT NULL COMMENT '商户id',
  `player_id` bigint NOT NULL COMMENT '球员id',
  `team_id` bigint DEFAULT NULL COMMENT '球队id',
  `game_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '赛事类型 1-足球 2-篮球 3-网球 4-棒球 9-羽毛球 13-排球 19-乒乓球',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否热门 0-否 1-是',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_player` (`player_id`,`merchant_id`) USING BTREE,
  UNIQUE KEY `uniq_team_player` (`merchant_id`,`team_id`,`player_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='球队球员配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_video_info`
--

DROP TABLE IF EXISTS `tb_video_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_video_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uniq_title` char(32) GENERATED ALWAYS AS (md5(`video_title`)) STORED,
  `video_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `video_source` varchar(255) DEFAULT NULL COMMENT '来源渠道',
  `tag_id` bigint DEFAULT NULL COMMENT '标签id',
  `video_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上架状态，1=上架，0=下架',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_title` (`uniq_title`,`tag_id`) USING BTREE,
  KEY `idx_title` (`video_title`(191)) USING BTREE,
  KEY `idx_status` (`video_status`) USING BTREE,
  KEY `idx_tag` (`tag_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='录像表';
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

-- Dump completed on 2024-06-14 14:35:23
