#!/bin/bash
#################################################
# Project: Execute the MongoDB file
# Branch: 
# Author: Gok, the DBA
# Created: 2024-01-30
# Updated: 2024-01-30
# Note: SM-Prod
#################################################

#user=`whoami`
    ## 要用 centos 身分登入
#WhH=$(echo `who -m` | cut -d ' ' -f 1)
#date=`date +%Y-%m-%d-%H:%M:%S`
#jars=/data
#log="tee -a $jars/log/andy-${WhH}-${date}.log"


## 上傳 SQL 檔案
cd $jars/op-rd-sql
rz -E &&

if [[ $? != 0 ]];
then 
    echo "ERROR: 上傳檔案失敗！請重新上傳"
    exit 0
else
    echo "INFO: 上傳檔案成功！"
    echo '======'
fi


newsql=$(ls -p -t $jars/op-rd-sql | grep -v / | head -1)
rm -f $jars/mongo.js
ln -s $jars/op-rd-sql/$newsql $jars/mongo.js


## 清理 SQL 檔案內容
# 連續空白修改為單一空白
sed -i 's/[ ]\+/ /g' $jars/mongo.js
# 去除分號之前的空白
sed -i 's/ ;/;/g' $jars/mongo.js
# 刪除每一行的 leading space
sed -i 's/^[[:blank:]]*//' $jars/mongo.js
# 去除空白行
sed -i '/^$/d' $jars/mongo.js
# 去除 # 為首的註解行
sed -i '/^#/d' $jars/mongo.js
# 去除 -- 為首的註解行
sed -i '/^--/d' $jars/mongo.js


## 執行 SQL 指令
user='root'
pass='drPstAZxE3-TQ9cAbKp.SVaDnmsafaM9'
deployment='b-mongo.4tpgp.mongodb.net'

echo 
echo 您即將進入 SM-Prod 的 Mongodb 進行操作......
echo 以下為 SM-Prod 的 Mongodb 底下的所有名稱
echo ======
mongosh "mongodb+srv://${user}:${pass}@${deployment}/" --eval "show dbs" | awk '{print $1}' | grep ^saas

echo 
read -ep "請輸入欲執行的資料庫名稱，一次一個：" dbname
echo 此次要執行的資料庫名稱為： $dbname
echo ======

## 執行指令
mongosh "mongodb+srv://${user}:${pass}@${deployment}/${dbname}" < $jars/mongo.js 2>> $jars/op-rd-sql/${newsql}.error 
echo 

error=$(grep -ic ERROR $jars/op-rd-sql/${newsql}.error)
if [[ $error -gt 0 ]]; 
then 
    echo "本次執行 $newsql 遭遇 $error 次錯誤！"
    echo '詳細的錯誤訊息如下：'
    grep -ic ERROR $jars/op-rd-sql/${newsql}.error
else
    echo "本次執行 $newsql 沒有遭遇錯誤！"
    rm -rf $jars/op-rd-sql/${newsql}.error
fi

## 僅保留這一個月的所有 SQL 檔案
del_files=$(ls -lp $jars/op-rd-sql | grep -v / | awk '{print $6, $NF}' | grep `date -d "-1 month" +%b` | awk '{print $2}')
for df in $del_files; 
do 
    rm -rf $jars/op-rd-sql/$df
done
