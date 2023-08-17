#/bin/sh

# Merge all json files in a directory into one file
# Usage: merge_jsons.sh <directory> <output_file>

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
    echo "Usage: merge_jsons.sh <directory> <output_file>"
    exit 1
fi

# Check if the directory exists
if [ ! -d $1 ]; then
    echo "Directory $1 does not exist"
    exit 1
fi

# Check if the output file exists
if [ -f $2 ]; then
    echo "Output file $2 already exists"
    exit 1
fi

# Merge all json files in the directory
files=($1/*.json)
pos=$(( ${#files[*]} - 1 ))
last=${files[$pos]}

echo "{" > $2
# loop through the files
for file in "${files[@]}"; do
    # get the file name without the extension
    file_name=$(basename $file .json)
    # convert file_name to uppercase
    file_name=$(echo $file_name | tr '[:lower:]' '[:upper:]')
   
    echo "\"$file_name\": " >> $2
    cat $file >> $2

    # if the file is the last file, don't add a comma
    if [ "$file" != "$last" ]; then
        echo "," >> $2
    fi
done
echo "}" >> $2

cat $2 | jq > $2.tmp
mv $2.tmp $2