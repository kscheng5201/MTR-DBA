#!/bin/sh
#查網域到期日
#bot='bot2064806699:AAFifowrvKUTmOYsuxLrvlNw11W4Qw_kaBc'
#chat_ID='-636066178'
#domename=`cat /root/domename.txt|grep -e .*[.].*[.]|awk -F '.' '{print $2"."$3}'|sort|uniq`
#read -ep "請輸入要查詢的網域 (如不需直接按enter): " ans
#if [ -n "$ans" ];then
#        domename="$ans"
#fi
domename=$1
for domename in $domename
do
        x=0
        while [[ "$x" != 10 ]]
        do
                notAfter=`whois "$domename"|grep -ie Expiry -e 'Expiration Date'|awk -F 'Date: ' '{print $2}'|head -n 1`
                declare -i date_dem=$(date --date="${notAfter}" +%s)      # 到期日期秒數
                declare -i date_now=$(date +%s)                        # 現在日期秒數
                declare -i date_total_s=$((${date_dem}-${date_now}))   # 剩餘秒數統計
                declare -i date_d=$((${date_total_s}/60/60/24))        # 轉為日數
                if [ -n "${notAfter}" ];then
                        a="網域 $domename 到期日 $notAfter"
#                        curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=${chat_ID}" --data-urlencode "text=${a}" "https://api.telegram.org/${bot}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
#			echo $a
                        if [ "${date_total_s}" -lt "0" ]; then                 # 判斷是否已到期
#                                a=`echo "網域*.${domename}到期日已超過 " $((-1*${date_d})) " 天"`
                                a=`echo $((-1*${date_d}))`
#                                TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
				echo 0.$a
                        else
                                #if [ "$date_d" -lt "3" ];then
                                        declare -i date_h=$(($((${date_total_s}-${date_d}*60*60*24))/60/60))
#                                        a=`echo "網域*.${domename}剩下 ${date_d} 天 ${date_h} 小時過期."`
                                        a=`echo "${date_d}"`
#                                        TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
				echo $a
                                #fi
                        fi
                        x=10
                else
                        ((x=$x+1))
                        sleep 5
                        if [ "$x" = 10 ];then
                                a="$domename whois 查詢不到"
                                TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
#				echo $a
                        fi
                fi
        done
done
