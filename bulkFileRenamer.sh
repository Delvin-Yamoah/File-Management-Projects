#!/bin/bash

# Script to rename files in a directory with options for prefix, suffix, counter, date, and extension.

read -p "Enter the directory to rename files in: " DIR
if [ -z "$DIR" ]; then
  echo "Error: Directory cannot be empty."
  exit 1
fi
if [[ ! -d "$DIR" ]]; then
  echo "Error: Directory '$DIR' does not exist or is not a directory."
  exit 1
fi

read -p "Enter the prefix (leave empty for none): " PREFIX
read -p "Enter the suffix (leave empty for none): " SUFFIX

while true; do
  read -p "Use counter? (yes/no): " USE_COUNTER
  case "$USE_COUNTER" in
    [yY]es|[yY]) USE_COUNTER="yes"; break ;;
    [nN]o|[nN])  USE_COUNTER="no"; break ;;
    *) echo "Invalid input. Please enter 'yes' or 'no'.";;
  esac
done

while true; do
  read -p "Use date? (yes/no): " USE_DATE
  case "$USE_DATE" in
    [yY]es|[yY]) USE_DATE="yes"; break ;;
    [nN]o|[nN])  USE_DATE="no"; break ;;
    *) echo "Invalid input. Please enter 'yes' or 'no'.";;
  esac
done

read -p "Enter the optional extension to filter (e.g., .txt, leave empty for all): " EXT

DATE=$(date +%Y-%m-%d_%H-%M-%S) # Include time as well
COUNT=1

for FILE in "$DIR"/*; do
  if [ -f "$FILE" ]; then
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
  fi
done

echo "File renaming complete in directory: $DIR"