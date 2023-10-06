#!/bin/sh

json_files=$(find . -name "*.json")

# Validate JSON files
for file in $json_files
do
    echo "Validating $file"
    result=`python -m json.tool $file`
    if [ $? -ne 0 ]; then
        echo "Invalid JSON file: $file"
        exit 1
    fi
done