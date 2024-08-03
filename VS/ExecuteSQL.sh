#!/bin/bash
#################################################
# Project: Execute the SQL file
# Branch: 
# Author: Gok, the DBA
# Created: 2022-09-01
# Updated: 2023-07-03
# Note: 增加註解刪除機制，以及分別通報失敗語法及原因
#################################################

user=`whoami`
WhH=$(echo `who -m` | cut -d ' ' -f 1)
date=`date +%Y-%m-%d-%H:%M:%S`
jars="/data"
log="tee -a $jars/log/andy-${WhH}-${date}.log"
master_mysql_ip='10.23.1.180'
PWW='1qaz@WSX'

## 把多空白修改為單一空白
sed -i 's/[ ]\+/ /g' $jars/update.sql
## 去除分號之前的空白
sed -i 's/ ;/;/g' $jars/update.sql
## 去除每一行的 leading space
sed -i 's/^[[:blank:]]*//' $jars/update.sql
## 去除空白行
sed -i '/^$/d' $jars/update.sql
## 去除註解行：以 # 開頭
sed -i '/^#/d' $jars/update.sql
## 去除註解行：以 -- 開頭
sed -i '/^--/d' $jars/update.sql


sql_syntax=`cat $jars/update.sql`
ls=`ls`


if [[ -n `grep -i 'USE ' $jars/update.sql` ]]; 
then 
    key_db=`grep -i 'USE ' $jars/update.sql | sed 's/;//g' | cut -d ' ' -f 2`
else 
    key_db='global_3rd_db'
fi

## DBA-自我監控群
token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title='由 Operation 所執行的 SQL'



function MsgToBot() {
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

${msg}" > /dev/null 2>&1
}


function RunSQL_one() {
    echo ''
    echo '開始執行此檔案'
    echo '開始執行 SQL 指令'

    ## 每一個指令逐一送出與執行
    for i in $(seq 1 `grep -c ';' $jars/update.sql`);
    do
        ## 取得單一 SQL 指令
        sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
        ## 印出指令並寫入 update_slide.sql 檔案
        echo ''
        echo "${sql_single//$(echo $ls)/*}" ';' | sudo tee $jars/update_slide.sql
        ## 傳送 update_slide.sql 檔案到 MySQL Master Server
        scp -rp $jars/update_slide.sql ${user}@${master_mysql_ip}:/home/${user}/update.sql > /dev/null 2>&1
        ## 指令寫入 log 檔案
        cat $jars/update_slide.sql >> $jars/output_${date}.log

        ## 執行 SQL 指令
        ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/update.sql;'" >> $jars/output_${date}.log 2>&1
        ## 刪除 update_slide.sql 檔案
        sudo rm $jars/update_slide.sql
        ## 空行寫入 log 檔案
        echo >> $jars/output_${date}.log
    done

    ## 刪除 log 檔案中的 Warning 訊息
    sed -i '/Warning/d' $jars/output_${date}.log 2> /dev/null
    echo '...'
    echo 'SQL 執行完畢'
    echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep -c ';') 個指令" | $log
    echo "此次作業共發生 `grep -c ERROR $jars/output_${date}.log` 次錯誤"

    ## 假如遇到錯誤，以下印出錯誤訊息
    if [[ `grep -c ERROR $jars/output_${date}.log` -gt 0 ]];
    then 
        echo '詳細的錯誤訊息如下' | $log
        sed -i 's/ at line 1 in file: //g' $jars/output_${date}.log
        ## 印出詳細的錯誤訊息
        grep -B1 ERROR $jars/output_${date}.log | cut -d : -f 2
        ## 詳細的錯誤訊息寫到正式 log
        grep -B1 ERROR $jars/output_${date}.log | $log > /dev/null

        echo ''
        echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
        echo '此次更新工作到此結束(部分未完成)，感謝協助' | $log
        echo '======================================'

        msg='ERROR: SQL 部分執行成功'
        MsgToBot
        msg=`grep -B1 ERROR $jars/output_${date}.log`
        MsgToBot
    else
        echo ''
        echo '請於群組告知此工作已完成，並請需求人員確認資料現況'                
        echo '此次更新工作到此結束(全部已執行)，感謝協助' | $log
        echo '======================================'

        msg='Info: SQL 全部執行成功'
        MsgToBot
    fi

    ## 刪除此次的 log
    rm -rf $jars/output_${date}.log
}


function RunSQL_all() {
    ## 傳送整份 update.sql 檔案到 MySQL Master Server
    scp -rp $jars/update.sql ${user}@${master_mysql_ip}:/home/${user}/update.sql > /dev/null 2>&1
    ## SQL 檔案整份執行，所有 response 都寫到 log 內
    ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/update.sql;'" >> $jars/output_${date}.log 2>&1

    ## 刪除 log 檔案中的 Warning 訊息
    sed -i '/Warning/d' $jars/output_${date}.log 2> /dev/null
    echo '...'
    echo 'SQL 執行完畢'
    echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep -c ';') 個指令" | $log
    echo "此次作業共發生 `grep -c ERROR $jars/output_${date}.log` 次錯誤"

    ## 假如遇到錯誤，以下印出錯誤訊息
    if [[ `grep -c ERROR $jars/output_${date}.log` -gt 0 ]];
    then 
        echo '詳細的錯誤訊息如下' | $log
        ## 印出詳細的錯誤訊息
        grep ERROR $jars/output_${date}.log | cut -d : -f 3 | $log
        ## 提醒僅執行到的檔案位置
        echo '出現錯誤的指令位置' | $log
        grep ERROR $jars/output_${date}.log | cut -d : -f 1 | cut -d ')' -f 2 | $log
        echo ''
        echo '注意！在上述錯誤發生之後的指令都尚未執行'

        echo ''
        echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
        echo '此次更新工作到此結束(部分未完成)，感謝協助' | $log
        echo '======================================'

        msg='ERROR: SQL 部分執行成功'
        MsgToBot
        msg=`grep ERROR $jars/output_${date}.log | cut -d : -f 1 | cut -d ')' -f 2`
        MsgToBot
    else 
        echo ''
        echo '請於群組告知此工作已完成，並請需求人員確認資料現況'                
        echo '此次更新工作到此結束(全部已執行)，感謝協助' | $log
        echo '======================================'

        msg='Info: SQL 全部執行成功'
        MsgToBot
    fi

    ## 刪除此次的 log
    rm -rf $jars/output_${date}.log
}



echo ''
echo '更新 SQL 程式開始執行'
echo '...'
echo '說明：'
echo '若檢查到檔案內出現有疑慮的內容，會出現警示或錯誤'
echo '只有在確認檔案內容沒問題時，才會執行'
echo '每個檢查步驟都會有細部說明'
echo '...'
echo '以下開始'
echo '======================================'

## 檢查檔案中有無夾帶 SELECT 或 TRUNCATE 指令
if [[ -z `grep -iE '^SELECT |TRUNCATE ' $jars/update.sql` ]];
then
    ## 檢查 Transaction 格式是否完整
    if [[ `grep -ic 'BEGIN;' $jars/update.sql` = `grep -ic 'COMMIT;' $jars/update.sql` ]];
    then
        sed -i 's/^DROP TABLE IF EXISTS/DROP TABLE/gi' $jars/update.sql

        ## 檢查是否有 DROP TABLE 指令
        if [[ -z `grep -i '^DROP TABLE' $jars/update.sql` ]];
        then
            ## 檢查是否有 DELETE 指令
            if [[ -z `grep -i '^DELETE FROM' $jars/update.sql` ]];
            then
                ## 檢查是否有虛擬變數
                if [[ -z `grep -i 'SET @' $jars/update.sql` ]];
                then 
                    RunSQL_one

                ## SQL 檔案中帶有虛擬變數
                else
                    RunSQL_all
                fi

            ## 檔案中帶有 DELETE 指令 
            else
                echo ''
                echo "這個檔案有 `grep -ic 'DELETE FROM' $jars/update.sql` 個 DELETE 指令，分別為"

                for i in $(seq 1 `grep -c ';' $jars/update.sql`);
                do
                    echo $sql_syntax | cut -d ';' -f $i | grep -i 'DELETE FROM'
                done

                read -ep '經與需求人員確認後，確定要執行這些刪除指令？(Yes/No)' ans
                answer=$ans
                shopt -s nocasematch

                if [[ "${answer,,}" =~ ^(YES|Y) ]];
                then
                    ## 檢查是否有虛擬變數
                    if [[ -z `grep -i 'SET @' $jars/update.sql` ]];
                    then 
                        RunSQL_one

                    ## SQL 檔案中帶有虛擬變數
                    else
                        RunSQL_all
                    fi
                fi
            fi
        
        ## 檔案內容帶有 DROP TABLE 指令
        else
            ## 取得資料表名稱
            drops=`grep -i '^DROP TABLE' $jars/update.sql | cut -d ' ' -f 3 | sed 's/;//g' | cut -d . -f 2`

            ## 迴圈去跑出每張表的相應指令
            for table in $drops; 
            do 
                ## 製作指令：將每張表的資料比數與表名記為一字串（結果範例：7220#gl_game_bet）
                see_existed="
                    select concat_ws('#', TABLE_ROWS, TABLE_NAME)
                    from information_schema.tables
                    where table_schema = '$key_db'
                        and table_name = '$table'
                    ;"
                ## 輸出結果到 existed.log
                echo "${see_existed}" > $jars/see_existed.sql 

                ## 傳送 see_existed.sql 檔案到 MySQL Master Server
                scp -rp $jars/see_existed.sql ${user}@${master_mysql_ip}:/home/${user}/see_existed.sql > /dev/null
                ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} < see_existed.sql" >> $jars/existed.log 2> /dev/null
                echo > $jars/see_existed.sql 
            done

            ## 刪除訊息：password Warning, Table doesn't exist, count 0, blank line
            sed -i '/Warning/d' $jars/existed.log
            sed -i '/ERROR 1146/d' $jars/existed.log
            sed -i '/^0/d' $jars/existed.log
            sed -i '/^$/d' $jars/existed.log

            ## 若 existed.log 的 size 仍 > 0
            if [[ -s $jars/existed.log ]]; 
            then 
                ## 逐行列印資料表筆數的資訊
                while read line; 
                do
                    echo "$(echo $line | cut -d '#' -f 2) 這張表內有 $(echo $line | cut -d '#' -f 1) 筆資料，故暫停執行 DROP TABLE 指令"
                done < $jars/existed.log

                echo ''
                echo '也請向需求人員與 DBA 說明此事，也告知檔案名稱及上述訊息'
                echo '此次更新工作到此結束(全部皆未執行)，感謝協助' | $log
                echo '======================================'

                msg='ERROR: 帶 DROP TABLE 指令，但是資料表內有 records'
                MsgToBot

                ## 刪除檔案
                rm -rf $jars/existed.log

            ## 若 existed.log 的 size == 0
            else 
                ## 檢查是否有虛擬變數
                if [[ -z `grep -i 'SET @' $jars/update.sql` ]];
                then 
                    RunSQL_one

                ## SQL 檔案中帶有虛擬變數
                else
                    RunSQL_all
                fi
            fi
        fi

    ## Transaction 格式不完整
    else
        echo ''
        echo '確認 Transaction 格式有誤' | $log
        echo '請聯絡 DBA 說明此事，也告知檔案名稱及上述訊息，以利後續檢查'
        echo '此次更新工作到此結束(全部未執行)，感謝協助' | $log
        echo '======================================'

        msg='ERROR: 經確認 Transaction 格式有誤'
        MsgToBot
    fi

## 帶有 SELECT/TRUNCATE 語法
else
    echo ''
    echo '本檔案帶有 SELECT/TRUNCATE 語法' | $log
    echo '請向需求人員與 DBA 說明此事，也告知檔案名稱及上述訊息'
    echo '此次更新工作到此結束(全部未執行)，感謝協助' | $log
    echo '======================================'

    msg='ERROR: 本檔案帶有 SELECT/TRUNCATE 語法'
    MsgToBot
fi
