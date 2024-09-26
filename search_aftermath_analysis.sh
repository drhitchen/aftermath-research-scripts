#!/bin/bash

# Define the path to the configuration file
config_file_path="./config.sh"

# Check if the configuration file exists and is readable, then source it
if [[ -f "$config_file_path" && -r "$config_file_path" ]]; then
    source "$config_file_path"
    echo "Config file: $(realpath "$config_file_path")"
else
    echo "Configuration file not found or not readable at: $(realpath "$config_file_path")"
    exit 1
fi

# Print out the variables from the config file
echo "Base Folder: $base_dir"
echo "Date Pattern: $date_pattern"
echo "Grep Pattern: $grep_pattern"
echo "Grep Ignore: $grep_ignore"
echo "Search Artifacts: $search_artifacts"

# Define a temporary file for capturing grep output
temp_file=$(mktemp)

# Add artifacts directory to the search command if flag is set
if [ "$search_artifacts" = true ]; then
    # Search Aftermath analysis and artifacts
    search_cmd="grep -iER --color=always \"$date_pattern\" ${base_dir}Aftermath_* \
    | grep -Ev \"$grep_ignore\" \
    | grep -iE --color=always \"$grep_pattern\""
else
    # Search Aftermath analysis only
    search_cmd="grep -iER --color=always \"$date_pattern\" ${base_dir}Aftermath_Analysis_* \
    | grep -Ev \"$grep_ignore\" \
    | grep -iE --color=always \"$grep_pattern\""
fi

# Run the search command and save the result in the temporary file
eval "$search_cmd" > "$temp_file"

# Check if the temporary file is empty
if [ ! -s "$temp_file" ]; then
    echo "No matching results found."
else
    cat "$temp_file"
fi

# Clean up the temporary file
rm "$temp_file"
