#!/bin/bash
#########################################################
# Project: Manaully Rebalance the replica for b site sync
# Branch: 
# Author: Gok, the DBA
# Created: 2023-06-20
# Updated: 2023-06-26
# Note: 此腳本放在 b 站的 elasticsearch backend 主機上
#########################################################


data_dir=/etc/dba

#### 先設定 cluster 為不可自動分配的模式
curl -X PUT "`hostname`:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d' { "persistent": { "cluster.routing.rebalance.enable": "none" }}'
##############################################################################################
## cluster.routing.rebalance.enable
## (Dynamic) Enable or disable rebalancing for specific kinds of shards:
# all - (default) Allows shard balancing for all kinds of shards.
# primaries - Allows shard balancing only for primary shards.
# replicas - Allows shard balancing only for replica shards.
# none - No shard balancing of any kind are allowed for any indices.
# Ref: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-cluster.html
##############################################################################################


#### 檢查 b 站 node 是否有拿到任何的 primary shards
primary_in_b=$(curl -XGET `hostname`:9200/_cat/shards | awk '$3 == "p"' | grep -c `hostname`)

if [[ $primary_in_b -gt 0 ]]; 
then 
    echo CRITICAL ISSUE!!!!!!!
    curl -XGET `hostname`:9200/_cat/shards | awk '$3 == "p"' | grep `hostname` | awk '{print $1}' | sort | uniq
    exit
else 
    echo It is ALRIGHT! Keep Going this Programming.
fi



#### 拿到所有 gl_* 的 index
indices=$(curl -XGET `hostname`:9200/_cat/indices/gl_* | awk '{print $3}')

#### 迴圈逐一檢查 index 並處理
for i in $indices; 
do 
    #### 取得各 index 的 primary shards 總數
    shards=$(curl -XGET `hostname`:9200/_cat/indices/$i | awk '{print $5}')
    #### 現在 b 站已拿到的 replica shards 總數
    replica_in_b=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep -c `hostname`)

    #### 若以上兩者數目不相等才會進入此項處理
    if [[ $shards -gt $replica_in_b ]];
    then 
        for r in $(seq 0 `expr $shards - 1`); 
        do
            #### 產生檢查用之參考檔案
            echo $r >> $data_dir/$i.shards
        done

        #### 取得 b 站持有之 replica shards 編號
        replicas=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep `hostname` | awk '{print $2}')

        #### 逐一檢查，讓參考檔案僅留下要處理的 replica shards 名單
        for b in $replicas;
        do
            sed -i "/$b/d" $data_dir/$i.shards
        done 

        #### 針對要處理的 replica shards 逐一移置
        for c in `cat $data_dir/$i.shards`;
        do 
            #### 找一個有目標 replica shards 的 node
            source=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep "$c r" | head -1 | awk '{print $8}')
            #### 將 reroute API 的指令輸出到另一檔案
            cat << EOF > $data_dir/reroute.sh
                curl -X POST `hostname`:9200/_cluster/reroute?metric=none -H 'Content-Type: application/json' -d'
                {
                    "commands": [
                        {
                        "move": {
                            "index": "$i", "shard": $c,
                            "from_node": "$source", "to_node": "`hostname`"
                            }
                        }
                    ]
                }
                '
EOF

            #### 執行 reroute API 指令
            sh $data_dir/reroute.sh
            #### 刪除 reroute API 的指令檔
            rm -rf $data_dir/reroute.sh
        done            
    fi

    #### 刪除檢查用之參考檔案
    rm -rf $data_dir/$i.shards



    #### 檢查若 replica shards 在源站 node 是否分配不均
    if [[ $shards -eq 3 ]]; 
    then 
        avg=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep -v `hostname` | awk '{print $8}' | sort | uniq -c | sort -k 8 | awk '{print $1}' | tail -1)
        if [[ $avg -ne 2 ]]; 
        then 
            ## 取得有分配平衡的那台 node
            fit=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep -v `hostname` | awk '{print $8}' | sort | uniq -c | awk '$1 == 2' | awk '{print $2}')
            ## 取得少分配那台 node 自身已持有的 primary shards
            target_n=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep -v `hostname` | awk '{print $8}' | sort | uniq -c | head -1 | awk '{print $2}')
            target_p=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep $target_n | awk '$3 == "p"' | awk '{print $2}') 
            ## 取得多分配那台 node 該分配出來的 replica shards            
            source_n=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep -v `hostname` | awk '{print $8}' | sort | uniq -c | tail -1 | awk '{print $2}')
            source_r=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep $source_n | awk '$3 == "r"' | grep -v " $target_p " | awk '{print $2}') 

            cat << EOF > $data_dir/reroute.sh
                curl -X POST `hostname`:9200/_cluster/reroute?metric=none -H 'Content-Type: application/json' -d'
                {
                    "commands": [
                        {
                        "move": {
                            "index": "$i", "shard": $source_r,
                            "from_node": "$source_n", "to_node": "$target_n"
                            }
                        }
                    ]
                }
                '
EOF

            #### 執行 reroute API 指令
            sh $data_dir/reroute.sh
            #### 刪除 reroute API 的指令檔
            rm -rf $data_dir/reroute.sh
        fi

    else
        ## 若 primary shards 總數 >3
        if [[ $shards -gt 3 && `expr $shards % 3` -ne 0 ]]; 
        then
            echo index $i 有 $shards primary shards 且 $shards 不是 3 的倍數，先不處理
        fi

    fi
done
        


#### 結束後維持設定，cluster 不改回可自動分配 replica 的模式
# curl -X PUT `hostname`:9200/_cluster/settings?pretty -H 'Content-Type: application/json' -d' { "persistent": { "cluster.routing.rebalance.enable": "replicas" }}'