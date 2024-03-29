# data_validation_with_shacl
Repository which has all the services in it to do the data validation based on the maturity model using SHACL and RDFUnit plus display results.

This code is integrated with the Leipniz data manager in order to validate the maturity model (level) against a dataset located at the SPARQL endpoint and then provide the report via JekyllRDF.
The Jekyll part is just a template and a config which is used to show HTML reports from RDF data generated by [rdf-maturitylevel-pipeline](https://github.com/AKSW/rdf-maturitylevel-pipeline).


## Idea
Users on the LDM could start data quality tests and see test results.
For this a [CKAN extension](https://github.com/stream-project/ckanext-qualityreports) is needed which calls the RDFUnit service and forwards users to the corresponding Jekyll page of the given dataset.

## RDFUnit
This is a webhook which puts ids send via http into a fifo queue of which each entry (id) is then used to gather shapes, the maturity model and RDF data from a SPARQL endpoint to generate reports.
These reports are stored in a ttl file.

**See [rdf-maturitylevel-pipeline](https://github.com/AKSW/rdf-maturitylevel-pipeline).**

## Jekyll-RDF
This is a Jekyll container with the Jekyll-RDF plugin installed. It uses the ttl file generated by RDFUnit service to show RDFUnit reports as HTML websites.

## TODO

* authentification when using SPARQL endpoint
* using graph URIs based on dataset metadata
* use maturity model for material data
* Make also datasets from DSMS work
* report should visual indicate the metric status (red=failed, green=success)
