#!/bin/bash
##########################################
# Project: 執行 Redis 指令
# Branch: 
# Author: Gok, the DBA
# Created: 2024-03-25
# Updated: 2024-03-28
# Note: 3.0 Prod 版本
##########################################

#Wh=`who -m`
#WhH=`echo $Wh|awk '{print $1}'`
#date=`date +%Y-%m-%d-%H:%M:%S`
#jars=/data
# source /data/VAR.sh
# log="tee -a $jars/log/andy-${WhH}-${date}.log"

## 執行 SQL 指令
echo 
read -ep "請問要執行的指令是在前台 (cs) 還是後台 (plt): " stage
echo '======'

if [[ "$stage" == 'cs' ]]; 
then 
    nohup $(kubectl exec deployment/redis-$stage-client -- ./open-port-forward.sh 6379) &
    sleep 1s
    redis_pw='yAVvpUWQfVSM34q7'
elif [[ "$stage" == 'plt' ]]; 
then 
    nohup $(kubectl exec deployment/redis-$stage-client -- ./open-port-forward.sh 6379) &
    sleep 1s
    redis_pw='eqv59GaZZt33CEqY'
else
    echo '請重新操作一次，並輸入正確的英文字：前台 (cs) 或後台 (plt)'
    exit 0
fi


printf "\E[1;36;36m"
echo "本程式可執行的 Redis 指令為："
echo "a. 查詢 Key"
echo "b. 建立 Key"
echo "c. 刪除 Key"
echo "d. 其他......"
printf "\E[0m"

echo 
read -ep "請問此次欲執行的指令為（a/b/c/d）？" ans
echo "你選擇的是 $ans"
echo "注意：這裡只針對完整的 key 進行動作，無法進行模糊查詢"
echo "注意：若是研發人員要找帶有某字串的全部 key，請找 DBA 處理"
echo "##################################################"
echo 


printf "\E[0;33;33m"
case $ans in
a)
    read -ep "請輸入要查詢的 key：" key
    read -ep "請輸入指定的 db 數字（0 至 15，若無則是 0）：" db
    value_type=`/usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db TYPE $key | tail -1 | tr -d '\r'`
    # echo value_type = $value_type

    if [[ $value_type != 'none' ]]; 
    then 
        case $value_type in 
            string)
                echo "======"
                echo "$key 的類型為 $value_type"
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db GET $key 
            ;;
            hash)
                echo "======"
                echo "$key 的類型為 $value_type"
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db HGET $key 
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db HMGET $key 
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db HGETALL $key 
            ;;
            lists)
                echo "======"
                echo "$key 的類型為 $value_type"
                read -ep "請依序提供以下完整資訊： <key> <start> <end>" syntax
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db lrange $syntax 
            ;;
            sets)
                echo "======"
                echo "$key 的類型為 $value_type"
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db smembers $key 
            ;;
            `sorted sets`)
                echo "======"
                echo "$key 的類型為 $value_type"
                read -ep "請依序提供以下完整資訊： <key> <min> <max>" syntax
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db ZRANGEBYSCORE $syntax 
            ;;
            stream)
                echo "======"
                echo "$key 的類型為 $value_type"
                read -ep "請依序提供以下完整資訊： xread count <count> streams <key> <ID>" syntax
                /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db $syntax 
            ;;
            *)
                echo "找不到 $key 這個 key，請確認是否輸入正確" |$log
                exit 0
            esac
    else 
        echo "找不到 $key 這個 key，請確認是否輸入正確" |$log
        exit 0
    fi
;;
b)
    echo 
    echo "此處將以 SET 方式建立 key，其 value 會是字串（string）"
    read -ep "請輸入要建立的 key：" key
    read -ep "請輸入要建立的 value：" value
    read -ep "請輸入指定的 db 數字（0 至 15，若無則是 0）：" db
    /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db SET $key $value  

    echo ...
    echo "Redis key（$key） 建立成功！"
    echo "確認結果："
    /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db GET $key  
;;
c)
    read -ep "請輸入要刪除的 key：" key
    read -ep "請輸入指定的 db 數字（0 至 15，若無則是 0）：" db
    output=`/usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db DEL $key | tail -1 | tr -d '\r'` 

    echo "確認結果："
    if [[ $output == "(integer) 1" ]]; 
    then 
        echo ...
        echo "Redis key（$key） 刪除成功！"
    elif [[ $output == "(integer) 0" ]];     
    then
        echo ...
        echo "Redis key（$key） 不存在，請再確認！"
    else 
        echo ...
        echo "請 RD 確認要刪除的 Redis key 正確字串！" 
    fi
;;
d)
    read -ep "請貼上研發人員提供的完整語法：" syntax
    echo "此次的指令是： $syntax"
    read -ep "請輸入指定的 db 數字（0 至 15，若無則是 0）：" db
    /usr/local/bin/redis-cli -h localhost -p 6379 -a "$redis_pw" -n $db $syntax  

    echo ...
    echo "Redis 指令（$syntax） 執行成功！"
;;
*)
    printf "\E[1;1;32m"
    echo "沒有這個選項"|$log
    exit 0
esac
printf "\E[0;37;40m"


## 刪除這次所建立的連線
ps -aux | grep 6379 | grep `whoami` | awk '{print $2}' | sudo xargs kill > /dev/null