#!/bin/bash
#######################################
# Project: RabbitMQ 資料定期備份
# Branch: 
# Author: Gok, the DBA
# Created: 2022-11-22
# Updated: 2023-02-10
# Note: 增加邏輯備份在內
#######################################

date=`date +"%Y-%m-%d %H:%M:%S"`
rabbitmq_port="5672"

file_dir=`rabbitmqctl eval 'rabbit_mnesia:dir().'`
file_dir=`eval "echo $file_dir"`
backup_location=/data/rabbitmq/backup
backup_log=/data/rabbitmq/backup/rabbitmqbackup.log
backup_time=`date +%Y%m%d%H%M`  #定義備份詳細時間
backup_Ymd=`date +%Y-%m-%d` #定義備份目錄中的年月日時間
backup_dir=$backup_location/$backup_Ymd  #備份資料夾全路徑
backup_server='10.25.1.183'

token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"



# 判斷rabbitmq是否啟動,rabbitmq沒有啟動則備份退出
rabbitmq_ps=`ps -ef | grep rabbitmq | wc -l`
rabbitmq_listen=`netstat -an | grep LISTEN | grep $rabbitmq_port | wc -l`
if [ [$rabbitmq_ps == 0] -o [$rabbitmq_listen == 0] ]; 
then
    echo "-- $date 備份異常資訊--" >> $backup_log
    echo "ERROR: rabbitmq is not running! backup stop!" >> $backup_log
    exit
else
    echo ''
    echo "Alright! rabbitmq is running! backup GO ON!"
fi


echo ''
echo "rabbitmq connect ok! Please wait......"
echo "backup rabbitmq ..."

mkdir -p $backup_dir
echo "database $dbname backup start..."


#### 邏輯備份先來
/usr/local/bin/rabbitmqadmin export $backup_dir/rabbitmq-config-$backup_time 
gzip $backup_dir/rabbitmq-config-$backup_time 

#### 資料備份後到
cd $file_dir && tar -zcvf rabbitmq-data-$backup_time.tar.gz . #打包與壓縮當前資料夾下所有檔案,壓縮檔會放置在所執行的User目錄下
cp /`whoami`/rabbitmq-data-$backup_time.tar.gz $backup_dir
rm -rf /`whoami`/rabbitmq-data-$backup_time.tar.gz

flag=`echo $?`
if [ $flag == "0" ];
then
    echo "-- $date 備份正常資訊--" >> $backup_log
    echo "$dbname 已備份至 $backup_dir/rabbitmq-$backup_time.tar.gz" >> $backup_log
else
    echo "-- $date 備份異常資訊--" >> $backup_log
    echo "ERROR: database $dbname backup fail!" >> $backup_log
fi      

echo "-- $date 備份正常資訊--" >> $backup_log
echo "All database backup success! Thank you!" >> $backup_log

# ## Messege to Telegram Bot
# if [[ -n `cat $backup_log | grep ERROR` ]];
# then
#     current=`echo ${date::16}`
#     head_now=`cat -n $backup_log | grep "$current" | head -n 1 | cut -d '-' -f 1`
#     head_now=$(($head_now * 1))

#     msg=`tail -n +$head_now $backup_log`
#     curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=rabbitmq Backup ERROR at [[`hostname`]] 

# ${msg}" > /dev/null 2>&1

#     # sh /opt/totelegram.sh

# else
    if [[ "$date" =~ "23:00" ]];
    then
        today_s=$(ls -al -h $backup_location/`date +%Y-%m-%d` | grep 2300 | awk '{print $5}')
        yesterday_s=$(ls -al -h $backup_location/`date -d "1 day ago" +%Y-%m-%d` | grep 2300 | awk '{print $5}')

        today=$(ls -al $backup_location/`date +%Y-%m-%d` | grep 2300 | awk '{print $5}')
        yesterday=$(ls -al $backup_location/`date -d "1 day ago" +%Y-%m-%d` | grep 2300 | awk '{print $5}')
        diff=`expr $today - $yesterday`
        growth=`awk -v x=$diff -v y=$yesterday 'BEGIN{printf "%.2f\n",100 * x/y}'`

        echo "`hostname | awk -F 'prod-|-0' '{print $2}'` 今日 `date +%Y-%m-%d` 的資料量為 $today_s，較昨日增加 $growth%" >> $backup_log
    fi

# fi


## 刪除過期備份
if [[ `ls -d */ $backup_location | wc -l` -gt 5 ]];
then 
    last_5th=`ls -d */ $backup_location | tail -5 | head -1`
    delete_to=`ls -d */ $backup_location | grep -B111 "$last_5th"`

    for d in $delete_to; 
    do 
        echo "-- $date 刪除 $d 備份檔--" >> $backup_log
        rm -rf $backup_location/$d
    done
fi

# send file to backup_server
scp -i /home/gok/.ssh/gok_rsa -r $backup_dir gok@${backup_server}:/efsbackup/rabbitmq
scp -i /home/gok/.ssh/gok_rsa -r $backup_log gok@${backup_server}:/efsbackup/rabbitmq


end_time=`date +"%Y-%m-%d %H:%M:%S"`
duration=`echo $(($(date +%s -d "$end_time") - $(date +%s -d "$date"))) | awk '{t=split("60 s 60 m 24 h 999 d", a); for(n=1; n<t; n+=2){if($1==0)break; s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
echo "-- $date 備份正常資訊--" >> $backup_log
echo "現有資料備份所需時間：$duration" >> $backup_log
