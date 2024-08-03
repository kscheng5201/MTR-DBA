#!/bin/bash
################################################
# Project: mysqldump 每天備份資訊匯報到 Telegram
# Branch: 
# Author: unknown
# Editor: Gok, the DBA
# Created: 2022-08-26
# Updated: 2022-09-28
# Note: 增加 TG 訊息內容
################################################

## The Messenge to where Neo Wo is involved
chat_a="-728211620"
token_a="2064806699:AAFifowrvKUTmOYsuxLrvlNw11W4Qw_kaBc"

## The Messenge to where DBA monitor only
token_b="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat_b="-675619128"



date=`date +%Y-%m-%d-%H:%M:%S`
BB=`cat /opt/mysqlbackup.log | grep -e '異常' -e 'ERROR' -e 'fail'`
if [ -n "$BB" ];
then
    BB=" $date $BB"
else
    BB=" $date mysql無備份異常"
fi
curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_a" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_a}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_b" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_b}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'


num=$(ls -al /opt/mysql/`date -d "1 day ago" +"%Y-%m-%d"` | grep global_3rd_db | wc -l)
msg="昨天 `date -d "1 day ago" +"%Y-%m-%d"` 在 `hostname` 共執行備份 $num 次。"
curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_a" --data-urlencode "text=${msg}" "https://api.telegram.org/bot${token_a}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_b" --data-urlencode "text=${msg}" "https://api.telegram.org/bot${token_b}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'


msg=`tail -n 1 /opt/mysqlbackup.log`
curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_a" --data-urlencode "text=${msg}" "https://api.telegram.org/bot${token_a}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_b" --data-urlencode "text=${msg}" "https://api.telegram.org/bot${token_b}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'

echo > /opt/mysqlbackup.log

