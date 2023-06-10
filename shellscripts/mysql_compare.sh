#!/bin/bash

source mysql.env

# check if a filename argument was provided
if [ -z "$1" ]; then
  echo "Please provide a filename as an argument."
  exit 1
fi

# check if the file exists
if [ ! -f "$1" ]; then
  echo "File not found."
  exit 1
fi

# database credentials

# execute the MySQL query and store the result in a variable
RESULT=$(mysql -u $DB_USER -p$DB_PASS $DB_NAME --skip-column-names -e "$QUERY")

# output the result to a file in the specified directory
echo "$RESULT" > "$OUTPUT_DIR/output.csv"

# read the list from the file into an array
readarray -t LIST_EXP < "$1"
readarray -t LIST_RES < "$OUTPUT_DIR/output.csv"

# iterate over each item in the list and check if it exists in the MySQL result
for ITEM in "${LIST_EXP[@]}"
do
  if [[ " ${LIST_RES[@]} " =~ " $ITEM " ]]; then
    echo "$ITEM found in database"
  else
    echo "$ITEM not found in database"
  fi
done
