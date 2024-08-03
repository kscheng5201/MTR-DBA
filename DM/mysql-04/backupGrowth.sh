#!/bin/bash
#########################################################
# Project: Backup Growth Report 備份資料量環比成長率報告
# Branch: 
# Author: Gok, the DBA
# Created: 2023-02-22
# Updated: 2023-02-23
# Note: Week-on-Week Weekly Report
#########################################################

prod='DM'
today=`date -d "-1 day" +%Y-%m-%d`
last_week=`date -d "-8 day" +%Y-%m-%d`


## The Messenge to the Official Group
chat_a="-728211620"
token_a="2064806699:AAFifowrvKUTmOYsuxLrvlNw11W4Qw_kaBc"
## The Messenge to the DBA monitor only
token_b="5624325337:AAEAhFxz8FitLOE6ez3FyErRaRXlfLOsPEc"
chat_b="-675619128"

function TG() {
    curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_a" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_a}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
    curl --silent -X POST --retry 5 --retry-delay 0 --retry-max-time 60 --data-urlencode "chat_id=$chat_b" --data-urlencode "text=${BB}" "https://api.telegram.org/bot${token_b}/sendMessage?disable_web_page_preview=true" | grep -q '"ok":true'
}



## MySQL ##
bucket=`aws s3 ls | awk '/dm/ && /mysql/' | awk '{print $3}'`
size_t=`aws s3 ls s3://$bucket/$today --recursive | awk '/global/ && /2300/' | awk '{print $3}' | tail -1`
size_lw=`aws s3 ls s3://$bucket/$last_week --recursive | awk '/global/ && /2300/' | awk '{print $3}' | tail -1`
diff=`expr $size_t - $size_lw`
growth=`awk -v x=$diff -v y=$size_lw 'BEGIN{printf "%.2f\n",100 * x/y}'`

# echo 
# echo last week is 
# echo $size_lw | numfmt --to=iec
# echo 
# echo bucket is $bucket
# echo size_t = $size_t
# echo size_lw = $size_lw
# echo diff is $diff
# echo growth is $growth

BB="$prod MySQL 今日 `date +%Y-%m-%d` 資料量 `echo $size_t | numfmt --to=iec`，較上週同期增加 $growth%"
TG


## Redis ##
bucket=`aws s3 ls | awk '/dm/ && /redis/' | awk '{print $3}'`
size_t=`aws s3 ls s3://$bucket/$today --recursive | awk '/dump/ && /2300/' | awk '{sum += $3} END {print sum}'`
size_lw=`aws s3 ls s3://$bucket/$last_week --recursive | awk '/dump/ && /2300/' | awk '{sum += $3} END {print sum}'`
diff=`expr $size_t - $size_lw`
growth=`awk -v x=$diff -v y=$size_lw 'BEGIN{printf "%.2f\n",100 * x/y}'`

# echo 
# echo last week is 
# echo $size_lw | numfmt --to=iec
# echo 
# echo bucket is $bucket
# echo size_t = $size_t
# echo size_lw = $size_lw
# echo diff is $diff
# echo growth is $growth

BB="$prod Redis 今日 `date +%Y-%m-%d` 資料量 `echo $size_t | numfmt --to=iec`，較上週同期增加 $growth%"
TG


## RabbitMQ ##
bucket=`aws s3 ls | awk '/dm/ && /rabbitmq/' | awk '{print $3}'`
size_t=`aws s3 ls s3://$bucket/$today --recursive | grep 2300 | awk '{sum += $3} END {print sum}'`
size_lw=`aws s3 ls s3://$bucket/$last_week --recursive | grep 2300 | awk '{sum += $3} END {print sum}'`
diff=`expr $size_t - $size_lw`
growth=`awk -v x=$diff -v y=$size_lw 'BEGIN{printf "%.2f\n",100 * x/y}'`

# echo 
# echo last week is 
# echo $size_lw | numfmt --to=iec
# echo 
# echo bucket is $bucket
# echo size_t = $size_t
# echo size_lw = $size_lw
# echo diff is $diff
# echo growth is $growth

BB="$prod RabbitMQ 今日 `date +%Y-%m-%d` 資料量 `echo $size_t | numfmt --to=iec`，較上週同期增加 $growth%"
TG


## Mongo ##
today=`date -d "-1 day" +%Y%m%d`
last_week=`date -d "-8 day" +%Y%m%d`

bucket=`aws s3 ls | awk '/dm/ && /mongo/' | awk '{print $3}'`
size_t=`aws s3 ls s3://$bucket --recursive | awk "/$today/ && /dump/" | awk '{sum += $3} END {print sum}'`
size_lw=`aws s3 ls s3://$bucket --recursive | awk "/$last_week/ && /dump/" | awk '{sum += $3} END {print sum}'`
diff=`expr $size_t - $size_lw`
growth=`awk -v x=$diff -v y=$size_lw 'BEGIN{printf "%.2f\n",100 * x/y}'`

# echo 
# echo last week is 
# echo $size_lw | numfmt --to=iec
# echo 
# echo bucket is $bucket
# echo size_t = $size_t
# echo size_lw = $size_lw
# echo diff is $diff
# echo growth is $growth

BB="$prod MongoDB 今日 `date +%Y-%m-%d` 資料量 `echo $size_t | numfmt --to=iec`，較上週同期增加 $growth%"
TG


## ES-Backend ## 
BB=`grep '資料量' /efsbackup/elasticsearch-backend-snapshot.log | tail -1`
TG


## ES-Infra ## 
BB=`grep '資料量' /efsbackup/elasticsearch-infra-snapshot.log | tail -1`
TG


