#!/bin/bash
#################################################
# Project: Execute the SQL file
# Branch: 
# Author: Gok, the DBA
# Created: 2022-09-01
# Updated: 2022-09-02
# Note: 檢查檔案內容並執行 SQL
#################################################

user=`whoami`
master_mysql_ip='10.21.1.180'
PWW='1qaz@WSX'
sql_syntax=`cat update.sql`

if [[ -n `grep -i 'USE ' update.sql` ]]; 
then 
    key_db=`grep -i 'USE ' update.sql | sed 's/;//g' | cut -d ' ' -f 2`
else 
    key_db='global_3rd_db'
fi

token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title='Execute SQL by OPeration Team'


function MsgToBot() {
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

${msg}" > /dev/null 2>&1
}

function RunSQL() {
    if [[ `grep -i DELETE update.sql | wc -l` -lt 2 ]]; 
    then 
        echo ''
        echo '確認此檔案僅 $(grep -i DELETE update.sql | wc -l) 個 DELETE 指令'
        echo '開始執行此檔案'

        for i in $(seq 1 `grep ';' update.sql | wc -l`); 
        do 
            sql_single=`echo $sql_syntax | cut -d ';' -f $i`
            echo ''
            echo ${sql_single} ';'
            mysql -sN -uroot -p${PWW} -e "USE ${key_db}; ${sql_single};" >> output.log 2>&1
        done
        sed -i '/Warning/d' output.log
        echo '...'
        echo 'SQL 執行完畢'
        echo '檢查是否全部成功'

        if [[ -s output.log ]]; 
        then 
            echo ''
            echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' update.sql | grep ';' | wc -l) 個指令"
            echo '部分錯誤訊息如下'
            cat output.log
            echo '此次更新工作到此結束，感謝協助'
            echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
            msg='ERROR: SQL 部分執行成功'
            MsgToBot
            msg=`cat output.log`
            MsgToBot
        else
            echo ''
            echo 'SQL 全部執行成功'
            echo "共完成 $(grep -ivE 'USE |BEGIN|COMMIT' update.sql | grep ';' | wc -l) 個指令"
            echo ''
            echo '此次更新工作到此結束，感謝協助'
            echo '請於群組告知此工作已完成，並請需求人員確認資料現況'
            msg='Info: SQL 全部執行成功'
            MsgToBot
        fi
    else
        echo ''
        echo "這個檔案有 $(grep -i DELETE update.sql | wc -l) 個 DELETE 指令，分別為"

        for i in $(seq 1 `grep ';' update.sql | wc -l`);
        do
            sql_single=`echo $sql_syntax | cut -d ';' -f $i`
            grep -i DELETE <<< "$sql_single"
        done
        echo "請聯絡需求人員，確認要執行這些指令？並告知檔案名稱及上述訊息"

        read -ep '經與需求人員確認後，確定要執行這些刪除指令？(Yes/No)' ans
        answer=$ans
        shopt -s nocasematch

        if [[ "${answer,,}" =~ ^(YES|Y) ]];
        then
            echo ''
            echo '開始執行此檔案'
            for i in $(seq 1 `grep ';' update.sql | wc -l`); 
            do 
                sql_single=`echo $sql_syntax | cut -d ';' -f $i`
                echo ${sql_single} ';'
                mysql -sN -uroot -p${PWW} -e "USE ${key_db}; ${sql_single};" >> output.log 2>&1
            done

            sed -i '/Warning/d' output.log
            echo '...'
            echo 'SQL 執行完畢'
            echo '檢查是否全部成功'

            if [[ -s output.log ]]; 
            then 
                echo ''
                echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' update.sql | grep ';' | wc -l) 個指令"
                echo '部分錯誤訊息如下'
                cat output.log
                echo '此次更新工作到此結束，感謝協助'
                echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
                msg='ERROR: SQL 部分執行成功'
                MsgToBot
                msg=`cat output.log`
                MsgToBot
            else
                echo ''
                echo 'SQL 全部執行成功'
                echo "共完成 $(grep -ivE 'USE |BEGIN|COMMIT' update.sql | grep ';' | wc -l) 個指令"
                echo ''
                echo '此次更新工作到此結束，感謝協助'
                echo '請於群組告知此工作已完成，並請需求人員確認資料現況'
                msg='Info: SQL 全部執行成功'
                MsgToBot
            fi

        else
            echo '請確認後再來執行'
            echo '若需求人員要修改 DELETE 內容，請當事人提供一份新的檔案，再重新執行此流程'
            msg='Warning: 3+ DELETE 指令，與需求人員待確認'
            MsgToBot
        fi
    fi
    
    rm output.log
}


echo ''
echo '更新 SQL 程式開始執行'
echo '...'
echo '說明：'
echo '若檢查到檔案內出現有疑慮的內容，整份檔案都不會被執行'
echo '只有在確認全部沒問題時，才會執行'
echo '每個檢查步驟都會有細部說明'
echo '...'
echo '以下開始'
echo '======================================'

if [[ `cat update.sql | grep -i BEGIN | wc -l` = `cat update.sql | grep -i 'COMMIT' | wc -l` ]]; 
then 
    echo ''
    echo '經確認，Transaction 格式完整'
    echo '繼續後續檢查'

    sed -i 's/DROP TABLE IF EXISTS/DROP TABLE/gi' update.sql
    drops=`grep -i 'DROP TABLE' update.sql | sed 's/^[[:blank:]]*//' | cut -d ' ' -f 3 | sed 's/;//g' | cut -d . -f 2`
    if [[ -n $drops ]];
    then 
        echo ''
        echo '檔案內有 DROP TABLE 指令，檢查是否該資料表已存在，或是表內已有資料'
        rm see_existed.sql

        for table in $drops; 
        do 
            see_existed="
                select concat_ws('#', count(*), '$table')
                from $key_db.$table
                ;"
            echo $see_existed >> see_existed.sql 
        done
        # cat see_existed.sql

        mysql -sN -uroot -p${PWW} -e "source see_existed.sql" > existed.log 2>&1
        result=`cat existed.log | grep -ivE 'Warning|ERROR 1146' | grep -v 0`


        if [[ -z $result ]]; 
        then 
            echo ''
            echo '現有資料不會受到 DROP TABLE 指令所影響'
            echo '繼續後續檢查'

            RunSQL
        else 
            echo ''
            echo '發現不妙...'

            for m in $result; 
            do 
                echo $(echo $m | cut -d '#' -f 2) 這張表內有 $(echo $m | cut -d '#' -f 1) 筆資料
            done 

            echo 請聯絡需求人員，確認這張資料表真的要刪除？並告知檔案名稱及上述訊息
            echo 也請向 DBA 說明此事，也告知檔案名稱及上述訊息

            rm see_existed.sql 
            msg='ERROR: 帶 DROP TABLE 指令，但是目標資料表內有 records'
            MsgToBot
        fi

        rm existed.log
    else 
        echo ''
        echo '檔案沒有 DROP TABLE 指令'
        echo '繼續後續檢查'
        RunSQL
    fi


else 
    echo ''
    echo '經確認 Transaction 格式有誤'
    echo '請聯絡 DBA 說明此事，也告知檔案名稱及上述訊息，以利後續檢查'
    msg='ERROR: 經確認 Transaction 格式有誤'
    MsgToBot
fi
