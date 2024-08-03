# for rp02, rp03, rp04
#!/bin/bash
##################################
# Project: Check the Query Status
# Branch: 
# Author: Gok, the DBA
# Created: 2022-08-10
# Updated: 2022-09-13
# Note: 
###################################

mysql_user="zabbix"
mysql_pwd="csnt@P@ssw0rd"
token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"
title="MySQL Query Monitor Info"


short_query="
    SELECT 
        count(*)
    FROM information_schema.processlist 
    WHERE command = 'Query'
        and user NOT IN ('$mysql_user', 'gcprds')
    ;"    
to_zabbix=`mysql -sN -u ${mysql_user} -p${mysql_pwd} -e "$short_query" 2>/dev/null`
echo ${to_zabbix}
#echo ${to_zabbix} `date` | sudo tee -a QueryMonitor.log


check_query="
    SELECT 
        '$(hostname)' host,
        CONCAT(user, '@', SUBSTRING_INDEX(host, ':', 1)) user, 
        info sql_syntax 
    FROM information_schema.processlist 
    WHERE command = 'Query' 
        and user NOT IN ('$mysql_user', 'gcprds')
        and info NOT REGEXP 'SQL_NO_CACHE'
    \G"
to_telegram=`mysql -u ${mysql_user} -p${mysql_pwd} -e "$check_query" 2>/dev/null`


if [[ -n $to_telegram ]];
then 
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=${title} at [[`hostname`]] 

${to_telegram}" > /dev/null 2>&1

fi
