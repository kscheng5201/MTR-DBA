#!/bin/bash
#########################################################
# Project: parse logstash
# Branch: 
# Author: Gok, the DBA
# Created: 2023-02-23
# Updated: 2023-02-23
# Note: Week-on-Week Weekly Report
#########################################################
data_dir=`pwd`
conf_dir=/etc/logstash/conf.d
src_ip='10.23.1.170'
dest_ip='10.26.1.170'

#### 第一階段比對：index 是否一致
curl -XGET $src_ip:9200/_cat/indices/gl_* | awk '{print $3}' | sort > $data_dir/src.index
curl -XGET $dest_ip:9200/_cat/indices/gl_* | awk '{print $3}' | sort > $data_dir/dest.index
diff $data_dir/src.index $data_dir/dest.index -y -W 111 | grep '|'

if [[ -n `diff $data_dir/src.index $data_dir/dest.index -y -W 111 | grep '|'` ]];
then 
    echo create new index at b site
else 
    echo do nothing
fi 



### 假如 do nothing 後繼續找需要處理的 index
## 假如源站數據較多
curl -XGET $src_ip:9200/_cat/indices/gl_* | awk '{print $3, $7}' | sort > $data_dir/src.info
curl -XGET $dest_ip:9200/_cat/indices/gl_* | awk '{print $3, $7}' | sort > $data_dir/dest.info

# 列出 reload 資料量的名單
diff_index=`diff $data_dir/src.info $data_dir/dest.info -y -W 111 | grep '|' | awk '{if ($2 > $5) print $1}'`
for idx in $diff_index;
do
    echo diff_index = $idx
    sed "11s/gl_\*/${idx}/" $conf_dir/logstash.conf > $conf_dir/logstash.conf.$idx
    echo ==== $idx import began at `date` >> $data_dir/es2es.log
    /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf.$idx
    echo ==== $idx import ended at `date` >> $data_dir/es2es.log
    echo >> $data_dir/es2es.log
    rm -rf $conf_dir/logstash.conf.$idx 
done


## 假如 b 站資料量較多
reset_index=`diff $data_dir/src.info $data_dir/dest.info -y -W 111 | grep '|' | awk '{if ($2 < $5) print $1}'`
for idx in $reset_index; 
do
    echo reset_index = $idx
    sed "11s/gl_\*/${idx}/" $conf_dir/logstash.conf > $conf_dir/logstash.conf.$idx
    echo ==== $idx remove began at `date` >> $data_dir/es2es.log
    curl -XDELETE $dest_ip:9200/$idx
    echo ==== $idx import began at `date` >> $data_dir/es2es.log
    /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf.$idx
    echo ==== $idx import ended at `date` >> $data_dir/es2es.log
    echo >> $data_dir/es2es.log
    rm -rf $conf_dir/logstash.conf.$idx 
done
