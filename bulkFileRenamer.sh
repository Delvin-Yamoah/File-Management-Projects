#!/bin/bash

DIR="$1"
PREFIX="$2"
SUFFIX="$3"
USE_COUNTER="$4"   # "yes" or "no"
USE_DATE="$5"      # "yes" or "no"
EXT="$6"           # optional (e.g. ".txt")

if [ -z "$DIR" ]; then
  echo "Usage: $0 <folder> <prefix> <suffix> <counter yes/no> <date yes/no> [extension]"
  exit 1
fi

DATE=$(date +%Y-%m-%d)
COUNT=1

for FILE in "$DIR"/*; do
  BASENAME=$(basename "$FILE")
  NAME="${BASENAME%.*}"
  EXTENSION=".${BASENAME##*.}"

  if [ -n "$EXT" ] && [[ "$EXTENSION" != "$EXT" ]]; then
    continue
  fi

  NEWNAME="${PREFIX}${NAME}${SUFFIX}"

  if [ "$USE_DATE" = "yes" ]; then
    NEWNAME="${NEWNAME}_${DATE}"
  fi

  if [ "$USE_COUNTER" = "yes" ]; then
    NEWNAME="${NEWNAME}_$(printf "%03d" $COUNT)"
    COUNT=$((COUNT + 1))
  fi

  mv -v "$FILE" "$DIR/${NEWNAME}${EXTENSION}"
done
