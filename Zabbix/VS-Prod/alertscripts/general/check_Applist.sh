#!/bin/bash
grep -rs server_port= /data/*.sh|awk -F '.sh:server_port=' '{print $1","$2}'|awk -F '/data/' '{print $2}' > /etc/zabbix/alertscripts/Applis.csv
#grep -rs server_port= /data/*.sh | sed 's/\/data\/\(.*\).sh.*=\([0-9].*\)$/\1,\2/' > /etc/zabbix/alertscripts/Applis.csv
input=${1:-/etc/zabbix/alertscripts/Applis.csv}
domain=$(cat ${input} | tail -n +1 | sed 's;,; ;g' | tr -d '\r' | sed -r '/^\s*$/d' | sed 's; ;,;g')
aa=(${domain})
length=${#aa[@]}

printf "{\n"
printf "  \"data\": ["
for (( i=0 ; i<$length ; i++ ))
do
  unset bb
  IFS=',' read -r -a bb <<< "${aa[$i]}"
  if [ "${#bb[@]}" != "2" ]; then
    continue
  fi
  printf "\n    {"
  printf "\n      \"{#APP}\":\"${bb[0]}\","
  printf "\n      \"{#TCP_PORT}\":\"${bb[1]}\""
  printf "\n    }"
  if [ $i -lt $[$length-1] ];then
          printf ','
  fi
done
printf "\n  ]\n"
printf "}\n"
