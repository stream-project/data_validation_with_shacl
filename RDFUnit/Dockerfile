FROM aksw/rdfunit

RUN apt-get update && apt-get upgrade -y && apt-get install -y webhook curl raptor2-utils

RUN mkdir -p /opt/webhook/pipe && mkfifo /opt/webhook/pipe/host_executor_queue && mkdir -p /var/www/html/reports

COPY ./webhook.json /opt/webhook/webhook.json
COPY ./hook_script.sh /opt/webhook/hook_script.sh
COPY ./readFromPipe.sh /opt/webhook/readFromPipe.sh
COPY ./prepare_ttl_files.sh /opt/webhook/prepare_ttl_files.sh
COPY ./entrypoint.sh /opt/webhook/entrypoint.sh

WORKDIR /opt/webhook

ENTRYPOINT /opt/webhook/entrypoint.sh
