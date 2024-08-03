#!/bin/bash

curl -skw "%{$1}\n" -H "Host: h5.v01bbb.com" -o /dev/null https://35.190.75.99/testconnection/350k.png

