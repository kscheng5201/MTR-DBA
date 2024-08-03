#!/bin/bash
######################################
# Project: 資料庫指令操作之主腳本
# Branch: 
# Author: Gok, the DBA
# Created: 2024-03-22
# Updated: 2024-03-22
# Note: 
######################################


## 切換專案
echo 
read -ep "您現在要執行哪個專案的 Prod 任務？（3.0 / Mall） " project
project=${project^^}

if [[ "$project" == 'MALL' ]]; 
then 
    context=`kubectl config get-contexts | awk '{print $2}' | grep ldpro | grep -i $project`
    kubectl config use-context $context
else 
    context=`kubectl config get-contexts | awk '{print $2}' | grep ldpro | grep -v mall`
    kubectl config use-context $context
fi

pname=`kubectl config current-context`
echo "現在已切換到專案 $pname" | $log
echo ============



## 進入資料庫任務
if [[ "$pname" == 'prod-3-0-gke' ]];
then    
    echo 
    echo "您現在要執行 3.0-Prod 的哪個資料庫的指令？（輸入第一個英文字母即可）"
    echo [P]ostgres
    echo [R]edis
    echo [M]ongodb
    echo [E]lasticsearch
    echo 
    read -e ans
    ans=${ans^^}
    echo "你選擇的是 $ans" | $log
    
    case $ans in
        P)      
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Postgres 語法"`
            source $jars/ExecuteSQL-30.sh
        ;;
        R)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Redis 語法"`
            source $jars/ExecuteRedis-30.sh
        ;;
        M)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Mongodb 語法"`
            source $jars/ExecuteMongo-30.sh
        ;;
        E)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Elasticsearch 語法"`
            source $jars/ExecuteES-30.sh
        ;;
        *)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 未知 的語法"`
            echo 
        ;;
    esac

elif [[ "$pname" == 'ldpro-prod-mall' ]];
then 
    echo
    echo "您現在要執行 Mall-Prod 的哪個資料庫的指令？（輸入第一個英文字母即可）"
    echo [P]ostgres
    echo [R]edis
    echo [M]ongodb
    echo [E]lasticsearch
    echo 
    read -e ans
    ans=${ans^^}
    echo "你選擇的是 $ans" | $log
        
    case $ans in
        P)      
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Postgres 語法"`
            source $jars/ExecuteSQL-mall.sh
        ;;
        R)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Redis 語法"`
            source $jars/ExecuteRedis-mall.sh
        ;;
        M)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Mongodb 語法"`
            source $jars/ExecuteMongo-mall.sh
        ;;
        E)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 Elasticsearch 語法"`
            source $jars/ExecuteES-mall.sh
        ;;
        *)
            bavgbix=`curl -s X POST "https://api.telegram.org/bot6126553675:AAFsX-v-q1FbWPBvzP3qBhChwV1Xt3Ts-AY/sendMessage?chat_id=-917310226&text=$Wh 執行了 未知 的語法"`
            echo 
        ;;
    esac
else 
    echo '迄今僅有 3.0-Prod 以及 Mall-Prod 兩專案，其他為無效專案。'
    exit 0
fi
