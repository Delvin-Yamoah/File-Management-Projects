#!/bin/bash

# Organize files by extension in a specified directory.

# Path to the directory you want to sort
target_dir="home/example/exampleFiles" 

# Check if the target directory exists and is a directory.
[[ ! -d "$target_dir" ]] && {
  echo "Error: Directory '$target_dir' does not exist or is not a directory."
  exit 1
}

declare -A ext_map=(
  ["pdf"]="Documents" ["txt"]="Documents" ["docx"]="Documents"
  ["sh"]="Scripts" ["pem"]="Security"
  ["jpg"]="Images" ["png"]="Images"
)

# Create subdirectories.
for sub_dir in "${ext_map[@]}"; do
  mkdir -p "$target_dir/$sub_dir"
done
mkdir -p "$target_dir/Other"

# Find and process files.
find "$target_dir" -maxdepth 1 -type f -print0 | while IFS= read -r -d $'\0' file; do
  filename=$(basename "$file")
  ext_lower=$(tr '[:upper:]' '[:lower:]' <<< "${filename##*.}")
  dest_subdir="${ext_map["$ext_lower"]}"

  echo "Processing file: $file"
  echo "Filename: $filename"
  echo "Extension (lowercase): $ext_lower"
  echo "Destination Subdirectory: $dest_subdir"

  if [[ -n "$dest_subdir" ]]; then
    mv "$file" "$target_dir/$dest_subdir/$filename"
  else
    mv "$file" "$target_dir/Other/$filename"
  fi
done

echo "File organization complete for directory: $target_dir"