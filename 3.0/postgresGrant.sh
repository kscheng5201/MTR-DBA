#!/bin/bash
######################################
# Project: Postgres Table Grant
# Branch: 
# Author: Gok, the DBA
# Created: 2024-04-30
# Updated: 2024-05-02
# Note: Grant new table to QA account
######################################


data_dir=/data

qa_list='
phoe_beqa
ivan_beqa
ann_beqa
tina_beqa
james_qa
elliot_qa
meta_qa
jungyu_beqa
charlie_beqa
'

project=`kubectl config current-context`

if [[ "$project" != 'gke-ldpro-qa' ]]; 
then 
    echo 
    echo "請切換到正確的專案再執行！現在是 $project"
    echo ==========
    exit
fi



## 執行 SQL 指令
echo 
read -ep "請問要執行的指令是在前台 (cs) 還是後台 (plt): " stage
echo '======'

## 檢查 port-forward 連線是否已經建立
port=`ps -aux | grep port-forward | grep postgres-$stage-master | grep -v grep | tail -c 11 | cut -d : -f 1`

if [[ -z $port ]];
then
    ## 取得 port-forward 資訊
    svc=`kubectl get service -n sqlproxy | awk '{print $1}' | grep postgres-$stage-master`
    port=`date +%s | tail -c 6 | sed 's/^0*//'`

    if [[ $port -gt 65535 ]];
    then
        port=`expr $port - 65535`
    fi

    ## 進行 port-forward 連線，利用 centos 這帳號
    nohup kubectl port-forward -n sqlproxy service/$svc $port:5432 & 1> /dev/null
    sleep 1s

    echo
    echo '已設置完成的連線資訊如下：'
    ps -aux | grep port-forward | grep $stage-master | grep `whoami` | cut -d / -f 3
    echo '======'
fi


## 取得所有的 database 名稱
dbs=`PGPASSWORD="qa_${stage}_java_app_db" psql -h localhost -p $port -U ${stage}_java_app postgres -t -c "SELECT datname FROM pg_database"`
touch $data_dir/postgres-${stage}-tables-new.txt
echo `date +"%F %T"` >> $data_dir/postgres-${stage}-tables-new.txt

for db in $dbs; 
do 
    # echo 
    # echo db = $db
    ## 計算各 database 裡面的 table 總數
    table_num=`PGPASSWORD="qa_${stage}_java_app_db" psql -h localhost -p $port -U ${stage}_java_app $db -t -c "SELECT COUNT(1) FROM information_schema.tables" | head -1 | sed 's/^[[:blank:]]*//'`

    if [[ -z $table_num ]]; 
    then 
        ## 未取到值的 db，寫到 log
        echo $db >> $data_dir/postgres-${stage}-tables-new.txt
        echo 0 >> $data_dir/postgres-${stage}-tables-new.txt
    else
        ## 有取到值的 db，開始檢查是否有新增資料表
        echo $db >> $data_dir/postgres-${stage}-tables-new.txt
        echo $table_num >> $data_dir/postgres-${stage}-tables-new.txt

        for qa in $qa_list; 
        do 
            sql_syntax="
                ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO $qa;
                GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to $qa;
                GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public to $qa;
                GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public to $qa;
                ALTER DEFAULT PRIVILEGES IN SCHEMA $db GRANT ALL PRIVILEGES ON TABLES TO $qa;
                GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA $db to $qa;
                GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA $db to $qa;
                GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA $db to $qa;
                "
            echo 
            # echo qa = $qa
            # echo $sql_syntax

            ## 取得先前各資料庫的資訊表總數
            old_table_num=`grep $db -A1 $data_dir/postgres-${stage}-tables.txt | tail -1`

            if [[ $old_table_num -le $table_num ]]; 
            then 
                ## 發現資料表數目有增長，才執行 Grant 指令
                PGPASSWORD="qa_${stage}_java_app_db" psql -h localhost -p $port -U ${stage}_java_app $db -c "$sql_syntax"
            fi
        done
    fi
done


## 檔案更名
mv $data_dir/postgres-${stage}-tables-new.txt $data_dir/postgres-${stage}-tables.txt

## 刪除 centos 所建立的 port-forward 連線
ps -aux | grep port-forward | grep master-gcloud-sqlproxy | grep `whoami` | awk '{print $2}' | xargs kill