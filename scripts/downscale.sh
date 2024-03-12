#!/bin/bash

# Array of source directories
SOURCE_DIRS=("./dataset/field/cocci" "./dataset/field/healthy" "./dataset/field/ncd" "./dataset/field/salmo")

# Directory to store the modified files
TARGET_DIR="./dataset/field/images"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Loop through each source directory
for dir in "${SOURCE_DIRS[@]}"; do
    # Check if directory exists
    if [[ -d $dir ]]; then
        # Loop through each file in the directory
        for file in "$dir"/*; do
            if [[ -f $file ]]; then
                # Get the base name of the file to preserve its name in the target directory
                base_name=$(basename "$file")
                # Use convert to resize the image and save it to the target directory
                convert "$file" -resize 640x640\> "$TARGET_DIR/$base_name"
            fi
        done
    else
        echo "Directory $dir does not exist."
    fi
done
