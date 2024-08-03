#!/bin/bash
check=`mysql -h34.84.63.14 -uzabbix -p'csnt@P@ssw0rd' -e "show slave status\G" 2>/dev/null|grep Yes|wc -l`
if [[ "$check" = "2" ]];then
        echo 0 #主從同步
else
        echo 1 #主從不同步
fi

