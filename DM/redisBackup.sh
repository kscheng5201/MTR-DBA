#!/bin/bash
##################################################
# Project: Redis 資料定期備份
# Branch: 
# Author: Gok, the DBA
# Created: 2022-12-05
# Updated: 2023-04-24
# Note: 修改備份資料位置為 /etc/dba/backup 並傳送到 /home/gok/backups
##################################################

date=`date +"%Y-%m-%d %H:%M:%S"`

redis_host=`hostname -i | cut -d ' ' -f 2`
redis_password="newld20200909"

backup_location=/etc/dba
dump_file='dump-6380.rdb'
append_file='appendonly-6380.aof'
backup_log="`echo $redis_host | cut -d . -f 4`-redis_backup.log"
expire_backup_delete="ON" #是否開啟過期備份刪除 ON為開啟 OFF為關閉
expire_days=1 #過期時間天數 預設為三天，此項只有在expire_backup_delete開啟時有效

backup_time=`date +%Y%m%d%H%M`  #定義備份詳細時間
backup_Ymd=`date +%Y-%m-%d` #定義備份目錄中的年月日時間
backup_dir=$backup_location/backup/$backup_Ymd  #備份資料夾全路徑
mkdir -p $backup_dir
backup_server='10.25.1.183'

token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"



# 判斷redis是否啟動,redis沒有啟動則備份退出
if [[ `netstat -ntulp | grep :63 | wc -l` = 2 ]]; 
then 
    echo ''
    echo "Alright! redis is running! backup GO ON!"
else
    echo "-- $date 備份異常資訊--" >> $backup_location/backup/$backup_log
    echo "ERROR: redis is not running! backup stop!" >> $backup_location/backup/$backup_log
    exit
fi

# 連線到redis資料庫取得 info 資訊，無法連線則備份退出
redis-cli -h $redis_host -p 6377 -c -a $redis_password info 2> /dev/null 

flag=`echo $?`
if [ $flag != "0" ]; then
    echo "-- $date 備份異常資訊--" >> $backup_location/backup/$backup_log
    echo "ERROR: Can't connect redis server! backup stop!" >> $backup_location/backup/$backup_log
    exit
else
    echo ''
    echo "redis connect ok! Please wait......"

    echo "$dump_file backup $backup_time start..."    
    gzip -c /usr/local/redis-cluster/data/$dump_file > $backup_dir/`echo $redis_host | cut -d . -f 4`-$dump_file-$backup_time.gz

    flag=`echo $?`
    if [ $flag == "0" ];
    then
        echo "-- $date 備份正常資訊--" >> $backup_location/backup/$backup_log
        echo "$dump_file 已備份至 $backup_dir/`echo $redis_host | cut -d . -f 4`-$dump_file-$backup_time.gz" >> $backup_location/backup/$backup_log
    else
        echo "-- $date 備份異常資訊--" >> $backup_location/backup/$backup_log
        echo "ERROR: $backup_file backup fail!" >> $backup_location/backup/$backup_log
    fi

    echo ''
    echo "$append_file backup $backup_time start..."    
    gzip -c /usr/local/redis-cluster/data/$append_file > $backup_dir/`echo $redis_host | cut -d . -f 4`-$append_file-$backup_time.gz

    flag=`echo $?`
    echo "-- $date 備份正常資訊--" >> $backup_location/backup/$backup_log
    echo "$append_file 已備份至 $backup_dir/`echo $redis_host | cut -d . -f 4`-$append_file-$backup_time.gz" >> $backup_location/backup/$backup_log
    
fi


# 如果開啟了刪除過期備份，則進行刪除操作
if [ "$expire_backup_delete" == "ON" -a  "$backup_location/backup" != "" ];
then
    echo "-- $date 備份刪除資訊--" >> $backup_location/backup/$backup_log
    if [ -n `find $backup_location/backup/ -type d -mtime +$expire_days` ];
    then
        echo "No File Should be deleted!" >> $backup_location/backup/$backup_log
    else
        find $backup_location/backup/ -type d -mtime +$expire_days >> $backup_location/backup/$backup_log
        find $backup_location/backup/ -type d -mtime +$expire_days | xargs rm -rf
    fi

    echo ''
    echo "Expired backup data delete complete!"
fi

echo "-- $date 備份正常資訊--" >> $backup_location/backup/$backup_log
echo "All database backup success! Thank you!" >> $backup_location/backup/$backup_log


end_time=`date +"%Y-%m-%d %H:%M:%S"`
duration=`echo $(($(date +%s -d "$end_time") - $(date +%s -d "$date"))) | awk '{t=split("60 s 60 m 24 h 999 d", a); for(n=1; n<t; n+=2){if($1==0)break; s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
echo "-- $date 備份正常資訊--" >> $backup_location/backup/$backup_log
if [[ $date == $end_time ]]; 
then 
	duration='0s'
fi
echo "現有資料備份所需時間：$duration" >> $backup_location/backup/$backup_log


# send file to backup_server
scp -i /home/gok/.ssh/gok_rsa -r $backup_dir gok@${backup_server}:/home/gok/backups/redis 
scp -i /home/gok/.ssh/gok_rsa -r $backup_location/backup/$backup_log gok@${backup_server}:/home/gok/backups/redis 



# 以下都不執行，主要因為這台機器不給連線到外網
## Messege to Telegram Bot
# if [[ -n `cat $backup_location/backup/$backup_log | grep ERROR` ]];
# then
#     current=`echo ${date::16}`
#     head_now=`cat -n $backup_location/backup/$backup_log | grep "$current" | head -n 1 | cut -d '-' -f 1`
#     head_now=$(($head_now * 1))

#     msg=`tail -n +$head_now $backup_location/backup/$backup_log`
#     curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=redis Backup ERROR at [[`hostname`]] 

# ${msg}" > /dev/null 2>&1

# else
#     if [[ "$date" =~ "00:00" ]];
#     then
#         msg="All database backup Today `date +"%Y-%m-%d"` is SUCCESS! Thank Everyone!"
#         curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=redis Backup Info at [[`hostname`]] 

# ${msg}" > /dev/null 2>&1

#     sh $backup_location/redisMsgTG.sh
#     fi
# fi
