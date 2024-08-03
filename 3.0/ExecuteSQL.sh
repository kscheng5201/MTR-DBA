#!/bin/bash
#################################################
# Project: Execute the PostgreSQL file
# Branch: 
# Author: Gok, the DBA
# Created: 2024-02-07
# Updated: 2024-02-07
# Note: port-forward 從本 script 分開
#################################################

#user=`whoami`
    ## 要用 centos 身分登入
#WhH=$(echo `who -m` | cut -d ' ' -f 1)
#date=`date +%Y-%m-%d-%H:%M:%S`
#jars=/data
#log="tee -a $jars/log/andy-${WhH}-${date}.log"


## 刪除舊檔案
rm -rf $jars/crud/postgres/`date +"%F"`/*

## 上傳 SQL 檔案
mkdir -p $jars/crud/postgres/`date +"%F"`

cd $jars/crud/postgres/`date +"%F"`
rz -E &&

if [[ $? != 0 ]];
then 
    echo "ERROR: 上傳 SQL 檔案失敗！請重新上傳"
    exit 0
else
    echo "INFO: 上傳 SQL 檔案成功！"
    echo '======'
fi

newsql=$(ls $jars/crud/postgres/`date +"%F"` | head -n 1 | awk '{print $NF}')
rm -f $jars/update.sql
ln -s $jars/crud/postgres/`date +"%F"`/$newsql $jars/update.sql


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


## 隨機產生 Port 號的機制
function GetPort {
    port=`date +%s | tail -c 6`

    if [[ $port -gt 65535 ]];
    then
        port=`expr $port - 65535`
    fi
}

## 執行 SQL 指令
echo 
read -ep "請問要執行的指令是在前台 (cs) 還是後台 (plt): " stage
echo '======'

if [[ $stage == 'plt' ]]; 
then 
    port=`ps -aux | grep port-forward | grep $stage | grep -v grep | tail -c 11 | cut -d : -f 1`
    puser='plt_java_app'
    pass='qPN78eYLy99jKkfT'

    if [[ -z $port ]];
    then
        echo '請先執行「3.0-PROD PostgreSQL 連線設置」，再回來執行「3.0-PROD PostgreSQL 語法執行」'
        exit 0
    else
        echo 執行 SQL 檔案
        PGPASSWORD=$pass psql -h localhost -p $port -U $puser postgres -f $jars/update.sql

        # echo Kill Process
        #ps -aux | grep port-forward | grep $port | awk '{print $2}' | sudo xargs kill 2> /dev/null
    fi

elif [[ $stage == 'cs' ]];    
then
    port=`ps -aux | grep port-forward | grep $stage | grep -v grep | tail -c 11 | cut -d : -f 1`
    puser='cs_java_app'
    pass='K722nWRFZMKHLn5N'

    if [[ -z $port ]];
    then
        echo '請先執行「3.0-PROD PostgreSQL 連線設置」，再回來執行「3.0-PROD PostgreSQL 語法執行」'
        exit 0

    else
        echo 執行 SQL 檔案
        PGPASSWORD=$pass psql -h localhost -p $port -U $puser postgres -f $jars/update.sql

        # echo Kill Process
        #ps -aux | grep port-forward | grep $port | awk '{print $2}' | sudo xargs kill 2> /dev/null
    fi

else
    echo no this stage
fi



## 僅保留前一個月的所有 SQL 檔案
rm -rf $jars/crud/postgres/`date -d "-2 month" +"%Y-%m"`*
