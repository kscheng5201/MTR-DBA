input=${1:-/etc/zabbix/alertscripts/domename.csv}
domain=$(cat ${input}|tail -n +2 |sort|uniq)
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
  printf "\n      \"{#CHECK_DOMNAME}\":\"${bb[0]}\","
  printf "\n      \"{#TCP_PORT}\":\"${bb[1]}\""
  printf "\n    }"
  if [ $i -lt $[$length-1] ];then
          printf ','
  fi
done
printf "\n  ]\n"
printf "}\n"
