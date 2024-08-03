#!/bin/bash
##################################################
# Project: ALTER Replica Identity
# Branch: 
# Author: Gok, the DBA
# Created: 2023-12-18
# Updated: 2023-12-18
# Note: 修改 Replica Identity，Primary Key 優先、再來是 UNIQUE KEY
# Ref: https://pigsty.cc/zh/blog/2021/03/03/pg%E5%A4%8D%E5%88%B6%E6%A0%87%E8%AF%86%E8%AF%A6%E8%A7%A3replica-identity/
##################################################

#### Complete 4 Type ####
# ALTER TABLE <TABLE_NAME> REPLICA IDENTITY { DEFAULT | USING INDEX index_name | FULL | NOTHING };  -- 有以下四種形式
# ALTER TABLE <TABLE_NAME> REPLICA IDENTITY DEFAULT;                                                -- 使用 Primary Key，沒有的話就用 FULL
# ALTER TABLE <TABLE_NAME> REPLICA IDENTITY FULL;                                                   -- 使用整行作为 Identity
# ALTER TABLE <TABLE_NAME> REPLICA IDENTITY USING INDEX <UNIQUE_KEY_NAME>;                          -- 使用 Unique Key
# ALTER TABLE <TABLE_NAME> REPLICA IDENTITY NOTHING;                                                -- 不設置 REPLICA IDENTITY
#### Complete 4 Type ####


## 取得所有的 Database
sql='SELECT datname FROM pg_catalog.pg_database;'
dbs=`PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d postgres -t -c "$sql" | grep -v cloud | grep -v template`

## 每個 Database 逐一進行
for db in $dbs; 
do
    # echo db = $db
    ## 取得所有的 Table
    sql="SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = '$db';"
    tables=`PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -t -c "$sql"`

    ## 每個 Table 逐一進行
    for t in $tables; 
    do 
        # echo t = $t
        ## 檢查 Primary Key 是否存在
        pk=`PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "\d+ $db.$t;" | grep 'PRIMARY KEY'`

        if [[ -n $pk ]];
        then 
            ## 若是 Primary Key 存在，則將 REPLICA IDENTITY 設置為 DEFAULT（Primary Key 優先）
            sql="ALTER TABLE $db.$t REPLICA IDENTITY DEFAULT;"
            PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "$sql" 2>> error.log
            echo 

            ## 檢查此表的狀態；若將 REPLICA IDENTITY 設置為 DEFAULT，則會查看不到任何資訊
            PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "\d+ $db.$t;" | grep 'Replica Identity'

        else
            ## 若是 Primary Key 不存在，則檢查 UNIQUE Key 是否存在 
            uk=`PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "\d+ $db.$t;" | grep 'UNIQUE CONSTRAINT' | cut -d \" -f 2`

            if [[ -n $uk ]];
            then 
                # echo $db.$t HAVE UNIQUE KEY: $uk
                ## 若是 Unique Key 不存在，則將 REPLICA IDENTITY 設置為 USING INDEX（Unique Key）                
                sql="ALTER TABLE $db.$t REPLICA IDENTITY USING INDEX $uk;"
                PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "$sql" 2>> error.log
                echo

                ## 檢查此表的狀態
                PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "\d+ $db.$t;" | grep 'Replica Identity'
                # echo $db.$t NO pk

            else
                # echo $db.$t HAVE NO PRIMARY AND UNIQUE KEY BOTH!!!
                ## 若是 PRIMARY KEY AND UNIQUE KEY 都不存在，則將 REPLICA IDENTITY 設置為 FULL
                sql="ALTER TABLE $db.$t REPLICA IDENTITY FULL;"
                PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "$sql" 2>> error.log
                echo 

                ## 檢查此表的狀態
                PGPASSWORD='qPN78eYLy99jKkfT' psql -h localhost -p 15432 -U plt_java_app -d $db -c "\d+ $db.$t;" | grep 'Replica Identity'
            fi
        fi          
    done
done