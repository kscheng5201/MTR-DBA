#!/bin/bash
##########################################
# Project: OP 執行 MySQL 指令
# Branch: Dove Prod 版本
# Author: Gok, the DBA
# Created: 2023-12-28
# Updated: 2024-05-18
# Note: 加入輸出查詢檔案
##########################################

src_dir=/etc/dba


## 取得 SQL 指令
echo 
echo "注意：從通訊軟體複製的語法，建議使用以下「純文字貼上」方式，避免不必要的字元帶入"
echo "Windows 電腦的快捷鍵為「Ctrl + Shift + V」，macOS 電腦則是「Cmd + Shift + V」"
echo 
echo "請在此填入此次要執行的 SQL 指令（一次一組，並一行貼上指令）：" | $log
echo "======"
read -e SQLcommand
shopt -s nocasematch
## 將最末的分號消除
SQLcommand=`echo "${SQLcommand}" | sed 's/;$//'`

echo 
echo 此次指令為："${SQLcommand}" | $log
table_schema=`echo "${SQLcommand}" | cut -d . -f 1 | awk '{print $NF}'`
table_name=`echo "${SQLcommand}" | cut -d . -f 2 | awk '{print $1}'`

## 詢問是否要備份
echo 
echo "請問此次執行先是否要先備份？（[Y]es：進行備份）" | $log
read -e backup
shopt -s nocasematch


hosts=`tail -n +2 $src_dir/mysql.list | grep backup | awk '{print $2}' | uniq`
for h in $hosts; 
do 
    ## echo h = $h
    rds=`grep $h $src_dir/mysql.list | awk '{print $1}' | cut -d - -f 1-3`
    echo "在 $rds 中查看是否有這資料表..."
    echo 

    user=`grep $h $src_dir/mysql.list | awk '{print $3}'`
    pass=`grep $h $src_dir/mysql.list | awk '{print $4}'`

    sql="USE $table_schema; SHOW Tables;"
    num=`mysql -h $h -P 3306 -u $user -p"$pass" -sN -e "$sql" 2> /dev/null | grep -c ^${table_name}$`

    ## 找到資料表所在 Server 並且有要備份
    if [[ $num -ge 1 ]];
    then
        echo "！！！！" 
        echo "在 `grep $h $src_dir/mysql.list | awk '{print $1}' | cut -d - -f 1-3` 成功找到資料表！"
        echo

	    if [[ "${backup}" =~ ^(YES|Y|y|yes) ]]; 
        then 
            echo "備份 $table_schema.$table_name 進行中......" | $log
            start_time=`date +"%Y-%m-%d %H:%M:%S"`
            ## 備份到 local 端
            mysqldump -h $h -P 3306 -u$user -p"$pass" --set-gtid-purged=OFF --databases $table_schema --tables $table_name 2> /dev/null | gzip > $src_dir/op-rd-sql/backups/$table_schema-$table_name-$date.sql.gz
            ## 備份到 remote 端
            # ssh $backup_ip "mysqldump -h $host -P 3306 -u$user -p'$pass' --set-gtid-purged=OFF --databases $db_name --tables $table_name > $backup_remote/$db_name-$table_name-$date.sql" 2>/dev/null

            echo 
            end_time=`date +"%Y-%m-%d %H:%M:%S"`
            duration=`echo $(($(date +%s -d "$end_time") - $(date +%s -d "$start_time"))) | awk '{t=split("60 s 60 m 24 h 999 d", a); for(n=1; n<t; n+=2){if($1==0)break; s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
            echo "備份 $table_schema.$table_name 已完成......，費時 $duration" | $log
            echo '======'
        else
	        echo 
            echo 此次 SQL 執行前不進行備份作業。| $log
	        echo '======'
        fi

        ## 開始進行主要的 SQL 指令
        h=`grep -B1 $h $src_dir/mysql.list | head -1 | awk '{print $2}'`
        user=`grep $h $src_dir/mysql.list | awk '{print $3}'`
        pass=`grep $h $src_dir/mysql.list | awk '{print $4}'`

        ## 判斷此次只是 SELECT 語法
        if [[ -n `echo "${SQLcommand}" | grep -i '^SELECT'` ]];
        then
            echo 
            echo '將查詢結果輸出成檔案'
            mysql -h $h -P 3306 -u $user -p"$pass" -e "${SQLcommand}" 1> $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$date.txt

            echo '轉換 txt 檔輸出成 excel 檔案'
            python $jars/txt2excel.py

            ## 刪除原本的 txt 檔案
            rm -rf $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$date.txt

            echo '下載查詢結果 excel 檔案到 local，請選擇一個 local 電腦的位置存放此檔案'
            mv $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$date.xlsx $src_dir/op-rd-sql/outputs/$table_schema-$table_name-`date +"%Y%m%d%H%M"`.xlsx
            sz $src_dir/op-rd-sql/outputs/$table_schema-$table_name-`date +"%Y%m%d%H%M"`.xlsx
            #cp $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$date.xlsx /home/`whoami`
            #sz /home/`whoami`/$table_schema-$table_name-$date.xlsx
            #rm -rf /home/`whoami`/$table_schema-$table_name-$date.xlsx

            echo 此次 SQL 檔案已經執行完畢。| $log
            echo '======'     
        else
            echo 
            echo '開始執行非 SELECT 的 CRUD 指令'
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
        fi

        ## 跳出迴圈，不再執行
        break
    fi
done

