#!/bin/bash
##################################################
# Project: 從 nginx-logs 查找特定 uri
# Branch: 
# Author: Gok, the DBA
# Created: 2023-07-28
# Updated: 2023-08-01
# Note: 要先建立 uri 名單（uri.txt），才能實作
##################################################

data_dir=/etc/dba


## 取得近期七天（不包含今天）的 nginx-logs 的編號
nginxs=$(curl -XGET `hostname`:9200/_cat/indices/nginx* | awk '{print $3}' | cut -d _ -f 2 | sort -n | tail -8 | head -7)

## 迴圈執行近期七天（不包含今天）的 nginx-logs
for n in $nginxs;
do 
    ## 逐行讀取 uri 名單
    while read -r line; 
    do 
        ## 製作指令成腳本
        cat << EOF > $data_dir/$line_$n.sh
            curl -X GET `hostname`:9200/nginx-logs_$n/_search?pretty -H 'Content-Type: application/json' -d'
            {
              "query": { 
                "bool": { 
                  "filter": [ 
                    { "match": { "tags": "nginx-3rd" }},
                    { "match": { "uri": "$line" }}   
                  ]
                }
              }
            }
            ' | grep -A2 hits | grep value | awk '{print \$3}' | sed 's/.$//g' 
EOF

        ## 執行腳本
        hits=`sh $data_dir/$line_$n.sh`

        ## 寫入中繼檔案：只有 hits > 0 的 uri 才會寫入
        if [[ $hits -gt 0 ]];
        then
            echo -e $line ' \t ' $hits >> $data_dir/output.log 
        fi

        ## 刪除腳本
        rm -rf $data_dir/$line_$n.sh

    done < $data_dir/uri.txt
done


## 將 uri 名單重新製作成表格
while read -r line;
do
    ## 完全沒找到的 uri，直接寫 0
    if [[ `grep -c $line $data_dir/output.log` -eq 0 ]];
    then
        echo -e 0 '\t' $line >> $data_dir/countURI_`date +%F`.txt
    else
        ## 有找到的 uri，另存檔後計算、再寫入結果
        grep $line output.log > $data_dir/temp.log
        sum=`awk '{sum+=$2;}END{print sum;}' $data_dir/temp.log`
        echo -e $sum '\t' $line >> $data_dir/countURI_`date +%F`.txt
        ## 刪除暫存檔
        rm -rf $data_dir/temp.log
    fi
done < $data_dir/uri.txt

## 刪除中繼檔案
rm -rf $data_dir/output.log