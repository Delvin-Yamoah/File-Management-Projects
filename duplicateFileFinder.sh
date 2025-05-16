#!/bin/bash

# Script to find and handle duplicate files in a directory.
# The script will now prompt the user for the source and destination directories.

# Prompt the user to enter the directory to check for duplicates
read -p "Enter the directory to check for duplicate files: " DIR

# Check if the directory is provided
if [ -z "$DIR" ]; then
  echo "Error: Directory is required. Exiting."
  exit 1
fi

# Check if the directory exists
if [[ ! -d "$DIR" ]]; then
  echo "Error: Directory '$DIR' does not exist or is not a directory. Exiting."
  exit 1
fi

# Prompt the user to enter the destination directory (optional)
read -p "Enter the destination directory to move duplicates (leave blank to delete): " DEST_DIR

# If a destination directory is provided, check if it exists
if [ -n "$DEST_DIR" ] && [[ ! -d "$DEST_DIR" ]]; then
  echo "Error: Destination directory '$DEST_DIR' does not exist or is not a directory. Exiting."
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
              echo "No destination folder provided. Deleting duplicate."
              rm -v "$file"
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
