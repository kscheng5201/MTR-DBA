#!/bin/bash
PORT="$1"
check_APP=`curl -s http://127.0.0.1:"$PORT"/api/internal/actuator/health`

if [[ -z "$check_APP" ]];then
        echo 2 #服務沒起來
elif [[ "$(echo $check_APP|grep '{"status":"DOWN",'|wc -l)" = "0" ]];then
        echo 0 #服務正常
else
        echo 1 #服務異常
fi
