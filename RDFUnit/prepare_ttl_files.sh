#!/bin/bash

SPARQL_ENDPOINT="https://sparql.stream-dataspace.net/sparql"
SPARQL_GRAPH_DATA="http://test.de/"
SPARQL_GRAPH_SHAPES="http://test.de/shapes/"
DIR_REPORT_BASE="/var/www/html/reports"
ID=$1

# Load the ttl files
curl -G $SPARQL_ENDPOINT  --data-urlencode query='construct {  ?s ?p ?o } where { ?s ?p ?o }' --data-urlencode default-graph-uri=$SPARQL_GRAPH_DATA --data-urlencode format='text/turtle' > data.ttl
curl -G $SPARQL_ENDPOINT  --data-urlencode query='construct {  ?s ?p ?o } where { ?s ?p ?o }' --data-urlencode default-graph-uri=$SPARQL_GRAPH_SHAPES --data-urlencode format='text/turtle' > shapes.ttl

# Execute RDFUnit
java -jar /app/rdfunit-validate.jar -d ./data.ttl -s ./shapes.ttl -f /tmp/ -o turtle --result-level shacl -A >> /proc/1/fd/1

# Prepare data file for Jekyll RDF
sed -i -e 's/urn:uuid:/http:\/\/stream-dataspace.net\/reports\//g' /tmp/results/._data.ttl.shaclTestCaseResult.ttl
mkdir -p /var/www/html/reports/_data/
cat /tmp/results/._data.ttl.shaclTestCaseResult.ttl >> /var/www/html/reports/_data/report.ttl
rapper -i turtle -o turtle /var/www/html/reports/_data/report.ttl > /var/www/html/reports/_data/report2.ttl
rm -f /var/www/html/reports/_data/report.ttl
mv /var/www/html/reports/_data/report2.ttl /var/www/html/reports/_data/report.ttl
