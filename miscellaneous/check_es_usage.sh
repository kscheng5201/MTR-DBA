#!/bin/bash
##################################################
# Project: Check the elasticsearch data usage
# Branch: 
# Author: Gok, the DBA
# Created: 2023-11-07
# Updated: 2023-11-07
# Note: 若硬碟使用量接近告警值會自動刪除最舊的 index
##################################################

dba_dir=/etc/dba
usage=`df -h | grep data | awk '{print $5}' | cut -d % -f 1`
index=`curl -XGET localhost:9200/_cat/indices/service* | awk '{print $3}' | cut -d _ -f 1 | sort | uniq`


if [[ $usage -gt 79 ]];
then
    # 寫 log
    echo ===== `date` ===== >> $dba_dir/deleteIndex.log
    echo ===== 執行前的硬碟使用率 ===== >> $dba_dir/deleteIndex.log
    df -h | grep data >> $dba_dir/deleteIndex.log

    for idx in $index;
    do
        # 拿到兩 index 的最小尾數編號
        delNum=`curl -XGET localhost:9200/_cat/indices/$idx* | awk '{print $3}' | cut -d _ -f 2 | sort -nr | tail -1`

        # 寫 log
        echo 最舊的 index: $idx_$delNum >> $dba_dir/deleteIndex.log

        # delete the oldest index
        # curl -XDELETE localhost:9200/$idx_$delNum

        # 寫 log
        echo ===== 執行後的硬碟使用率 ===== >> $dba_dir/deleteIndex.log
        df -h | grep data >> $dba_dir/deleteIndex.log
        echo >> $dba_dir/deleteIndex.log
    done
fi
