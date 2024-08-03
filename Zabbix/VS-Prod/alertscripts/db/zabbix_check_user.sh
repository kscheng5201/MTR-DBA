#!/bin/bash
D=`date +%Y-%m-%d`
#每日註冊人數
case $1 in
每日註冊人數)
BB=`echo """
use global_3rd_db;
select COUNT(*) from gl_user where register_date between '$D 00:00:00' AND '$D 23:59:59';
"""|sudo mysql -uzabbix -pcsnt@P@ssw0rd 2>&1 |grep -E [0-9]`
echo $BB
;;
全平台登入人數)
##全平台登入人數
AA=`echo """
use global_3rd_db;
select COUNT(*) from gl_user_login where login_time between '$D 00:00:00' AND '$D 23:59:59';
"""|sudo mysql -uzabbix -pcsnt@P@ssw0rd 2>&1 |grep -E [0-9]`
echo $AA
;;
#PC登入人數
PC登入人數)
CC=`echo """
use global_3rd_db;
select COUNT(*) from gl_user_login where login_time between '$D 00:00:00' AND '$D 23:59:59' and client_type = 0;
"""|sudo mysql -uzabbix -pcsnt@P@ssw0rd 2>&1 |grep -E [0-9]`
echo $CC
;;
#H5登入人數
H5登入人數)
DD=`echo """
use global_3rd_db;
select COUNT(*) from gl_user_login where login_time between '$D 00:00:00' AND '$D 23:59:59' and client_type = 1;
"""|sudo mysql -uzabbix -pcsnt@P@ssw0rd 2>&1 |grep -E [0-9]`
echo $DD
;;
#Android登入人數
Android登入人數)
EE=`echo """
use global_3rd_db;
select COUNT(*) from gl_user_login where login_time between '$D 00:00:00' AND '$D 23:59:59' and client_type = 2;
"""|sudo mysql -uzabbix -pcsnt@P@ssw0rd 2>&1 |grep -E [0-9]`
echo $EE
;;
#IOS登入人數
IOS登入人數)
FF=`echo """
use global_3rd_db;
select COUNT(*) from gl_user_login where login_time between '$D 00:00:00' AND '$D 23:59:59' and client_type = 3;
"""|sudo mysql -uzabbix -pcsnt@P@ssw0rd 2>&1 |grep -E [0-9]`
echo $FF
esac
