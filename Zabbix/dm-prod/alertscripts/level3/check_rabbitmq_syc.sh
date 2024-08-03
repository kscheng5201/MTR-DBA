#!/bin/bash
sudo rabbitmqctl cluster_status|grep -e '(none)' -e Alarms -e 'Network Partitions' > /etc/zabbix/alertscripts/rabb.txt
a=`sed -n 2p /etc/zabbix/alertscripts/rabb.txt|grep '(none)'|wc -l`
b=`sed -n 4p /etc/zabbix/alertscripts/rabb.txt|grep '(none)'|wc -l`
#a=1
#b=0
((i=$a+$b))
((d=$a+$b))
if [ "$i" = 2 ];then
	echo 1	#代表正常
elif [ "$d" = 0 ];then
	echo 0	#代表Alarms及Network Partitions同時異常
elif [ "$a" = 0 ];then
	echo 2	#代表Alarms異常
elif [ "$b" = 0 ];then
        echo 3	#代表Network Partitions異常
fi	
