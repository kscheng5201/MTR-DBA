#!/bin/bash
##################################################
# Project: Check the Graylog running
# Branch: 
# Author: Gok, the DBA
# Created: 2023-11-08
# Updated: 2023-11-08
# Note: 若發現延遲秒數太多，會重新啟動 Graylog
##################################################

## SM-AWS-LS-LOG 告警群
chat_a="-1002142724386"
token_a="2064806699:AAFifowrvKUTmOYsuxLrvlNw11W4Qw_kaBc"

## DBA-自我監控群
token_b="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat_b="-675619128"

function TG() {
    curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_a" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_a}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
    curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_b" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_b}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
        }



index=`curl -XGET localhost:9200/_cat/indices/service* | awk '{print $3}' | cut -d _ -f 1 | sort | uniq`

for i in $index;
do
    # 拿到兩 index 的最小尾數編號
    Num=`curl -XGET localhost:9200/_cat/indices/${i}* | awk '{print $3}' | cut -d _ -f 2 | sort -n | tail -1`

    last_time=`curl -X GET localhost:9200/${i}_${Num}/_search?pretty -H 'Content-Type: application/json' -d'
    {
      "sort": [{
          "timestamp": {
            "order": "desc"
          }
        },
        {
          "_score": {
            "order": "desc"
          }
        }
      ],
      "size": 1
    }
    ' | grep timestamp | tr -d \" | grep -v '@' | cut -d : -f 2-5 | cut -d . -f 1` 

    last_sec=`date -d "$last_time" +"%s"`
    now_sec=`date -d "-8 hour" +"%s"`

    # echo last_time = $last_time
    # echo now = `date -d "-8 hour" +"%F %T"`
    # echo timediff = $(($now_sec - $last_sec))


    timediff=`expr $now_sec - $last_sec`

    # 若 graylog 取得最後一筆 message 的時間與當下相差超過 300 秒，則重啟 graylog 
    if [[ $timediff -gt 300 ]]; 
    then 
        echo restart the graylog
        container_id=`docker ps | grep graylog | awk '{print $1}'`
        echo docker restart $container_id

        BB="Graylog 進入重啟作業！因資料已延遲 $timediff 秒"
        TG

        # 若有重啟 graylog，則停止迴圈
        break
    fi
done
