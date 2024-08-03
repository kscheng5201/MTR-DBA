#!/bin/bash
curl -s http://127.0.0.1:8000/API/getmessage$1|awk -F '.' '{print $1}'
