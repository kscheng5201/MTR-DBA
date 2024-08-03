#!/bin/bash
#dig @8.8.8.8 forehand-nginx-proxy-1902982714.ap-northeast-1.elb.amazonaws.com  +short
CURRENT_IPs=`nslookup forehand-nginx-proxy-1902982714.ap-northeast-1.elb.amazonaws.com 8.8.8.8 | grep -v "8.8.8.8" | grep "Address" |awk '{ print $2 }'`
echo $CURRENT_IPs
