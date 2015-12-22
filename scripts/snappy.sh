#!/usr/bin/env bash

DIR="/Users/justin/Dropbox (Personal)/public/snappy"
TIMESTAMP=$(date +%y%m%d%H%M%S)
ORIGINAL=$DIR/$TIMESTAMP.png
WEB=$DIR/$TIMESTAMP.jpg
INDEX="index.html"
INDEX_PATH=$DIR/$INDEX
ENTRIES_PER_ROW=4

mkdir -p "$DIR"

imagesnap "$ORIGINAL"
convert "$ORIGINAL" -resize 300x300 "$WEB"

TOTAL_COUNT=$(find "$DIR" -name "*.jpg" -prune -print | grep -c /)
TOTAL_ROWS=$(( ($TOTAL_COUNT / $ENTRIES_PER_ROW) + 1 ))

IMG_TAGS=""

cd "$DIR" && for f in `ls -t *.jpg | head -12` ; do IMG_TAGS="$IMG_TAGS <div class=\"col-md-3 col-sm-6 col-xs-12\"><a href=\"${f/jpg/png}\" target=_blank><img src=\"$f\" class=\"img-responsive\"></a></div>" ; done

echo $IMG_TAGS

HTML="<!DOCTYPE html>
<html lang=\"en\">
  <head>
    <meta charset=\"utf-8\">
    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">
    <title>Snappy</title>
    <meta name=\"description\" content=\"\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css\" integrity=\"sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7\" crossorigin=\"anonymous\">
  </head>
  <body>
    <div class=\"container\">
      <div class=\"row\">
        $IMG_TAGS
      </div>
    </div>
    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js\"></script>
    <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\" integrity=\"sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS\" crossorigin=\"anonymous\"></script>
  </body>
</html>"

echo $HTML > "$INDEX_PATH"
