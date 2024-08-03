#!/bin/bash
###############################################
# Project: mysqldump 資料定期備份
# Branch: 
# Author: unknown
# Editor: Gok, the DBA
# Created: 2022-05-09
# Updated: 2023-04-12
# Note: 增加針對 op 所做的 sql-backup 進行刪除
###############################################

date=`date "+%Y-%m-%d %H:%M:%S"`

mysql_user="gcprds" #MySQL備份使用者
mysql_password="1qaz@WSX" #MySQL備份使用者的密碼
mysql_host="localhost"
mysql_port="3306"
mysql_charset="utf8" #MySQL編碼

backup_db_arr=("global_3rd_db" "mysql" ) #要備份的資料庫名稱
backup_location=/usr/local/mysql/mysqldump
backup_log=/opt/mysqlbackup.log
expire_backup_delete="ON" #是否開啟過期備份刪除 ON為開啟 OFF為關閉
expire_days=1 #過期時間天數 預設為三天，此項只有在expire_backup_delete開啟時有效

backup_time=`date +%Y%m%d%H%M`  #定義備份詳細時間
backup_Ymd=`date +%Y-%m-%d` #定義備份目錄中的年月日時間
backup_dir=$backup_location/$backup_Ymd  #備份資料夾全路徑

## DBA 自我監控群
token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"



# 判斷MYSQL是否啟動,mysql沒有啟動則備份退出
mysql_ps=`ps -ef | grep mysql | wc -l`
mysql_listen=`netstat -an | grep LISTEN | grep $mysql_port | wc -l`
if [ [$mysql_ps == 0] -o [$mysql_listen == 0] ]; 
then
    echo "-- $date 備份異常資訊--" >> $backup_log
    echo "ERROR: MySQL is not running! backup stop!" >> $backup_log
    exit
else
    echo ''
    echo "Alright! MySQL is running! backup GO ON!"
fi

# 連線到mysql資料庫，無法連線則備份退出
mysql -h$mysql_host -P$mysql_port -u$mysql_user -p$mysql_password <<end
    use mysql;
    select host,user from user where user='root' and host='localhost';
    exit
end

flag=`echo $?`
if [ $flag != "0" ]; then
    echo "-- $date 備份異常資訊--" >> $backup_log
    echo "ERROR: Can't connect mysql server! backup stop!" >> $backup_log
    exit
else
    echo ''
    echo "MySQL connect ok! Please wait......"
    echo "backup binlog ..."
    binlog=`mysql -h$mysql_host -u$mysql_user -P$mysql_port -p$mysql_password -e 'show master status' | grep 'bin' | awk '{print $1}'`
    `mysql -h$mysql_host -u$mysql_user -P$mysql_port -p$mysql_password -e 'flush logs;'`
    `gzip -c /var/lib/mysql/$binlog > $backup_dir/$binlog-$backup_time.gz`

    # 判斷有沒有定義備份的資料庫，如果定義則開始備份，否則退出備份
    if [ "$backup_db_arr" != "" ];
    then
        #dbnames=$(cut -d ',' -f1-5 $backup_database)
        #echo "arr is (${backup_db_arr[@]})"
        for dbname in ${backup_db_arr[@]}
        do
            echo "database $dbname backup start..."
            `mkdir -p $backup_dir`
            `mysqldump -h$mysql_host -P$mysql_port -u$mysql_user -p$mysql_password $dbname --master-data=2 --single-transaction --default-character-set=$mysql_charset | gzip > $backup_dir/$dbname-$backup_time.sql.gz`

            flag=`echo $?`
            if [ $flag == "0" ];
            then
                echo "-- $date 備份正常資訊--" >> /opt/mysqlbackup.log
                echo "$dbname 已備份至 $backup_dir/$dbname-$backup_time.sql.gz" >> /opt/mysqlbackup.log
            else
                echo "-- $date 備份異常資訊--" >> $backup_log
                echo "ERROR: database $dbname backup fail!" >> $backup_log
            fi      
        done

    else
        echo "-- $date 備份異常資訊--" >> $backup_log
        echo "ERROR: No database to backup! backup stop" >> $backup_log
        exit
    fi
fi


# 如果開啟了刪除過期備份，則進行刪除操作
if [ "$expire_backup_delete" == "ON" -a  "$backup_location" != "" ];
then
    echo "-- $date 備份刪除資訊--" >> $backup_log
    if [ -n `find $backup_location/ -type d -mtime +$expire_days` ];
    then
        echo "No File Should be deleted!" >> $backup_log
    else
        find $backup_location/ -type d -mtime +$expire_days >> $backup_log
        `find $backup_location/ -type d -mtime +$expire_days | xargs rm -rf`
    fi

    echo ''
    echo "Expired backup data delete complete!"
fi

echo "-- $date 備份正常資訊--" >> /opt/mysqlbackup.log
echo "All database backup success! Thank you!" >> /opt/mysqlbackup.log

end_time=`date +"%Y-%m-%d %H:%M:%S"`
duration=`echo $(($(date +%s -d "$end_time") - $(date +%s -d "$date"))) | awk '{t=split("60 s 60 m 24 h 999 d", a); for(n=1; n<t; n+=2){if($1==0)break; s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
echo "-- $date 備份正常資訊--" >> /opt/mysqlbackup.log
echo "備份開始時間：$date" >> /opt/mysqlbackup.log
echo "備份結束時間：$end_time" >> /opt/mysqlbackup.log
echo "現有資料備份所需時間：$duration" >> /opt/mysqlbackup.log


if [[ "$date" =~ "23:00" ]];
then
    today_s=$(ls -al -h $backup_location/`date +%Y-%m-%d` | grep global_3rd_db | grep 2300 | awk '{print $5}')
    yesterday_s=$(ls -al -h $backup_location/`date -d "1 day ago" +%Y-%m-%d` | grep global_3rd_db | grep 2300 | awk '{print $5}')

    today=$(ls -al $backup_location/`date +%Y-%m-%d` | grep global_3rd_db | grep 2300 | awk '{print $5}')
    yesterday=$(ls -al $backup_location/`date -d "1 day ago" +%Y-%m-%d` | grep global_3rd_db | grep 2300 | awk '{print $5}')
    diff=`expr $today - $yesterday`
    growth=`awk -v x=$diff -v y=$yesterday 'BEGIN{printf "%.2f\n",100 * x/y}'`

    echo "MySQL 今日 `date +%Y-%m-%d` 的資料量為 $today_s，較昨日增加 $growth%" >> $backup_log
    #msg="MySQL 今日 `date +%Y-%m-%d` 的資料量為 $today_s，較昨日增加 $growth%"
    #curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${msg}" > /dev/null 2>&1
fi






## Messege to Telegram Bot
if [[ -n `cat $backup_log | grep ERROR` ]];
then
    current=`echo ${date::16}`
    head_now=`cat -n $backup_log | grep "$current" | head -n 1 | cut -d '-' -f 1`
    head_now=$(($head_now * 1))

    msg=`tail -n +$head_now $backup_log`
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=MySQL Backup ERROR at [[`hostname`]] 

${msg}" > /dev/null 2>&1

    #sh /opt/totelegram.sh

else
    if [[ "$date" =~ "00:00" ]];
    then
        msg="All database backup Today `date +"%Y-%m-%d"` is SUCCESS! Thank Everyone!"
        curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=MySQL Backup Info at [[`hostname`]] 

${msg}" > /dev/null 2>&1

        #sh /opt/totelegram.sh
        ## delete the log file
        #rm $backup_log
    fi
fi


## rm the oldest day backup when the disk usage > 78%
usage=`df -h | grep mysql | awk '{print $5}' | cut -d % -f 1`

if [[ $usage -gt 78 ]];
then
    old=`ls $backup_location | sort | head -n 1`
    rm -rf $backup_location/$old

    msg="mysql 資料夾使用量達到 $usage%，故刪除了 $old 的備份資料"
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=MySQL Backup Info at [[`hostname`]] 

${msg}" > /dev/null 2>&1
fi


## remove the oldest op backup when the file number > 5
total=`ls -al /usr/local/mysql/op-backup | grep -c global_3rd_db`
echo $total

if [[ $total > 5 ]]; 
then 
    head_n=`expr $total - 5`
    files=`ls /usr/local/mysql/op-backup | grep global_3rd_db | head -$head_n`
    cd /usr/local/mysql/op-backup && rm -rf $files

    msg="DM sql-backup 資料夾超過 $head_n 份，故刪除了備份資料 $files"
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${msg}" > /dev/null 2>&1    
fi

