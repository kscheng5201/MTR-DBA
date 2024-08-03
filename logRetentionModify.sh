#!/bin/bash
####################################################################
# Project: Update the topic retention policy
# Branch: 
# Author: Gok, the DBA
# Created: 2023-09-19
# Updated: 2023-09-19
# Note: 為了要因應大量資料所導致的磁碟空間不足之危機處理
#####################################################################

kafka_dir=/usr/local/kafka
size=`df -h | grep data | awk '{print $5}' | sed 's/.$//'`
log=/etc/dba/logRetentionModify.log


## 當 /data 的 Use% >= 78%
if [[ $size -ge 78 ]]; 
then 
    echo ====== `date +"%F %T"` ====== >> $log
    df -h >> $log

    log_dir=`grep log.dirs ${kafka_dir}/config/server.properties | cut -d = -f 2`
    big=`du $log_dir | sort -nk1 -r | grep -v "${log_dir}$" | head -1 | awk '{print $2}'`

    echo 資料量最大為以下 kafka 資料夾 >> $log
    du -h $log_dir | grep $big >> $log

    topic=`echo $big | cut -d / -f 5 | sed 's/-[0-9]$//'`
    echo 本次處理的 kafka topic: $topic >> $log

    ## 確認有取得正確的 kafka topic 名字
    check=`$kafka_dir/bin/kafka-topics.sh --list --bootstrap-server localhost:9092 | grep $topic`
    if [[ -n $check ]]; 
    then 
        ## 取得所有現有與 retention 有關的參數
        echo $topic 所有現有與 retention 有關的參數: >> $log
        $kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic $topic --all | grep retention | awk '{print $1}' >> $log
        parameters=`$kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic ${topic} --all | grep retention | awk '{print $1}'`

        ## 先針對 retention.bytes 修正參數
        if [[ $parameters =~ 'retention.bytes=-1' ]];
        then
            ## 設定最大值為 200G
            p='retention.bytes'
            value=`expr 1073741824 \* 200`
            $kafka_dir/bin/kafka-configs.sh --alter --bootstrap-server localhost:9092 --entity-type topics --entity-name $topic --add-config $p=$value

            ## 確認新設定有修改成功
            output=`$kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic ${topic} --all | grep "$p=$value"`
            if [[ -z $output ]]; 
            then 
                echo ERROR: 參數 $p 調整未成功，請再確認！ >> $log
            else 
                echo INFO: 參數 $p 調整已成功，$p=$value >> $log
            fi

        ## 如果 retention.bytes 的參數不是 -1 才進行以下調整
        else
            # 迴圈逐一取得 retention 相關參數
            for p in $parameters; 
            do
                ## 只處理帶有 retention.ms 字眼的參數
                if [[ $p =~ 'retention.ms' ]]; 
                then 
                    ## 針對 delete.retention.ms 做處理
                    if [[ $p =~ 'delete' ]]; 
                    then 
                        echo $topic 未調整前的參數為 $p >> $log
                        value=`echo $p | cut -d = -f 2`

                        ## delete.retention.ms 的參數最小為一小時，只剩一小時則不動作
                        if [[ $value -gt 3600000 ]]; 
                        then 
                            ## delete.retention.ms 的參數減少一小時，單位為毫秒
                            value=`expr $value - 3600000`
                            $kafka_dir/bin/kafka-configs.sh --alter --bootstrap-server localhost:9092 --entity-type topics --entity-name $topic --add-config $p=$value

                            ## 確認新設定有修改成功
                            output=`$kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic $topic --all | grep "$p=$value"`
                            if [[ -z $output ]]; 
                            then 
                                echo ERROR: 參數 `echo $p | cut -d = -f 1` 調整未成功，請再確認！ >> $log
                            else 
                                echo INFO: 參數 `echo $p | cut -d = -f 1` 調整已成功，value = $value >> $log
                            fi
                        else 
                            echo $topic 此 kafka topic 的參數 $p，是否考慮要調整保留時間低於一小時？ >> $log
                        fi
                    fi
                fi
            done
        fi
    fi

    ## 最後確認: retention.ms 的數字要與 delete.retention.ms 一致
    parameters=`$kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic $topic --all | grep retention.ms | awk '{print $1}' | cut -d = -f 2`

    if [[ `echo $parameters | cut -d ' ' -f 1` -ne `echo $parameters | cut -d ' ' -f 2` ]]; 
    then 
        echo retention.ms 與 delete.retention.ms 不一致，分別為: >> $log
        echo $parameters >> $log

        value=`echo $parameters | cut -d ' ' -f 2`
        $kafka_dir/bin/kafka-configs.sh --alter --bootstrap-server localhost:9092 --entity-type topics --entity-name $topic --add-config retention.ms=$value

        ## 確認新設定有修改成功
        output=`$kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic ${topic} --all | grep "retention.ms=$value"`
        if [[ -z $output ]]; 
        then 
            echo ERROR: 參數 retention.ms 調整未成功，請再確認！ >> $log
        else 
            echo INFO: 參數 retention.ms 調整已成功，value = $value >> $log
        fi
    fi

    echo 綜觀所有 $topic 有關 retention 現行參數　>> $log
    $kafka_dir/bin/kafka-configs.sh --bootstrap-server localhost:9092 --describe --topic ${topic} --all | grep retention | awk '{print $1}' >> $log
    echo >> $log
fi













input {
    if "vs-b-messages" in [tags] {
        kafka {
            bootstrap_servers => "10.21.1.160:9092,10.21.1.162:9092,10.21.1.163:9092"
            topics => ["vs-b-messages-log"]
            codec => "json"
            decorate_events => true
        	}
	    }

    if "vs-a-messages" in [tags] {
        kafka { 
            bootstrap_servers => "10.21.1.160:9092,10.21.1.162:9092,10.21.1.163:9092"
            topics => ["vs-a-messages-log"]
            codec => "json" 
            decorate_events => true
            }
        }
}

output {
    if "vs-b-messages" in [tags] {
        tcp {
            host  => "43.198.54.254"
            port  => 6000
            codec => json_lines
            }
        }

    if "cmd-log" in [tags] {
        tcp {
            host  => "43.198.54.254"
            port  => 6000
            codec => json_lines
            }

        file {
            path => ["/etc/logstash/logs/log.log"]
        }
    }
}

- type: log
  enabled: true
  paths:
    - /var/log/cmd.log
  tags: ["cmd-log","vs-a","tcp"]
  fields:
    kafka_topic: vs-uat-cmd-log