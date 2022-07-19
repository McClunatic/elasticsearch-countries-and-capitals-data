#!/bin/bash

elasticdump \
    --input=/tmp/document_mapping.json \
    --output=http://localhost:9200/document \
    --type=mapping
elasticdump \
    --input=/tmp/document.json \
    --output=http://localhost:9200/document \
    --type=data
