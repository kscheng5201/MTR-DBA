#!/bin/bash
#mysql -uroot -p1qaz@WSX -e "SELECT name,channel_id FROM global_3rd_db.gl_game;" 2>/dev/null |tail -n +2|sed 's;\t;,;g' > test.txt
mysql -uroot -p1qaz@WSX -e "SELECT name,channel_id FROM global_3rd_db.gl_game;" 2>/dev/null |tail -n +2|sed 's;\t;,;g'|sed 's/,/ /g' |sort -n -k 2 -t " "|uniq -f 1|awk '{print "a"$2","$1}' > test.txt
domain=$(cat /etc/zabbix/alertscripts/test.txt | tail -n +2 | sed 's;,; ;g' | tr -d '\r' | sed -r '/^\s*$/d' | sed 's; ;,;g')
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
  printf "\n      \"{#TCP_PORT}\":\"${bb[0]}\""
  printf "\n      \"{#TCP_PORR}\":\"${bb[1]}\""
  printf "\n    }"
  if [ $i -lt $[$length-1] ];then
          printf ','
  fi
done
printf "\n  ]\n"
printf "}\n"
