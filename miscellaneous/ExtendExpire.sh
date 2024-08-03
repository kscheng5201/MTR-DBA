#!/bin/bash
#################################################
# Project: Extend the expire date for rd account
# Branch: 
# Author: Gok, the DBA
# Created: 2022-08-30
# Updated: 2022-08-31
# Note: 延長帳號使用權限
#################################################

user=`whoami`
WhH=$(echo `who -m` | cut -d ' ' -f 1)
date=`date +%Y-%m-%d-%H:%M:%S`
jars="/data"
log="tee -a $jars/log/andy-${WhH}-${date}.log"
backup_mysql_ip='10.22.1.183'
PWW='1qaz@WSX'
token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title="延長帳號使用權限(OP 操作)"


read -ep "請輸入要延長期限的帳號名稱(一次一個): " user_name
name=$user_name

check_user="
    select user
    from mysql.user
    where user = '$name'
    ;"
#echo $check_user
ssh ${user}@${backup_mysql_ip} "cat << EOF > check_user.sql $check_user
EOF"


echo ''
echo "正在檢查是否有 $name 這個使用者..."
echo '...'
checked=`ssh ${user}@${backup_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'source check_user.sql' 2>/dev/null"`

if [[ -n $checked ]]; 
then 
    echo ''
    echo "$name 這個使用者存在！" 
    echo "開始進行權限延長工作..."
    echo '...'
    sleep 3

    extend_expire="
        UPDATE mysql.user SET password_last_changed = now() WHERE user = '$name'; 
        FLUSH PRIVILEGES;
        "
    # echo $extend_expire

    ssh ${user}@${backup_mysql_ip} "cat << EOF > extend_expire.sql $extend_expire
EOF"
    result=`ssh ${user}@${backup_mysql_ip} "mysql -sN -uroot -p${PWW} -e 'source extend_expire.sql' 2>/dev/null"`

    if [ `echo $?` = "0" ]; 
    then
        echo ''
        msg="$name 這帳號的使用權限已經展延到 `date -d '30 day' +"%Y-%m-%d"`" 
        echo $msg | $log
        echo "給 $name 這帳號的權限展延工作已完成，感謝您！" | $log

        ### The Format for the Telegram bot ###
        curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[$backup_mysql_ip]] 

${msg}" > /dev/null 2>&1
        ### The Format for the Telegram bot ###

        ssh ${user}@${backup_mysql_ip} "rm extend_expire.sql"
    else 
        echo ''
        echo '請通知 DBA 查看問題！'
    fi

else 
    echo ''
    echo "$name 這個使用者似乎不存在耶！再請麻煩確認一下喔～" 
fi


ssh ${user}@${backup_mysql_ip} "rm check_user.sql"
