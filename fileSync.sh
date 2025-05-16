#!/bin/bash

# This function shows how to use the script if the user doesn't provide folder paths
usage() {
  echo "Usage: $0"
  echo "This script will sync files between two folders."
  echo "You will be prompted to enter the folder paths."
  exit 1
}

# Prompt the user for the folder paths
echo "Enter the path for the first folder (e.g., /home/user/folder1):"
read FOLDER1
echo "Enter the path for the second folder (e.g., /home/user/folder2):"
read FOLDER2

# Check if both folders exist
if [ ! -d "$FOLDER1" ] || [ ! -d "$FOLDER2" ]; then
  echo "One or both folders do not exist. Please check the paths."
  exit 1
fi

# This function will sync files from FOLDER1 to FOLDER2
sync_folder1_to_folder2() {
  for file1 in "$FOLDER1"/*; do
    filename=$(basename "$file1")  # Get the file name (not the full path)
    file2="$FOLDER2/$filename"

    # If the file exists in FOLDER2
    if [ -f "$file2" ]; then
      # Compare timestamps and decide which file to copy
      timestamp1=$(stat -c %Y "$file1")
      timestamp2=$(stat -c %Y "$file2")

      if [ "$timestamp1" -gt "$timestamp2" ]; then
        # File in FOLDER1 is newer, copy it to FOLDER2
        echo "Copying $filename from $FOLDER1 to $FOLDER2"
        cp "$file1" "$file2"
      fi
    else
      # If the file doesn't exist in FOLDER2, copy it
      echo "Copying $filename from $FOLDER1 to $FOLDER2"
      cp "$file1" "$file2"
    fi
  done
}

# This function will sync files from FOLDER2 to FOLDER1
sync_folder2_to_folder1() {
  for file2 in "$FOLDER2"/*; do
    filename=$(basename "$file2")
    file1="$FOLDER1/$filename"

    # If the file exists in FOLDER1
    if [ -f "$file1" ]; then
      # Compare timestamps and decide which file to copy
      timestamp1=$(stat -c %Y "$file1")
      timestamp2=$(stat -c %Y "$file2")

      if [ "$timestamp2" -gt "$timestamp1" ]; then
        # File in FOLDER2 is newer, copy it to FOLDER1
        echo "Copying $filename from $FOLDER2 to $FOLDER1"
        cp "$file2" "$file1"
      fi
    else
      # If the file doesn't exist in FOLDER1, copy it
      echo "Copying $filename from $FOLDER2 to $FOLDER1"
      cp "$file2" "$file1"
    fi
  done
}

# Call the functions to sync in both directions
sync_folder1_to_folder2
sync_folder2_to_folder1
