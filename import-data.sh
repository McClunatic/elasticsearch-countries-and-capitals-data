#!/bin/bash

npx elasticdump \
    --input=document_mapping.json \
    --output=http://localhost:9200/document \
    --type=mapping
npx elasticdump \
    --input=document.json \
    --output=http://localhost:9200/document \
    --type=data
