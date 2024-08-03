#!/bin/bash
####################################################################
# Project: Run the elasticsearch snapshot
# Branch: 
# Author: Gok, the DBA
# Created: 2023-02-10
# Updated: 2023-02-13
# Note: Snapshot lifecycle management (SLM) doesn't work as expected
#####################################################################

## 專案名稱
prod="DM"

## snapshot 名稱的時間格式
date=`date +%Y%m%d.%H%M`
last_day=`date -d "1 day ago" +%Y%m%d.%H%M`

## log 檔名
log=/opt/`hostname | awk -F 'prod-|-0' '{print $2}'`-snapshot.log

## snapshot 開始 log
echo >> $log
echo "====== snapshot [ backup-$date ] start at: `date` ======" >> $log

## snapshot 執行指令
echo >> $log
curl -XPUT `hostname`:9200/_snapshot/backup/backup-$date >> $log


## 資料量成長報告
today_size_h=$(curl -X GET `hostname`:9200/_snapshot/backup/backup-$date/_status?pretty | grep size_in_bytes | head -n 1 | awk '{print $3}' | cut -d , -f 1 | numfmt --to=iec)
today_size=$(curl -X GET `hostname`:9200/_snapshot/backup/backup-$date/_status?pretty | grep size_in_bytes | head -n 1 | awk '{print $3}' | cut -d , -f 1)
yesterday_size=$(curl -X GET `hostname`:9200/_snapshot/backup/backup-$last_day/_status?pretty | grep size_in_bytes | head -n 1 | awk '{print $3}' | cut -d , -f 1)
diff=`expr $today_size - $yesterday_size`
growth=`awk -v x=$diff -v y=$yesterday_size 'BEGIN{printf "%.2f\n",100 * x/y}'`

echo >> $log
echo "$prod `hostname | awk -F 'prod-|-0' '{print $2}'` 在 `date +%Y-%m-%d` 的資料量為 $today_size_h，較昨日增加 $growth%" >> $log


## 整天狀態確認
if [[ `echo $date | cut -d . -f 2` == '2300' ]]; 
then 
    dd=`date +%Y%m%d`
    freq=$(curl -XGET `hostname`:9200/_snapshot/backup/backup-$dd*?pretty | grep '"state"' | grep -c SUCCESS)

    if [[ $freq -ge 23 ]]; 
    then 
        echo >> $log
        echo "$prod `hostname | awk -F 'prod-|-0' '{print $2}'` 在 `date +%Y-%m-%d` 無備份異常" >> $log
    else
        echo >> $log
        echo "今日 snapshot 只有 $freq 份，還請確認 snapshot 狀態" >> $log
    fi
fi


## snapshot 結束 log
echo >> $log
echo "====== snapshot [ backup-$date ] end at: `date` ======" >> $log