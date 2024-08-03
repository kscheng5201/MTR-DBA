#!/bin/sh
#查域名馮證到期日
#bot='bot2064806699:AAFifowrvKUTmOYsuxLrvlNw11W4Qw_kaBc'
#chat_ID='-636066178'
domename=`echo $1|grep -v '#'`

#domename=`cat /etc/zabbix/alertscripts/domename.txt|grep -v '#'`   #如要吃檔案的域名加這段
#read -ep "請輸入要查詢的域名 (如不需直接按enter): " ans
#if [ -n "$ans" ];then
#        domename="$ans"
#fi
for domename in $domename
do
notAfter=`echo | openssl s_client -servername "$domename" -connect "$domename":$2 2>/dev/null | openssl x509 -noout -dates 2>/dev/null|grep notAfter|awk -F 'notAfter=' '{print $2}'` #取得域名馮證到期日
a="$domename 憑證到期日 $notAfter"
#TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
if [ -z "$notAfter" ];then
        a=`echo "${domename}該域名為301跳轉或沒有憑證"`
        TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
        #sed -i "s/$domename/#$domename/g" /home/andychang/domename.txt
#       echo "$a"
#	echo "0.9999"
else
        notAfter=`date -d "$notAfter" +%s`      #轉成秒
        notAfter=`date "+%Y%m%d" --date=@$notAfter`     #把看轉成看的懂的日期
        declare -i date_dem=$(date --date="${notAfter}" +%s)      # 到期日期秒數
        declare -i date_now=$(date +%s)                        # 現在日期秒數
        declare -i date_total_s=$((${date_dem}-${date_now}))   # 剩餘秒數統計
        declare -i date_d=$((${date_total_s}/60/60/24))        # 轉為日數
        if [ "${date_total_s}" -lt "0" ]; then                 # 判斷是否已到期
#                a=`echo "域名${domename}馮證日期已超過 " $((-1*${date_d})) " 天"`
                a=`echo "$((-1*${date_d}))"`
#                TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
                echo "0.$a"
#               echo "-$((-1*${date_d}))"
        else
                #if [ "$date_d" -lt "3" ];then
                        declare -i date_h=$(($((${date_total_s}-${date_d}*60*60*24))/60/60))
#                        a=`echo "域名${domename}憑證剩下 ${date_d} 天 ${date_h} 小時過期."`
                        a=`echo ${date_d}`
#                       TG=`curl -s X POST "https://api.telegram.org/$bot/sendMessage?chat_id=$chat_ID&text=$a"`
#                       echo "${date_d}"
                        echo $a
                #fi
        fi
fi
done

