#!/bin/bash
###################################################
# Project: postgreSQL 資料定期備份到 GCS
# Branch: 
# Author: Gok, the DBA
# Created: 2023-04-14
# Updated: 2023-04-25
# Note: 
####################################################

mkdir -p /etc/dba
log=/etc/dba/postgreBackup.log

#  cs: 前台資料
# plt: 後台資料

echo ====== $(date +"%Y%m%d-%H%M") backup START >> $log

# Get two replicas' name
replicas=`gcloud sql instances list | awk '{print $1}' | grep replica`
bucket_name='3-0-postgres-backup'


for r in $replicas; 
do 
    if [[ $r =~ "-fe-" ]];
    then
        # the front-end replica
        echo now is working on $r to $backet_name >> $log

        # get gcloud sql instances serviceAccountEmailAddress
        serviceAccountEmailAddress=`gcloud sql instances describe $r | grep serviceAccountEmailAddress | cut -d : -f 2 | sed 's/^ *//g'`
        # grant the bucket to the serviceAccountEmailAddress
        gsutil iam ch serviceAccount:$serviceAccountEmailAddress:objectAdmin gs://$bucket_name 2>&1 > /dev/null
        
        if [[ -n `gcloud alpha storage buckets get-iam-policy gs://$bucket_name | grep $serviceAccountEmailAddress` ]];
        then 
            dbs=`gcloud sql databases list -i $r | awk '{print $1}' | tail -n +2`

            for db in $dbs;
            do
                gcloud sql export sql $r gs://$bucket_name/cs/$db/$(date +"%Y%m%d-%H00").tar.gz  --database=$db >> $log
            done
        fi

    else
        # the back-end replica
        echo now is working on $r to $backet_name >> $log

        # get gcloud sql instances serviceAccountEmailAddress
        serviceAccountEmailAddress=`gcloud sql instances describe $r | grep serviceAccountEmailAddress | cut -d : -f 2 | sed 's/^ *//g'`
        # grant the bucket to the serviceAccountEmailAddress
        gsutil iam ch serviceAccount:$serviceAccountEmailAddress:objectAdmin gs://$bucket_name 2>&1 > /dev/null
        
        if [[ -n `gcloud alpha storage buckets get-iam-policy gs://$bucket_name | grep $serviceAccountEmailAddress` ]];
        then 
            dbs=`gcloud sql databases list -i $r | awk '{print $1}' | tail -n +2`

            for db in $dbs;
            do
                gcloud sql export sql $r gs://$bucket_name/plt/$db/$(date +"%Y%m%d-%H00").tar.gz  --database=$db >> $log
            done
        fi
    fi
done

echo ====== $(date +"%Y%m%d-%H%M") backup END >> $log
echo >> $log