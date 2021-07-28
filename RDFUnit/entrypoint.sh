#!/bin/bash

/opt/webhook/readFromPipe.sh &
webhook -hooks /opt/webhook/webhook.json -verbose -port 80 -header "Access-Control-Allow-Origin=*" -header "Access-Control-Allow-Methods=*" -header "Access-Control-Allow-Headers=*"
