#!/bin/bash
#Parameters:
# 1: ID
# 2: repository: dsms or nomad

DIR_REPORT_BASE="/var/www/html/reports"
ID=$1
ID1="$(cut -d'/' -f1 <<<"$ID")"
ID2="$(cut -d'/' -f2 <<<"$ID")"
REPOSITORY=$2

# Load the ttl files
# from data endpoint
if [ $REPOSITORY == "nomad" ]
then
  curl -G $SPARQL_ENDPOINT  --data-urlencode query='PREFIX nomad: <http://https://nomad-coe.eu/ontology#> construct { ?s ?p ?o } where { ?s a  <http://www.w3.org/ns/sosa/Sample> ; nomad:has_upload_id "$ID1" ; nomad:has_calc_id "$ID2" ; ?p ?o . }' --data-urlencode repo=Nomad -H 'Accept: text/turtle' > pipeline/data.ttl
else
  curl -G $SPARQL_ENDPOINT  --data-urlencode query='construct { ?s ?p ?o } where { ?s a  <http://www.w3.org/ns/sosa/Sample> ; nomad:has_upload_id "$ID1" ; nomad:has_calc_id "$ID2" ; ?p ?o . }' --data-urlencode repo=Dsms -H 'Accept: text/turtle' > pipeline/data.ttl
fi
# from shape endpoint
curl -G https://sparql.stream-dataspace.net/sparql  --data-urlencode query='construct {  ?s ?p ?o } where { ?s ?p ?o }' --data-urlencode default-graph-uri=$SPARQL_GRAPH_SHAPES --data-urlencode format='text/turtle' > pipeline/shapes.ttl
# from maturityModel endpoint
curl -G https://sparql.stream-dataspace.net/sparql  --data-urlencode query='construct {  ?s ?p ?o } where { ?s ?p ?o }' --data-urlencode default-graph-uri=$SPARQL_GRAPH_MM --data-urlencode format='text/turtle' > pipeline/mm.ttl

# Execute the pipeline
rm pipeline/nextflow.config && cp nextflow.config pipeline/nextflow.config
cd pipeline && /opt/nextflow/nextflow run pipeline/pipeline.nf

# Copy new triples to main ttl file and make it a working ttl file again
mkdir -p /var/www/html/reports/_data/
cat result.ttl >> /var/www/html/reports/_data/report.ttl
rapper -i turtle -o turtle /var/www/html/reports/_data/report.ttl > /var/www/html/reports/_data/report2.ttl
rm -f /var/www/html/reports/_data/report.ttl
mv /var/www/html/reports/_data/report2.ttl /var/www/html/reports/_data/report.ttl
