#!/bin/bash
sudo firewall-cmd --list-all >/dev/null 2>&1
ret=$?
a=`sudo ufw status 2>/dev/null|grep 'Status: active'`
if [ "$ret" = 0 ];then
        echo 1
elif [ "$a" = 'Status: active' ];then
        echo 1
else
        echo 0
fi
