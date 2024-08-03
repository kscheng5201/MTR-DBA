#!/bin/bash
gg='/etc/zabbix/alertscripts/trans.txt'
mysql -N --silent -e "SELECT * FROM global_3rd_db.gl_game_transferexception where status=0 AND ((from_channel_id=0 AND to_channel_id=11) or (from_channel_id=11 AND to_channel_id=0) or (from_channel_id =0 AND to_channel_id=17) or (from_channel_id=17 AND to_channel_id=0) or (from_channel_id=0 AND to_channel_id=32) or (from_channel_id=32 AND to_channel_id=0));"> $gg
a=`cat $gg |awk '{print $6 ,$7}'|grep 11|wc -l` #AE
b=`cat $gg |awk '{print $6 ,$7}'|grep 32|wc -l` #BG
c=`cat $gg |awk '{print $6 ,$7}'|grep 17|wc -l` #幸運棋牌
if [ "${a}" -eq 0 -a "${b}" -eq 0 -a "${c}" -eq 0 ];then #正常
        echo 0
elif [ "${b}" -gt 0 -a "${a}" -eq 0 -a "${c}" -eq 0 ];then #BG
        echo 32
elif [ "${c}" -gt 0 -a "${a}" -eq 0 -a "${b}" -eq 0 ];then #幸運棋牌
        echo 17
elif [ "${a}" -gt 0 -a "${b}" -eq 0 -a "${c}" -eq 0 ];then #AE
        echo 11
else #多項
        echo 1
fi
