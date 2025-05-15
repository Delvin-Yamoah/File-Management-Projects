#!/bin/bash

# Step 1: Ask the user for the folder to check
echo "Enter the folder you want to check (e.g., /home/user):"
read FOLDER

# Check if the folder exists
if [ ! -d "$FOLDER" ]; then
  echo "The folder '$FOLDER' does not exist. Please try again."
  exit 1
fi

# Step 2: Ask if user wants to filter out small files (optional)
echo "Do you want to filter out small files (e.g., files smaller than 100MB)? (yes/no)"
read FILTER

if [ "$FILTER" == "yes" ]; then
  echo "Enter the minimum file size to show (e.g., 100M for 100MB, 1G for 1GB):"
  read SIZE
  FILTER_COMMAND="--threshold=$SIZE"
else
  FILTER_COMMAND=""
fi

# Step 3: Show disk usage in a simple tree format, sorted by size
echo "Here is the disk usage for the folder '$FOLDER' (sorted by size):"
du -ah --max-depth=2 "$FOLDER" | sort -rh | less
