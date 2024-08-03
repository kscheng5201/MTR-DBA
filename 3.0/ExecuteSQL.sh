#!/bin/bash
#################################################
# Project: Execute the PostgreSQL file
# Branch: 
# Author: Gok, the DBA
# Created: 2023-11-08
# Updated: 2024-01-31
# Note: 優化 port-forward 建立機制
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
        ## 取得 port-forward 資訊
        svc=`kubectl get service -n sqlproxy | awk '{print $1}' | grep master | grep $stage`
        GetPort

        ## 進行 port-forward 連線
        kubectl -n sqlproxy port-forward service/$svc $port:5432 &
    
        ## 執行 SQL 檔案
        PGPASSWORD=$pass psql -h localhost -p $port -U $puser postgres -f $jars/update.sql

        ## Kill Process
        ps -aux | grep port-forward | grep $port | awk '{print $2}' | xargs kill 2> /dev/null
    else
        ## 執行 SQL 檔案
        PGPASSWORD=$pass psql -h localhost -p $port -U $puser postgres -f $jars/update.sql 
    fi

elif [[ $stage == 'cs' ]];    
then
    port=`ps -aux | grep port-forward | grep $stage | grep -v grep | tail -c 11 | cut -d : -f 1`
    puser='cs_java_app'
    pass='K722nWRFZMKHLn5N'

    if [[ -z $port ]];
    then
        ## 取得 port-forward 資訊
        svc=`kubectl get service -n sqlproxy | awk '{print $1}' | grep master | grep $stage`
        GetPort

        ## 進行 port-forward 連線
        kubectl -n sqlproxy port-forward service/$svc $port:5432 &

        ## 執行 SQL 檔案
        PGPASSWORD=$pass psql -h localhost -p $port -U $puser postgres -f $jars/update.sql

        ## Kill Process
        ps -aux | grep port-forward | grep $port | awk '{print $2}' | xargs kill 2> /dev/null
    else
        ## 執行 SQL 檔案
        PGPASSWORD=$pass psql -h localhost -p $port -U $puser postgres -f $jars/update.sql 
    fi
else
    echo no this stage
fi

## 僅保留前一個月的所有 SQL 檔案
rm -rf $jars/crud/postgres/`date -d "-2 month" +"%Y-%m"`*
