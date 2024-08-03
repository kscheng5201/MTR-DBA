#!/bin/bash
####################################
# Project: b 站 es-backend 補完計畫
# Branch: 
# Author: Gok, the DBA
# Created: 2023-02-23
# Updated: 2023-02-23
# Note: es to es via logstash
####################################

dba_dir=/etc/dba
conf_dir=/etc/logstash/conf.d
log=$log
src_ip='10.23.1.170'
dest_ip='10.26.1.170'

#### 第一階段比對：index 是否一致
curl -XGET $src_ip:9200/_cat/indices/gl_* | awk '{print $3}' | sort > $dba_dir/src.index
curl -XGET $dest_ip:9200/_cat/indices/gl_* | awk '{print $3}' | sort > $dba_dir/dest.index
diff $dba_dir/src.index $dba_dir/dest.index -y -W 111 | grep '|'

## 若 index 不一致則建立 index
if [[ -n `diff $dba_dir/src.index $dba_dir/dest.index -y -W 111 | grep '|'` ]];
then 
    /usr/bin/python $dba_dir/indiceCreate.py
else 
    ## 假如 index 沒問題又源站數據較多
    # 拿到兩邊現在的 index & doc
    curl -XGET $src_ip:9200/_cat/indices/gl_* | awk '{print $3, $7}' | sort > $dba_dir/src.info
    curl -XGET $dest_ip:9200/_cat/indices/gl_* | awk '{print $3, $7}' | sort > $dba_dir/dest.info

    # 列出 reload 資料量的名單
    diff_index=`diff $dba_dir/src.info $dba_dir/dest.info -y -W 111 | grep '|' | awk '{if ($2 > $5) print $1}'`
    for idx in $diff_index;
    do
        echo diff_index = $idx

        # 建立 index 專屬的 conf
        sed "11s/gl_\*/${idx}/" $conf_dir/logstash.conf > $conf_dir/logstash.conf.$idx

        # 開始執行當前 index 的寫入 pipeline
        echo ==== $idx import began at `date` >> $log
        /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf.$idx
        echo ==== $idx import ended at `date` >> $log
        echo >> $log
        rm -rf $conf_dir/logstash.conf.$idx 
    done
fi

## 假如 b 站資料量較多
reset_index=`diff $dba_dir/src.info $dba_dir/dest.info -y -W 111 | grep '|' | awk '{if ($2 < $5) print $1}'`
for idx in $reset_index; 
do
    echo reset_index = $idx

    # 建立 index 專屬的 conf
    sed "11s/gl_\*/${idx}/" $conf_dir/logstash.conf > $conf_dir/logstash.conf.$idx

    # 開始執行當前 index 的刪除
    echo ==== $idx remove began at `date` >> $log
    curl -XDELETE $dest_ip:9200/$idx

    # 開始執行當前 index 的寫入 pipeline
    echo ==== $idx import began at `date` >> $log
    /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf.$idx
    echo ==== $idx import ended at `date` >> $log
    echo >> $log
    rm -rf $conf_dir/logstash.conf.$idx 
done


