#!/bin/bash
txt='857d06e346bb63223c04b99ead35bedb.txt'
i=0
while [ "$i" != 2 ]
do
oo=`curl -s -m 5 -H 'Cache-Control: no-cache' -L https://"$1"/eab04ab61dba8417b2e3708ee18a99eb/"$txt"`
if [ -z "$oo" ];then
        ((i=$i+1))
        sleep 3
else
        if [ "$oo" = "7f36780c94302e486fe741aad1b51f04" ];then
                andy=1  #正常
                i=2
        else
                andy=0 #被脅持 比對檔案內容不符
                sudo echo $(date "+%Y-%m-%d_%H:%M:%S") "$1" oo="$oo" >> /tmp/check_picture.log
                i=2
        fi
fi
done

sleep 0.1

if [ -z "$oo" ];then
        echo 3
else
        echo $andy
fi
