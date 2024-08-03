#!/bin/bash
######################################
# Project: 清空根目錄 / 的 log file
# Branch: 
# Author: Gok, the DBA
# Created: 2024-01-25
# Updated: 2024-01-25
# Note: 
######################################


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


dba_dir=/etc/dba
bf_usage=`df -h | grep -B1 data$ | awk '{print $5}' | cut -d % -f 1 | head -1`

if [[ $bf_usage -ge 80 ]];
then
    log_dir=/var/lib/docker/containers
    big_dir=`du $log_dir | sort -nk1 | tail -2 | head -1 | awk '{print $2}'`

    big_size=`ls -lh $big_dir/*.log | awk '{print $5}'`
    big_file=`ls -l $big_dir/*.log | awk '{print $NF}'`

    ## 清空此檔案
    echo > $big_file
    af_usage=`df -h | grep -B1 data$ | awk '{print $5}' | cut -d % -f 1 | head -1`

    # 發送訊息到 TG
    BB="INFO: 在刪除 log 之後，`hostname` 根目錄 / 的 Use% 從 ${bf_usage}% 降為 ${af_usage}%"
    TG
fi