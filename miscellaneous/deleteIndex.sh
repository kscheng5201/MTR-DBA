#!/bin/bash
##################################################
# Project: Check the elasticsearch data usage
# Branch: 
# Author: Gok, the DBA
# Created: 2023-01-12
# Updated: 2023-02-10
# Note: 增加紀錄 index 刪除的 log
##################################################

usage=`df -h | grep data | awk '{print $5}' | cut -d % -f 1`
index='nginx service'

if [[ $usage -gt 78 ]];
then
    for idx in $index;
    do
        ## 拿到兩 index 的尾數編號
        num=$(echo $(curl -XGET `hostname`:9200/_cat/indices/$idx-logs*?v | grep open | awk '{print $3}' | cut -d _ -f 2 | sort))
        curl -XGET `hostname`:9200/_cat/indices/$idx-logs*?v | grep open | awk '{print $3}' | cut -d _ -f 2 | sort > $idx.list
        # 拿到最大位數
        length=`awk '{print length}' $idx.list | sort | uniq | tail -n 1`
        # 清空檔案
        rm -rf $idx.list

        for i in $num;
        do
            int=$(printf "%0${length}d" $i)
            echo $int >> $idx.list
        done

        delNum=`sort $idx.list | head -n 1 | awk '{printf "%d\n",$0;}'`
        # echo $idx-logs_$delNum

        echo "====== `date` ======" >> /opt/deleteIndex.log
        echo "磁碟空間使用率達到 $usage，逕行刪除 $idx-logs_$delNum" >> /opt/deleteIndex.log
        # delete the oldest index
        curl -XDELETE `hostname`:9200/$idx-logs_$delNum
        echo "刪除 $idx-logs_$delNum 後，磁碟空間使用率降為 `df -h | grep data | awk '{print $5}' | cut -d % -f 1`%" >> /opt/deleteIndex.log

        # 清空檔案
        rm -rf $idx.list
    done
fi
