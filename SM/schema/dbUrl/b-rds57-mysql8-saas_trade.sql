-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: b-rds57-mysql8.cgzsgwy0jfrd.ap-northeast-1.rds.amazonaws.com    Database: saas_trade
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
-- Table structure for table `charge_order`
--

DROP TABLE IF EXISTS `charge_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charge_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '买家',
  `order_no` varchar(24) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `amount` int NOT NULL DEFAULT '0' COMMENT '充值金额,单位分',
  `pay_type` int NOT NULL DEFAULT '0' COMMENT '1-app支付宝，2-app微信，3-apple 4-H5支付宝 5-H5微信',
  `pay_status` int NOT NULL DEFAULT '0' COMMENT '0 待支付 1 已支付',
  `out_trade_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '外部交易单号',
  `order_status` int NOT NULL DEFAULT '0' COMMENT '0 新建；1 已完成 2 已取消 3 超时未支付（系统关闭）4 已退款',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `charge_order_order_no_index` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=51966 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `charge_order_item`
--

DROP TABLE IF EXISTS `charge_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charge_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商家编号',
  `order_no` varchar(24) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `product_name` varchar(24) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '物品名称',
  `product_num` bigint NOT NULL DEFAULT '0' COMMENT '物品数量',
  `source_id` bigint NOT NULL DEFAULT '0' COMMENT '来源ID',
  `source_type` int NOT NULL DEFAULT '0' COMMENT '来源类型 0-鹰币',
  `biz_code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '业务类型0-c充值 1-消费',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `charge_order_item_order_no_index` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=51966 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_service_msg`
--

DROP TABLE IF EXISTS `trade_service_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trade_service_msg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商户编号',
  `transaction_id` varchar(64) NOT NULL DEFAULT '' COMMENT '事物消息编号',
  `message_id` varchar(64) NOT NULL DEFAULT '' COMMENT '消息编号',
  `message_status` int NOT NULL DEFAULT '1' COMMENT '消息状态 1-commit,2-unknown,3-rollback',
  `body` text NOT NULL COMMENT '消息内容',
  `param` text NOT NULL COMMENT '消息参数',
  `handler_flag` int NOT NULL DEFAULT '0' COMMENT '处理标识 0-无需处理 1-待处理（仅有unknown状态的消息初始化时为1，待处理后需更改为已处理2）2-已处理',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2024-06-14 14:34:22
