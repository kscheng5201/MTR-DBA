#!/bin/bash
a=`curl -s ftp://JU5.Vbet:nLQwJjYmMH@xj.gdcapi.com|grep AGIN|wc -l`
if [ $a = 1 ];then
	echo 1 #正常
else
	echo 0 #異常
fi

#IP_A=(xj.gdcapi.com)
#
#function FTP_TEST_IP()
#{
#	for IP in $*
#	do
#		echo "${IP}"
#		T=$(timeout 2 ftp ${IP}) #默认端口 21
#		#echo "$T"
#		echo $T >> /etc/zabbix/alertscripts/dbug.log
#		S=`echo "$T" | grep "Connected to ${IP} (138.43.34.19)." | wc -l`	#根据主机返回的信息，如果超时，返回的匹配值 行数为0
#		#双括号不用再次解析变量
#		echo $S >> /etc/zabbix/alertscripts/dbug.log
#		if ((T==1)) #if 后加 then
#		then
#			echo "FTP ${IP} 连接成功"
#		elif ((T==0)) #elif 后加then
#		then
#			echo "FTP ${IP} 连接失败"
#		else
#			echo "FTP ${IP} 状态未知，返回结果；$T"
#		fi
#	done
#}
#
##测试A主机采集点FTP连接是否正常
##echo "---------------------------------------------------------测试A主机FTP连接---------------------------------------------------------------"
#FTP_TEST_IP ${IP_A[*]}
