#!/bin/bash

# read from pipe
pipe=/opt/webhook/pipe/host_executor_queue
[ -p "$pipe" ] || mkfifo -m 0600 "$pipe" || exit 1
while :; do
    while read -r datasetid; do
        dt=$(date '+%Y/%m/%d %H:%M:%S')
        if [ "$datasetid" ]; then
            wall "$dt : Fifo value: $service"
            # execute script
            
        fi
    done <"$pipe"
    sleep 30s
done
