#!/bin/bash
##########################################
# Project: 執行 Redis 指令
# Branch: 
# Author: Gok, the DBA
# Created: 2024-02-01
# Updated: 2024-03-08
# Note: SM Prod 版本
##########################################


redis_ip='10.0.0.31'
redis_pw='HbpZ8gQwCg-4RP-BTCeb3m3yb6W.ydWZ'

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
    value_type=`redis-cli -h $redis_ip -p 6379 -a $redis_pw TYPE $key 2> /dev/null`
    # echo value_type = $value_type

    if [[ $value_type != 'none' ]]; 
    then 
        case $value_type in 
            string)
                echo "======"
                echo "$key 的類型為 $value_type"
                redis-cli -h $redis_ip -p 6379 -a $redis_pw GET $key 2> /dev/null
            ;;
            hash)
                echo "======"
                echo "$key 的類型為 $value_type"
                redis-cli -h $redis_ip -p 6379 -a $redis_pw HGET $key 2> /dev/null
                redis-cli -h $redis_ip -p 6379 -a $redis_pw HMGET $key 2> /dev/null
                redis-cli -h $redis_ip -p 6379 -a $redis_pw HGETALL $key 2> /dev/null
            ;;
            lists)
                echo "======"
                echo "$key 的類型為 $value_type"
                read -ep "請依序提供以下完整資訊： <key> <start> <end>" syntax
                redis-cli -h $redis_ip -p 6379 -a $redis_pw lrange $syntax 2> /dev/null
            ;;
            sets)
                echo "======"
                echo "$key 的類型為 $value_type"
                redis-cli -h $redis_ip -p 6379 -a $redis_pw smembers $key 2> /dev/null
            ;;
            `sorted sets`)
                echo "======"
                echo "$key 的類型為 $value_type"
                read -ep "請依序提供以下完整資訊： <key> <min> <max>" syntax
                redis-cli -h $redis_ip -p 6379 -a $redis_pw ZRANGEBYSCORE $syntax 2> /dev/null
            ;;
            stream)
                echo "======"
                echo "$key 的類型為 $value_type"
                read -ep "請依序提供以下完整資訊： xread count <count> streams <key> <ID>" syntax
                redis-cli -h $redis_ip -p 6379 -a $redis_pw $syntax 2> /dev/null
            ;;
            *)
                echo "找不到這個 key，請確認是否輸入正確" |$log
                exit 0
            esac
    else 
        echo "找不到 $key 這個 key，請確認是否輸入正確" |$log
        exit 0
    fi
;;
b)
    echo 
    echo "此處將以 GET 方式建立 key，其 value 會是字串（string）"
    read -ep "請輸入要建立的 key：" key
    read -ep "請輸入要建立的 value：" value    
    redis-cli -h $redis_ip -p 6379 -a $redis_pw SET $key $value 2> /dev/null 

    echo ...
    echo "Redis key（$key） 建立成功！"
    echo "確認結果："
    redis-cli -h $redis_ip -p 6379 -a $redis_pw GET $key 2> /dev/null 
;;
C)
    read -ep "請輸入要刪除的 key：" key
    output=`redis-cli -h $redis_ip -p 6379 -a $redis_pw DEL $key 2> /dev/null` 

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
    redis-cli -h $redis_ip -p 6379 -a $redis_pw $syntax 2> /dev/null 

    echo ...
    echo "Redis 指令（$syntax） 執行成功！"
;;
*)
	printf "\E[1;1;32m"
	echo "沒有這個選項"|$log
	exit 0
esac
printf "\E[0;37;40m"
