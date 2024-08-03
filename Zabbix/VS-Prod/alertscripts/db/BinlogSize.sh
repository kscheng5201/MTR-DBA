#!/bin/bash
###################################################
# Project: 監控 binlog 檔案大小
# Branch: 
# Author: Gok, the DBA
# Created: 2023-07-07
# Updated: 2023-07-07
# Note: 與 DML 監控腳本互補
###################################################

## 取得 binlog 路徑
binlog_dir=`grep ^log_bin /etc/my.cnf | awk '{print $3}' | cut -d . -f 1`

## 計算 mysql-bin.* 所有檔案的總數
ls -l $binlog_dir.* | awk '{sum += $5} END {print sum}'


## 每台 MySQL 的 expire_logs_days 設定天數不同，可用以下語法查看
# sudo grep expire /etc/my.cnf | awk '{print $3}'

## 把 zabbix 這 user 加入 mysql 這 group
# sudo usermod -aG mysql zabbix

## 轉換成 zabbix 這角色執行腳本
# sudo -u zabbix sh /etc/zabbix/alertscripts/BinlogSize.sh
