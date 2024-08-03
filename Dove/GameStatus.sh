$ cat GameStatus.sh 
#!/bin/bash
##########################################
# Project: OP 確認並修改賽事狀態
# Branch: 
# Author: Gok, the DBA
# Created: 2023-12-04
# Updated: 2023-12-28
# Note: Dove Prod 版本，用 Centos 身分執行
##########################################

src_dir=/etc/dba

## 詢問賽事 ID
echo 
echo "請輸入此次要查詢的賽事 ID：" | $log
read -e third_match_id
echo ......
echo "以下為賽事 ID 為 $third_match_id 的比賽狀態" | $log

## 取得登入資訊
h_bk=`tail -n +2 $src_dir/mysql.list | grep match-backup | awk '{print $2}'` 
user=`grep $h_bk $src_dir/mysql.list | awk '{print $3}'`
pass=`grep $h_bk $src_dir/mysql.list | awk '{print $4}'`

sql="SELECT third_match_id, game_status FROM sian_match.match_info WHERE third_match_id = $third_match_id"
mysql -h $h_bk -P 3306 -u $user -p"$pass" -e "$sql" 2> /dev/null | $log

echo 
echo 'game_status 比賽狀態：'
echo '0-進行中 1-未開賽 2-已结束 3-已推遲 4-已取消 5-已中斷 6-已腰斬 7-已延期 8-待定 9-異常'
echo ......

echo 
echo "是否要修改賽事 ID 為 $third_match_id 的比賽狀態？（[Y]es：進行修改）" | $log
read -e up
shopt -s nocasematch
echo ......

if [[ "${up}" =~ ^(YES|Y|y|yes) ]]; 
then 
    echo 
    echo "開始修改賽事 ID 為 $third_match_id 的比賽狀態" | $log
    echo ......

    ## 取得 Master 的 hostname
    h_ma=`grep -B1 $h_bk $src_dir/mysql.list | head -1 | awk '{print $2}'`
    upd="UPDATE sian_match.match_info SET game_status = 0 WHERE third_match_id = $third_match_id"
    mysql -h $h_ma -P 3306 -u $user -p"$pass" -e "$upd" 2> /dev/null | $log

    echo 
    echo "賽事 ID 為 $third_match_id 的比賽狀態已改為「進行中」" | $log
    mysql -h $h_bk -P 3306 -u $user -p"$pass" -e "$sql" 2> /dev/null | $log
    echo '======'
else 
    echo "賽事 ID 為 $third_match_id 的比賽狀態未修改" | $log
fi

