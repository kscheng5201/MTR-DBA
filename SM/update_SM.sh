#!/bin/bash
######################################
# Project: OP 操作腳本總選單
# Branch: 
# Author: Gok, the DBA
# Created: 2024-01-18
# Updated: 2024-01-18
# Note: 從 update_dove.sh 改寫而來
######################################

Wh=`who -m`
WhH=`echo $Wh|awk '{print $1}'`
date=`date +%Y-%m-%d-%H:%M:%S`
jars=/data
#source /data/VAR.sh
log="tee -a $jars/log/andy-${WhH}-${date}.log"
T_P=`ps axu | grep $(cat $jars/A_PID.TXT) | grep -v grep | wc -l`
if [ $T_P != '0' ];
then
	echo "已有其他人在執行腳本，請稍後再試"|$log
	exit 0
fi

echo $$ > $jars/A_PID.TXT
testuser=`id | awk '{print $1}' | grep -o "(.*)"`
echo "" | $log
echo '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^' | $log

echo $Wh >> $jars/log/andy-${WhH}-${date}.log
if [ "$testuser" != '(centos)' ]; 
then
	echo $date 請切換正確帳號執行 |$log
	exit 0
fi

###### 如登入帳號為optest才匹配，否則有全功能 ########
#if [[ `echo $Wh|awk '{print $1}'` = 'optest' ]];then
#	echo "1.更版前端" |$log
#else
	echo "1. 輸出服務（app）的日誌檔案" | $log
	echo "2. 輸出 cab-service 的日誌檔案" | $log
	echo "3. 輸出 EMQX 主服務的日誌檔案" | $log
	echo "4. 輸出小助手（xzs）的服務日誌檔案" | $log
	echo "5. 服務（app）狀態檢查" | $log
	echo "6. cab-service 狀態檢查" | $log
	echo "7. 刪除日誌檔案" | $log
	echo 
	echo "a. 執行 MySQL 指令" | $log
	echo "b. 執行 Redis 指令" | $log
	echo "c. 執行 MongoDB 指令" | $log
	echo "d. 查找簡訊驗證碼" | $log
	echo "請選擇要進入的功能 (輸入編號)？ " | $log

	read -e ans
    echo "你選擇的是 $ans" | $log
#fi
##################################################
printf "\E[0;33;33m"

case $ans in
1)
	source $jars/export-app-logs.sh
;;
2)
	source $jars/export-cab-logs.sh
;;
3)
	source $jars/export-emqx-main-logs.sh
;;
4)
	source $jars/export-xzs-app-logs.sh
;;
5)
	source $jars/health-check-app.sh
;;
6)
	source $jars/health-check-cab.sh
;;
7)
	source $jars/remove-exported-logfile.sh
;;
a)
	source $jars/ExecuteSQL.sh
;;
b)
	source $jars/ExecuteRedis.sh
;;
c)
	source $jars/ExecuteMongo.sh
;;
d)
	source $jars/verification-code.sh
;;
*)
	printf "\E[1;1;32m"
	echo "沒有這個選項"|$log
	exit 0
esac
printf "\E[0;37;40m"
