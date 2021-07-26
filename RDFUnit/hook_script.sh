#!/bin/bash

echo "Test: webhook is working" >> /proc/1/fd/1

pipe=/opt/webhook/pipe/host_executor_queue

if [[ ! -p $pipe ]]; then
    echo "Reader not running" >> /proc/1/fd/1
    exit 1
fi

PAYLOAD=$1

if [[ "$PAYLOAD" ]]; then
    echo "$PAYLOAD" >$pipe
else
    echo "No data? $0 $1 $2" > $pipe
fi
