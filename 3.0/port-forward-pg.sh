#!/bin/bash
#################################################
# Project: Connect to the PostgreSQL Server
# Branch: 
# Author: Gok, the DBA
# Created: 2024-02-07
# Updated: 2024-02-07
# Note: port-forward 建立機制獨立設置
#################################################


## 隨機產生 Port 號的機制
function GetPort {
    port=`date +%s | tail -c 6`

    if [[ $port -gt 65535 ]];
    then
        port=`expr $port - 65535`
    fi
}

echo 
read -ep "請問要執行的指令是在前台 (cs) 還是後台 (plt): " stage
echo '======'

port=`ps -aux | grep port-forward | grep $stage | grep -v grep | tail -c 11 | cut -d : -f 1`
if [[ -z $port ]];
then 
    ## 取得 port-forward 資訊
    svc=`kubectl get service -n sqlproxy | awk '{print $1}' | grep master | grep $stage`
    GetPort

    ## 進行 port-forward 連線，利用 Gok 的帳號
    sudo -u gok nohup kubectl -n sqlproxy port-forward service/$svc $port:5432 &

    ## 公告已完成之連線資訊
    echo '已設置完成的連線資訊如下：'
    ps -aux | grep port-forward | grep $stage | grep ^gok | cut -d / -f 3
    echo '======'

else
    echo 
    echo '現在已有連線，不用再建立。資訊如下：'
    ps -aux | grep port-forward | grep $stage | grep -v ^root | cut -d / -f 3
    echo '======'
fi
