#!/bin/bash
####################################################################
# Project: Run the elasticsearch snapshot
# Branch: 
# Author: Gok, the DBA
# Created: 2023-02-23
# Updated: 2023-09-14
# Note: 修正錯誤 — 資料成長量參數誤用到後續的每日 review
#####################################################################


## 先讀取環境數 (其實可以不用。因為有把環境變數部署好，會自動吃到)
source /etc/environment

## 專案名稱
prod="VS"

## snapshot 名稱的時間格式
date=`date +%Y%m%d.%H%M`

data_dir=/etc/dba
## log 檔名
log=$data_dir/`hostname | awk -F 'prod-|-0' '{print $2}'`-snapshot.log
## backup_server
backup_server='10.25.1.183'


## snapshot 開始 log
echo >> $log
echo "====== snapshot [ backup-$date ] start at: `date` ======" >> $log

## snapshot 執行指令
echo >> $log
curl -XPUT `hostname`:9200/_snapshot/backup/backup-$date >> $log
sleep 10

## 資料量成長報告
date_1h=`date -d '-1 hour' +%Y%m%d.%H%M`
last_day=`date -d "-1 hour -7 day" +%Y%m%d.%H%M`

today_size=$(curl -X GET `hostname`:9200/_snapshot/backup/backup-$date_1h/_status?pretty | tac | tac | grep size_in_bytes | head -n 1 | awk '{print $3}' | cut -d , -f 1)
last_week_size=$(curl -X GET `hostname`:9200/_snapshot/backup/backup-$last_day/_status?pretty | tac | tac | grep size_in_bytes | head -n 1 | awk '{print $3}' | cut -d , -f 1)
diff=`expr $today_size - $last_week_size`
growth=`awk -v x=$diff -v y=$last_week_size 'BEGIN{printf "%.2f\n",100 * x/y}'`

echo >> $log
echo today_size is $today_size >> $log
echo last_week_size is $last_week_size >> $log
echo diff is $diff >> $log
echo growth is $growth >> $log
echo >> $log

echo "$prod `hostname | awk -F 'prod-|-0' '{print $2}'` 今日 `date +%Y-%m-%d` 資料量 `echo $today_size | numfmt --to=iec`，較上週同期（`echo $last_week_size | numfmt --to=iec`）增加 $growth%" >> $log


## 整天狀態確認
if [[ `echo $date | cut -d . -f 2` == '2300' ]]; 
then 
    dd=`date +%Y%m%d`
    freq=$(curl -XGET `hostname`:9200/_snapshot/backup/backup-${dd}*?pretty | grep '"state"' | grep -c SUCCESS)

    if [[ $freq -ge 23 ]]; 
    then 
        echo >> $log
        echo "$prod `hostname | awk -F 'prod-|-0' '{print $2}'` 在 `date +%Y-%m-%d` 無備份異常" >> $log
    else
        echo >> $log
        echo "今日備份只有 $freq 份，還請確認 snapshot 運作狀態" >> $log
    fi
fi

## 傳送 log 到 backup_server
scp -i /home/gok/.ssh/gok_rsa -l 81920 -r $log gok@$backup_server:/home/gok/backups


## 查看所有備份檔案的指令
# curl -XGET `hostname`:9200/_cat/snapshots/backup