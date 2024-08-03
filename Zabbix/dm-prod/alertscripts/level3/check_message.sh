#!/bin/bash
curl -sH "Content-Type: application/json" -XGET 'http://127.0.0.1:9200/nginx-logs*/_count' -d '{"query":{"bool":{"must":[{"range":{"timestamp":{"gte":"now-60m","lte":"now"}}},{"match":{"tags":"nginx-1st, beats_input_codec_plain_applied"}},{"match":{"request_url": "/api/v4/user/login/code"}}]}}}' |awk -F"[:/,]" '{print $2}'
