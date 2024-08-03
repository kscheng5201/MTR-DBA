# for rp01
#!/bin/bash
a=`cat /etc/zabbix/alertscripts/game_maintain.txt|grep $1,`
aa=`echo $a|awk -F ',' '{print $2}'|awk '{print $1}'`
bb=`echo $a|awk -F ',' '{print $2}'|awk '{print $2}'`
cc=`echo $a|awk -F ',' '{print $3}'|awk '{print $1}'`
dd=`echo $a|awk -F ',' '{print $3}'|awk '{print $2}'`
ee=`echo $a|awk -F ',' '{print $4}'`
c_time=`date +%s`       # 目前時間日期
ktime_stamp=`date -d "$aa $bb" +%s`       # 起始日期與時間一同轉換為 timestamp
etime_stamp=`date -d "$cc $dd" +%s`       # 結束日期與時間一同轉換為 timestamp
k_compare=$(( $c_time - $ktime_stamp ))         # 目前時間與起始時間相減來比對
e_compare=$(( $c_time - $etime_stamp ))         # 目前時間與結束時間相減來比對
if [ $ee -eq 0 ];then     # 0表示後台有對外開啟這個遊戲，故比對是否有掛上維護
    if [ $k_compare -gt 0 -a $e_compare -lt 0 ];then     # 如果結束時間大於目前時間 , 表示正在維護但未關閉遊戲 , 則回傳 1 觸發告警
        echo 1
    else
        echo 0                  # 如果結束時間小於目前時間 , 表示維護時間已過 , 而後台也處於非維護狀態 , 則回傳 0 不觸發告警
    fi
else
    echo 2      # 2表示遊戲處於關閉中未掛上前台
fi
