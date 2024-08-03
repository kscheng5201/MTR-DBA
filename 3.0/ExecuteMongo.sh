#!/bin/bash
#################################################
# Project: Execute the MongoDB file
# Branch: 
# Author: Gok, the DBA
# Created: 2024-01-08
# Updated: 2024-01-10
# Note: 
#################################################

#user=`whoami`
    ## 要用 centos 身分登入
#WhH=$(echo `who -m` | cut -d ' ' -f 1)
#date=`date +%Y-%m-%d-%H:%M:%S`
#jars=/data
#log="tee -a $jars/log/andy-${WhH}-${date}.log"





## 上傳 SQL 檔案
mkdir -p $jars/crud/mongo/`date +"%F"`
## 刪除舊檔案
rm -rf $jars/crud/mongo/`date +"%F"`/*


cd $jars/crud/mongo/`date +"%F"`
rz -E &&

if [[ $? != 0 ]];
then 
    echo "ERROR: 上傳檔案失敗！請重新上傳"
    exit 0
else
    echo "INFO: 上傳檔案成功！"
    echo '======'
fi


newsql=$(ls $jars/crud/mongo/`date +"%F"` | head -n 1 | awk '{print $NF}')
rm -f $jars/mongo.sql
ln -s $jars/crud/mongo/`date +"%F"`/$newsql $jars/mongo.sql


## 清理 SQL 檔案內容
# 連續空白修改為單一空白
sed -i 's/[ ]\+/ /g' $jars/mongo.sql
# 去除分號之前的空白
sed -i 's/ ;/;/g' $jars/mongo.sql
# 刪除每一行的 leading space
sed -i 's/^[[:blank:]]*//' $jars/mongo.sql
# 去除空白行
sed -i '/^$/d' $jars/mongo.sql
# 去除 # 為首的註解行
sed -i '/^#/d' $jars/mongo.sql
# 去除 -- 為首的註解行
sed -i '/^--/d' $jars/mongo.sql


## 執行 SQL 指令
echo 
read -ep "請問要執行的指令是在前台 (cs) 還是後台 (plt): " stage
echo '======'

if [[ $stage == 'plt' ]]; 
then 
    deployment='ldpro-prod-atlas-plt-cl.mtrr1.mongodb.net'
    puser='prod_plt_java_app'
    ppass='b2X8mVxzPzk5AsQM'

    ## 執行指令
    mongosh "mongodb+srv://${puser}:${ppass}@${deployment}/" -f $jars/mongo.sql 2>> $jars/crud/mongo/`date +"%F"`/${newsql}.error | $log

    error=$(grep -ic ERROR $jars/crud/mongo/`date +"%F"`/${newsql}.error)
    if [[ $error -gt 0 ]]; 
    then 
        echo "本次執行 $newsql 遭遇 $error 次錯誤！"
        echo '詳細的錯誤訊息如下：'
        grep -ic ERROR $jars/crud/mongo/`date +"%F"`/${newsql}.error
    else
        echo "本次執行 $newsql 沒有遭遇錯誤！"
    fi
else 
    deployment='ldpro-prod-atlas-cs-clu.mtrr1.mongodb.net'
    puser='prod_cs_java_app'
    ppass='LmeHhyJK52UXwc2X'

    ## 執行指令
    mongosh "mongodb+srv://${puser}:${ppass}@${deployment}/" -f $jars/mongo.sql 2>> $jars/crud/mongo/`date +"%F"`/${newsql}.error

    error=$(grep -ic ERROR $jars/crud/mongo/`date +"%F"`/${newsql}.error)
    if [[ $error -gt 0 ]]; 
    then 
        echo "本次執行 $newsql 遭遇 $error 次錯誤！"
        echo '詳細的錯誤訊息如下：'
        grep -ic ERROR $jars/crud/mongo/`date +"%F"`/${newsql}.error
    else
        echo "本次執行 $newsql 沒有遭遇錯誤！"
    fi
fi

## 僅保留前一個月的所有 SQL 檔案
rm -rf $jars/crud/mongo/`date -d "-2 month" +"%Y-%m"`*