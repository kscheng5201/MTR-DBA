
#!/bin/bash
#################################################
# Project: Extract the DDL of SQL file
# Branch: 
# Author: Gok, the DBA
# Created: 2022-12-01
# Updated: 2022-12-01
# Note: 抽出檔案中的 DDL 語句
#################################################
jars="/data"
sql_syntax=`grep -v '\-\- ' $jars/update.sql`

echo '======================================'
echo '開始檢查檔案中的 DDL 語句'
echo '......'

if [[ -z `grep -iE 'CREATE TABLE|DROP TABLE|ALTER TABLE|TRUNCATE TABLE'  $jars/update.sql` ]];
then 
    echo 
    echo '本檔案未包含 DDL(Data Definition Languages) 語句'
else
    echo ''
    echo '本檔案有包含的 DDL(Data Definition Languages) 語句如下：'
    echo ''
    
    for i in $(seq 1 `grep ';' $jars/update.sql | wc -l`);
    do
        echo $sql_syntax | cut -d ';' -f $i | grep -iE 'CREATE TABLE|DROP TABLE|ALTER TABLE|TRUNCATE TABLE'
        
        if [[ -n `echo $sql_syntax | cut -d ';' -f $i | grep -iE 'CREATE TABLE|DROP TABLE|ALTER TABLE|TRUNCATE TABLE'` ]]; 
        then 
            echo ';'
        fi
    done 
fi

echo ''
echo '再請協助將上述羅列的 DDL 語句複製到紀錄表中，感謝。'
echo ''
