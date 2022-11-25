#!/bin/bash

# read from pipe
pipe=/opt/webhook/pipe/host_executor_queue
[ -p "$pipe" ] || mkfifo -m 0600 "$pipe" || exit 1
while :; do
    while read -r data; do
        dt=$(date '+%Y/%m/%d %H:%M:%S')
        # TODO handle wrong values

        if [ "$data" ]; then
            echo "$dt : Fifo value: $data" >> /proc/1/fd/1
            # execute script
            ./execute_pipeline.sh $data
        fi
    done <"$pipe"
    sleep 30s
done
