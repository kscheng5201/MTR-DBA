#!/bin/bash
i=0
domname=$1
chech=`echo $2|sed 's#http://#https://#'`
while [ "$i" != 2 ]
do
        gg=`curl -H 'Cache-Control: no-cache' -m 14 -s -o /dev/null -w "%{http_code} %{redirect_url}" -k "$domname"`
        a=`echo $gg|awk '{print $1}'`
        b=`echo $gg|awk '{print $2}'|sed 's#http://#https://#'`
        if [ "$a" = 000 ];then
                ((i=$i+1))
        else
                i=2
        fi
done
TTT (){
if [[ "${b}" = "$chech"* ]];then
        echo 1          #正常
elif [[ -z "${b}" ]];then
        echo 10         #沒有抓到值
else
        echo 0          #肯定被脅持
fi
}
if [[ "${a}" = 000 ]];then
        a=3
fi

if [ "${a}" = 308 -o "${a}" = 301 ];then
        c=ok
else
        echo $a         #被脅持沒有跳轉
fi

if [[ $c = ok ]];then
        TTT
fi

