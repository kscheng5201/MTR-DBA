#!/bin/bash
###################################
# Project: Slow Query Minitor
# Branch: 
# Author: Gok, the DBA
# Created: 2022-08-18
# Updated: 2022-09-13
# Note: 
###################################

mysql_user='zabbix'
mysql_pwd='csnt@P@ssw0rd'
token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title="Slow Query Warnning"

## the vIndicator could be freq, time, row
if [[ -n "$1" ]]; 
then 
    vIndicator=$1
else 
    vIndicator="freq"
fi



## Get the directory of slow_query_log_file
slow_dir=$(echo `mysql -u $mysql_user -p$mysql_pwd -e "show variables like 'slow_query_log_file';" 2>/dev/null` | cut -d ' ' -f 4)

## Get the last minute record then count
head_now=$(sudo cat -n $slow_dir | grep '# Time' | grep `date -d "8 hour ago 1 minute ago" +"%Y-%m-%d"` | head -n 1 | cut -d '#' -f 1)
    # The time zone of slow log is UTC+0 at production, whatever Master/Slave/Backup



if [[ -z $head_now ]];
then 
    echo 0
else 
    head_now=$(($head_now * 1))

    # Count Total at current minute
    SQL_TOTAL=`sudo tail -n +$head_now $slow_dir | grep '# Time' | wc -l`

    # Count Only gcprds
    gcprds=`sudo tail -n +$head_now $slow_dir | grep gcprds | wc -l`


    if [[ $SQL_TOTAL = $gcprds ]]; 
    then 
        # The number for Zabbix dashboard
        echo 0
    else 
        last=`sudo cat -n $slow_dir | tail -n +$head_now | head -n 1 | cut -d '#' -f 1`
        last=$(($last * 1))

        if [[ $vIndicator = "freq" ]]; 
        then 
            echo $(($SQL_TOTAL - $gcprds))
        elif [[ $vIndicator = "time" ]]; 
        then 
            if [[ `sudo tail -n +$last $slow_dir | grep '# Query_time:' | wc -l` = 1 ]]; 
            then 
                sudo tail -n +$last $slow_dir | grep '# Query_time:' | cut -d ':' -f 2 | cut -d '.' -f 1
            else
                n=0
                for m in `sudo tail -n +$last $slow_dir | grep '# Query_time:' | cut -d ':' -f 2 | cut -d '.' -f 1`
                do 
                    if [[ $n -le $m ]]; 
                    then 
                        n=$m                       
                    fi
                done
                
                echo $n
            fi

        elif [[ $vIndicator = "row" ]];
        then 
            if [[ `sudo tail -n +$last $slow_dir | grep '# Query_time:' | wc -l` = 1 ]]; 
            then
                echo $(sudo tail -n +$last $slow_dir | grep '# Query_time:' | cut -d ':' -f 4 | cut -d 'R' -f 1)
            else 
                x=0
                for y in `sudo tail -n +$last $slow_dir | grep '# Query_time:' | cut -d ':' -f 4 | cut -d 'R' -f 1 | sed 's/^ *//g'`
                do 
                    if [[ $x -le $y ]]; 
                    then 
                        x=$y                       
                    fi
                done
                
                echo $x
            fi
        fi

        msg=`sudo tail -n +$last $slow_dir | grep '#'`
        # echo $msg


        ## The Format for the Telegram bot ###
        #curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

#${msg}" > /dev/null 2>&1
        ### The Format for the Telegram bot ###

        # Delete the First One Tenth row
        last10=`expr $last / 10`    
        # sudo sed -i "1,${last10}d" $slow_dir > /dev/null 2>&1
    fi
fi

## Get TG token information can put the below in the browser
# Step: Create A Group(Not Channel), Add the bot, message whatever, then check by the url 
# Or you will see nothing but {"ok":true,"result":[]}
# https://api.telegram.org/bot${token}/getUpdates
