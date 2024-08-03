#!/bin/bash
##################################################
# Project: 記錄所有 index 不穩定的狀態
# Branch: 
# Author: Gok, the DBA
# Created: 2023-07-31
# Updated: 2023-07-31
# Note: 針對 elasticsearch-backend
##################################################

host_ip='10.23.1.170'
log=/etc/dba/shardsInfra.log


## 取得檔案 size
bf=`ls -al $log | awk '{print $5}'`

## 寫入 log
curl -XGET $host_ip:9200/_cat/shards | grep -v STARTED >> $log

## 再次取得檔案 size
af=`ls -al $log | awk '{print $5}'`

## 比較兩次檔案 size
if [[ $bf < $af ]];
then 
    echo "==== tha above was at `date +'%F %T'` ====" >> $log 
    echo >> $log 
fi 