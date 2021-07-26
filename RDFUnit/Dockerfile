FROM aksw/rdfunit

RUN apt-get update && apt-get upgrade -y && apt-get install -y webhook cron

RUN mkdir -p /opt/webhook/pipe && mkfifo /opt/webhook/pipe/host_executor_queue

COPY ./webhook.json /opt/webhook/webhook.json
COPY ./hook_script.sh /opt/webhook/hook_script.sh
COPY ./readFromPipe.sh /opt/webhook/readFromPipe.sh

ENTRYPOINT webhook -hooks /opt/webhook/webhook.json -verbose -port 80 -header "Access-Control-Allow-Origin=*" -header "Access-Control-Allow-Methods=*" -header "Access-Control-Allow-Headers=*"
