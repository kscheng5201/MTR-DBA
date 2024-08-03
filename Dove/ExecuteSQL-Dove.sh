#!/bin/bash
##########################################
# Project: OP 執行 MySQL 指令
# Branch: Dove Prod 版本
# Author: Gok, the DBA
# Created: 2023-12-28
# Updated: 2024-06-18
# Note: 檔案上傳 / 強制備份 / 查詢無結果之公告 / DELETE 指令確認詢問
##########################################

src_dir=/etc/dba
Wh=`who -m`
WhH=`echo $Wh|awk '{print $1}'`
date=`date +"%Y-%m-%d-%H:%M:%S"`
jars="/data"
log="tee -a $jars/log/andy-${WhH}-${date}.log"


## 取得 SQL 指令
echo 
echo "從此開始執行 MySQL 指令"
echo "請先上傳 SQL 檔案"
echo "======================="

## 上傳 SQL 檔案
mkdir -p $jars/op-rd-sql/logs/`date +"%F"`
rm -rf $jars/op-rd-sql/logs/`date +"%F"`/*
cd $jars/op-rd-sql/logs/`date +"%F"`
rz -E && 

if [[ $? != 0 ]];
then 
    echo "ERROR: 上傳 SQL 檔案失敗！請重新上傳"
    exit 0
fi

newsql=$(ls -ltr $jars/op-rd-sql/logs/`date +%F` | tail -n 1 | awk '{print $NF}')
echo newsql = $newsql
rm -rf $jars/update.sql
ln -s $jars/op-rd-sql/logs/`date +%F`/$newsql $jars/update.sql


## 清理 SQL 檔案內容
# 連續空白修改為單一空白
sed -i 's/[ ]\+/ /g' $jars/update.sql
# 去除分號之前的空白
sed -i 's/ ;/;/g' $jars/update.sql
# 刪除每一行的 leading space
sed -i 's/^[[:blank:]]*//' $jars/update.sql
# 去除空白行
sed -i '/^$/d' $jars/update.sql
# 去除 # 為首的註解行
sed -i '/^#/d' $jars/update.sql
# 去除 -- 為首的註解行
sed -i '/^--/d' $jars/update.sql

## DBA-自我監控群
token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title='由一線人員所執行的 SQL'

function MsgToBot() {
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

${msg}" > /dev/null 2>&1
}


## 檢查 SQL 檔案內的指令數
num=`grep -c ';' $jars/update.sql`
echo 
echo 此 SQL 檔內共有 $num 個指令
echo ......


## 查看此次 SQL 檔案內的 CRUD 指令
del=`grep -aic '^DELETE\|^DROP\|^TRUNCATE' $jars/update.sql`

if [[ $del -gt 0 ]]; 
then 
    echo '等等！此次 SQL 語法包含以下資料刪除相關語句：'
    grep -ai '^DELETE\|^DROP\|^TRUNCATE' $jars/update.sql
    read -ep '是否確定要執行（請與提出需求的人員確認）？ (Yes/No)' ans
    shopt -s nocasematch

    if [[ ! "${ans,,}" =~ ^(YES|Y) ]];
    then 
        echo "此次 SQL 檔案停止執行"
        exit 0
    fi
fi


crud=`grep -aic '^INSERT\|^UPDATE\|^DELETE\|^DROP\|^TRUNCATE' $jars/update.sql`

if [[ $crud -gt 0 ]]; 
then 
    echo 
    echo 此檔案包含 INSERT / UPDATE / DELETE 指令，要先進行備份

    ## 取得各資料表的資訊
    # 先取得所有 database 資訊
    dbs=$(grep -ai 'SELECT\|^INSERT\|^UPDATE\|^DELETE\|^DROP\|^TRUNCATE' $jars/update.sql | cut -d . -f 1 | awk '{print $NF}' | tr -d '`' | uniq)

    for table_schema in $dbs; 
    do 
        # echo db = $db
        tables=$(grep -ai $table_schema $jars/update.sql | cut -d . -f 2 | awk '{print $1}' | tr -d '`' | uniq)

        for table_name in $tables; 
        do 
            # echo table = $table
            echo 
            echo "開始對 $table_schema.$table_name 進行備份"
            echo ......


            ## 找到 hostname 資訊
            hosts=`tail -n +2 $src_dir/b_ver.list | awk '{print $2}' | uniq`

            for h in $hosts; 
            do 
                ## echo h = $h
                rds=`grep $h $src_dir/b_ver.list | awk '{print $1}' | uniq`
                echo "在 $rds 中查看是否有這資料表..."
                echo 

                user=`grep $h $src_dir/b_ver.list | awk '{print $3}' | head -1`
                pass=`grep $h $src_dir/b_ver.list | awk '{print $4}' | head -1`

                sql="USE $table_schema; SHOW Tables;"
                num=`mysql -h $h -P 3306 -u $user -p"$pass" -sN -e "$sql" 2> /dev/null | grep -c ^${table_name}$`

                ## 找到資料表所在 Server 進行備份
                if [[ $num -ge 1 ]];
                then
                    echo "！！！！" 
                    echo "在 `grep $h $src_dir/b_ver.list | awk '{print $1}' | cut -d - -f 1-3` 成功找到資料表！"
                    echo

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


                    ## 開始進行主要的 SQL 指令
                    echo ''
                    echo '開始執行此檔案'
                    echo '開始執行 SQL 指令'
                    sql_syntax=`cat $jars/update.sql`

                    ## 每一個指令逐一送出與執行
                    for i in $(seq 1 `grep -c ';' $jars/update.sql`);
                    do
                        ## 取得單一 SQL 指令
                        sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
                        ## 印出指令並寫入 update_slide.sql 檔案
                        echo ''
                        echo "${sql_single//`ls`/*}" ';' > $jars/update_slide.sql

                        ## 執行 SQL 指令
                        mysql -h $h -P 3306 -u $user -p"$pass" -e "SOURCE $jars/update_slide.sql" 2>> $jars/op-rd-sql/logs/`date +%F`/$newsql.error
                        ## 刪除 update_slide.sql 檔案
                        rm -rf $jars/update_slide.sql
                    done

                    ## 假如遇到錯誤，以下印出錯誤訊息
                    if [[ $(grep -c ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error) -gt 0 ]];
                    then 
                        echo '詳細的錯誤訊息如下' | $log
                        ## 印出詳細的錯誤訊息
                        grep ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error | cut -d : -f 3 | $log
                        ## 提醒僅執行到的檔案位置
                        echo '出現錯誤的指令位置' | $log
                        grep ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error | cut -d : -f 1 | cut -d ')' -f 2 | $log
                        echo ''
                        echo '注意！上述錯誤發生的指令都尚未執行'
                        echo '注意！其他無錯誤發生的指令都已執行完畢'                    

                        echo ''
                        echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
                        echo '此次更新工作到此結束(部分未完成)，感謝協助' | $log
                        echo '======================================'

                        msg='ERROR: SQL 部分執行成功'
                        MsgToBot
                        msg=$(grep ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error | cut -d : -f 3)
                        MsgToBot
                    fi 

                    echo '...'
                    echo 'SQL 執行完畢'
                    echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep -c ';') 個指令" | $log
                    echo "此次作業共發生 $(grep -c ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error) 次錯誤"

                    exit 0
                fi
            done

            ## 跳出迴圈，不再執行
            # break
        done
    done

else
    ## 此次只是 SELECT 語法
    dbs=$(grep -ai '^SELECT' $jars/update.sql | cut -d . -f 1 | awk '{print $NF}' | tr -d '`' | uniq)

    for table_schema in $dbs; 
    do 
        # echo db = $db
        tables=$(grep -ai $table_schema $jars/update.sql | cut -d . -f 2 | awk '{print $1}' | tr -d '`' | uniq)

        for table_name in $tables; 
        do 
            ## 找到 hostname 資訊
            hosts=`tail -n +2 $src_dir/b_ver.list | awk '{print $2}' | uniq`

            for h in $hosts; 
            do 
                ## echo h = $h
                rds=`grep $h $src_dir/b_ver.list | awk '{print $1}' | uniq`
                echo "在 $rds 中查看是否有這資料表..."
                echo 

                user=`grep $h $src_dir/b_ver.list | awk '{print $3}' | head -1`
                pass=`grep $h $src_dir/b_ver.list | awk '{print $4}' | head -1`

                sql="USE $table_schema; SHOW Tables;"
                num=`mysql -h $h -P 3306 -u $user -p"$pass" -sN -e "$sql" 2> /dev/null | grep -c ^${table_name}$`

                ## 找到資料表所在的 Slave Server
                if [[ $num -ge 1 ]];
                then
                    echo "！！！！" 
                    echo "在 $rds 成功找到資料表！"
                    echo

                    echo ''
                    echo '開始執行此檔案'
                    echo '開始執行 SQL 指令'
                    sql_syntax=`cat $jars/update.sql`

                    ## 每一個指令逐一送出與執行
                    for i in $(seq 1 `grep -c ';' $jars/update.sql`);
                    do
                        ## 取得單一 SQL 指令
                        sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
                        ## 印出指令並寫入 update_slide.sql 檔案
                        echo ''
                        echo "${sql_single//`ls`/*}" ';' > $jars/update_slide.sql

                        ## 執行 SQL 指令
                        # mysql -h $h -P 3306 -u $user -p"$pass" $table_schema < $jars/update_slide.sql >> $jars/op-rd-sql/logs/`date +%F`/$newsql.error

                        mysql -h $h -P 3306 -u $user -p"$pass" -e "SOURCE $jars/update_slide.sql" 2>> $jars/op-rd-sql/logs/`date +%F`/$newsql.error


                        ## 若查詢結果為空，則告知非異常狀況
                        if [[ -z `mysql -h $h -P 3306 -u $user -p"$pass" -e "SOURCE $jars/update_slide.sql" 2> /dev/null` ]]; 
                        then 
                            echo 
                            echo '以下指令無符合條件之資料，獲得筆數為 0'
                            cat $jars/update_slide.sql
                            echo '=========='
                        else
                            echo '將查詢結果輸出成檔案'

                            rdate=`date +"%Y%m%d%H%M%S"`
                            mysql -h $h -P 3306 -u $user -p"$pass" -e "SOURCE $jars/update_slide.sql" 1> $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$rdate.txt

                            echo '轉換 txt 檔輸出成 excel 檔案'
                            python $jars/txt2excel.py

                            ## 刪除原本的 txt 檔案
                            rm -rf $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$rdate.txt

                            echo 
                            echo '下載查詢結果 excel 檔案到 local，請選擇一個 local 電腦的位置存放此檔案'
                            # mv $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$date.xlsx $src_dir/op-rd-sql/outputs/$table_schema-$table_name-`date +"%Y%m%d%H00"`.xlsx
                            sz $src_dir/op-rd-sql/outputs/$table_schema-$table_name-$rdate.xlsx
                        fi
                        ## 刪除 update_slide.sql 檔案
                        rm -rf $jars/update_slide.sql
                    done

                    ## 假如遇到錯誤，以下印出錯誤訊息
                    if [[ $(grep -c ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error) -gt 0 ]];
                    then 
                        echo '詳細的錯誤訊息如下' | $log
                        ## 印出詳細的錯誤訊息
                        grep ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error | cut -d : -f 3 | $log
                        ## 提醒僅執行到的檔案位置
                        echo '出現錯誤的指令位置' | $log
                        grep ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error | cut -d : -f 1 | cut -d ')' -f 2 | $log
                        echo ''
                        echo '注意！上述錯誤發生的指令都尚未執行'
                        echo '注意！其他無錯誤發生的指令都已執行完畢'                    

                        echo ''
                        echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
                        echo '此次更新工作到此結束(部分未完成)，感謝協助' | $log
                        echo '======================================'

                        msg='ERROR: SQL 部分執行成功'
                        MsgToBot
                        msg=$(grep ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error | cut -d : -f 3)
                        MsgToBot
                    fi

                    echo '...'
                    echo 'SQL 執行完畢'
                    echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep -c ';') 個指令" | $log
                    echo "此次作業共發生 $(grep -c ERROR $jars/op-rd-sql/logs/`date +%F`/$newsql.error) 次錯誤"

                    exit 0
                fi

                ## 跳出迴圈，不再執行
                # break
            done
        done
    done
fi

