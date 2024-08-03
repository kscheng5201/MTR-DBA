#!/bin/bash
#################################################
# Project: Execute the SQL file
# Branch: 
# Author: Gok, the DBA
# Created: 2022-09-01
# Updated: 2023-02-21
# Note: 修正 SELECT 不阻擋子查詢機制
#################################################

#user=`whoami`
#WhH=$(echo `who -m` | cut -d ' ' -f 1)
#date=`date +%Y-%m-%d-%H:%M:%S`
#jars="/data"
#log="tee -a $jars/log/andy-${WhH}-${date}.log"
#master_mysql_ip='10.23.1.180'
#PWW='1qaz@WSX'

## 把多空白修改為單一空白
sed -i 's/[ ]\+/ /g' $jars/update.sql
## 去除分號之前的空白
sed -i 's/ ;/;/g' $jars/update.sql

sql_syntax=`grep -v '\-\- ' $jars/update.sql`
ls=`ls`


if [[ -n `grep -i 'USE ' $jars/update.sql` ]]; 
then 
    key_db=`grep -i 'USE ' $jars/update.sql | sed 's/;//g' | cut -d ' ' -f 2`
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
    if [[ `grep -i 'DELETE FROM' $jars/update.sql | wc -l` -lt 1 ]]; 
    then 
        echo ''
        echo "確認此檔案僅 $(grep -i 'DELETE FROM' $jars/update.sql | wc -l) 個 DELETE 指令"
        echo '開始執行此檔案'
        rm -rf $jars/output.log

        if [[ -z `grep -iE 'SET @|font size' $jars/update.sql` ]];
        then 
            for i in $(seq 1 `grep ';' $jars/update.sql | wc -l`); 
            do             
                sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
                echo ''
                echo "${sql_single//$(echo $ls)/*}" ';' | sudo tee $jars/update_slide.sql
                scp -rp $jars/update_slide.sql ${user}@${master_mysql_ip}:/home/${user}/update.sql > /dev/null 2>&1
                ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/update.sql;'" >> $jars/output.log 2>&1
                sudo rm $jars/update_slide.sql
            done
        else 
            echo ''
            echo "這檔案中有 `grep -iE 'SET @|font size' $jars/update.sql | wc -l` 個特殊狀況，所以全部指令一起執行"

            for i in $(seq 1 `grep ';' $jars/update.sql | wc -l`); 
            do             
                sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
                echo ''
                echo "${sql_single//$(echo $ls)/*}" ';'
            done

            scp -rp $jars/update.sql ${user}@${master_mysql_ip}:/home/${user}/update.sql > /dev/null 2>&1
            ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/update.sql;'" >> $jars/output.log 2>&1
        fi

        sed -i '/Warning/d' $jars/output.log 2> /dev/null
        echo '...'
        echo 'SQL 執行完畢'
        echo '檢查是否全部成功'

        if [[ -s $jars/output.log ]]; 
        then 
            echo ''
            echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep ';' | wc -l) 個指令" | $log
            echo '部分錯誤訊息如下' | $log
            cat $jars/output.log | cut -d ':' -f 3
            cat $jars/output.log >> $jars/log/andy-${WhH}-${date}.log

            echo ''
            echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
            echo '此次更新工作到此結束(部分已執行)，感謝協助' | $log
            echo '======================================'

            msg='ERROR: SQL 部分執行成功'
            MsgToBot
            msg=`cat $jars/output.log`
            MsgToBot

        else 
            echo ''
            echo 'SQL 全部執行成功' | $log
            echo "共完成 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep ';' | wc -l) 個指令" | $log

            echo ''
            echo '請於群組告知此工作已完成，並請需求人員確認資料現況'                
            echo '此次更新工作到此結束(全部已執行)，感謝協助' | $log
            echo '======================================'

            msg='Info: SQL 全部執行成功'
            MsgToBot

        fi
    else
        echo ''
        echo "這個檔案有 $(grep -i 'DELETE FROM' $jars/update.sql | wc -l) 個 DELETE 指令，分別為"

        for i in $(seq 1 `grep ';' $jars/update.sql | wc -l`);
        do
            echo $sql_syntax | cut -d ';' -f $i | grep -i 'DELETE FROM'
        done
        echo "請聯絡需求人員，確認要執行這些指令？並告知檔案名稱及上述訊息"

        read -ep '經與需求人員確認後，確定要執行這些刪除指令？(Yes/No)' ans
        answer=$ans
        shopt -s nocasematch

        if [[ "${answer,,}" =~ ^(YES|Y) ]];
        then
            echo ''
            echo '開始執行此檔案'
            rm -rf $jar/output.log

            if [[ -z `grep -iE 'SET @|font size' $jars/update.sql` ]];
            then 
                for i in $(seq 1 `grep ';' $jars/update.sql | wc -l`); 
                do             
                    sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
                    echo ''
                    echo "${sql_single//$(echo $ls)/*}" ';' | sudo tee $jars/update_slide.sql
                    scp -rp $jars/update_slide.sql ${user}@${master_mysql_ip}:/home/${user}/update.sql > /dev/null 2>&1
                    ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/update.sql;'" >> $jars/output.log 2>&1
                    sudo rm $jars/update_slide.sql
                done
            else 
                echo ''
                echo "這檔案中有 `grep -iE 'SET @|font size' $jars/update.sql | wc -l` 個特殊狀況，所以全部指令一起執行"

                for i in $(seq 1 `grep ';' $jars/update.sql | wc -l`); 
                do             
                    sql_single=`echo ${sql_syntax} | cut -d ';' -f $i`
                    echo ''
                    echo "${sql_single//$(echo $ls)/*}" ';'
                done

                scp -rp $jars/update.sql ${user}@${master_mysql_ip}:/home/${user}/update.sql > /dev/null 2>&1
                ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/update.sql;'" >> $jars/output.log 2>&1
            fi

            sed -i '/Warning/d' $jars/output.log 2> /dev/null
            echo '...'
            echo 'SQL 執行完畢'
            echo '檢查是否全部成功'

            if [[ -s $jars/output.log ]]; 
            then 
                echo ''
                echo "共執行 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep ';' | wc -l) 個指令" | $log
                echo '部分錯誤訊息如下' | $log
                cat $jars/output.log | cut -d ':' -f 3
                cat $jars/output.log >> $jars/log/andy-${WhH}-${date}.log

                echo ''
                echo '請於群組告知此工作已完成，並說明上述錯誤訊息，並請需求人員確認資料現況'
                echo '此次更新工作到此結束(部分已執行)，感謝協助' | $log
                echo '======================================'

                msg='ERROR: SQL 部分執行成功'
                MsgToBot
                msg=`cat $jars/output.log`
                MsgToBot

            else 
                echo ''
                echo 'SQL 全部執行成功' | $log
                echo "共完成 $(grep -ivE 'USE |BEGIN|COMMIT' $jars/update.sql | grep ';' | wc -l) 個指令" | $log

                echo ''
                echo '請於群組告知此工作已完成，並請需求人員確認資料現況'                
                echo '此次更新工作到此結束(全部已執行)，感謝協助' | $log
                echo '======================================'

                msg='Info: SQL 全部執行成功'
                MsgToBot

            fi

        else
            echo ''
            echo '請確認後再來執行' | $log
            echo '若需求人員要修改 DELETE 內容，請當事人提供一份新的檔案，再重新執行此流程' | $log
            echo '此次更新工作到此結束(全部未執行)，感謝協助' | $log
            echo '======================================'

            msg='Warning: 1+ DELETE 指令，與需求人員待確認'
            MsgToBot
        fi
    fi
    rm -rf $jars/output.log
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

if [[ -z `grep -iE 'SELECT |TRUNCATE ' $jars/update.sql` ]]; 
then 
    echo ''
    echo '經確認，本檔案無夾帶 SELECT 或 TRUNCATE 相關指令'
    echo '繼續後續檢查'

    if [[ `cat $jars/update.sql | grep -i 'BEGIN;' | wc -l` = `cat $jars/update.sql | grep -i 'COMMIT;' | wc -l` ]]; 
    then 
        echo ''
        echo '經確認，Transaction 格式完整'
        echo '繼續後續檢查'

        sed -i 's/DROP TABLE IF EXISTS/DROP TABLE/gi' $jars/update.sql
        drops=`grep -i 'DROP TABLE' $jars/update.sql | sed 's/^[[:blank:]]*//' | cut -d ' ' -f 3 | sed 's/;//g' | cut -d . -f 2`
        if [[ -n $drops ]];
        then 
            echo ''
            echo '檔案內有 DROP TABLE 指令，檢查是否該資料表已存在，或是表內已有資料'
            rm -rf $jars/see_existed.sql

            for table in $drops; 
            do 
                see_existed="
                    select concat_ws('#', count(*), '$table')
                    from $key_db.$table
                    ;"
                echo "${see_existed}" >> $jars/see_existed.sql 
            done
            # cat see_existed.sql
            # mysql -sN -uroot -p${PWW} -e "source see_existed.sql" > existed.log 2>&1

            scp -rp $jars/see_existed.sql ${user}@${master_mysql_ip}:/home/${user}/see_existed.sql > /dev/null 2>&1
            ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'source see_existed.sql'" > $jars/existed.log 2>&1
            result=`cat $jars/existed.log | grep -ivE 'Warning|ERROR 1146' | grep -v 0`


            if [[ -z $result ]]; 
            then 
                echo ''
                echo '現有資料不會受到 DROP TABLE 指令所影響'
                echo '繼續後續檢查'

                RunSQL
            else 
                echo ''
                echo '發現不妙...' | $log

                for m in $result; 
                do 
                    echo "$(echo $m | cut -d '#' -f 2) 這張表內有 $(echo $m | cut -d '#' -f 1) 筆資料" | $log
                done 

                echo ''
                echo '請聯絡需求人員，確認這張資料表真的要刪除？並告知檔案名稱及上述訊息'
                echo '也請向 DBA 說明此事，也告知檔案名稱及上述訊息'
                echo '此次更新工作到此結束(全部未執行)，感謝協助' | $log
                echo '======================================'

                msg='ERROR: 帶 DROP TABLE 指令，但是目標資料表內有 records'
                MsgToBot
            fi

            rm $jars/existed.log
        else 
            echo ''
            echo '檔案沒有 DROP TABLE 指令'
            echo '繼續後續檢查'
            RunSQL
        fi


    else 
        echo ''
        echo '經確認 Transaction 格式有誤' | $log
        echo '請聯絡 DBA 說明此事，也告知檔案名稱及上述訊息，以利後續檢查'
        echo '此次更新工作到此結束(全部未執行)，感謝協助' | $log
        echo '======================================'

        msg='ERROR: 經確認 Transaction 格式有誤'
        MsgToBot
    fi
else 
    echo ''
    echo '本檔案帶有 SELECT/TRUNCATE 語法' | $log
    echo '請向需求人員與 DBA 說明此事，也告知檔案名稱及上述訊息'
    echo '此次更新工作到此結束(全部未執行)，感謝協助' | $log
    echo '======================================'

    msg='ERROR: 本檔案帶有 SELECT/TRUNCATE 語法'
    MsgToBot
fi
