#!/usr/bin/env bash

DIR=$(mktemp -d)
TIMESTAMP=$(date +%y%m%d%H%M%S)
ORIGINAL=$DIR/$TIMESTAMP.png
EMAIL=$1
TOKEN=$2

/usr/local/bin/imagesnap "$ORIGINAL"

curl \
  -H 'Accept: application/json' \
  -H "Accept: application/vnd.halide.v1" \
  -H "X-API-EMAIL: $EMAIL" \
  -H "X-API-TOKEN: $TOKEN" \
  -F "capture[attachment]=@$ORIGINAL;type=image/png" \
  https://www.halidecapture.com/api/captures

# Cleanup
rm $ORIGINAL
