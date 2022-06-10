#!/bin/bash

ZONE_ID=
EMAIL=
KEY=
 

curl -s -X GET https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?per_page=500 \
    -H "X-Auth-Email: ${EMAIL}" \
    -H "X-Auth-Key: ${KEY}" \
    -H "Content-Type: application/json" | jq .result[].id |  tr -d '"' | (
  while read id; do
    curl -s -X DELETE https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${id} \
      -H "X-Auth-Email: ${EMAIL}" \
      -H "X-Auth-Key: ${KEY}" \
      -H "Content-Type: application/json"
  done
  )
