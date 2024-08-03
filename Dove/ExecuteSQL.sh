#!/bin/bash
##########################################
# Project: OP 執行 MySQL 指令
# Branch: 
# Author: Gok, the DBA
# Created: 2024-01-18
# Updated: 2024-01-18
# Note: SM Prod 版本
##########################################

src_dir=/etc/dba


## 取得 SQL 指令
echo 
echo "請在此填入此次要執行的 SQL 指令（一次一組，並一行貼上指令）：" | $log
read -e SQLcommand 
shopt -s nocasematch

echo 
echo 此次指令為：$SQLcommand | $log
table_schema=`echo "${SQLcommand}" | cut -d . -f 1 | awk '{print $NF}'`
table_name=`echo "${SQLcommand}" | cut -d . -f 2 | awk '{print $1}'`

## 詢問是否要備份
echo 
echo "請問此次執行先是否要先備份？（[Y]es：進行備份）" | $log
read -e backup
shopt -s nocasematch


hosts=`awk '{print $2}' $src_dir/b_ver.list | grep rds | uniq`
for h in $hosts; 
do 
    echo
    # echo h = $h
    user=`grep $h $src_dir/b_ver.list | head -1 | awk '{print $3}'`
    pass=`grep $h $src_dir/b_ver.list | head -1 | awk '{print $4}'`

    sql="USE $table_schema; SHOW Tables;"
    num=`mysql -h $h -P 3306 -u $user -p"$pass" -sN -e "$sql" 2> /dev/null | grep -c ^${table_name}$`

    ## 找到資料表所在 Server 並且有要備份
    if [[ $num -ge 1 ]];
    then 
        if [[ "${backup}" =~ ^(YES|Y|y|yes) ]]; 
        then 
            echo "備份 $table_schema.$table_name 進行中......" | $log
            start_time=`date +"%Y-%m-%d %H:%M:%S"`
            ## 備份到 local 端
            mysqldump -h $h -P 3306 -u$user -p"$pass" --set-gtid-purged=OFF --databases $table_schema --tables $table_name 2> /dev/null | gzip > $src_dir/op-rd-sql/backups/$table_schema-$table_name-$date.sql.gz
            ## 備份到 remote 端
            # ssh $backup_ip "mysqldump -h $host -P 3306 -u$user -p'$pass' --set-gtid-purged=OFF --databases $db_name --tables $table_name > $backup_remote/$db_name-$table_name-$date.sql" 2>/dev/null

            echo 
            if [[ $start_time eq $end_time ]];
            then 
                duration='0s'
            else
                duration=`echo $(($(date +%s -d "$end_time") - $(date +%s -d "$start_time"))) | awk '{t=split("60 s 60 m 24 h 999 d", a); for(n=1; n<t; n+=2){if($1==0)break; s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
            fi

            echo "備份 $table_schema.$table_name 已完成......，費時 $duration" | $log
            echo '======'
        else
            echo 
            echo 此次 SQL 執行前不進行備份作業。| $log
            echo '======'
        fi

        ## 開始進行主要的 SQL 指令
        mysql -h $h -P 3306 -u $user -p"$pass" -e "${SQLcommand}" 2> $src_dir/op-rd-sql/logs/$table_schema-$table_name-$date.error | $log

        error_num=`grep -ic ERROR $src_dir/op-rd-sql/logs/$table_schema-$table_name-$date.error`
        if [[ $error_num -gt 0 ]]; 
        then 
            echo "此次執行共發生 $error_num 個錯誤" | $log
            echo '詳細錯誤訊息如下' | $log
            grep -v Warning $src_dir/op-rd-sql/logs/$table_schema-$table_name-$date.error | $log
        else
            rm -rf $src_dir/op-rd-sql/logs/$table_schema-$table_name-$date.error
            echo 
            echo 此次 SQL 檔案已經執行完畢。| $log
            echo '======'            
        fi

        ## 後面的主機不用再檢查
        break
    fi
done