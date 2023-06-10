#!/bin/bash

# MySQL credentials
DB_HOST="localhost"
DB_USER="johnito"
DB_PASS="RootUnity0216#@!"
DB_NAME="budget_tracker_db"

# SQL query to execute
SQL_QUERY="SELECT * FROM login_tbl"

# Output file
OUTPUT_FILE="/home/johnito/result_dir/sample.csv"

# Connect to MySQL and execute query
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$SQL_QUERY" > "$OUTPUT_FILE"

echo "Query executed and output written to $OUTPUT_FILE"
