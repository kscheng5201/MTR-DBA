#!/bin/bash
i=0
domname=$1
while [ "$i" != 2 ]
do
        gg=`curl -H 'Cache-Control: no-cache' -m 14 -s -o /dev/null -w "%{http_code}" -k "$domname"`
        if [ "$gg" = 000 ];then
                ((i=$i+1))
        else
                i=2
        fi
done

if [[ "${gg}" = 000 ]];then
        gg=3
else
        echo $gg
fi

