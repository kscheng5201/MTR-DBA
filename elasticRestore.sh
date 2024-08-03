#!/bin/bash
#######################################################
# Project: Elasticsearch restore from snapshots in S3
# Branch: 
# Author: Gok, the DBA
# Created: 2023-04-19
# Updated: 2022-04-19
# Note: 開始執行前，先確定 es 服務是否已啟動
#######################################################


log=/etc/dba/elasticRestore.log
echo ====== $(date) restore START ====== >> $log


# 拿到所有 index
indices=$(curl -XGET `hostname`:9200/_cat/indices | awk '{print $3}')
echo 逐一刪除 index >> $log

for i in $indices; 
do
    curl -XDELETE `hostname`:9200/$i > /dev/null
done

last_snapshot=$(curl -XGET `hostname`:9200/_cat/snapshots/backup | grep SUCCESS | tail -1 | awk '{print $1}')
echo 最近一份已完成之 snapshot 名稱: $last_snapshot >> $log

echo 正式進行 restore >> $log
curl -XPOST `hostname`:9200/_snapshot/backup/$last_snapshot/_restore


echo restore 進行中... >> $log
total=$(curl -XGET `hostname`:9200/_cat/indices | wc -l)
echo 共有 $total 的 index 進行復原 >> $log
echo ... >> $log

for i in {1..33};
do
    completed=$(curl -XGET `hostname`:9200/_cat/shards | grep ' p ' | grep STARTED | awk '{print $1}' | sort | uniq | wc -l)
    working=$(curl -XGET `hostname`:9200/_cat/shards | grep ' p ' | grep -v STARTED | awk '{print $1}' | sort | uniq | wc -l)

    if [[ $working > 0 ]];
    then
        echo >> $log
        echo 現有 $completed 個 index 已復原 >> $log
        echo 還有 $working 個 index 復原中 >> $log
        sleep 60
    else
        break
    fi
done

## off the replica then index status will turn from yellow to green
curl -XPUT "`hostname`:9200/_settings?pretty" -H 'Content-Type: application/json' -d '{"index.number_of_replicas": 0}'


echo >> $log
echo ====== $(date) restore DONE ====== >> $log
echo >> $log
