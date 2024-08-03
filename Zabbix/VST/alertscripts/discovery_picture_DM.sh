input=${1:-/etc/zabbix/alertscripts/discovery_picture_DM.csv}
domain=$(cat ${input} | tail -n +2 | sed 's;,; ;g' | tr -d '\r' | sed -r '/^\s*$/d' | sed 's; ;,;g')
aa=(${domain})
length=${#aa[@]}

printf "{\n"
printf "  \"data\": ["
for (( i=0 ; i<$length ; i++ ))
do
  unset bb
  IFS=',' read -r -a bb <<< "${aa[$i]}"
  if [ "${#bb[@]}" != "1" ]; then
    continue
  fi
  printf "\n    {"
  printf "\n      \"{#TCP_PORT}\":\"${bb[0]}\""
#  printf "\n      \"{#TCP_PORR}\":\"${bb[1]}\""
  printf "\n    }"
  if [ $i -lt $[$length-1] ];then
          printf ','
  fi
done
printf "\n  ]\n"
printf "}\n"

