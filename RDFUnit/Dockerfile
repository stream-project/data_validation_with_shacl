FROM aksw/rdfunit

RUN apt-get update && apt-get upgrade -y && apt-get install -y webhook curl raptor2-utils wget jq

RUN mkdir -p /var/www/html/reports

COPY ./webhook.json /opt/webhook/webhook.json
COPY ./hook_script.sh /opt/webhook/hook_script.sh
COPY ./entrypoint.sh /opt/webhook/entrypoint.sh

WORKDIR /opt/webhook

ENTRYPOINT /opt/webhook/entrypoint.sh
