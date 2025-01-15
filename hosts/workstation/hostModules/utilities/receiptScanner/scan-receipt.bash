#!/bin/bash

# Define the file path and API token
DOC_PATH="/path/to/your/file.pdf"
API_TOKEN="your_api_token_here"

# Define the endpoint URL
URL="https://paperless.chiliahedron.wtf/api/documents/post_document/"

# Perform the POST request using curl with Authorization header
curl -X POST "$URL" \
  -F "document=@$DOC_PATH" \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: multipart/form-data"