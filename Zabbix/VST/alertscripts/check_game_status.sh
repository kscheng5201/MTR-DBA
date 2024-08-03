##!/bin/bash　　
HOSTNAME="localhost"                                           #数据库信息
PORT="3306"
USERNAME=root
PASSWORD="1qaz@WSX"
DBNAME="global_3rd_db"                                                       #数据库名称
TABLENAME="gl_game"                                            #数据库中表的名称
#也可以写 HOSTNAME="localhost"，端口号 PORT可以不设定
#查询
select_sql="select name,start_date,end_date,status from ${TABLENAME}"
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${select_sql}" 2>/dev/null |tail -n +2|sed 's;\t;,;g' > /etc/zabbix/alertscripts/game_maintain.txt

sleep 1
input=${1:-/etc/zabbix/alertscripts/game_maintain.txt}
domain=$(cat ${input} | tail -n +1 | sed 's;,; ;g' | tr -d '\r' | sed -r '/^\s*$/d' | sed 's; ;,;g')
aa=(${domain})
length=${#aa[@]}

printf "{\n"
printf "  \"data\": ["
for (( i=0 ; i<$length ; i++ ))
do
  unset bb
  IFS=',' read -r -a bb <<< "${aa[$i]}"
#  if [ "${#bb[@]}" != "2" ]; then
#    continue
#  fi
  printf "\n    {"
  printf "\n      \"{#T_A}\":\"${bb[0]}\""
#  printf "\n      \"{#T_B}\":\"${bb[1]}\","
#  printf "\n      \"{#T_C}\":\"${bb[2]}\","
#  printf "\n      \"{#T_D}\":\"${bb[3]}\","
#  printf "\n      \"{#T_E}\":\"${bb[4]}\","
#  printf "\n      \"{#T_F}\":\"${bb[5]}\""
  printf "\n    }"
  if [ $i -lt $[$length-1] ];then
          printf ','
  fi
done
printf "\n  ]\n"
printf "}\n"


