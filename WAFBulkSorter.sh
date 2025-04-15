#!/bin/bash

# WAFBulkSorter - Filters and sorts WAF detection results from wafw00f (JSON only)

# Check for jq
if ! command -v jq &> /dev/null; then
    echo "❌ Error: 'jq' is required but not installed."
    echo "🔧 Install it using: sudo apt install jq"
    exit 1
fi

# Usage/help function
usage() {
    echo ""
    echo "🧰 WAFBulkSorter - Filters and sorts WAF detection results from wafw00f (JSON only)"
    echo "Usage:"
    echo "  $0 [-o output_directory] <wafw00f_output.json>"
    echo ""
    echo "Arguments:"
    echo "  <wafw00f_output.json>   Path to JSON output file from wafw00f."
    echo ""
    echo "Options:"
    echo "  -o output_directory     (Optional) Directory to save result files."
    echo "                          If not provided, saves to the current working directory."
    echo "  -h                      Show this help message."
    echo ""
    exit 1
}

# Default output dir is the current working directory
output_dir="$(pwd)"
input_file=""

# Parse options and arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -o)
            shift
            output_dir="$1"
            ;;
        -h)
            usage
            ;;
        -*)
            echo "❌ Unknown option: $1"
            usage
            ;;
        *)
            # This is the input file
            input_file="$1"
            ;;
    esac
    shift
done

# Validate input file
if [[ -z "$input_file" || ! -f "$input_file" ]]; then
    echo "❌ Error: Please provide a valid wafw00f JSON file as input."
    usage
fi

# Make sure output directory exists
mkdir -p "$output_dir"

# Output files
waf_file="$output_dir/waf_domains.txt"
nonwaf_file="$output_dir/nonwaf_domains.txt"
error_file="$output_dir/error_domains.txt"

# Initialize output files
> "$waf_file"
> "$nonwaf_file"
> "$error_file"

# Counters
waf_count=0
nonwaf_count=0
error_count=0

# Process JSON results
while read -r line; do
    url=$(echo "$line" | jq -r '.url')
    detected=$(echo "$line" | jq -r '.detected')

    if [[ "$detected" == "true" ]]; then
        echo "$url" >> "$waf_file"
        ((waf_count++))
    elif [[ "$detected" == "false" ]]; then
        echo "$url" >> "$nonwaf_file"
        ((nonwaf_count++))
    else
        echo "$url" >> "$error_file"
        ((error_count++))
    fi
done < <(jq -c '.[]' "$input_file")

# Summary
echo ""
echo "✅ WAF Detection Summary (JSON)"
echo "--------------------------------------"
echo "🔐 WAF Detected      : $waf_count"
echo "🛡  No WAF Detected  : $nonwaf_count"
echo "❌ Error Domains      : $error_count"
echo "--------------------------------------"
echo "📁 Output Files:"
echo "   - $waf_file"
echo "   - $nonwaf_file"
echo "   - $error_file"
