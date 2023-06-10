#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Error: At least one argument is required."
    exit 1
fi

# Delete file function
delete_file() {
    # Add your delete file command here
    # For example: rm filename.txt
    rm "$1"
}

arg1=$1

# Prompt user for confirmation
read -p "Do you want to delete the file? (y/n): " answer

# Branch the process based on the user's input
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    output=$(delete_file ${arg1} 2>&1)  # Execute delete_file command and capture output

    # Check if the output contains the "Permission denied" message
    if [[ "$output" == *"Permission denied"* ]]; then
        echo "You don't have permission to delete the file."
    else
        echo "File deleted successfully."
    fi
else
    echo "File deletion canceled."
fi
