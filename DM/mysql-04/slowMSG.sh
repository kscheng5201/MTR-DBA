#!/bin/bash
###################################################
# Project: 慢查詢細節之訊息發布
# Branch: 
# Author: Gok, the DBA
# Created: 2023-06-05
# Updated: 2023-07-03
# Note: 修正過去紀錄保留機制
###################################################

prod='DM'
data_dir=/home/gok/slowlog
date=`date +"%Y-%m-%d %H:%M:%S"`


## DM-PROD-警報群
chat_a="-1001695454920"
token_a="2064806699:AAFifowrvKUTmOYsuxLrvlNw11W4Qw_kaBc"

## DBA-自我監控群
token_b="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat_b="-675619128"


function TG() {
    curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_a" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_a}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
    curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_b" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_b}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
}


if [[ `ls $data_dir | grep -c -v 'sent'` -ge 1 ]];
then
    file=`ls $data_dir | grep -v 'sent'`
    for f in $file; 
    do
        BB=`cat $data_dir/$f`
        TG
        mv $data_dir/$f $data_dir/${f}_sent
    done
fi

## 過去紀錄只保留 40 份
if [[ `ls $data_dir | grep -c 'sent'` -gt 40 ]];
then
    file=`ls -t $data_dir | tail -1`
    rm -rf $data_dir/$file
fi
