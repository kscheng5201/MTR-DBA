#!/bin/bash
abc="""
`cat <<EOF
{"query":{"bool":{"must":[{"range":{"timestamp":{"gte":"now-60m","lte":"now"}}},{"match":{"level":"ERROR"}},{"match":{"service": "$1"}}]}}}
EOF
`
"""
curl -sH "Content-Type: application/json" -XGET http://127.0.0.1:9200/service-logs_*/_count -d "$abc" |awk -F"[:/,]" '{print $2}'
