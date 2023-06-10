#!/bin/bash

# Directory path containing the .deb files
directory="/path/to/directory"

# Output file to log the information
output_file="deb_info.log"

# Loop through each .deb file in the directory
for file in "$directory"/*.deb; do
    if [[ -f "$file" ]]; then
        echo "Processing: $file"
        dpkg -I "$file" >> "$output_file"
        echo "----------------------------------------" >> "$output_file"
    fi
done

