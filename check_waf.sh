#!/bin/bash

# Check if domains.txt exists
if [ ! -f domains.txt ]; then
    echo "Error: domains.txt not found!"
    exit 1
fi

# Loop through each domain in the file
while IFS= read -r domain || [ -n "$domain" ]; do
    if [[ -z "$domain" ]]; then
        continue  # skip empty lines
    fi

    echo "🔍 Checking WAF for: $domain"
    wafw00f "$domain"
    echo "----------------------------------------"
done < domains.txt
