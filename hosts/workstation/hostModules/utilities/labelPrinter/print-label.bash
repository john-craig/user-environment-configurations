#!/bin/bash

EXPECTED_DEVICE="Dymo-CoStar Corp. DYMO LabelWriter 550"
PRINTER_NAME="DYMO_LabelWriter_550"

if [[ -z "$1" ]]; then
  echo "Error: Missing required argument." >&2
  echo "Usage: $0 <argument>" >&2
  exit 1
fi
INVENTORY_TITLE=$1

# Search for the device in lsusb output
if lsusb | grep -q "$EXPECTED_DEVICE"; then
  echo "Device found: $EXPECTED_DEVICE"
else
  echo "Error: Device '$EXPECTED_DEVICE' not found." >&2
  exit 1
fi

# Check if the printer is listed
if lpstat -p | grep -q "$PRINTER_NAME"; then
  echo "Printer found: $PRINTER_NAME"
else
  echo "Error: Printer '$PRINTER_NAME' not found." >&2
  exit 1
fi

API_TOKEN_PATH="/sec/nocodb/workstation/evak/api-token.txt"

RESPONSE=$({ echo -n 'xc-token: '; cat $API_TOKEN_PATH | tr -d '\n'; } | \
curl -sS -X 'POST' \
  'https://nocodb.chiliahedron.wtf/api/v2/tables/mfg0toy3oa6vzmu/records' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H @- \
  -d "{
  \"Item Name\": \"$INVENTORY_TITLE\"
}")

# Extract the 'Id' field using jq
RECORD_ID=$(echo "$RESPONSE" | jq -r '.Id')

# Check if RECORD_ID is non-empty
if [[ -z "$RECORD_ID" ]]; then
  echo "Error: 'Id' field not found in response." >&2
  exit 1
fi

RESPONSE=$({ echo -n 'xc-token: '; cat $API_TOKEN_PATH | tr -d '\n'; } | \
curl -sS -X 'GET' \
  "https://nocodb.chiliahedron.wtf/api/v2/tables/mfg0toy3oa6vzmu/records/$RECORD_ID" \
  -H 'accept: application/json' \
  -H @-)

# Attempt to extract the "QR Code" field
QR_CODE_STRING=$(echo "$RESPONSE" | jq -r '."QR Code" // empty')

if [[ -z "$QR_CODE_STRING" ]]; then
  echo "Error: 'QR Code' field not found in the input JSON."
  exit 1
else
  echo "QR Code String: '$QR_CODE_STRING'"
fi

QR_CODE_IMG="/tmp/qr-code-$(date +%s).png"
qrencode -o $QR_CODE_IMG "$QR_CODE_STRING"

echo "Printing QR Code..."
lp -d DYMO_LabelWriter_550 -o fit-to-page $QR_CODE_IMG