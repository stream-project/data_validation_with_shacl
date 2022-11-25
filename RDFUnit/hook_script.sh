#!/bin/bash

#echo "Test: webhook is working" >> /proc/1/fd/1

pipe=/opt/webhook/pipe/host_executor_queue

PAYLOAD=$1

if [ -z "$PAYALOAD" ]; then
    echo "$PAYLOAD $2" >$pipe
else
    echo "No data? $0 $1 $2" > $pipe
fi
