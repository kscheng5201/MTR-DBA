#!/bin/bash
#######################################
# Project: Slow Query Minitor
# Branch: 
# Author: Gok, the DBA
# Created: 2022-08-18
# Updated: 2023-06-15
# Note: 到達告警值，會輸出 slowlog 內容
#######################################

last_minute=`date -d "8 hour ago 1 minute ago" +"%Y-%m-%dT%H:%M"`
slow_dir=`sudo grep slow_query_log_file /etc/my.cnf | awk '{print $3}'`
data_dir=/etc/zabbix/alertscripts

## the vIndicator could be freq, time, row
if [[ -n "$1" ]]; 
then 
    vIndicator=$1
else 
    vIndicator="freq"
fi



## 假如這分鐘沒有任何 log，則全部變項皆顯示為 0
if [[ `sudo grep -c $last_minute $slow_dir` -eq 0 ]]; 
then 
    echo 0
else 
    ## 項目：累積次
    if [[ $vIndicator = 'freq' ]];
    then 
        # echo last minute total count is
        sudo grep -c $last_minute $slow_dir

        ## 如果最近一分鐘的 slowlog 累積 >= 30 筆
        if [[ `sudo grep -c $last_minute $slow_dir` -ge 30 ]]; 
        then 
            echo `hostname` >> $data_dir/up30f0m_$last_minute.log
            echo '慢查詢異常：一分鐘內累計次數大於 30 次' >> $data_dir/up30f0m_$last_minute.log
            echo ' ' >> $data_dir/up30f0m_$last_minute.log

            head=`sudo cat -n $slow_dir | grep $last_minute | awk '{print $1}' | head -1`
            tail=$(sudo cat -n $slow_dir | grep `date -d "8 hour ago" +"%Y-%m-%dT%H:%M"` | awk '{print $1}' | head -1)

            ## 如果最新的 slowlog 只有到前一分鐘的資料
            if [[ -z $tail ]]; 
            then 
                sudo grep -A11111 $last_minute $slow_dir >> $data_dir/up30f0m_$last_minute.log

                ## 若產生出來的檔案為空，則刪除；不然則傳送
                if [[ $(ls -al $data_dir/up30f0m_$last_minute.log | awk '{print $5}') -eq 0 ]];
                then 
                    rm -rf $data_dir/up30f0m_$last_minute.log
                else 
                    awk NF $data_dir/up30f0m_$last_minute.log > $data_dir/`hostname | cut -d - -f 3-4`_up30f0m_$last_minute.log 2> /dev/null
                    scp -i /home/gok/.ssh/gok_rsa $data_dir/`hostname | cut -d - -f 3-4`_up30f0m_$last_minute.log gok@10.25.1.183:/home/gok/slowlog > /dev/null
                    rm -rf $data_dir/up30f0m_$last_minute.log
                    rm -rf $data_dir/`hostname | cut -d - -f 3-4`_up30f0m_$last_minute.log
                fi

            ## 如果最新的 slowlog 已經有當前這分鐘的資料
            else
                sudo awk "NR>=${head}&&NR<${tail}" $slow_dir >> $data_dir/up30f0m_$last_minute.log

                ## 若產生出來的檔案為空，則刪除；不然則傳送
                if [[ $(ls -al $data_dir/up30f0m_$last_minute.log | awk '{print $5}') -eq 0 ]];
                then 
                    rm -rf $data_dir/up30f0m_$last_minute.log
                else 
                    awk NF $data_dir/up30f0m_$last_minute.log > $data_dir/`hostname | cut -d - -f 3-4`_up30f0m_$last_minute.log 2> /dev/null
                    scp -i /home/gok/.ssh/gok_rsa $data_dir/`hostname | cut -d - -f 3-4`_up30f0m_$last_minute.log gok@10.25.1.183:/home/gok/slowlog > /dev/null
                    rm -rf $data_dir/up30f0m_$last_minute.log
                    rm -rf $data_dir/`hostname | cut -d - -f 3-4`_up30f0m_$last_minute.log
                fi
            fi 
        fi

    ## 項目：查詢時間
    elif [[ $vIndicator = 'time' ]];
    then
        # echo last minute max sec is
        sudo grep -A2 $last_minute $slow_dir | grep Query_time | awk '{print $3}' | sort -n | tail -1

        more16=`sudo grep -A2 $last_minute $slow_dir | grep Query_time | awk '{print $3}' | sort -n | tail -1 | cut -d . -f 1`
        if [[ $more16 -ge 16 ]]; 
        then 
            sudo sh /etc/dba/more16s.sh $last_minute
        fi

    ## 項目：輸出筆數
    elif [[ $vIndicator = 'row' ]];  
    then
        # echo last minute the max row is
        sudo grep -A2 $last_minute $slow_dir | grep Rows_sent | awk '{print $7}' | sort -n | tail -1

        max_sent=`sudo grep -A2 $last_minute $slow_dir | grep Rows_sent | awk '{print $7}' | sort -n | tail -1`
        if [[ $max_sent -ge 100000 ]]; 
        then 
            sudo sh /etc/dba/send100k.sh
        fi

    ## vIndicator 未依規定輸入的情況
   else 
       echo -1
    fi
fi


## 項目：十分鐘內累計大於 30 次
target=`sudo grep Time $slow_dir | tail -30 | head -1 | awk '{print $3}' | cut -d . -f 1`
target=`date +%s -d "$target"`

b10m=`date -d "8 hour ago 10 minute ago" +%s`

if [[ $target -ge $b10m ]]; 
then 
    echo `hostname` >> $data_dir/up30f10m_$last_minute.log
    echo '慢查詢異常：十分鐘內累計次數大於 30 次' >> $data_dir/up30f10m_$last_minute.log
    echo ' ' >> $data_dir/up30f10m_$last_minute.log

    ts=`sudo grep Time: $slow_dir | tail -30 | head -1`
    sudo grep -A11111 $ts $slow_dir >> $data_dir/up30f10m_$last_minute.log

    ## 若產生出來的檔案為空，則刪除；不然則傳送
    if [[ $(ls -al $data_dir/up30f10m_$last_minute.log | awk '{print $5}') -eq 0 ]];
    then 
        rm -rf $data_dir/up30f10m_$last_minute.log
    else 
        awk NF $data_dir/up30f10m_$last_minute.log > $data_dir/`hostname | cut -d - -f 3-4`_up30f10m_$last_minute.log 2> /dev/null
        scp -i /home/gok/.ssh/gok_rsa $data_dir/`hostname | cut -d - -f 3-4`_up30f10m_$last_minute.log gok@10.25.1.183:/home/gok/slowlog > /dev/null
        rm -rf $data_dir/up30f10m_$last_minute.log
        rm -rf $data_dir/`hostname | cut -d - -f 3-4`_up30f10m_$last_minute.log
    fi
fi