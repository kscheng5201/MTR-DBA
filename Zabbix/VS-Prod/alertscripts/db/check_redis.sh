#!/bin/bash
##############################################
# Project: Check the Redis Replication Status
# Branch: 
# Author: unknown
# Editor: Gok, the DBA
# Created: unknown
# Updated: 2023-06-01
# Note: 從一主二從的判斷基礎改回一主一從
##############################################

redisip=$1
server=`hostname`
url='/etc/zabbix/alertscripts'

before=`ls -al /etc/zabbix/alertscripts/test.txt | awk -F " " '{print $5}'`
TESTREDIS() {
    redis-cli -h $server -p 6377 -a newld20200909 cluster nodes 2>/dev/null > "$url"/test.txt
    redis12=`cat "$url"/test.txt | grep "$redisip" | grep master | awk '{print $1}'`
    check=`grep -c "$redis12" "$url"/test.txt`
}
TESTREDIS
after=`ls -al /etc/zabbix/alertscripts/test.txt | awk -F " " '{print $5}'`


if [[ "$check" = 2 ]];
then
    echo 0 #主從同步正常
elif [[ "$before" == "$after" ]];
then
    echo ===== $server \($redisip\): `date` ===== >> /tmp/redis-checkfailed.txt
    echo redis12 = $redis12 >> /tmp/redis-checkfailed.txt
    echo check = $check >> /tmp/redis-checkfailed.txt

    echo >> /tmp/redis-checkfailed.txt
    cat "$url"/test.txt >> /tmp/redis-checkfailed.txt
    echo 0 #假性主從同步正常

else
    echo ===== $server \($redisip\): `date` ===== >> /tmp/redis-checkfailed.txt
    echo redis12 = $redis12 >> /tmp/redis-checkfailed.txt
    echo check = $check >> /tmp/redis-checkfailed.txt

    echo >> /tmp/redis-checkfailed.txt
    cat "$url"/test.txt >> /tmp/redis-checkfailed.txt
    echo 1 #主從不同步
fi

