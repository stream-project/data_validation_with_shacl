#!/bin/bash

# read from pipe
pipe=/opt/webhook/pipe/host_executor_queue
[ -p "$pipe" ] || mkfifo -m 0600 "$pipe" || exit 1
while :; do
    while read -r datasetid; do
        dt=$(date '+%Y/%m/%d %H:%M:%S')
        # TODO handle wrong values
        
        if [ "$datasetid" ]; then
            echo "$dt : Fifo value: $datasetid" >> /proc/1/fd/1
            # execute script
            ./prepare_ttl_files.sh $datasetid
        fi
    done <"$pipe"
    sleep 30s
done
