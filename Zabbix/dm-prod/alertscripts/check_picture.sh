# for elasicsearch-infra
#!/bin/bash
ff='5448516d24ae381882657ac5a5722cef'
txt='857d06e346bb63223c04b99ead35bedb.txt'
i=0
dd=$(date "+%Y-%m-%d_%H:%M:%S.%N")"$txt"
while [ "$i" != 3 ]
do
sudo rm -rf /tmp/"$dd"
wget --no-dns-cache --no-check-certificate -T 9 -t 1 https://"$1"/eab04ab61dba8417b2e3708ee18a99eb/"$txt" -O /tmp/"$dd" 2>/dev/null &&
test -e /tmp/"$dd" && TT="yes" || TT="no"
if [ $TT = yes ];then
        oo=`cat /tmp/"$dd"`
        if [ "$oo" = "7f36780c94302e486fe741aad1b51f04" ];then
                gg=`md5sum /tmp/"$dd" 2>/dev/null|awk -F '/' '{print $1}'`

                if [ $gg = $ff ];then
                        andy=1  #正常
                else
                        andy=0  #被脅持 比對md5不符
                        echo $(date "+%Y-%m-%d_%H:%M:%S") "$1" gg="$gg" >> /tmp/check_picture.log
                fi
                i=3
        else
#                ((i=$i+1))
#                sleep 0.1
                andy=0 #被脅持 比對檔案內容不符
                sudo echo $(date "+%Y-%m-%d_%H:%M:%S") "$1" oo="$oo" >> /tmp/check_picture.log
#                sudo rm -rf /tmp/"$dd"
                i=3
        fi
else
        ((i=$i+1))
        sleep 0.1
        echo $(date "+%Y-%m-%d_%H:%M:%S") "$1" "$i次下載不到檔案" >> /tmp/check_picture.log
        sudo rm -rf /tmp/"$dd"
fi
done

sleep 0.1
#if [ -z "$andy" ];then
#        andy=0 #抓的到檔案，但最後檔案內容不符
#       exit 0
#fi
test -e /tmp/"$dd" && sudo rm -rf /tmp/"$dd"|echo $andy || echo 3 #如抓不到檔案回應3表示被脅原或無回應，否則刪掉檔案回應值
