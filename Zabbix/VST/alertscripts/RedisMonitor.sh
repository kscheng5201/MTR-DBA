#!/bin/bash
##############################################
# Project: Check the Redis Status currently
# Branch: 
# Author: Gok, the DBA
# Created: 2023-01-10
# Updated: 2023-01-12
# Note: 針對 Redis 的 Info 資訊取得較細的監控項
##############################################

redis_ip=$1
redis_port=$2
    # master: 6377
    # slave: 6380
item=$3
password='newld20200909'

if [[ $item != 'db0' ]];
then
    output=`redis-cli -h $redis_ip -p $redis_port -c -a $password info 2>/dev/null | grep ${item}: | cut -d : -f 2`

    if [[ -z $output ]];
    then
        echo 0
    else
        echo $output
    fi

else
    output=`redis-cli -h $redis_ip -p $redis_port -c -a $password info 2>/dev/null | grep ^$item | cut -d = -f 2 | cut -d , -f 1`
    echo $output
fi


#################################################################################################################################################
# item list
#################################################################################################################################################
## clients
# connected_clients: Number of client connections (excluding connections from replicas)
# blocked_clients: Number of clients pending on a blocking call (BLPOP, BRPOP, BRPOPLPUSH, BLMOVE, BZPOPMIN, BZPOPMAX)

## Memory
# used_memory: Total number of bytes allocated by Redis using its allocator (either standard libc, jemalloc, or an alternative allocator such as tcmalloc)
# mem_fragmentation_ratio: Ratio between used_memory_rss and used_memory. Note that this doesn't only includes fragmentation, but also other process overheads (see the allocator_* metrics), and also overheads like code, shared libraries, stack, etc.

## persistence
# current_save_keys_processed: Number of keys processed by the current save operation
# current_save_keys_total: Number of keys at the beginning of the current save operation
# rdb_last_save_time: Epoch-based timestamp of last successful RDB save

## Stats
# instantaneous_ops_per_sec: Number of commands processed per second
# instantaneous_input_kbps: The network's read rate per second in KB/sec
# instantaneous_output_kbps: The network's write rate per second in KB/sec
# rejected_connections: Number of connections rejected because of maxclients limit
# evicted_keys: Number of evicted keys due to maxmemory limit
# keyspace_hits: Number of successful lookup of keys in the main dictionary
# keyspace_misses: Number of failed lookup of keys in the main dictionary

## Replication
# (master) connected_slaves: Number of connected replicas
# (slave) master_last_io_seconds_ago: Number of seconds since the last interaction with master
# (slave) master_link_down_since_seconds: Number of seconds since the link is down

# Keyspace
# db0:keys=?

## Reference: https://redis.io/commands/info/
#################################################################################################################################################
