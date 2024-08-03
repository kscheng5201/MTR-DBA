#! /bin/bash
current=`date "+%Y-%m-%d %H:%M:%S"`     #获取当前时间，例：2015-03-11 12:33:41
timeStamp=`date -d "$current" +%s`      #将current转换为时间戳，精确到秒
currentTimeStamp=$((timeStamp*1000)) #将current转换为时间戳，精确到毫秒
requestBody="""
`cat <<EOF
{"query":{"constant_score": {"filter": {"bool": {"must": [{"range": {"logoutTime": {"gte": ${currentTimeStamp}}}},{"term": {"userType": {"value": 0}}}]}}}}}
EOF
`
"""
echo $requestBody
curl -sH "Content-Type: application/json" -X GET http://"elasticsearch-backend-01":9200/gl_user/_count -d "$requestBody"|awk -F '{"count":' '{print $2}' |awk -F ',"_shards' '{print $1}'
