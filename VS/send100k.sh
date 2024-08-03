#!/bin/bash
###################################################
# Project: 輸出特定時段的 slow log 細節
# Branch: 
# Author: Gok, the DBA
# Created: 2023-05-25
# Updated: 2023-06-30
# Note: 修正檔案名稱 sent100k 為 send100k
####################################################

ts=`date -d "8 hour ago 1 minute ago" +"%Y-%m-%dT%H:%M"`
slow_dir=`sudo grep slow_query_log_file /etc/my.cnf | awk '{print $3}'`
data_dir=/etc/dba


## 這個時段內的輸出超過 100000 筆資料的總數
max100k=`sudo grep -A2 $ts $slow_dir | grep Rows_sent | awk '$7 >= 100000' | wc -l`

## 如果有出現 Rows_sent >= 100000 的 slow log 時
if [[ $max100k -gt 0 ]];
then 
    ## 先建立檔案
    echo `hostname` >> $data_dir/send100k_$ts.log
    echo ' ' >> $data_dir/send100k_$ts.log
    here=`sudo grep -c $ts $slow_dir`

    ## 如果 Rows_sent >= 100000 的 slow log 總數就是全部
    if [[ $max100k -eq $here ]];
    then 
        head=`sudo cat -n $slow_dir | grep $ts | awk '{print $1}' | head -1`
        tail=$(sudo cat -n $slow_dir | grep `date -d "8 hour ago" +"%Y-%m-%dT%H:%M"` | awk '{print $1}' | head -1)

        if [[ -z $tail ]]; 
        then 
            ## 如果最新的 slowlog 只有到前一分鐘的資料
            sudo grep -A11111 $ts $slow_dir >> $data_dir/send100k_$ts.log
        else
            ## 如果最新的 slowlog 已經有當前這分鐘的資料
            sudo awk "NR>=${head}&&NR<${tail}" $slow_dir >> $data_dir/send100k_$ts.log
        fi 

    ## 這分鐘的 slow log 夾雜 Rows_sent < 100000 的結果
    else
        ## 取得同時段的全部時間戳 Line Number
        rm -rf $data_dir/line.txt
        sudo cat -n $slow_dir | grep $ts | awk '{print $1}' > $data_dir/line.txt

        ## 取得同時段顯示 Rows_sent >= 100000 的 Line Number
        one=`sudo cat -n $slow_dir | grep -A2 $ts | grep Rows_sent | awk '$7 >= 100000' | awk '{print $1}'`
        for i in $one;
        do
            i=`expr $i - 2`
            j=`grep -A1 $i $data_dir/line.txt | tail -1`
            sudo awk "NR>=${i}&&NR<${j}" $slow_dir >> $data_dir/send100k_$ts.log
            sed -i '' -e '$ d' $data_dir/send100k_$ts.log 2> /dev/null
            echo --- >> $data_dir/send100k_$ts.log
            echo --- >> $data_dir/send100k_$ts.log
        done
    fi


    ## 若產生出來的檔案為空，則刪除；不然則傳送
    if [[ $(ls -al $data_dir/send100k_$ts.log | awk '{print $5}') -eq 0 ]];
    then 
        rm -rf $data_dir/send100k_$ts.log
    else 
        ## 刪除成果檔最後兩行
        # sed -i '' -e '$ d' $data_dir/send100k_$ts.log 2> /dev/null
        # sed -i '' -e '$ d' $data_dir/send100k_$ts.log 2> /dev/null
        ## 刪除空白行
        awk NF $data_dir/send100k_$ts.log > $data_dir/`hostname | cut -d - -f 3-4`_send100k_$ts.log 2> /dev/null

        scp -i /home/gok/.ssh/gok_rsa $data_dir/`hostname | cut -d - -f 3-4`_send100k_$ts.log gok@10.25.1.183:/home/gok/slowlog > /dev/null
        rm -rf $data_dir/send100k_$ts.log
        rm -rf $data_dir/`hostname | cut -d - -f 3-4`_ent100k_$ts.log
    fi

    ## 刪除 Line Number 參考用檔案
    rm -rf $data_dir/line.txt
fi
