#!/bin/bash
date_dir=/etc/dba

#### 先設定 cluster 只可自動分配 replica 的模式
curl -X PUT "`hostname`:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d' { "persistent": { "cluster.routing.rebalance.enable": "replicas" }}'

## 取得所有 primary shards 分配不均的 index 名單
indices=$(curl -XGET `hostname`:9200/_cat/shards/gl_* | awk '$3 == "p"' | awk '{print $1, $8}' | sort | uniq -c | sort -k 2 | awk '$1 !=1' | awk '{print $2}' | sort | uniq | grep -vE 'gl_user_daily_report|gl_user_game_daily_report')

for i in $indices; 
do
    echo 
    echo i = $i
    avg=$(curl -XGET `hostname`:9200/_cat/shards/$i | awk '$3 == "p"' | awk '{print $8}' | sort | uniq -c | sort -nk 1 | tail -1 | awk '{print $1}')
    echo avg = $avg

    if [[ $avg -gt 1 ]]; 
    then
        echo hahahaha 
        ## 取得有多拿 primary shards 的那台 node
        source_n=$(curl -XGET `hostname`:9200/_cat/shards/$i | awk '$3 == "p"' | awk '{print $8}' | sort | uniq -c | sort -nk 1 | tail -1 | awk '{print $2}')
        ## 取得有多拿 primary shards 的那台 node，身上的 primary shards
        source_p=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep $source_n | awk '$3 == "p"' | awk '{print $2}')

        ## 取得尚未拿 primary shards 的那台 node
        target_n=$(curl -XGET `hostname`:9200/_cat/shards/$i | awk '$3 == "r"' | awk '{print $8}' | sort | uniq -c | awk '$1 > 1' | awk '{print $2}')
        echo 
        echo source_n $source_n
        echo source_p $source_p
        echo target_n $target_n


        for p in $source_p; 
        do
            echo 000000000000000000000000000        
            echo p == $p
            echo curl -XGET `hostname`:9200/_cat/shards/$i | grep $target_n | awk '{print $2}' | grep -c $p
            exam_v=$(curl -XGET `hostname`:9200/_cat/shards/$i | grep $target_n | awk '{print $2}' | grep -c $p)
            echo exam = $exam_v

            if [[ $exam_v -eq 0 ]];
            then 
                echo "針對 $i 這個 index，該把 $source_n 的 primary shards $p 搬到 $target_n"

                cat << EOF > $data_dir/reroute_$i.sh
                curl -X POST `hostname`:9200/_cluster/reroute?metric=none -H 'Content-Type: application/json' -d'
                {
                    "commands": [
                        {
                        "move": {
                            "index": "$i", "shard": $p,
                            "from_node": "$source_n", "to_node": "$target_n"
                            }
                        }
                    ]
                }
                '
EOF

                #### 執行 reroute API 指令
                sh $data_dir/reroute_$i.sh
                #### 刪除 reroute API 的指令檔
                rm -rf $data_dir/reroute_$i.sh

            fi
        done
    fi
done
