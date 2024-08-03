#!/bin/bash
#Description:xtrabackup complete
#Author:created by arvin
#2024-03-11 v0.1

USER='dbabackup'
PASSWD='FgkndA=CtbwPh6hd'
SERVER=$(hostname | cut -d - -f 4-7)
BACKUP_DIR="/dbfiles/backup/$SERVER"
DATE=$(date +"%F_%T")
USERFTP='ftpbk'
PASSWDFTP='mysqlAIbak'
SERVERFTP='10.11.3.235'

## Re-construct the backup directory and logging
sudo rm -rf $BACKUP_DIR
echo "start the $SERVER is full backup at $(date)" >> /dbfiles/scripts/$SERVER.log
[[ -d $BACKUP_DIR ]] || mkdir -p $BACKUP_DIR

## 用 xtrabackup 執行
innobackupex --parallel=2 --compress --compress-threads=1 --socket=/dbfiles/mysql_home/data/mysql.sock --user=$USER --password="$PASSWD" $BACKUP_DIR &> $BACKUP_DIR"$DATE".txt
egrep ".* Backup created in directory.*" $BACKUP_DIR/"$DATE".txt >> $BACKUP_DIR/full.info
sudo rm -rf $BACKUP_DIR/"$DATE".txt
echo "end the $SERVER is full backup at $(date)" >> /dbfiles/scripts/$SERVER.log

#incremental
# echo "start the $SERVER is incremental backup at $(date)" >> /dbfiles/scripts/$SERVER.log
# BASE_DIR="$(tail -1 $BACKUP_DIR/full.info | cut -d\' -f2)"
# [[ -d $BACKUP_DIR ]] || mkdir $BACKUP_DIR
# innobackupex --parallel=2 --compress --compress-threads=1 --socket=/dbfiles/mysql_home/data/mysql.sock --user=$USER --password="$PASSWD" --incremental $BACKUP_DIR --incremental-basedir=$BASE_DIR &> $BACKUP_DIR"$DATE".txt
# egrep ".*Backup created in directory.*" $BACKUP_DIR/"$DATE".txt >> $BACKUP_DIR/incremention.info
# sudo rm -rf $BACKUP_DIR/"$DATE".txt
# echo "end the $SERVER is incremental backup at $(date)" >> /dbfiles/scripts/$SERVER.log
# sudo find $BACKUP_DIR* -type d -mtime +38 | xargs rm -rf

#ftp batch upload
updir=$BACKUP_DIR
todir="/data/ftp/$SERVER"

echo "updir = $updir, todir = $todir"

sss=`find $updir -type d -printf $todir/'%P\n'| awk '{if ($0 == "")next;print "mkdir " $0}'`
aaa=`find $updir -type f -printf 'put %p %P \n'`

echo "sss=$sss, aaa=$aaa"

ftp -nv $SERVERFTP <<EOF
user $USERFTP $PASSWDFTP
passive
type binary
prompt
$sss
cd $todir
$aaa
quit
EOF
