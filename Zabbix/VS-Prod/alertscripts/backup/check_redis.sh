#!/bin/bash
redisip=$1
server=`hostname`
url='/etc/zabbix/alertscripts'
TESTREDIS(){
redis-cli -h $server -p 6377 -a newld20200909 cluster nodes 2>/dev/null > "$url"/test.txt
reids120=`cat "$url"/test.txt |grep "$redisip"|grep master|awk '{print $1}'`
check=`cat "$url"/test.txt | grep "$reids120"|wc -l`
}
TESTREDIS
if [[ "$check" = 3 ]];then
        echo 0 #主從同步正常
else
        echo ===== $server \($redisip\): `date` ===== >> /tmp/redis-checkfailed.txt
        cat "$url"/test.txt >> /tmp/redis-checkfailed.txt
        echo 1 #主從不同步
fi
