#!/bin/bash
#################################################
# Project: 修正資料表與欄位之文字編碼
# Branch: 
# Author: Gok, the DBA
# Created: 2022-10-03
# Updated: 2022-10-03
# Note: 主要是把 latin1 的編碼改成 uft8
#################################################

#user=`whoami`
#WhH=$(echo `who -m` | cut -d ' ' -f 1)
#date=`date +%Y-%m-%d-%H:%M:%S`
#jars="/data"
#log="tee -a $jars/log/andy-${WhH}-${date}.log"
#master_mysql_ip='10.23.1.180'
#PWW='1qaz@WSX'


if [[ -n `grep -i 'USE ' $jars/update.sql` ]]; 
then 
    key_db=`grep -i 'USE ' $jars/update.sql | sed 's/;//g' | cut -d ' ' -f 2`
else 
    key_db='global_3rd_db'
fi

token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
    # VS 與 DM 可能不同
title='CORRECT the CHARACTER SET and COLLATE on Table or Column'



function MsgToBot() {
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

${msg}" > /dev/null 2>&1
}


alter_table_before="
    SELECT concat('Alter table ', table_schema, '.', table_name, ' CHARACTER SET = utf8; ALTER TABLE ', table_schema, '.', table_name, ' COLLATE = utf8_general_ci;')
    FROM information_schema.TABLES T,
        information_schema.COLLATION_CHARACTER_SET_APPLICABILITY CCSA
    WHERE CCSA.collation_name = T.table_collation
    AND T.table_schema = '$key_db'
    AND CCSA.character_set_name = 'latin1'
    ;"
echo $alter_table_before | sudo tee $jars/alter_table_before.sql > /dev/null
scp -rp $jars/alter_table_before.sql ${user}@${master_mysql_ip}:/home/${user}/alter_table_before.sql > /dev/null 2>&1
ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/alter_table_before.sql;' > /home/${user}/alter_table_then.sql" > $jars/alter_table_output.log 2> /dev/null
echo '開始執行表格編碼修正' | $log > /dev/null
ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/alter_table_then.sql;'" 2> /dev/null

msg=`ssh ${user}@${master_mysql_ip} "cat /home/${user}/alter_table_then.sql"`
MsgToBot
ssh ${user}@${master_mysql_ip} "rm -rf /home/${user}/alter_table_before.sql"
ssh ${user}@${master_mysql_ip} "rm -rf /home/${user}/alter_table_then.sql"

msg=`cat $jars/alter_table_output.log`
MsgToBot
sudo rm $jars/alter_table_output.log



modify_column_before="
    select concat('alter table ', table_schema, '.', table_name, ' modify column ', column_name, space(1), column_type, ' CHARACTER SET utf8 COLLATE utf8_general_ci ', if(is_nullable = 'YES', 'DEFAULT NULL', 'NOT NULL'), ' COMMENT ', quote(column_comment), ';') 
    from information_schema.columns 
    where table_schema = '$key_db' 
        and character_set_name = 'latin1'
    ;"
echo $modify_column_before | sudo tee $jars/modify_column_before.sql > /dev/null
scp -rp $jars/modify_column_before.sql ${user}@${master_mysql_ip}:/home/${user}/modify_column_before.sql > /dev/null 2>&1
ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/modify_column_before.sql;' > /home/${user}/modify_column_then.sql" > $jars/modify_column_output.log 2> /dev/null

echo '開始執行欄位編碼修正' | $log > /dev/null
ssh ${user}@${master_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'USE ${key_db}; SOURCE /home/${user}/modify_column_then.sql;'" 2> /dev/null

msg=`ssh ${user}@${master_mysql_ip} "cat /home/${user}/modify_column_then.sql"`
MsgToBot
ssh ${user}@${master_mysql_ip} "rm -rf /home/${user}/modify_column_before.sql"
ssh ${user}@${master_mysql_ip} "rm -rf /home/${user}/modify_column_then.sql"

msg=`cat $jars/modify_column_output.log`
MsgToBot
sudo rm $jars/modify_column_output.log

