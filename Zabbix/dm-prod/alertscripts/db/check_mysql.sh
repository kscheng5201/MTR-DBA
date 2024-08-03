#!/bin/bash
###################################################
# Project: 監控 MySQL 主從同步狀態
# Branch: 
# Author: unknown
# Created: 2021-12-01
# Updated: 2023-07-10
# Note: 保留出錯時當下的狀態資訊
###################################################

user='root'
PWD='1qaz@WSX'
log_dir=/etc/dba

check=`mysql -u${user} -p${PWD} -e "show slave status\G" 2>/dev/null | grep -c Yes`
if [[ "$check" = "2" ]];
then
    echo 0 #主從同步
else
    echo 1 #主從不同步
    rm -rf $log_dir/slave_*.log
    echo "check = $check" >> $log_dir/slave_`date +"%Y%m%d%H%M"`.log
    echo `date` >> $log_dir/slave_`date +"%Y%m%d%H%M"`.log
    mysql -u${user} -p${PWD} -e "show slave status\G" 2>/dev/null >> $log_dir/slave_`date +"%Y%m%d%H%M"`.log
    # scp -i /home/gok/.ssh/gok_rsa $log_dir/slave_`date +"%Y%m%d%H%M"`.log gok@10.25.1.183:/home/gok > /dev/null
fi
