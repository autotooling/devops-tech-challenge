#!/bin/bash
echo "Querying VM metadata"
echo "Route Endpoint: http://169.254.169.254/metadata"
echo "API used: /metadata/instance within VM"
result_file=metadata.json
curl -o $result_file \
-X GET \
-H "Accept: application/json" \
Metadata:true \
--noproxy "*" \
"http://169.254.169.254/metadata/instance?api-version=2021-02-01&format=json"

if [ -f "${result_file}" ] || [ -s "${result_file}" ]; then
    echo "Metadata Details"
    cat metadata.json
fi