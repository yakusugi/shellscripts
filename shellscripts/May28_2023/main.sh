#!/bin/bash

# Read the alphabets from the environment file
source alphabets.env

# Convert the comma-separated string to an array
IFS=',' read -ra alphabet_arr <<< "$alphabet_list"

# echoing the array for a testing purpose
echo "${alphabet_arr[@]}"

# Output file name
output_file="output.txt"

# Initialize the output file with headers
echo "dept request deleted error" > "$output_file"

# Declare an associative array to store the department key sums
declare -A dept_sums

# Loop through the department keys and initialize the sums
for dept_key in "${dept_keys[@]}"; do
  dept_sums[$dept_key]="0 0 0"
done

# Read the file name list from the environment file
mapfile -t file_list < file_name_list