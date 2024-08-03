#!/bin/bash
############################
# Project: MongoDB 資料復原
# Branch: 
# Author: Gok, the DBA
# Created: 2022-12-14
# Updated: 2022-12-14
# Note: 
############################

read -ep '現在要回復資料到哪一天?，若是今天可略過 (請輸入日期，格式：YYYYMMDD) ？ ' dd
read -ep '現在要回復資料到哪個時間點? (請輸入小時，最多兩位數) ' hh

if [[ -z $dd ]];
then 
    dd=`date +%Y%m%d`
fi

master_ip='10.23.1.111'
port='27017'
backup_location=/data/mongo/backup

if [[ "`date -d $dd +%Y-%m-%d`" == "`date +%Y-%m-%d`" ]];
then 
    for i in $(seq 1 $hh);
    do 
        i2=$(printf "%02d" $i)
        echo ''
        echo "working on ${backup_location}/`date -d $dd +%Y-%m-%d`/mongo-oplog-${dd}${i2}00"
        mongorestore --host ${master_ip} --port ${port} --oplogReplay ${backup_location}/`date -d $dd +%Y-%m-%d`/mongo-oplog-${dd}${i2}00/local
    done
else
    echo ''
    echo "working on full backup recovery on `date -d $dd +%Y-%m-%d`"
    mongorestore --host ${master_ip} --port ${port} --oplogReplay ${backup_location}/`date -d $dd +%Y-%m-%d`/mongodump-`date -d $dd +%Y%m%d`0000

    for i in $(seq 1 $hh);
    do 
        i2=$(printf "%02d" $i)
        echo ''
        echo "working on ${backup_location}/`date -d $dd +%Y-%m-%d`/mongo-oplog-${dd}${i2}00"
        mongorestore --host ${master_ip} --port ${port} --oplogReplay ${backup_location}/`date -d $dd +%Y-%m-%d`/mongo-oplog-${dd}${i2}00/local
    done
fi
