#!/bin/bash
##########################################
# Project: OP 執行 MySQL 指令
# Branch: 
# Author: Gok, the DBA
# Created: 2023-11-21
# Updated: 2023-11-21
# Note: 
##########################################


Wh=`whoami`
source_dir=/etc/dba
log="tee -a $source_dir/logs/${Wh}-`date +'%Y%m%d%H%M'`.log"
backup_ip='10.0.1.110'
backup_local="$source_dir/logs"
backup_remote=/re/backups/op-backups


if [[ $Wh = 'centos' ]];
then
    echo "請問要進入哪台主機操作 SQL 指令（請輸入編號）" | $log
    echo "(1) b-nacos-rds" | $log
    echo "(2) b-rds57" | $log
    echo "(3) b-rds57-box-match" | $log
    echo "(4) b-rds57-dark" | $log
    echo "(5) b-rds57-game" | $log
    echo "(6) b-rds57-info" | $log
    echo "(7) b-rds57-sns" | $log
    echo "(8) b-rds57-swift" | $log
    echo "(9) b-rds57-user" | $log
    echo "(10) b-rds57-xzs" | $log
    echo '========================'

    read -e ans
    echo 
    echo "你選擇的是（$ans）" | $log

    case $ans in
    1)
        svc='b-nacos-rds'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    2)
        svc='b-rds57'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`            
    ;;
    3)
        svc='b-rds-57-box-match'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    4)
        svc='b-rds57-dark'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    5)
        svc='b-rds57-game'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    6)
        svc='b-rds57-info'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    7)
        svc='b-rds57-sns'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`            
    ;;
    8)
        svc='b-rds57-swift'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    9)
        svc='b-rds57-user'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    10)
        svc='b-rds57-xzs'
        host=`grep $svc $source_dir/b_ver.list | awk '{print $2}' | uniq`
        user=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $3}'`
        pass=`grep $svc $source_dir/b_ver.list | head -1 | awk '{print $4}'`
    ;;
    *)
        echo 沒有這個選項 | $log
        exit 0
    esac


    ## 執行 SQL 前的備份作業
    echo 
    echo "請問此次執行先是否要先備份？（Y：進行備份）"
    read -e backup

    if [[ $backup == 'Y' ]]; 
    then 
        echo "請問要備份的資料庫名稱？"
        read -e db_name
        echo "請問要備份的資料表名稱？"
        read -e table_name
        echo "備份 $db_name.$table_name 進行中......"

        ## 備份到 local 端
        mysqldump -h $host -P 3306 -u$user -p"$pass" --set-gtid-purged=OFF --databases $db_name --tables $table_name > $backup_local/$db_name-$table_name-`date +'%Y%m%d%H%M'`.sql 2>/dev/null
        ## 備份到 remote 端
        # ssh $backup_ip "mysqldump -h $host -P 3306 -u$user -p'$pass' --set-gtid-purged=OFF --databases $db_name --tables $table_name > $backup_remote/$db_name-$table_name-`date +'%Y%m%d%H%M'`.sql" 2>/dev/null

        echo 
        echo "備份 $db_name.$table_name 已完成......"
    else
        echo 此次 SQL 執行前沒有進行備份作業。
    fi


    ## 上傳 SQL 檔案
    mkdir -p /home/$Wh/op-sql/`date +"%F"`
    cd /home/$Wh/op-sql/`date +"%F"`
    rz -E &&

    if [[ $? != 0 ]];
    then 
        echo "ERROR: 上傳 SQL 檔案失敗！請重新上傳"
        exit 0
    else
        newsql=$(ls -ltr /home/$Wh/op-sql/`date +"%F"` | tail -n 1 | awk '{print $NF}')
        rm -f /home/$Wh/update.sql
        ln -s /home/$Wh/op-sql/`date +"%F"`/$newsql /home/$Wh/update.sql

        ## 執行指令
        mysql -h $host -P 3306 -u $user -p"$pass" -e "source /home/$Wh/update.sql"
    fi
fi
