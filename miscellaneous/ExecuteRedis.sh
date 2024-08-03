#!/bin/bash
#################################################
# Project: Execute the Redis Command
# Branch: 
# Author: Gok, the DBA
# Created: 2023-02-04
# Updated: 2023-02-04
# Note: OP 可直接執行 Redis 指令
#################################################

user=`whoami`
WhH=$(echo `who -m` | cut -d ' ' -f 1)
date=`date +%Y-%m-%d-%H:%M:%S`
jars="/data"
log="tee -a $jars/log/andy-${WhH}-${date}.log"

master_redis_ip='10.23.1.120'
master_redis_port='6377'
PWW='newld20200909'

token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title='OP 執行 Redis 指令'


function MsgToBot() {
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

${msg}" > /dev/null 2>&1
}

echo ''
echo '執行 Redis 語法的腳本開始' | $log
echo '...'
echo ''
echo '以下範例...'
echo '執行指令: del admin_sys::SYS_MENU_LIST'
echo '請貼上「del admin_sys::SYS_MENU_LIST」即可'
echo '======================================'

echo ''
read -ep "請輸入要執行的 Redis 指令 (一次一組): " comm
comm=$comm

########################################################################################
# 刪除所有 Redis Key 的語法
# FLUSHDB [ASYNC]: 僅刪除當前 redis database 所有 key; ASYNC 是 Redis 4 之後版本才加上的
# FLUSHALL [ASYNC]: 刪除所有 redis database 所有 key; ASYNC 是 Redis 4 之後版本才加上的
# del *: Redis 4 之前版本可用
# unlink *: Redis 4 之後版本可用 (可以背景刪除)
########################################################################################


echo ''
echo '檢查是否帶有全稱符號(*)'
echo '...'

if [[ -n `echo "$comm" | grep \*` ]];
then 
    echo '此語法有刪除全部資料的危險。請再與需求人員確認。' 
    echo '請向需求人員與 DBA 說明此事，也告知上述訊息'
    echo '此次作業到此結束(未執行)，感謝協助' | $log
    echo '======================================'
    
    msg="未執行 $comm"
    MsgToBot
else
    echo ''
    echo '確認沒有全稱符號(*)'
    echo '...'
    echo ''
    echo '檢查是否帶有資料庫刪除指令'
    echo '...'

    if [[ `echo $comm | tr [:lower:] [:upper:]` =~ ^"FLUSH" ]];
    then 
        echo '此語法有刪除全部資料的危險。請再與需求人員確認' | $log
        echo '請向需求人員與 DBA 說明此事，也告知上述訊息'
        echo '此次作業到此結束(未執行)，感謝協助' | $log
        echo '======================================'

        msg="未執行 $comm"
        MsgToBot
    else
        echo ''
        echo '確認完畢，開始執行 redis 指令'
        echo '...'
        output=`ssh ${user}@${master_redis_ip} "redis-cli -h $master_redis_ip -p $master_redis_port -c -a $PWW 2> /dev/null $comm"`

        if [[ -z `echo $output | grep ERROR` ]] && [[ $output -ge 1 ]] 2> /dev/null ; 
        then 
            echo '此語法已順利執行完畢'
            echo '請於群組告知此工作已完成，並請需求人員確認資料現況'                
            echo '此次作業到此結束(已執行)，感謝協助' | $log
            echo '======================================'

            msg="順利執行完畢 $comm"
            MsgToBot
        else
            echo '此語法已執行完畢'
            echo '但是指令或 key 不存在，所以資料庫沒有任何改變。' | $log
            echo '此次作業到此結束，感謝協助' | $log
            echo '======================================'      

            msg=" $comm ：指令或 key 不存在"
            MsgToBot                      
        fi
    fi
fi
