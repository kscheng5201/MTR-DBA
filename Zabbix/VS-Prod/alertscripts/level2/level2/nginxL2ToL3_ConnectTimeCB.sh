#!/bin/bash

#curl -skw "%{time_connect}\n" -H 'Host: h5.v01bbb.com' -o /dev/null https://forehand-nginx-proxy-1902982714.ap-northeast-1.elb.amazonaws.com/conntest/fakepng/350k.png

option=$1
host_header=$2
host_header=${host_header:="h5.v01bbb.com"}
url=$3
url=${url:="/conntest/350k.png"}
upstream="forehand-nginx-proxy-1902982714.ap-northeast-1.elb.amazonaws.com"
upstream=$4

curl -skw "%{$option}" -H "Host: ${host_header}" https://${upstream}${url} -o /dev/null
