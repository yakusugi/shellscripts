#!/bin/bash

# Read the department keys from the environment file
source dept_keys.env

# Convert the comma-separated string to an array
IFS=',' read -ra dept_keys <<< "$dept_key_list"

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

# Loop through the files in the file name list
for file in "${file_list[@]}"; do
  # Check if the file exists
  if [[ ! -f "${TARGET_FILES_DIR}/${file}" ]]; then
    echo "File not found: $file"
    exit 1
  fi

  # Read the lines from the file
  while IFS= read -r line; do
    # Extract the department key from the line
    dept_key=$(echo "$line" | cut -d',' -f1)

    # Check if the department key exists in the associative array
    if [[ -v dept_sums[$dept_key] ]]; then
      # Extract the numbers from the line
      request=$(echo "$line" | cut -d',' -f2)
      deleted=$(echo "$line" | cut -d',' -f3)
      error=$(echo "$line" | cut -d',' -f4)

      # Update the sums for the department key
      old_sum=${dept_sums[$dept_key]}
      new_sum=$((request + old_sum[0]))" "$((deleted + old_sum[1]))" "$((error + old_sum[2]))
      dept_sums[$dept_key]=$new_sum
    fi
  done < "${TARGET_FILES_DIR}/${file}"
done

# Write the results to the output file
for dept_key in "${dept_keys[@]}"; do
  sum=${dept_sums[$dept_key]}
  echo "$dept_key $sum" >> "$output_file"
done
