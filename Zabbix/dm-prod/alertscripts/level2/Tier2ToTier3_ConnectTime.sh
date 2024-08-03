#!/bin/bash

curl -skw "%{$1}\n" -H "Host:admin.v01bbb.com" -o /dev/null https://3.37.202.134/conntest/fakepng/350k.png
