#!/bin/bash
###################################################
# Project: MongoDB 資料定期備份
# Branch: 
# Author: Gok, the DBA
# Created: 2022-11-11
# Updated: 2023-01-31
# Note: 在 log 中增加每日結算的資料成長量
####################################################

date=`date +"%Y-%m-%d %H:%M:%S"`
unix_now=$(date +%s)
mongo_port="27017"

backup_location=/data/mongo/backup
backup_log=/data/mongo/backup/mongobackup.log
backup_time=`date +%Y%m%d%H%M`  #定義備份詳細時間
backup_Ymd=`date +%Y-%m-%d` #定義備份目錄中的年月日時間
backup_dir=$backup_location/$backup_Ymd  #備份資料夾全路徑
backup_server='10.25.1.183'


# 判斷mongo是否啟動,mongo沒有啟動則備份退出
mongo_ps=`ps -ef | grep mongo | wc -l`
mongo_listen=`netstat -an | grep LISTEN | grep $mongo_port | wc -l`
if [ [$mongo_ps == 0] -o [$mongo_listen == 0] ]; 
then
    echo "-- $date 備份異常資訊--" >> $backup_log
    echo "ERROR: mongo is not running! backup stop!" >> $backup_log
    exit
else
    echo ''
    echo "Alright! mongo is running! backup GO ON!"

    echo ''
    echo "mongo connect ok! Please wait......"
    echo "backup mongo ..."

    # 判斷有沒有定義備份的資料庫，如果定義則開始備份，否則退出備份
    mkdir -p $backup_dir
    rm -rf $backup_location/`date -d "2 day ago" +%Y-%m-%d`

    if [[ "$date" =~ "00:00" ]];
    then
        echo "mongodb full backup start..."
        mongodump --oplog -o $backup_dir/mongodump-$backup_time

        flag=`echo $?`
        if [ $flag == "0" ];
        then
            echo "-- $date 備份正常資訊--" >> $backup_log
            echo "mongodump 已備份至 $backup_dir/mongodump-$backup_time" >> $backup_log
        else
            echo "-- $date 備份異常資訊--" >> $backup_log
            echo "ERROR: database mongodump backup fail!" >> $backup_log
        fi      
    else
        # 用 unixtime 直接鎖定時間區間：執行 script 的前 3600 秒，這一小時期間符合的所有資料
        diffTime=$(expr 60 \* 60)
        backup_start_unix=$(expr $unix_now - $diffTime)
        mongodump -d local -c oplog.rs --query '{ts:{$gte:Timestamp('$backup_start_unix',1),$lte:Timestamp('$unix_now',9999)}}' -o $backup_dir/mongo-oplog-$backup_time

        ## 改名是為了讓 mongorestore 使用這個檔案更簡單快速
        mv $backup_dir/mongo-oplog-$backup_time/local/oplog.rs.bson $backup_dir/mongo-oplog-$backup_time/local/oplog.bson

        flag=`echo $?`
        if [ $flag == "0" ];
        then
            echo "-- $date 備份正常資訊--" >> $backup_log
            echo "mongodump 已備份至 $backup_dir/mongo-oplog-$backup_time" >> $backup_log
        else
            echo "-- $date 備份異常資訊--" >> $backup_log
            echo "ERROR: database mongodump backup fail!" >> $backup_log
        fi      
    fi      
fi

echo "-- $date 備份正常資訊--" >> $backup_log
echo "All database backup success! Thank you!" >> $backup_log


## 計算兩日全量備份的資料成長量
if [[ "$date" =~ "23:00" ]];
then
    today_s=$(du -sh $backup_location/`date +%Y-%m-%d` | awk '{print $1}')
    yesterday_s=$(du -sh $backup_location/`date -d "1 day ago" +%Y-%m-%d` | awk '{print $1}')

    today=$(du -s $backup_location/`date +%Y-%m-%d` | awk '{print $1}')
    yesterday=$(du -s $backup_location/`date -d "1 day ago" +%Y-%m-%d` | awk '{print $1}')

    diff=`expr $today - $yesterday`
    growth=`awk -v x=$diff -v y=$yesterday 'BEGIN{printf "%.2f\n",100 * x/y}'`


    echo "MongoDB 今日 `date +%Y-%m-%d` 的資料量為 $today_s，較昨日增加 $growth%" >> $backup_log
fi


# send file to backup_server
if [[ "$date" =~ "00:00" ]];
then
    scp -i /home/gok/.ssh/gok_rsa -l 81920 -r $backup_dir/mongodump-$backup_time gok@${backup_server}:/efsbackup/mongo
else
    scp -i /home/gok/.ssh/gok_rsa -l 81920 -r $backup_dir/mongo-oplog-$backup_time gok@${backup_server}:/efsbackup/mongo
fi

scp -i /home/gok/.ssh/gok_rsa -l 81920 -r $backup_log gok@${backup_server}:/efsbackup/mongo 
# 81920 Kbit/s = 80 Mbps


end_time=`date +"%Y-%m-%d %H:%M:%S"`
duration=`echo $(($(date +%s -d "$end_time") - $(date +%s -d "$date"))) | awk '{t=split("60 s 60 m 24 h 999 d", a); for(n=1; n<t; n+=2){if($1==0)break; s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
echo "-- $date 備份正常資訊--" >> $backup_log
echo "現有資料備份所需時間：$duration" >> $backup_log


#### 備份全部成功或失敗的訊息，要在 TG 的那個 script 中處理 ####
    # if [[ "$date" =~ "23:00" && `ls -al $backup_dir | grep mongo | wc -l` == 24 ]];
    # then 
    #     if [[ -z `cat $backup_log | grep -e '異常' -e 'ERROR'` ]];
    #     then 
    #         echo "今日 $backup_Ymd 備份無異常" >> $backup_log
    #     else 
    #         cat $backup_log | grep -e '異常' -e 'ERROR'
    #     fi
    # else 
    #     echo > $backup_log
    # fi
