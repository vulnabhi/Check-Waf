# WAFBulkSorter

**WAFBulkSorter** is a command-line tool designed to **filter and categorize bulk WAF detection results** from the `wafw00f` tool. It takes the **JSON output** from `wafw00f` and splits the domains into **WAF detected** and **No WAF detected** categories. The tool also logs **error domains** that are unreachable or failed during the scan.

---

## Features

- **Bulk Processing:** Filter multiple domains at once from `wafw00f` output in **JSON** format.
- **Categorization:** Automatically sorts domains into **WAF detected**, **No WAF detected**, and **Error domains**.
- **Output Files:** Saves results in separate files:
  - `waf_domains.txt` — Domains behind a WAF.
  - `nonwaf_domains.txt` — Domains not behind a WAF.
  - `error_domains.txt` — Domains that are unreachable or had errors during scanning.
- **Count Summary:** Outputs a summary with counts of each category.

---

## Installation

1. **Clone the repository** (optional):
    ```bash
    git clone https://github.com/yourusername/WAFBulkSorter.git
    cd WAFBulkSorter
    ```

2. **Ensure dependencies are installed:**
    - The tool requires `jq` for JSON parsing. You can install it using:
        ```bash
        sudo apt update
        sudo apt install jq
        ```

---

## Usage

1. **Run `wafw00f` to scan your domains and output in JSON format:**
    ```bash
    wafw00f -i domains.txt -f json -o wafw00f.json
    ```

2. **Run `WAFBulkSorter` to process the output:**
    ```bash
    bash check_waf.sh wafw00f.json
    ```

3. **You can combine `wafw00f` and `WAFBulkSorter` in one liner**
   ```bash
   wafw00f -i domains.txt -f json -o wafw00f.json && bash check_waf.sh wafw00f.json
    ```


   This will create:
   - `waf_domains.txt` — Domains with WAFs.
   - `nonwaf_domains.txt` — Domains without WAFs.
   - `error_domains.txt` — Domains with errors.
   - A summary of detected domains will be displayed in the terminal.

---
