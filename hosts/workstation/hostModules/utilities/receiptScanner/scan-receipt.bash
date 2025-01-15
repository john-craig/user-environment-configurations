#!/bin/bash
DOC_PATH=/tmp/scanned-receipt-$(date +%s).jpeg

set -eo pipefail

scanimage --format=jpeg --output-file $DOC_PATH

# Define the file path and API token
API_TOKEN_PATH="/sec/paperless/workstation/evak/api-token.txt"
API_TOKEN=$(cat $API_TOKEN_PATH)

# Define the endpoint URL
URL="https://paperless.chiliahedron.wtf/api/documents/post_document/"

# Perform the POST request using curl with Authorization header
curl --silent -X POST "$URL" \
  -F "document=@$DOC_PATH" \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: multipart/form-data"

rm $DOC_PATH