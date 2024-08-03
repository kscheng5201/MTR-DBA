-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_live
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
-- Table structure for table `blood_rain_plan`
--

DROP TABLE IF EXISTS `blood_rain_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_rain_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商户ID',
  `plan_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'planId',
  `plan_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '活动策略名称',
  `relation_type` int DEFAULT NULL COMMENT '绑定类型 0赛事 1直播语聊',
  `lib_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
  `blood_rain_trigger` int DEFAULT NULL COMMENT '0进球事件 1赛事时间点 2指定时间点',
  `trigger_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '触发类型名称',
  `trigger_time` bigint DEFAULT NULL,
  `total` int DEFAULT NULL COMMENT '红包总数',
  `max_round` int DEFAULT NULL COMMENT '轮数上限',
  `max_hit` int DEFAULT NULL COMMENT '最多单个用户中奖数',
  `rate` double DEFAULT NULL COMMENT '中奖概率',
  `rewards` varchar(4096) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '红包配置',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `match_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '绑定赛事ID',
  `active` int DEFAULT NULL COMMENT '是否开启 0 开启 1禁用',
  `delay_time` bigint DEFAULT NULL COMMENT '延迟时间  单位:毫秒',
  `hold_time` bigint DEFAULT NULL COMMENT '持续时间 单位:毫秒',
  `start_time` bigint DEFAULT NULL COMMENT '开始时间 单位:毫秒',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间 单位:毫秒',
  `status` int DEFAULT NULL COMMENT '红包雨状态',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_match_id` (`match_id`),
  KEY `idx_trigger_time` (`trigger_time`)
) ENGINE=InnoDB AUTO_INCREMENT=12434 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bloodrain_log`
--

DROP TABLE IF EXISTS `bloodrain_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bloodrain_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户id',
  `channel_id` bigint NOT NULL DEFAULT '0' COMMENT '渠道id',
  `channel_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '渠道名称',
  `match_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '赛事id',
  `home_team` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队',
  `home_team_logo` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '主队徽标',
  `away_team` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客队',
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='球队pk表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heat_config_info`
--

DROP TABLE IF EXISTS `heat_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heat_config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户ID',
  `live_type` int DEFAULT NULL COMMENT '直播间类型:0.真实主播流2.主播赛事流1.官方直播间流3.电竞娱乐流',
  `live_type_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '直播间类型名称',
  `init_heat` int DEFAULT '100' COMMENT '初始热力值',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_delete` int DEFAULT '0' COMMENT '是否删除1:是0:否',
  `lang` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'zh' COMMENT '语言 zh:中文;en:英文;th:泰语;vi:越南语;ko:韩语;br:巴西语;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='热力值配置信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_call_log`
--

DROP TABLE IF EXISTS `live_call_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_call_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `live_channel` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播服务提供方',
  `invoke_method` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行方法',
  `call_param` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `call_result` text COLLATE utf8mb4_general_ci COMMENT '调用返回结果',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1809466 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_hdl_pull`
--

DROP TABLE IF EXISTS `live_hdl_pull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_hdl_pull` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `pull_protocol` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '拉流协议',
  `origin_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '源码率拉流URL',
  `fluent_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流畅码率拉流URL',
  `sd_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '标清码率拉流URL',
  `high_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '高清码率拉流URL',
  `hd_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '超清码率拉流URL',
  `pull_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流媒体唯一标识',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_hls_pull`
--

DROP TABLE IF EXISTS `live_hls_pull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_hls_pull` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `pull_protocol` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '拉流协议',
  `origin_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '源码率拉流URL',
  `fluent_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流畅码率拉流URL',
  `sd_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '标清码率拉流URL',
  `high_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '高清码率拉流URL',
  `hd_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '超清码率拉流URL',
  `pull_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流媒体唯一标识',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_info`
--

DROP TABLE IF EXISTS `live_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `live_channel` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播服务提供方',
  `channel_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播平台频道信息',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `user_status` int DEFAULT '0' COMMENT '主播状态0:正常;1:禁播',
  `title` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播标题',
  `push_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '推流地址',
  `cover_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播封面',
  `pull_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流媒体唯一标识',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `status` int DEFAULT '0' COMMENT '状态0：有效；1：无效',
  `is_del` int DEFAULT '0' COMMENT '逻辑删除标识0：未删除；1：已删除',
  `channel_name_3rd` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三方回调channelName',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104963 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_notify`
--

DROP TABLE IF EXISTS `live_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_notify` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `live_channel` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播服务提供方',
  `content` text COLLATE utf8mb4_general_ci COMMENT '源推送报文',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1408044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_pull`
--

DROP TABLE IF EXISTS `live_pull`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_pull` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `pull_protocol` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '拉流协议',
  `origin_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '源码率拉流URL',
  `fluent_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流畅码率拉流URL',
  `sd_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '标清码率拉流URL',
  `high_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '高清码率拉流URL',
  `hd_pull_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '超清码率拉流URL',
  `pull_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流媒体唯一标识',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_record`
--

DROP TABLE IF EXISTS `live_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `live_channel` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播服务提供方',
  `pull_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流媒体唯一标识',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `room_type` int DEFAULT NULL COMMENT '房间类型 0普通直播间 1官方主播',
  `title` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '标题',
  `push_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '推流地址',
  `cover_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播封面',
  `start_time` bigint DEFAULT NULL COMMENT '开播时间',
  `end_time` bigint DEFAULT NULL COMMENT '停播时间',
  `show_time` bigint DEFAULT NULL COMMENT '直播总时间',
  `status` int DEFAULT NULL COMMENT '直播状态 1:直播中;0:正常停播;2:异常停播 3:鉴别停播',
  `begin_time` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日期格式开始时间',
  `stop_time` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日期格式停播时间',
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id_user_id` (`merchant_id`,`user_id`),
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=380752 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_record_info`
--

DROP TABLE IF EXISTS `live_record_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_record_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户id',
  `application_code` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '应用code',
  `live_channel` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播服务提供方',
  `third_channel_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '第三方直播账号名称',
  `stream_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '推流发布点',
  `pull_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '流媒体唯一标识',
  `user_id` bigint DEFAULT NULL COMMENT '主播ID',
  `shadow_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '影子id',
  `room_no` varchar(16) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播房间号',
  `avatar` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主播头像',
  `nickname` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主播昵称',
  `use_master_account` int NOT NULL DEFAULT '0' COMMENT '是否使用主帐号开播 0-否; 1-是; ',
  `title` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '标题',
  `password` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '房间密码',
  `live_large_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播大类型,游戏,体育，综艺,旅游,厨艺等',
  `live_middle_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播中类型,游戏:王者荣耀,体育:足球，综艺:天天向上,旅游:游埃及记,厨艺:鱼等',
  `live_small_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播小类型,游戏:王者荣耀:诸葛亮,体育:足球:甲A，综艺:天天向上:欧弟,旅游:游埃及记:陈道明,厨艺:鱼等:红烧甲鱼',
  `live_type_remark1` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播信息补充1',
  `live_type_remark2` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播信息补充2',
  `live_type_remark3` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播信息补充3',
  `push_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '推流地址',
  `is_fixed_cover_url` int DEFAULT '0' COMMENT '是否固定封面 0:否;1:是',
  `cover_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '直播封面',
  `start_time` bigint DEFAULT NULL COMMENT '开播时间',
  `end_time` bigint DEFAULT NULL COMMENT '停播时间',
  `show_time` bigint DEFAULT NULL COMMENT '直播总时间',
  `status` int DEFAULT NULL COMMENT '直播状态 1:直播中;0:正常停播;2:异常停播 3:后台断流停播 4:鉴黄停播 5:鉴恐停播 6:鉴政停播',
  `begin_time` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日期格式开始时间',
  `stop_time` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日期格式停播时间',
  `hot_num` bigint NOT NULL DEFAULT '0' COMMENT '热力值',
  `view_num` bigint NOT NULL DEFAULT '0' COMMENT '观看人数',
  `gift_num` bigint NOT NULL DEFAULT '0' COMMENT '送礼个数',
  `gift_sender_num` bigint NOT NULL DEFAULT '0' COMMENT '送礼人数',
  `fans_num_start` bigint NOT NULL DEFAULT '0' COMMENT '起始粉丝数',
  `fans_num_end` bigint NOT NULL DEFAULT '0' COMMENT '当前粉丝数',
  `income_num` bigint NOT NULL DEFAULT '0' COMMENT '收益总数',
  `screen_mode` int NOT NULL DEFAULT '1' COMMENT '屏幕模式 1：横屏 2：竖屏',
  `platform` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'windows' COMMENT '平台',
  `anchor_type` int NOT NULL DEFAULT '0' COMMENT '主播类型 1-机器人 0-主播',
  `pk_status` int NOT NULL DEFAULT '0' COMMENT '是否开启pk 0-否 1-是',
  `bind_channel_id` bigint NOT NULL DEFAULT '0' COMMENT '绑定频道id',
  `bind_channel_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '绑定频道名称',
  `match_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '比赛id',
  `match_type` int DEFAULT NULL COMMENT '赛事类型',
  PRIMARY KEY (`id`),
  KEY `live_record_info_user_id_index` (`user_id`),
  KEY `live_record_info_room_no_index` (`room_no`),
  KEY `live_record_info_match_id_index` (`match_id`),
  KEY `live_record_info_status_index` (`status`),
  KEY `idx_live_record_info_channel_id` (`bind_channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4257143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_record_info_rel`
--

DROP TABLE IF EXISTS `live_record_info_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_record_info_rel` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户id',
  `show_id` bigint NOT NULL COMMENT '直播记录id',
  `user_id` bigint NOT NULL COMMENT '主播id',
  `rel` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联字符串',
  PRIMARY KEY (`id`),
  KEY `idx_live_record_info_rel_show_id` (`show_id`),
  KEY `idx_live_record_info_rel_user_id` (`user_id`),
  KEY `idx_live_record_info_rel_rel` (`rel`)
) ENGINE=InnoDB AUTO_INCREMENT=4260988 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='直播记录关联表';
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

-- Dump completed on 2024-06-14 14:34:20
