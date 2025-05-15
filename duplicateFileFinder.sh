#!/bin/bash

# The folder where the files are located
DIR="$1"
# Folder where you want to move duplicates (if empty, duplicates will just be deleted)
DEST_DIR="$2"

if [ -z "$DIR" ]; then
  echo "Usage: $0 <folder> [destination_folder_to_move]"
  exit 1
fi

# Create an empty array to keep track of file hashes
declare -A file_hashes

# Loop through all files in the directory
for file in "$DIR"/*; do
  if [ -f "$file" ]; then
    # Get the file's size
    size=$(stat -c %s "$file")
    # Get the hash (unique identifier) of the file
    hash=$(sha256sum "$file" | cut -d ' ' -f 1)

    # Check if we've already seen this file hash
    if [ -n "${file_hashes[$hash]}" ]; then
      # Compare file sizes to make sure it's the same file
      if [ "$(stat -c %s "${file_hashes[$hash]}")" -eq "$size" ]; then
        # If we found a duplicate, ask what to do with it
        echo "Duplicate found: $file"
        echo "1) Delete"
        echo "2) Move"
        echo "3) Skip"
        read -p "Choose an option (1/2/3): " choice

        case $choice in
          1) 
            rm -v "$file"  # Delete the file
            ;;
          2) 
            if [ -n "$DEST_DIR" ]; then
              mv -v "$file" "$DEST_DIR"  # Move to destination folder
            else
              echo "No destination folder provided. Skipping move."
            fi
            ;;
          3) 
            echo "Skipping $file."
            ;;
          *)
            echo "Invalid option. Skipping $file."
            ;;
        esac
      fi
    else
      # Store the file hash if it's not a duplicate
      file_hashes[$hash]="$file"
    fi
  fi
done
