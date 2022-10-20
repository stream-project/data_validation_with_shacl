#!/bin/bash

DIR_REPORT_BASE="/var/www/html/reports"
ID=$1
ID1="$(cut -d'/' -f1 <<<"$ID")"
ID2="$(cut -d'/' -f2 <<<"$ID")"

# Load the ttl files
# from data endpoint
curl -G $SPARQL_ENDPOINT  --data-urlencode query='PREFIX nomad: <http://https://nomad-coe.eu/ontology#> construct { ?s ?p ?o } where { ?s a  <http://www.w3.org/ns/sosa/Sample> ; nomad:has_upload_id "$ID1" ; nomad:has_calc_id "$ID2" ; ?p ?o . }' --data-urlencode repo=Nomad -H 'Accept: text/turtle' > data.ttl
# from shape endpoint
curl -G https://sparql.stream-dataspace.net/sparql  --data-urlencode query='construct {  ?s ?p ?o } where { ?s ?p ?o }' --data-urlencode default-graph-uri=$SPARQL_GRAPH_SHAPES --data-urlencode format='text/turtle' > shapes.ttl

# Execute the pipeline
rm pipeline/nextflow.config && cp nextflow.config pipeline/nextflow.config
/opt/nextflow/nextflow-22.04.1-all run pipeline/pipeline.nf

# Copy new triples to main ttl file and make it a working ttl file again
mkdir -p /var/www/html/reports/_data/
cat result.ttl >> /var/www/html/reports/_data/report.ttl
rapper -i turtle -o turtle /var/www/html/reports/_data/report.ttl > /var/www/html/reports/_data/report2.ttl
rm -f /var/www/html/reports/_data/report.ttl
mv /var/www/html/reports/_data/report2.ttl /var/www/html/reports/_data/report.ttl
