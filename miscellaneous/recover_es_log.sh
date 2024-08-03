#!/bin/bash
###################################################
# Project: 還原 nginx-logs & service-logs
# Branch: 
# Author: Gok, the DBA
# Created: 2023-05-24
# Updated: 2023-05-24
# Note: 先查好特定日期，還有 index 的始末編號
####################################################

## 查看所有備份檔案
# curl -XGET `hostname`:9200/_cat/snapshots/backup
## 建立執行用檔案
echo '#!/bin/bash' > restore.sh

## nginx-logs 
nginx_tail=$(curl -X GET "`hostname`:9200/_snapshot/backup/backup-20230523.1100?pretty" | grep nginx-logs | cut -d _ -f 2 | sed 's/",//g' | sort | tail -1)
echo nginx tail = $nginx_tail

nginx_tail=`expr $nginx_tail - 2`
nginx_head=`expr $nginx_tail - 22`
echo head = $nginx_head
echo tail = $nginx_tail

for i in `seq $nginx_head $nginx_tail`
do
    echo 
    echo i = $i
    echo 
    echo curl -X POST `hostname`:9200/_snapshot/backup/backup-20230523.1100/_restore?pretty -H \'Content-Type: application/json\' -d \'{  \"indices\": \"nginx-logs_$i\"}\' >> restore.sh
done


## service-logs 
service_tail=$(curl -X GET "`hostname`:9200/_snapshot/backup/backup-20230523.1100?pretty" | grep service-logs | cut -d _ -f 2 | sed 's/",//g' | sort | tail -1)
echo nginx tail = $service_tail

service_tail=`expr $service_tail - 2`
service_head=`expr $service_tail - 22`
echo head = $service_head
echo tail = $service_tail

for i in `seq $service_head $service_tail`
do
    echo 
    echo i = $i
    echo 
    echo curl -X POST `hostname`:9200/_snapshot/backup/backup-20230523.1100/_restore?pretty -H \'Content-Type: application/json\' -d \'{  \"indices\": \"service-logs_$i\"}\' >> restore.sh
done


sh restore.sh
rm -rf restore.sh
