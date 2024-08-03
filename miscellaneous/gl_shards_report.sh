#!/bin/bash
###################################################
# Project: 寫入 gl_shards_report 的腳本
# Branch: 
# Author: Gok, the DBA
# Created: 2023-07-14
# Updated: 2023-08-02
# Note: 新增六項 index 欄位 
###################################################


data_dir=/etc/dba
backend_es='10.23.1.170'

## 取得所有 gl_ 的 indices
indices=$(curl -XGET $backend_es:9200/_cat/indices/gl_* | awk '{print $3}')

for i in $indices; 
do 
    ## 取得當前 index 的 primary & replica 數目
    p=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $5}')
    r=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $6}')

    ## 計算 shards 總數
    sum=`expr $p \* $r`
    sum=`expr $sum \* 2`

    for s in $(seq 1 $sum); 
    do 
        ## 逐一取得每個 index 的 shards 資訊並輸出
        curl -XGET $backend_es:9200/_cat/shards/$i?format=json | cut -d \} -f $s >> $data_dir/$i.json
    done

    ## 取得 index 相關六項資料
    health=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $1}')
    status=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $2}')
    docs_count=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $7}')
    docs_deleted=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $8}')
    store_size=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $9}')
    pri_store_size=$(curl -XGET $backend_es:9200/_cat/indices/$i | awk '{print $10}')    

    ## 依序加入到 JSON 檔案中
    sed -e "s/$/, \"health\": \"$health\"/" -i $data_dir/$i.json
    sed -e "s/$/, \"status\": \"$status\"/" -i $data_dir/$i.json
    sed -e "s/$/, \"docs_count\": \"$docs_count\"/" -i $data_dir/$i.json
    sed -e "s/$/, \"docs_deleted\": \"$docs_deleted\"/" -i $data_dir/$i.json
    sed -e "s/$/, \"store_size\": \"$store_size\"/" -i $data_dir/$i.json
    sed -e "s/$/, \"pri_store_size\": \"$pri_store_size\"/" -i $data_dir/$i.json

    ## 單一 index 的內容寫入綜合文件
    cat $data_dir/$i.json >> $data_dir/input.json
    rm -rf $data_dir/$i.json
done

## 填入時間欄位
sed -e "s/$/, \"updateTime\": \"`date +"%Y-%m-%d %H:%M:00"`\"}/" -i $data_dir/input.json
## 刪除起始的逗點符號
sed -e "s/^,//g" -i $data_dir/input.json


## 以迴圈建立寫入指令
while read lines; 
do 
    echo "curl -XPOST `hostname`:9200/gl_shards_report/gl_shards_report?pretty -H 'Content-Type: application/json' -d'" >> $data_dir/input.sh
    echo $lines >> $data_dir/input.sh
    echo "'" >> $data_dir/input.sh
done < $data_dir/input.json


echo "====== START INPUT at `date`" >> $data_dir/shardsReport.log
echo "the info before input: " >> $data_dir/shardsReport.log
curl -XGET `hostname`:9200/_cat/indices/gl_shards_report?format=json >> $data_dir/shardsReport.log

## 執行資料寫入
sh $data_dir/input.sh 2>> $data_dir/shardsReport.log

echo "the info after input: " >> $data_dir/shardsReport.log
curl -XGET `hostname`:9200/_cat/indices/gl_shards_report?format=json >> $data_dir/shardsReport.log
echo >> $data_dir/shardsReport.log



## 刪除資料
rm -rf $data_dir/input.json
rm -rf $data_dir/input.sh

