#!/bin/bash

input_file="${1:-wafw00f.json}"

if ! command -v jq &> /dev/null; then
    echo "❌ Error: 'jq' is required but not installed."
    exit 1
fi

# Clear old outputs
> waf_domains.txt
> nonwaf_domains.txt
> error_domains.txt

# Safety check
if [ ! -f "$input_file" ]; then
    echo "❌ Error: File '$input_file' not found!"
    exit 1
fi

# Extract WAF-detected domains
jq -r '.[] | select(.detected == true) | .url' "$input_file" >> waf_domains.txt

# Extract No-WAF domains
jq -r '.[] | select(.detected == false) | .url' "$input_file" >> nonwaf_domains.txt

# Extract domains with error field
jq -r '.[] | select(.error != null) | .url' "$input_file" >> error_domains.txt

# Count
waf_count=$(wc -l < waf_domains.txt)
nonwaf_count=$(wc -l < nonwaf_domains.txt)
error_count=$(wc -l < error_domains.txt)

# Final output
echo ""
echo "✅ WAF Detection Summary (JSON)"
echo "--------------------------------------"
echo "🔐 WAF Detected      : $waf_count"
echo "🛡️  No WAF Detected  : $nonwaf_count"
echo "❌ Error Domains      : $error_count"
echo "--------------------------------------"
echo "📁 Output Files:"
echo "   - waf_domains.txt"
echo "   - nonwaf_domains.txt"
echo "   - error_domains.txt"
