#!/bin/bash

# get the pipeline
git clone https://github.com/AKSW/rdf-maturitylevel-pipeline.git pipeline

# Nextflow
mkdir /opt/nextflow
cd /opt/nextflow
wget -qO- https://github.com/nextflow-io/nextflow/releases/download/v22.04.1/nextflow-22.04.1-all
chmod +x nextflow

# Pipe
mkdir -p /opt/webhook/pipe
mkfifo -m a+rw /opt/webhook/pipe/host_executor_queue

# start reading from pipe
./readFromPipe.sh & # TODO: add to cron
