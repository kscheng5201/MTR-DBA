#!/bin/bash

curl -skw "%{$1}\n" -H "Host: h5.v01bbb.com" -o /dev/null https://35.244.244.162/testconnection/350k.png

