#!/bin/bash
##########################################################
# Project: postgreSQL 還原
# Branch: 第一步——清空還原機並建立 User & Role
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
## secret 檔案路徑
secret_dir=/opt/3-0-lab/application/app-secret
## cloud sql 相關 secret 檔案名稱
secrets=`ls $secret_dir | grep ^sql | grep -v aws | grep -v tc`

## 還原機的 Master 帳號 & 密碼
pg_pwd='postgres'

## 取得還原機的名稱
deployments=`gcloud sql instances list | awk '{print $1}' | grep ^dba`



## 迴圈刪除所有還原機的 database & user
for r in $deployments; 
do 
    ## 取得所有 database 名稱
    databases=`gcloud sql databases list -i $r | awk '{print $1}' | grep -v NAME | grep -v postgres`

    for d in $databases; 
    do
        gcloud sql databases delete $d -i $r
    done


    ## 取得所有 user 名稱
    users=`gcloud sql users list -i $r | awk '{print $1}' | grep -v NAME | grep -v postgres`

    for u in $users;
    do 
        gcloud sql users delete $u -i $r
    done
done


## 進入還原機建立帳號密碼
for r in $deployments; 
do
    if [[ "$r" =~ 'fe' ]];
    then 
        secrets=`ls $secret_dir | grep ^sql | grep cs | grep -v aws | grep -v tc`

        for s in $secrets;
        do
            user=`grep user $secret_dir/$s | grep -v '^#' | cut -d : -f 2`
            password=`grep password $secret_dir/$s | grep -v '^#' | cut -d : -f 2 | sed 's/^ *//g'`

            gcloud sql users create $user -i $r --password="$password"
        done

        ip=`gcloud sql instances list | grep -v fe | grep $r | awk '{print $4}'`
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "CREATE ROLE sit_app;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "CREATE ROLE sit_sr;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "CREATE USER app_jr WITH PASSWORD 'bzUCpCnMVspNg7Dp';" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_app TO app_svc;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_app TO app_jr;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_app TO flyway" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_sr TO flyway;" 2> /dev/null

    else
        secrets=`ls $secret_dir | grep ^sql | grep -v cs | grep -v aws | grep -v tc`

        for s in $secrets;
        do
            user=`grep user $secret_dir/$s | grep -v '^#' | cut -d : -f 2`
            password=`grep password $secret_dir/$s | grep -v '^#' | cut -d : -f 2 | sed 's/^ *//g'`

            gcloud sql users create $user -i $r --password="$password"
        done

        ip=`gcloud sql instances list | grep -v fe | grep $r | awk '{print $4}'`
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "CREATE ROLE sit_app;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "CREATE ROLE sit_sr;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "CREATE USER app_jr WITH PASSWORD 'bzUCpCnMVspNg7Dp';" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_app TO app_svc;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_app TO app_jr;" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_app TO flyway" 2> /dev/null
        PGPASSWORD=$pg_pwd psql -h $ip -p 5432 -U postgres -d postgres -c "GRANT sit_sr TO flyway;" 2> /dev/null
    fi
done
