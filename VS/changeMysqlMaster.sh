#!/bin/bash
#################################################
# Project: MySQL Master-Slave Switch Manually
# Branch: 
# Author: Gok, the DBA
# Created: 2023-08-08
# Updated: 2023-08-08
# Note: 手動執行 MySQL 主從切換
#################################################

user='centos'
old_master='10.150.1.180'
new_master='10.151.1.182'
PWW='1qaz@WSX'


read -ep "現在已經停止所有對 MySQL Server 的讀取及寫入？ (Yes/No)" ans
answer=$ans
shopt -s nocasematch


if [[ "${answer,,}" =~ ^(YES|Y) ]];
then
    echo "現在開始進行主從切換"
    echo ...


    ## 取得所有現行 slave 的 ip
    slave_ips=`ssh ${user}@${old_master} "netstat -na | grep 3306 | grep ${old_master}" | awk '{print $5}' | cut -d : -f 1`

    ## 逐一確認每台 slave 的狀態，以及 Master 是誰
    for ip in $slave_ips; 
    do
        Slave_Running=`ssh ${user}@${ip} "mysql -sN -uroot -p${PWW} -e 'show slave status\G' 2> /dev/null" | grep -c Yes`
        if [[ $Slave_Running -ne 2 ]]; 
        then 
            echo $ip Slave_IO_State is something wrong
            exit
        fi

        Master_Host=`ssh ${user}@${ip} "mysql -u root -p${PWW} -e 'show slave status\G' 2> /dev/null" | grep Master_Host | awk '{print $2}'`
        if [[ "${Master_Host}" != "${old_master}" ]];   
        then
            echo $ip\'s Master is $Master_Host, Not $old_master
            exit
        fi

        if [[ $Slave_Running == 2 && "${Master_Host}" == "${old_master}" ]];
        then 
            echo 
            echo $ip\'s Slave_State is GOOD and Master $Master_Host = $old_master
        fi 
    done


    ## 以上皆確認無誤，才會往下執行
    flag=`echo $?`
    if [[ $flag == "0" ]];
    then
        ## 取得新 Master 的 binlog_file & position
        new_master_bin=`ssh ${user}@${new_master} "mysql -uroot -p${PWW} -e 'show master status\G' 2> /dev/null" | grep File | awk '{print $2}'`
        new_master_pos=`ssh ${user}@${new_master} "mysql -uroot -p${PWW} -e 'show master status\G' 2> /dev/null" | grep Position | awk '{print $2}'`

        ## 針對變更後仍是 slave 的 server，製作 command
        for ip in $slave_ips;
        do
            if [[ $ip != $new_master ]];
            then 
                slave_to_slave="
                    stop slave;
                    reset slave; 
                    CHANGE MASTER TO 
                        MASTER_HOST='${new_master}', 
                        MASTER_USER='replication', 
                        MASTER_PASSWORD='1qaz+2wsx', 
                        MASTER_PORT=3306, 
                        MASTER_LOG_FILE='$new_master_bin', 
                        MASTER_LOG_POS=$new_master_pos
                    ;
                    start slave
                    ;"

                echo "${slave_to_slave}" | sudo tee /home/${user}/slave_to_slave.sql > /dev/null
                scp -rp /home/${user}/slave_to_slave.sql ${user}@${ip}:/home/${user} > /dev/null
                ssh ${user}@${ip} "mysql -sN -uroot -p${PWW} -e 'SOURCE /home/${user}/slave_to_slave.sql;'" 2> /dev/null
                ssh ${user}@${ip} "rm -rf /home/${user}/slave_to_slave.sql"
            fi
        done


        ## 針對變更後才是 slave 的 server (原是 master)，製作 command
        master_to_slave="
            reset master; 
            reset slave all; 
            CHANGE MASTER TO 
                MASTER_HOST='${new_master}', 
                MASTER_USER='replication', 
                MASTER_PASSWORD='1qaz+2wsx', 
                MASTER_PORT=3306, 
                MASTER_LOG_FILE='$new_master_bin', 
                MASTER_LOG_POS=$new_master_pos
            ;
            start slave
            ;"

        echo "${master_to_slave}" | sudo tee /home/${user}/master_to_slave.sql > /dev/null
        scp -rp /home/${user}/master_to_slave.sql ${user}@${old_master}:/home/${user} > /dev/null
        ssh ${user}@${old_master} "mysql -sN -uroot -p${PWW} -e 'SOURCE /home/${user}/master_to_slave.sql;'" 2> /dev/null
        ssh ${user}@${old_master} "rm -rf /home/${user}/master_to_slave.sql"
    fi



    ## 確認新的主從架構狀態
    ## 取得所有新的 slave  ip
    slave_ips=`ssh ${user}@${new_master} "netstat -na | grep 3306 | grep ${old_master}" | awk '{print $5}' | cut -d : -f 1`

    ## 逐一確認每台 slave 的狀態，以及 Master 是誰
    for ip in $slave_ips; 
    do
        echo 
        echo Checking the New Slave Status
        echo ip = $ip

        Slave_Running=`ssh ${user}@${ip} "mysql -sN -uroot -p${PWW} -e 'show slave status\G' 2> /dev/null" | grep -c Yes`
        if [[ $Slave_Running -ne 2 ]]; 
        then 
            echo $ip\' Slave_IO_State is something wrong
            exit
        fi

        Master_Host=`ssh ${user}@${ip} "mysql -u root -p${PWW} -e 'show slave status\G' 2> /dev/null" | grep Master_Host | awk '{print $2}'`
        if [[ "${Master_Host}" != "${new_master}" ]];   
        then
            echo $ip\'s Master is $Master_Host, Not $new_master
            exit
        fi

        if [[ $Slave_Running == 2 && "${Master_Host}" == "${new_master}" ]];
        then 
            echo 
            ssh ${user}@${ip} "mysql -uroot -p${PWW} -e 'show slave status\G' 2> /dev/null" | head
        fi 
    done


    ## 解除新 Master 原本的 Slave 身分
    ssh ${user}@${new_master} "mysql -uroot -p${PWW} -e 'stop slave; reset slave all;' 2> /dev/null" 
    echo 
    echo Checking the New Master Status
    echo ip = $new_master
    ssh ${user}@${new_master} "mysql -uroot -p${PWW} -e 'show master status\G' 2> /dev/null" | head
    ssh ${user}@${new_master} "mysql -uroot -p${PWW} -e 'show slave status\G' 2> /dev/null" | head


    ## 以上皆確認無誤，才會往下執行
    flag=`echo $?`
    if [[ $flag == "0" ]];
    then
        echo 
        echo ======
        echo 'COMPLETE ALL AND CONFIRM ALRIGHT!'
    fi

    ## 刪除檔案
    sudo rm -rf /home/${user}/slave_to_slave.sql
    sudo rm -rf /home/${user}/master_to_slave.sql

else 
    echo
    echo 請停止所有對 MySQL Server 的讀取及寫入之後，再來進行此工作！
fi