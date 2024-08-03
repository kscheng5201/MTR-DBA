#!/bin/bash
#######################################################
# Project: 輸出 SQL 運行超過 16 秒的 slow log 細節
# Branch: 
# Author: Gok, the DBA
# Created: 2023-06-01
# Updated: 2023-09-05
# Note: 修正 SQL 會印出空白內容的 bug
########################################################

#last=`date -d "8 hour ago 1 minute ago" +"%Y-%m-%dT%H:%M"`
last=$1
data_dir=/etc/dba

## 取得 slow log 路徑
slow_dir=`sudo grep slow_query_log_file /etc/my.cnf | awk '{print $3}'`

## 結算此時段運行超過 16 秒的 SQL 總數:
more16=`sudo grep -A2 "$last" $slow_dir | grep Query_time | awk '$3 >= 16' | wc -l`



## 假如此時段存在運行超過 16 秒的 SQL
if [[ $more16 -gt 0 ]];
then
    echo `hostname` >> $data_dir/output.log
    echo '慢查詢異常：秒數大於16秒' >> $data_dir/output.log
    echo ' ' >> $data_dir/output.log

    ## 取得此時段的全部資料
    # awk "/$last/,0" $slow_dir >> $data_dir/output.log

    ## 計算此時段的全部次數
    now_total=`sudo grep -c "$last" $slow_dir`


    ## 若全部都是超過 16 秒的 SQL
    if [[ $now_total -eq $more16 ]];
    then
        ## 直接全部印出 
        sudo awk "/$last/,0" $slow_dir >> $data_dir/output.log

    ## 混有秒數 < 16 秒的 SQL
    else
        ## 取得秒數大於 16 秒的 Query_time 行數
        now_on=`sudo cat -n $slow_dir | grep -A2 "$last" | grep Query_time | awk '$4 >= 16' | awk '{print $1}'`

        ## 取得關鍵時間戳之後的所有時間戳行數
        cat sudo cat -n $slow_dir | awk "/$last/,0" | grep Time | awk '{print $1}' > $data_dir/key.log

        ## 得到行數可能不只一筆
        for n in $now_on;
        do
            ## 調整回 Time 的那行行號
            n=`expr $n - 2`
            ## 取得下個 Time 的前一行號
            m=`grep -A1 $n $data_dir/key.log | tail -1`

            ## 假如沒有下一行：自己就是最後一筆 slowlog 紀錄
            if [[ $n -eq $m ]];
            then
                ## 取得整個 slowlog 的最後一行行號
                m=`cat -n $slow_dir | tail -1 | awk '{print $1}'`
                awk "NR>=${n}&&NR<=${m}" $slow_dir >> $data_dir/output.log
                echo --- >> $data_dir/output.log
                echo --- >> $data_dir/output.log
            else
                awk "NR>=${n}&&NR<${m}" $slow_dir >> $data_dir/output.log
                echo --- >> $data_dir/output.log
                echo --- >> $data_dir/output.log
            fi
        done
    fi
fi


## 刪除空白行
awk NF $data_dir/output.log > $data_dir/`hostname | cut -d - -f 3-4`_more16s_${last}.log 2> /dev/null

## 若產生出來的檔案為空，則刪除；不然則傳送
if [[ $(ls -al $data_dir/`hostname | cut -d - -f 3-4`_more16s_${last}.log | awk '{print $5}') -eq 0 ]];
then 
    rm -rf $data_dir/`hostname | cut -d - -f 3-4`_more16s_${last}.log
else 
    scp -i /home/gok/.ssh/gok_rsa $data_dir/`hostname | cut -d - -f 3-4`_more16s_${last}.log gok@10.25.1.183:/home/gok/slowlog > /dev/null
fi

echo "###### `date` ######" >> $data_dir/more16s.log
echo checked period: $last >> $data_dir/more16s.log
echo slow query total: $more16 >> $data_dir/more16s.log
echo output file: $data_dir/`hostname | cut -d - -f 3-4`_more16s_${last}.log >> $data_dir/more16s.log
echo >> $data_dir/more16s.log

rm -rf $data_dir/output.log
rm -rf $data_dir/key.log
rm -rf $data_dir/`hostname | cut -d - -f 3-4`_more16s_${last}.log
