# for elasticsearch-backend
#!/bin/bash
es=`curl -sXGET 'http://10.23.1.170:9200/_cluster/health?pretty'|grep red`
if [[ "$es" != "red" ]];then
	echo 0 #es叢集狀態正常
else
	echo 1 #es叢集異常
fi
