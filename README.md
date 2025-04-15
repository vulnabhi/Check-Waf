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
    chmod +x WAFBulkSorter.sh
    ```

2. **Ensure dependencies are installed:**
    - The tool requires `jq` for JSON parsing. You can install it using:
        ```bash
        sudo apt update
        sudo apt install jq
        ```

4. **Move the script to a directory in your PATH** (optional):
    ```bash
    sudo mv WAFBulkSorter.sh /usr/local/bin/WAFBulkSorter
    ```

---

## Usage

1. **Run `wafw00f` to scan your domains and output in JSON format:**
    ```bash
    wafw00f -i domains.txt -f json -o wafw00f.json
    ```

2. **Run `WAFBulkSorter` to process the output:**
    ```bash
    bash WAFBulkSorter.sh wafw00f.json
    ```

3. **You can combine `wafw00f` and `WAFBulkSorter` in one line:**
   ```bash
   wafw00f -i domains.txt -f json -o wafw00f.json && bash WAFBulkSorter.sh wafw00f.json
    ```

4. **Optional: Specify an output directory using `-o` (optional):**
    ```bash
    bash WAFBulkSorter.sh wafw00f.json -o /path/to/output_directory
    ```

   This will create:
   - `waf_domains.txt` — Domains with WAFs.
   - `nonwaf_domains.txt` — Domains without WAFs.
   - `error_domains.txt` — Domains with errors.
   - A summary of detected domains will be displayed in the terminal.

---

## Command-line Options

- **`-o output_directory`**: (Optional) Directory to save the result files. If not provided, the results will be saved in the current working directory.
- **`-h`**: Display the help message with usage details.

---

## Example Output

```bash
✅ WAF Detection Summary (JSON)
--------------------------------------
🔐 WAF Detected      : 5
🛡  No WAF Detected  : 3
❌ Error Domains      : 2
--------------------------------------
📁 Output Files:
   - /path/to/output_directory/waf_domains.txt
   - /path/to/output_directory/nonwaf_domains.txt
   - /path/to/output_directory/error_domains.txt
