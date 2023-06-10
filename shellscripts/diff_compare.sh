#!/bin/bash

# check if the script was run with an argument
if [ -z "$1" ]; then
  echo "Please provide a search keyword as an argument."
  exit 1
fi

# set the search keyword from the argument
keyword="$1"

# search for files in the directory matching the keyword and store their names in an array
files=($(find . -name "*$keyword*" -type f))

# set the name of the output file
output="diff.txt"

# loop through the array of files and use the diff command to compare them
for (( i=0; i<${#files[@]}-1; i++ )); do
  for (( j=i+1; j<${#files[@]}; j++ )); do
    diff "${files[i]}" "${files[j]}" | grep "^<" | sed 's/^< //' >> "$output"
    diff "${files[i]}" "${files[j]}" | grep "^>" | sed 's/^> //' >> "$output"
  done
done

echo "Differences saved to $output"
