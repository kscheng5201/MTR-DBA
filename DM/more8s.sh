#!/bin/bash
#######################################################
# Project: 輸出 SQL 運行超過 8 秒的 slow log 細節
# Branch: 
# Author: Gok, the DBA
# Created: 2023-06-01
# Updated: 2023-06-02
# Note: 每分鐘運行一次，設定絕對路徑才能放到 /etc/dba
########################################################

last=`date -d "8 hour ago 1 minute ago" +"%Y-%m-%dT%H:%M"`
last=`echo $last | sed 's/.$//'`

# last='2023-06-01T07'
# echo
# echo last = $last

## 取得 slow log 路徑
slow_dir=`mysql -u root -p1qaz@WSX -sN -e "show variables like '%slow%';" | tail -1 | awk '{print $2}'`


## 結算此時段運行超過 8 秒的 SQL 總數
more8=`grep -A2 "$last" $slow_dir | grep Query_time | awk '{print $3}' | sort | awk '$1 >= 8' | wc -l`
# echo
# echo more8 = $more8

## 假如此時段存在運行超過 8 秒的 SQL
if [[ $more8 -gt 0 ]];
then
    ## 取得此時段的全部時間戳
    cat -n $slow_dir | grep "$last" | awk '{print $1}' > /etc/dba/key.txt
    # echo 
    # wc -l key.txt

    ## 取得 SQL 運行的全部秒數(>= 8s)
    float8=`grep -A2 "$last" $slow_dir | grep Query_time | awk '{print $3}' | awk '$1 >= 8'`
    # echo
    # echo float8 = 
    # echo $float8

    for f in $float8;
    do 
        ## 取得當前秒數的時間戳
        one=`cat -n $slow_dir | grep -A2 "$last" | grep -B2 "Query_time: $f" | grep Time | awk '{print $1}'`        
        # echo 
        # echo f = $f
        # echo one = $one

        ## 輸出開始
        for i in $one;
        do
            # echo start at $i
            j=`grep -A1 $i key.txt | tail -1`
            j=`expr $j - 1`
            # echo end at $j
            awk "NR>=${i}&&NR<=${j}" $slow_dir >> /etc/dba/output.txt
            echo --- >> /etc/dba/output.txt
            echo --- >> /etc/dba/output.txt
        done
    done
fi

# ts=`date +"%Y%m%dT%H"`
# ts=`echo $ts | sed 's/.$//'`
# awk NF output.txt > output_${ts}.txt

awk NF /etc/dba/output.txt > /etc/dba/output_${last}.txt 2> /dev/null

if [[ `ls -al /etc/dba/output_${last}.txt | awk '{print $5}'` -eq 0 ]];
then 
    rm -rf /etc/dba/output_${last}.txt
fi

echo "###### `date` ######" >> /etc/dba/more8s.log
echo checked period: $last >> /etc/dba/more8s.log
echo slow query total: $more8 >> /etc/dba/more8s.log
echo output file: /etc/dba/output_${last}.txt >> /etc/dba/more8s.log
echo >> /etc/dba/more8s.log


rm -rf /etc/dba/output.txt
rm -rf /etc/dba/key.txt
