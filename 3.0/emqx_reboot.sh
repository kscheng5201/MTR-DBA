#!/bin/bash
##################################################
# Project: Monitor the EMQX reboot
# Branch: 
# Author: Gok, the DBA
# Created: 2023-11-08
# Updated: 2023-11-08
# Note: 
##################################################

log_dir=/data/emqx/log

servers=`grep emq /etc/hosts | grep -v '^#' | awk '{print $2}'`

for s in $servers;
do
    echo $s >> emqxRestartMonitor.log
    last_time=`ssh $s "grep -iB5 'starting emqx' $log_dir/erlang.log* | tail | grep LOGGING | cut -d ' ' -f 4-11"`
    `date -d "$last_time" +"%F %T"` >> emqxRestartMonitor.log
done

