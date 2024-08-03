#!/bin/bash
##########################################################
# Project: postgreSQL 還原
# Branch: 第二步——匯入備份資料到還原機
# Author: Gok, the DBA
# Created: 2023-09-05
# Updated: 2023-09-06
# Note: 使用 Cloud SQL 的 Import，無法使用 Postgres 原生語法
###########################################################

mkdir -p /etc/dba
log=/etc/dba/postgresRecover.log

#  cs: 前台資料
# plt: 後台資料

echo ====== $(date +"%Y%m%d-%H%M") Recover START >> $log

## 備份資料位置
bucket_name='3-0-postgres-backup'
## 還原機的 Master 帳號 & 密碼
pg_pwd='postgres'

## secret 檔案路徑
secret_dir=/opt/3-0-lab/application/app-secret
## run 相關檔案路徑
run_dir=/opt/3-0-lab/application/cloud-sql-access/postgres-permission/sh
## DBA 資料夾
dba_dir=/etc/dba

## 取得還原機的名稱
deployments=`gcloud sql instances list | awk '{print $1}' | grep ^dba | grep fe`



## 進入還原機進行資料還原
for r in $deployments; 
do 
    if [[ $r =~ "-fe" ]];
    then
        # 這裡只有檢查 flyway 的密碼，主要是 run.sh 只有針對 postgres & flyway 兩帳號做權限設定
        # 又，預設 Master 帳號 postgres 的密碼就是 postgres
        flyway_name_in_secret=`ls $secret_dir | grep flyway | grep -v cs | grep -v aws`
        flyway_pass_in_secret=`grep -A1 'user: flyway' $secret_dir/$flyway_name_in_secret | grep password | cut -d : -f 2 | sed 's/^ *//g'`
        flyway_pass_in_run=`grep -A1 '^# flyway' $run_dir/run.sh | grep PGPASSWORD | cut -d = -f 2`        

        # 若 flyway & postgres 兩者的密碼都正確
        if [[ $flyway_pass_in_secret = $flyway_pass_in_run && -n `grep PGPASSWORD $run_dir/run.sh | grep postgres` ]]; 
        then 
            ip=`gcloud sql instances list | grep $r | awk '{print $4}'`


            db_schemas='cs_basics cs_fund cs_game cs_message cs_proxy cs_proxy'
            PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "\set db_name $1" -c "\set schema_name $2" -f $3



            $run_dir/run.sh cs_basics cs_basics $run_dir/create.sh $run_dir/flyway.sh
            $run_dir/run.sh cs_fund cs_fund $run_dir/create.sh $run_dir/flyway.sh
            $run_dir/run.sh cs_game cs_game $run_dir/create.sh $run_dir/flyway.sh
            $run_dir/run.sh cs_message cs_message $run_dir/create.sh $run_dir/flyway.sh
            $run_dir/run.sh cs_proxy cs_proxy $run_dir/create.sh $run_dir/flyway.sh
            $run_dir/run.sh cs_user cs_user $run_dir/create.sh $run_dir/flyway.sh
        fi


        # 取得 gcloud sql instances serviceAccountEmailAddress
        serviceAccountEmailAddress=`gcloud sql instances describe $r | grep serviceAccountEmailAddress | cut -d : -f 2 | sed 's/^ *//g'`
        # 授權 bucket 給 serviceAccountEmailAddress
        gsutil iam ch serviceAccount:$serviceAccountEmailAddress:objectAdmin gs://$bucket_name 2>&1 > /dev/null
        
        ## 若備份資料的 bucket 其 IAM policy 帶有 serviceAccountEmailAddress 資訊，則開始進行還原
        if [[ -n `gcloud alpha storage buckets get-iam-policy gs://$bucket_name | grep $serviceAccountEmailAddress` ]];
        then 
            dbs=`gsutil ls gs://$bucket_name/cs | cut -d / -f 5`

            for db in $dbs;
            do
                ## 找到最新一份檔案
                zipped_file=`gsutil ls -r gs://$bucket_name/cs/$db | grep gz$ | tail -1`
                ## 把壓縮檔解壓縮後放回 GCS
                gsutil cat $zipped_file | zcat | gsutil cp - $(echo $zipped_file | sed 's/.gz/.sql/g')
                ## 找到要執行還原的 sql 檔案
                latest_file=`gsutil ls -r gs://$bucket_name/cs/$db | grep sql$ | tail -1`
                
                echo 
                echo `date`
                echo working on $db to $r by $latest_file >> $log
                # gcloud sql databases delete -q $db -i $r
                # gcloud sql databases create $db -i $r
                gcloud sql import sql -q $r $latest_file --database=$db
                echo Y
            done
        fi
    fi
done

echo ====== $(date +"%Y%m%d-%H%M") Recover END >> $log
echo >> $log

