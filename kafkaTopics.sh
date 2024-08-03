#!/bin/bash
######################################
# Project: 取得 kafka topic
# Branch: 
# Author: Gok, the DBA
# Created: 2023-09-23
# Updated: 2023-09-23
# Note: 輸出格式為 zabbix 所需
######################################


data_dir=/etc/zabbix/alertscripts

## 取得所有 kafka topics
topics=`/usr/local/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092 | grep -v ^__consumer_offsets`

## 開始寫入檔案
echo '{"data":[' >> $data_dir/topics.log

## 各行寫入檔案
for t in $topics; 
do 
    echo {\"{#TCP_PORT}\":\"$t\"}, >> $data_dir/topics.log
done

## 修掉最後一行的結尾逗號
last=`tail -1 $data_dir/topics.log | sed 's/.$//'`

## 刪除最後一行
sed -i '$ d' $data_dir/topics.log

## 加入修正後的最後一行
echo $last >> $data_dir/topics.log

## 加入結尾括弧
echo ]} >> $data_dir/topics.log

## 列印結果
cat $data_dir/topics.log

## 刪除檔案
rm -rf $data_dir/topics.log