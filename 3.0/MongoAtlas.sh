#!/bin/bash
#########################################################
# Project: MongoDB Atlas Recover Locally 資料復原
# Branch: 
# Author: Gok, the DBA
# Created: 2023-03-16
# Updated: 2023-03-16
# Note: 預計排程為每小時進行一次，拉近間隔的細節可再與 TC 討論
##########################################################


date=`date +%Y-%m-%d`
now=`date +%Y%m%d.%H%M`
last_hour=`date -d "1 hour ago" +%Y%m%d%H%M`

mkdir -p /etc/dba/mongodump/${date}/${now}
data_dir=/etc/dba # 預計會變成/data/mongo/mongodump/$date
user=gok
pwd=ISffICi0Pt9xnyHh
cluster=crossregioncloud

## 取得所有的 db 名稱
dbs=`echo "show dbs" | mongosh "mongodb+srv://${cluster}.6ko0g.mongodb.net/" --apiVersion 1 --username ${user} --password ${pwd} | awk '{print $1}' | grep -vE 'admin|config|local' | grep -A111 -i atlas | grep -vi atlas`

## 個別 db 個別進行
for db in $dbs; 
do
    # 執行 mongodump 以及判斷是否要進行 mongorestore
    mongodump --uri mongodb+srv://${user}:${pwd}@${cluster}.6ko0g.mongodb.net/${db}
    mv ${data_dir}/dump/${db} ${data_dir}/mongodump/${date}/${now}/${db}

    # 刪除 Local mongoDB 內的 database
    mongosh << EOF
        use $db
        db.dropDatabase() 
EOF

    break
done


## 執行所有 mongoDB restore
mongorestore ${data_dir}/mongodump/${date}/${now}
