#!/bin/bash
echo $(sudo rabbitmqctl cluster_status|grep 'Node: rabbitmq'|grep status|wc -l)