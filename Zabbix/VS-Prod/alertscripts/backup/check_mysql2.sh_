#!/bin/bash
# -------------------------------------------------------------------------------
# FileName: check_mysql.sh
# Revision: 1.0
# -------------------------------------------------------------------------------
# Copyright:
# License: GPL

# 使用者名稱
MYSQL_USER='zabbix'

# 密碼
MYSQL_PWD='csnt@P@ssw0rd'

# 主機地址/IP
MYSQL_HOST='34.84.63.14'

# 埠
MYSQL_PORT='3306'

# 資料連線
MYSQL_CONN="/usr/bin/mysqladmin -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_PORT}"

# 引數是否正確
if [ $# -ne "1" ];then
echo "arg error!"
fi

# 獲取資料
case $1 in
Uptime)
result=`${MYSQL_CONN} status 2>/dev/null |cut -f2 -d":"|cut -f1 -d"T"`
echo $result
;;
Com_update)
result=`${MYSQL_CONN} extended-status   2>/dev/null  |grep -w "Com_update"|cut -d"|" -f3`
echo $result
;;
Slow_queries)
result=`${MYSQL_CONN} status  2>/dev/null  |cut -f5 -d":"|cut -f1 -d"O"`
echo $result
;;
Com_select)
result=`${MYSQL_CONN} extended-status  2>/dev/null  |grep -w "Com_select"|cut -d"|" -f3`
echo $result
;;
Com_rollback)
result=`${MYSQL_CONN} extended-status  2>/dev/null   |grep -w "Com_rollback"|cut -d"|" -f3`
echo $result
;;
Questions)
result=`${MYSQL_CONN} status   2>/dev/null |cut -f4 -d":"|cut -f1 -d"S"`
echo $result
;;
Com_insert)
result=`${MYSQL_CONN} extended-status   2>/dev/null  |grep -w "Com_insert"|cut -d"|" -f3`
echo $result
;;
Com_delete)
result=`${MYSQL_CONN} extended-status   2>/dev/null  |grep -w "Com_delete"|cut -d"|" -f3`
echo $result
;;
Com_commit)
result=`${MYSQL_CONN} extended-status   2>/dev/null  |grep -w "Com_commit"|cut -d"|" -f3`
echo $result
;;
Bytes_sent)
result=`${MYSQL_CONN} extended-status  2>/dev/null  |grep -w "Bytes_sent" |cut -d"|" -f3`
echo $result
;;
Bytes_received)
result=`${MYSQL_CONN} extended-status  2>/dev/null  |grep -w "Bytes_received" |cut -d"|" -f3`
echo $result
;;
Com_begin)
result=`${MYSQL_CONN} extended-status  2>/dev/null  |grep -w "Com_begin"|cut -d"|" -f3`
echo $result
;;

*)
echo "Usage:$0(Uptime|Com_update|Slow_queries|Com_select|Com_rollback|Questions|Com_insert|Com_delete|Com_commit|Bytes_sent|Bytes_received|Com_begin)"
;;
esac

