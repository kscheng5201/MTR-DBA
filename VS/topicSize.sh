#!/bin/bash
######################################
# Project: 輸出各 kafka topic 的值
# Branch: 
# Author: Gok, the DBA
# Created: 2023-09-23
# Updated: 2023-09-23
# Note: 輸出格式為 zabbix 所需
######################################


## 取得 log 資料位置
log_dir=`grep log.dirs /usr/local/kafka/config/server.properties | cut -d = -f 2`

## 每一個 kafka topic 來這裡取資料
num=`cd $log_dir && du | grep ./$1 | awk -F' ' '{sum+=$1;}END{print sum}'`


if [[ -n $num ]]; 
then 
    echo $num
else 
    echo 0

    ## 刪除不再使用的 kafka topic
    # /usr/local/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic $1
fi



## kafka topic 的名單來自以下腳本
# /etc/zabbix/alertscripts/kafkaTopics.sh
