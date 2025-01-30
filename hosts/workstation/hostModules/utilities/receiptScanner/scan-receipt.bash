#!/bin/bash
DOC_PATH=/tmp/scanned-receipt-$(date +%s).jpeg

set -eo pipefail

# Find USB device for Epson ES-50
SCANNER_DEVICE=$(lsusb | grep "Epson ES-50")
SCANNER_DEVICE="epsonds:libusb:$(echo $SCANNER_DEVICE | cut -d' ' -f2):$(echo $SCANNER_DEVICE | cut -d' ' -f4 | cut -d':' -f1)"

scanimage -d $SCANNER_DEVICE --format=jpeg --output-file $DOC_PATH

# Define the file path and API token
API_TOKEN_PATH="/sec/paperless/workstation/evak/api-token.txt"

# Define the endpoint URL
URL="https://paperless.chiliahedron.wtf/api/documents/post_document/"

# Perform the POST request using curl with Authorization header
{ echo -n 'Authorization: Token '; cat $API_TOKEN_PATH | tr -d '\n'; } | \
curl --silent -X POST "$URL" \
  -F "document=@$DOC_PATH" \
  -H @- \
  -H "Content-Type: multipart/form-data"

rm $DOC_PATH