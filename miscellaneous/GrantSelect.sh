#!/bin/bash
##############################################################
# Project: Grant the new tables if created on routine
# Branch: Priviliege attained
# Author: Gok, the DBA
# Created: 2022-08-15
# Updated: 2022-08-23
# Note: focus on RD relevant account 
##############################################################

## parameter setting
mysql_user="root" 
mysql_password="1qaz@WSX"
key_db="global_3rd_db"
key_user="rd"

token="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat="-675619128"


## Get the new-made table list
get_tables="
    select table_name 
    from information_schema.tables 
    where table_schema = '$key_db' 
        and create_time >= date_format(now() - interval 12 hour, '%Y-%m-%d %H:00:00')
    ;"
echo ''
echo [Get the new-made-table list]
echo $get_tables
table_list=`mysql -u $mysql_user -p$mysql_password -e "$get_tables"`
echo ''
echo $table_list


for table in $table_list; 
do 
    ## Find out the users with grant syntax
    grant_sql="
        select 
            concat('GRANT SELECT ON $key_db.$table TO ', quote(user), '@', quote(host), ';') 
        from mysql.user 
        where user REGEXP '$key_user' 
            and user <> 'gcprds'
        ;"
    echo ''
    echo [Find out the users with grant syntax]
    echo $grant_sql
        # Must check the list carefully if the some users jump into with the keyword randomly 
    mysql -u $mysql_user -p$mysql_password -e "$grant_sql" >> grant.sql
    sed -i '/table_name/d' grant.sql
    sed -i '/concat/d' grant.sql
done

## see whether the grant.sql exists
if [ -f grant.sql ];
then
    echo ''
    echo [New table found! Source the grant syntax]
    mysql -u $mysql_user -p$mysql_password -e "source grant.sql"

    msg=`cat grant.sql`
    curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=Grant Select Info at [[`hostname`]] 

${msg}" > /dev/null 2>&1

    echo ''
    echo [remove the working file grant.sql]
    rm -f grant.sql
else
    echo ''
    msg="There is no new table to grant!"
    # curl -X POST "https://api.telegram.org/bot${token}/sendMessage" -d "chat_id=${chat}&text=[[`hostname`]] ${msg}" > /dev/null 2>&1

fi
