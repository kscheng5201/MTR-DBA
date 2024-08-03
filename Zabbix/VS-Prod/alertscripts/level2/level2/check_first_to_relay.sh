#!/bin/bash
#35.75.77.28 源站外部ip
#34.84.102.237-pg-jp-m-b-n237 zabbix上設值的被監控主機名
#10.170.0.6 zabbix-proxy的內部ip
#check_first_to_relay[35.75.77.28] zabbix上設置的監控項
pa=`paping forehand-nginx-proxy-1902982714.ap-northeast-1.elb.amazonaws.com -p 443 -c 60|grep Failed |awk '{print $NF}'|cut -c 1 --complement|sed 's/.$//'|sed 's/%//'|sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"`
zabbix_sender -vv -s "34.96.164.238-GCP-prod-forehead-nginx-proxy" -z "10.170.0.6" -k "check_first_to_relay" -o "$pa"
