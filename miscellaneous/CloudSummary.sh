#!/bin/bash
################################################################
# Project: Stat the usage and price of cloud service
# Branch: Wo Neo requested
# Author: Gok, the DBA
# Created: 2022-08-17
# Updated: 2022-11-26
# Note: If more cloud service join, should create it beforehand
################################################################

##########################################################################
## The Data in Huawei should replace as English before import to MySQL ##
# (at Jumper) From Jumper to Master 
# scp /home/gok/Huawei_202206.csv gok@10.21.1.180:/home/gok/

# replace the keyword
# sed -i 's/Anti-DDoS流量清洗/Anti-DDoS/g' Huawei_202206.csv
# sed -i 's/云硬盘/Cloud Disk/g' Huawei_202206.csv
# sed -i 's/弹性云服务器/ECS/g' Huawei_202206.csv
# sed -i 's/企业主机安全/HSS/g' Huawei_202206.csv
# sed -i 's/虚拟私有云/VPC/g' Huawei_202206.csv
# sed -i 's/云解析服务/DNS/g' Huawei_202206.csv
# sed -i 's/数据加密服务/KMS/g' Huawei_202206.csv

# load data at Master
# mysql -e "LOAD DATA LOCAL INFILE 'Huawei_202206.csv' INTO TABLE cloud_stat.huawei FIELDS TERMINATED BY ',' IGNORE 1 LINES;""
## The Data in Huawei should replace as English before import to MySQL ##
##########################################################################


## Get the key_date: the First Date of Month ####
if [ -n "$1" ];
then
    key_date=`date -d $1 +"%Y%m01"`
else
    key_date=`date -d "1 month ago" +"%Y%m01"`
fi

## parameter setting
key_db="cloud_stat"
key_span="monthly"
dest_table="cloud_summary"

mysql_user='root'
mysql_pwd='1qaz@WSX'


## Get the tables of $key_db
get_tables="
    select table_name
    from information_schema.tables
    where table_schema = '$key_db'
    and table_name <> '$dest_table'
    ;"
echo ''
echo [## Get the tables of $key_db]
echo $get_tables
table_list=`mysql -u $mysql_user -p$mysql_pwd -e "$get_tables" | grep -v table_name`
echo ''
echo $table_list


## Create the table $key_db.$dest_table ##
build_table="
    DROP TABLE IF EXISTS $key_db.$dest_table
    ; 
    CREATE TABLE IF NOT EXISTS $key_db.$dest_table (
        id int auto_increment COMMENT 'serial number' UNIQUE, 
        billing_time date NOT NULL COMMENT '計費期間：Must be the 1st date of month', 
        span varchar(8) NOT NULL COMMENT '週期：daily/weekly/monthly/seasonal/yearly',
        b_partner varchar(32) NOT NULL COMMENT '廠商名稱', 
        cloud varchar(16) NOT NULL COMMENT '雲端平台名稱',
        item_main varchar(128) NOT NULL COMMENT '大項目', 
        item_sub varchar(128) NOT NULL COMMENT '子項目',
        item_rename varchar(64) COMMENT '整理後的項目名稱', 
        account varchar(64) NOT NULL COMMENT '帳號', 
        client_id varchar(64) NOT NULL COMMENT '用戶ID',
        project varchar(64) NOT NULL COMMENT '專案',
        payment_ori float COMMENT '使用費(USD)',
        discount float COMMENT '折扣',
        charge float COMMENT '手續費(USD)',
        payment_aft float COMMENT '折扣後金額(USD)：payment_ori * discount * charge',
        exchange float COMMENT '匯率',
        payment_tw float COMMENT '折扣後金額(TWD)：payment_ori * discount * charge * exchange',
        create_time timestamp DEFAULT CURRENT_TIMESTAMP, 
        update_time timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        primary key (billing_time, span, project, b_partner, account, cloud, item_main, item_sub, client_id), 
        key idx_billing_time (billing_time), 
        key idx_project (project),
        key idx_b_partner (b_partner), 
        key idx_account (account), 
        key idx_cloud (cloud), 
        key idx_item_main (item_main), 
        key idx_item_rename (item_rename), 
        key idx_client_id (client_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cloud Summary Table'
    ;"
echo ''
echo $build_table
mysql -u $mysql_user -p$mysql_pwd -e "$build_table"


for table in $table_list;
do 
    case $table in 
        ali)
        to_summary="
            INSERT INTO $key_db.$dest_table
                select 
                    null id, 
                    '$key_date' billing_time, 
                    '$key_span' span, 
                    ifnull(b_partner, 'N/A') b_partner, 
                    'Ali' cloud, 
                    Product_Name item_main, 
                    'N/A' item_sub, 
                    case
                        when Product_Name = 'EIP' then 'EIP'
                        when Product_Name = 'Object Storage Service (OSS)' then 'OSS'                        
                        when Product_Name = 'Global Traffic Manager' then 'GTM'
                        when Product_Name REGEXP '^Elastic Compute Service' then 'ECS'
                        when Product_Name REGEXP '^Alibaba Cloud DNS' then 'DNS'
                        when Product_Name REGEXP '^Cloud Disk' then 'Cloud Disk'
                        else Product_name
                    end item_rename, 
                    User_Account account, 
                    User_Name client_id, 
                    ifnull(project, 'N/A') prject,
                    sum(Original_Cost) payment_ori, 
                    null discount,
                    null charege, 
                    null payment_aft,
                    null exchange,
                    null payment_tw,
                    now() create_time, 
                    now() update_time
                from $key_db.$table a 
					inner join $key_db.account_list b
                    on a.User_Name = substring_index(b.account, '@', 1)
                where billing_cycle = '$key_date'
                group by 
                    b_partner, 
                    item_main, 
                    item_rename, 
                    User_Account, 
                    User_Name, 
                    ifnull(project, 'N/A')
            ;
            ALTER TABLE $key_db.$dest_table AUTO_INCREMENT = 1
            ;"
        echo ''
        echo $table
        echo $to_summary
        mysql -u $mysql_user -p$mysql_pwd -e "$to_summary"
        ;;

        alibaba)
        to_summary="
            INSERT INTO $key_db.$dest_table
                select 
                    null id, 
                    '$key_date' billing_time, 
                    '$key_span' span, 
                    b_partner,
                    'Ali' cloud, 
                    Product_Name item_main, 
                    'N/A' item_sub, 
                    case
                        when Product_Name = 'EIP' then 'EIP'
                        when Product_Name = 'Object Storage Service (OSS)' then 'OSS'                        
                        when Product_Name = 'Global Traffic Manager' then 'GTM'
                        when Product_Name REGEXP '^Elastic Compute Service' then 'ECS'
                        when Product_Name REGEXP '^Alibaba Cloud DNS' then 'DNS'
                        when Product_Name REGEXP '^Cloud Disk' then 'Cloud Disk'
                        else Product_name
                    end item_rename, 
					account, 
                    client_id,
                    project,
                    sum(Pretax_Cost) payment_ori,
                    sum(Discount) discount, 
                    null charge, 
                    null payment_aft,
                    null exchange, 
                    null payment_tw,
                    now() create_time, 
                    now() update_time
                from $key_db.$table a 
					inner join $key_db.account_list b
                    on a.User_Name = substring_index(b.account, '@', 1)
                where billing_cycle = '$key_date'
                group by 
                    b_partner, 
                    item_main, 
                    item_rename, 
                    account, 
                    client_id, 
                    project
            ;
            ALTER TABLE $key_db.$dest_table AUTO_INCREMENT = 1
            ;"
        echo ''
        echo $table
        echo $to_summary
        mysql -u $mysql_user -p$mysql_pwd -e "$to_summary"
        ;;

        aws)
        to_summary="
            INSERT INTO $key_db.$dest_table
                select 
                    null id, 
                    '$key_date' billing_time, 
                    '$key_span' span, 
                    b_partner,
                    'AWS' cloud, 
                    product_ProductName item_main, 
                    lineItem_UsageType item_sub, 
                    case product_ProductName
                        when 'Amazon CloudFront' then 'CDN'
                        when 'Amazon Route 53' then 'DNS'
                        when 'AmazonCloudWatch' then 'AmazonCloudWatch'
                        when 'Elastic Load Balancing' then 'ELB'
                        when 'Amazon Simple Storage Service' then 'S3'
                        when 'AWS Key Management Service' then 'KMS'
                        when 'AWS Data Transfer' then 'E-F-System'
                        when 'AWS CloudTrail' then 'AWS CloudTrail'
                        when 'Amazon Virtual Private Cloud' then 'VPC'
                        when 'Amazon Elastic Compute Cloud' then 'EC2'
                        else product_ProductName
                    end item_rename,
                    account, 
                    client_id, 
                    project,
                    sum(lineItem_UnblendedCost) payment_ori, 
					null discount, 
                    null charge, 
                    null payment_aft,
                    null exchange, 
                    null payment_tw,
                    now() create_time, 
                    now() update_time
                from $key_db.$table a 
                    inner join $key_db.account_list b
                    on a.lineItem_UsageAccountId = b.client_id
                where (lineItem_UsageEndDate >= '$key_date' - interval 1 day
                    and lineItem_UsageEndDate < '$key_date' + interval 1 month + interval 1 day)
                    or lineItem_UsageEndDate REGEXP '^0'
                group by 
                    b_partner, 
                    item_main, 
                    item_rename, 
                    account, 
                    client_id, 
                    project
            ;
            ALTER TABLE $key_db.$dest_table AUTO_INCREMENT = 1
            ;"
        echo ''
        echo $table
        echo $to_summary
        mysql -u $mysql_user -p$mysql_pwd -e "$to_summary"
        ;;

        gcp)
        to_summary="
            INSERT INTO $key_db.$dest_table
                select 
                    null id, 
                    '$key_date' billing_time, 
                    '$key_span' span, 
                    b_partner, 
                    'GCP' cloud, 
                    service item_main, 
                    sku item_sub, 
                    case 
                        when service = 'Networking' and sku REGEXP 'CDN' then 'CDN'
                        when service = 'Networking' and sku NOT REGEXP 'CDN' then 'Networking Data'
                        when service = 'Cloud SQL' then 'ECS'
                        when service = 'Cloud Logging' then 'LOG'
                        when service = 'Cloud DNS' then 'DNS'
                        when service = 'Compute Engine' and sku REGEXP 'IP' then 'EIP'
                        when service = 'Compute Engine' and sku REGEXP 'Storage' then 'Storage'
                        when service = 'Compute Engine' and sku REGEXP 'VPN' then 'VPN'
                        when service = 'Compute Engine' and sku REGEXP 'Licensing' then 'Licensing'

                        when service = 'Compute Engine' and sku REGEXP '^Network' then 'Networking Data'
                        when service = 'Compute Engine' and sku REGEXP 'PD Capacity' then 'PD Capacity'
                        when service = 'Compute Engine' and sku REGEXP 'E2 Instance' then 'E2 Instance'
                        when service = 'Compute Engine' and sku REGEXP 'Custom Instance' then 'Custom Instance'
                        when service = 'Compute Engine' and sku REGEXP 'Load Balanc' then 'HTTP Load Balancing'
                        when service = 'Compute Engine' and sku REGEXP 'PD Capacity' then 'PD Capacity'
                        else sku
                    end item_rename, 
                    a.account,
                    a.client_id,
                    a.project,
                    price_ori payment_ori,
                    null discount,
                    null charege, 
                    null payment_aft,
                    null exchange,
                    null payment_tw,
                    now() create_time, 
                    now() update_time
                from $key_db.$table a 
                    inner join $key_db.account_list b
                    on a.account = b.account
                        and a.client_id = b.client_id
                where (end_date >= '$key_date' - interval 1 day
                    and end_date < '$key_date' + interval 1 month)
                    or end_date = '0000-00-00'
            ;
            ALTER TABLE $key_db.$dest_table AUTO_INCREMENT = 1
            ;"
        echo ''
        echo $table
        echo $to_summary
        mysql -u $mysql_user -p$mysql_pwd -e "$to_summary"
        ;;

        huawei)
        to_summary="
            INSERT INTO $key_db.$dest_table
                select 
                    null id, 
                    '$key_date' billing_time, 
                    '$key_span' span, 
                    b_partner, 
                    'Huawei' cloud, 
                    prod_type item_main, 
                    prod_name item_sub, 
                    prod_type item_rename, 
                    account, 
                    b.client_id,
                    project, 
                    client_amount_of_consumption payment_ori,
                    null discount,
                    null charege,
                    null payment_aft,
                    null exchange,
                    null payment_tw,                     
                    now() create_time, 
                    now() update_time
                from $key_db.$table a 
					inner join $key_db.account_list b
                    on a.client_id = b.client_id
                where client_trade_time >= '$key_date'
                    and client_trade_time < '$key_date' + interval 1 month
            ;
            ALTER TABLE $key_db.$dest_table AUTO_INCREMENT = 1
            ;"
        echo ''
        echo $table
        echo $to_summary
        mysql -u $mysql_user -p$mysql_pwd -e "$to_summary"
        ;;

        tencent)
        to_summary="
            INSERT INTO $key_db.$dest_table
                select 
                    null id, 
                    '$key_date' billing_time, 
                    '$key_span' span,
                    'N/A' b_partner, 
                    'TX' cloud, 
                    ProductName item_main, 
                    SubproductName item_sub, 
                    case 
                        when ProductName = 'Cloud Virtual Machine(CVM)' then 'CVM'                               
                        when ProductName REGEXP 'storage' then 'Storage'
                        when ProductName REGEXP 'IP' then 'IP'                  
                        else ProductName
                    end item_rename, 
                    'N/A' account, 
                    'N/A' client, 
                    'N/A' project, 
                    Total_Cost_Inc_Tax payment_ori,
                    null discount,
                    null charege,
                    null payment_aft,
                    null exchange,
                    null payment_tw,
                    now() create_time, 
                    now() update_time
                from $key_db.$table
                where Usage_End_Time >= '$key_date'
                    and Usage_End_Time < '$key_date' + interval 1 month + interval 1 day
            ;
            ALTER TABLE $key_db.$dest_table AUTO_INCREMENT = 1
            ;"
        echo ''
        echo $table
        echo $to_summary
        mysql -u $mysql_user -p$mysql_pwd -e "$to_summary"
        ;;

    esac
done


## the output to excel for the end
final_report="
    select 
        tag_date, 
        span, 
        prod, 
        b_partner, 
        account, 
        cloud, 
        item_rename, 
        count(*) freq,
        round(sum(billing), 2) billing, 
        now() create_time, 
        now() update_time 
    from cloud_stat.cloud_summary 
    group by 
        tag_date, 
        span, 
        prod, 
        b_partner, 
        account, 
        cloud, 
        item_rename
    ;"
echo ''
echo [Run the following syntax at MySQLworkbench and then paste the output to excel for the end]
echo $final_report
