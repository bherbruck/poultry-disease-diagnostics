#!/bin/bash

# Base directory for source folders
BASE_DIR="./datasets/field/imgObjDet_Yolo"

# Directory to store the modified files
TARGET_DIR="./datasets/field/labels"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Declare an associative array for mapping directory names to indices
declare -A dir_indices=(["healthy"]=0 ["cocci"]=1 ["ncd"]=2 ["salmo"]=3)

# Loop through the associative array
for dir in "${!dir_indices[@]}"; do
  index=${dir_indices[$dir]}
  # Check if directory exists
  if [[ -d "$BASE_DIR/$dir" ]]; then
    # Loop through each .txt file in the directory
    for file in "$BASE_DIR/$dir"/*.txt; do
      if [[ -f $file ]]; then
        # Generate the path for the new file
        new_file="$TARGET_DIR/$(basename "$file")"
        # Process each line of the file
        while IFS= read -r line || [[ -n "$line" ]]; do
          # Replace the first character with the directory's corresponding index
          echo "${index}${line:1}" >>"$new_file"
        done <"$file"
      fi
    done
  else
    echo "Directory $BASE_DIR/$dir does not exist."
  fi
done
