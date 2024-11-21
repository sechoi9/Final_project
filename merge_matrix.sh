#!/bin/bash

# Input files
file1="/home/scoringfunctions/Documents/SaeHee/2nd_run/trinity_out_dir/again/MT-att2/Trinity.gene.counts.matrix"
file2="/home/scoringfunctions/Documents/SaeHee/2nd_run/trinity_out_dir/again/PM-att2/Trinity.gene.counts.matrix"
output="PM_MT_Trinity.gene.counts.matrix"

# Check if input files exist
if [[ ! -f "$file1" ]]; then
    echo "Error: File $file1 does not exist."
    exit 1
fi

if [[ ! -f "$file2" ]]; then
    echo "Error: File $file2 does not exist."
    exit 1
fi

# Read the headers from both files
header1=$(head -n 1 "$file1")
header2=$(head -n 1 "$file2")

# Write the new header with both files' headers to the output file
echo -e "Gene\t$header2\t$header1" > "$output"

# Create temporary files for the key-value pairs (ignoring the headers)
file1_no_header="file1_no_header.txt"
file2_no_header="file2_no_header.txt"

tail -n +2 "$file1" > "$file1_no_header"
tail -n +2 "$file2" > "$file2_no_header"

# Ensure no file-reading errors
if [[ ! -s "$file1_no_header" || ! -s "$file2_no_header" ]]; then
    echo "Error: Problem with temporary files."
    rm -f "$file1_no_header" "$file2_no_header"
    exit 1
fi

# Get all unique keys from both files
keys=$(cat "$file1_no_header" "$file2_no_header" | cut -f1 | sort | uniq)

# Loop through each unique key and merge data
for key in $keys; do
    # Get the value from file1, if it exists; otherwise, set to 0
    value1=$(grep -P "^$key\t" "$file1_no_header" | cut -f2-)
    if [ -z "$value1" ]; then
        value1=$(head -n 1 "$file1" | cut -f2- | tr '\t' '\n' | sed 's/.*/0/' | paste -sd '\t')
    fi

    # Get the value from file2, if it exists; otherwise, set to 0
    value2=$(grep -P "^$key\t" "$file2_no_header" | cut -f2-)
    if [ -z "$value2" ]; then
        value2=$(head -n 1 "$file2" | cut -f2- | tr '\t' '\n' | sed 's/.*/0/' | paste -sd '\t')
    fi

    # Output the key and the values, separated by tabs
    echo -e "$key\t$value2\t$value1" >> "$output"
done

# Clean up temporary files
rm -f "$file1_no_header" "$file2_no_header"

echo "Merged file created: $output"

